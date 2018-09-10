Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr710097.outbound.protection.outlook.com ([40.107.71.97]:15360
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbeIJLdP (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 10 Sep 2018 07:33:15 -0400
Date: Mon, 10 Sep 2018 01:40:22 -0500
From: Winnie Chang <winnie.chang@cypress.com>
To: backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com
Subject: [PATCH] patches: update lib-bucket_locks.patch for v4.18-rc1
Message-ID: <20180910064001.GA112464@aremote01.aus.cypress.com> (sfid-20180910_084049_140799_59A3EC0F)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch do not apply to source code in v4.18-rc1 due to
commit ce91f6ee5b3b (mm: kvmalloc does not fallback to vmalloc for
incompatible gfp flags) so updating it.

Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
---
 patches/lib-bucket_locks.patch | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/patches/lib-bucket_locks.patch b/patches/lib-bucket_locks.patch
index 15eeda1..c20c9ce 100644
--- a/patches/lib-bucket_locks.patch
+++ b/patches/lib-bucket_locks.patch
@@ -1,8 +1,6 @@
-diff --git a/compat/lib-bucket_locks.c b/compat/lib-bucket_locks.c
-index 266a97c5708b..405b52ca5708 100644
 --- a/compat/lib-bucket_locks.c
 +++ b/compat/lib-bucket_locks.c
-@@ -30,10 +30,24 @@ int alloc_bucket_spinlocks(spinlock_t **
+@@ -30,7 +30,21 @@
  	}
  
  	if (sizeof(spinlock_t) != 0) {
@@ -19,10 +17,7 @@ index 266a97c5708b..405b52ca5708 100644
 +			tlocks = kmalloc_array(size, sizeof(spinlock_t),
 +						   gfp);
 +#else
- 		if (gfpflags_allow_blocking(gfp))
- 			tlocks = kvmalloc(size * sizeof(spinlock_t), gfp);
- 		else
- 			tlocks = kmalloc_array(size, sizeof(spinlock_t), gfp);
+ 		tlocks = kvmalloc_array(size, sizeof(spinlock_t), gfp);
 +#endif
  		if (!tlocks)
  			return -ENOMEM;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
