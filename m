Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51048 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRMJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:12:09 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:40 +0300
Message-Id: <20180920112842.27198-13-luca@coelho.fi> (sfid-20180920_132908_334724_9A3D9FB1)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 12/14] backport: update lib-rhashtable.c
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The bucket_table_alloc() function was reworked, so update the patch
accordingly.  It's much simpler now, if !GFP_KERNEL, we just fail
(like we used to).  This is not a problem because we only use this
function with GFP_KERNEL anyway.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/lib-rhashtable.patch | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/lib-rhashtable.patch

diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
new file mode 100644
index 000000000000..a538d0c83fc7
--- /dev/null
+++ b/patches/lib-rhashtable.patch
@@ -0,0 +1,14 @@
+diff --git a/compat/lib-rhashtable.c b/compat/lib-rhashtable.c
+index 30526afa8343..bee37f2682dd 100644
+--- a/compat/lib-rhashtable.c
++++ b/compat/lib-rhashtable.c
+@@ -173,7 +173,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
+ 	int i;
+ 
+ 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
+-	tbl = kvzalloc(size, gfp);
++	if (gfp == GFP_KERNEL)
++		tbl = vzalloc(size);
+ 
+ 	size = nbuckets;
+ 
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
