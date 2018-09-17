Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56114 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRDA5 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:57 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] header: Add kzalloc()
Date: Mon, 17 Sep 2018 23:31:37 +0200
Message-Id: <20180917213142.7875-2-hauke@hauke-m.de> (sfid-20180917_233151_796202_35CC0AB3)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the kzalloc() function and allows it to remove the
lib-rhashtable.patch patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h |  6 ++++++
 patches/lib-rhashtable.patch         | 18 ------------------
 2 files changed, 6 insertions(+), 18 deletions(-)
 delete mode 100644 patches/lib-rhashtable.patch

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 7e69b873..38c452e2 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -112,6 +112,12 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 
 	return kvmalloc(bytes, flags);
 }
+
+#define kvzalloc LINUX_BACKPORT(kvzalloc)
+static inline void *kvzalloc(size_t size, gfp_t flags)
+{
+	return kvmalloc(size, flags | __GFP_ZERO);
+}
 #endif
 
 #endif /* __BACKPORT_MM_H */
diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
deleted file mode 100644
index 2e91f8d9..00000000
--- a/patches/lib-rhashtable.patch
+++ /dev/null
@@ -1,18 +0,0 @@
-
---- a/compat/lib-rhashtable.c
-+++ b/compat/lib-rhashtable.c
-@@ -175,10 +175,11 @@ static struct bucket_table *bucket_table
- 	int i;
- 
- 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
--	if (gfp != GFP_KERNEL)
-+	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) ||
-+	    gfp != GFP_KERNEL)
- 		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
--	else
--		tbl = kvzalloc(size, gfp);
-+	if (tbl == NULL && gfp == GFP_KERNEL)
-+		tbl = vzalloc(size);
- 
- 	size = nbuckets;
- 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
