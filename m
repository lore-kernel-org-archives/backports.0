Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:51163 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754993AbdESUqf (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 19 May 2017 16:46:35 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] patches: add patch for compat/lib-rhashtable.c
Date: Fri, 19 May 2017 21:46:17 +0100
Message-Id: <1495226777-11429-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170519_224637_347450_368DFBBA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The file compat/lib-rhashtable.c is a copy from the backported kernel
source lib/rhashtable.c. This patch reverts a recent change to that
file, ie. commit 43ca5bc4f72e ("lib/rhashtable.c: simplify a strange
allocation pattern"). It introduced the function gfpflags_allow_blocking()
introduced in 4.4 kernel and kvmalloc() introduced in 4.12-rc1. Looking
at those functions backporting them is complicated so instead add this
patch that reverts the change for kernel prior to 4.12.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/lib-rhashtable.patch | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 patches/lib-rhashtable.patch

diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
new file mode 100644
index 0000000..9c262b0
--- /dev/null
+++ b/patches/lib-rhashtable.patch
@@ -0,0 +1,32 @@
+--- a/compat/lib-rhashtable.c
++++ b/compat/lib-rhashtable.c
+@@ -86,11 +86,26 @@ static int alloc_bucket_locks(struct rhashtable *ht, struct bucket_table *tbl,
+ 		size = min(size, 1U << tbl->nest);
+ 
+ 	if (sizeof(spinlock_t) != 0) {
++#if LINUX_VERSION_IS_LESS(4,12,0)
++		tbl->locks = NULL;
++#ifdef CONFIG_NUMA
++		if (size * sizeof(spinlock_t) > PAGE_SIZE &&
++		    gfp == GFP_KERNEL)
++			tbl->locks = vmalloc(size * sizeof(spinlock_t));
++#endif
++		if (gfp != GFP_KERNEL)
++			gfp |= __GFP_NOWARN | __GFP_NORETRY;
++
++		if (!tbl->locks)
++			tbl->locks = kmalloc_array(size, sizeof(spinlock_t),
++						   gfp);
++#else
+ 		if (gfpflags_allow_blocking(gfp))
+ 			tbl->locks = kvmalloc(size * sizeof(spinlock_t), gfp);
+ 		else
+ 			tbl->locks = kmalloc_array(size, sizeof(spinlock_t),
+ 						   gfp);
++#endif
+ 		if (!tbl->locks)
+ 			return -ENOMEM;
+ 		for (i = 0; i < size; i++)
+-- 
+1.9.1
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
