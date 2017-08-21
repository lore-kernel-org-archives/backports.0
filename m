Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42937 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754198AbdHUW2q (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/21] compat: avoid usage of kvzalloc() in rhashtable.c
Date: Tue, 22 Aug 2017 00:28:08 +0200
Message-Id: <20170821222817.17376-13-hauke@hauke-m.de> (sfid-20170822_002849_246894_A23843F2)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This reverts commit 12e8fd6fd3802 ("lib/rhashtable.c: use kvzalloc() in
bucket_table_alloc() when possible") from upstream kernel.
Kernel versions older that 4.12 do not have kvzalloc() try to avoid the
usage of this.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/lib-rhashtable.patch | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
index 9c262b02..35424efb 100644
--- a/patches/lib-rhashtable.patch
+++ b/patches/lib-rhashtable.patch
@@ -27,6 +27,19 @@
  		if (!tbl->locks)
  			return -ENOMEM;
  		for (i = 0; i < size; i++)
--- 
-1.9.1
+@@ -226,10 +226,11 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
+ 	int i;
+ 
+ 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
+-	if (gfp != GFP_KERNEL)
++	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) ||
++	    gfp != GFP_KERNEL)
+ 		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
+-	else
+-		tbl = kvzalloc(size, gfp);
++	if (tbl == NULL && gfp == GFP_KERNEL)
++		tbl = vzalloc(size);
+ 
+ 	size = nbuckets;
+ 
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
