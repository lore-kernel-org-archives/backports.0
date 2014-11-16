Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37686 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/20] patches: igb: remove usage of pfmemalloc in struct page
Date: Sun, 16 Nov 2014 21:49:15 +0100
Message-Id: <1416170960-12868-16-git-send-email-hauke@hauke-m.de> (sfid-20141116_221346_828679_A04B393D)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The member pfmemalloc was added to struct page in kernel 3.6, it should
be same to just ignore it in most situation, so do so on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0049-no-pfmemalloc/igb.patch           | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch

diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
new file mode 100644
index 0000000..2f9f747
--- /dev/null
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -0,0 +1,28 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index a2d72a8..85d7005 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -6569,8 +6569,10 @@ static bool igb_can_reuse_rx_page(struct
+ 	if (unlikely(page_to_nid(page) != numa_node_id()))
+ 		return false;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	if (unlikely(page->pfmemalloc))
+ 		return false;
++#endif
+ 
+ #if (PAGE_SIZE < 8192)
+ 	/* if we are only owner of page we can reuse it */
+@@ -6638,8 +6640,12 @@ static bool igb_add_rx_frag(struct igb_r
+ 		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
+ 
+ 		/* we can reuse buffer as-is, just make sure it is local */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 		if (likely((page_to_nid(page) == numa_node_id()) &&
+ 			   !page->pfmemalloc))
++#else
++		if (likely(page_to_nid(page) == numa_node_id()))
++#endif
+ 			return true;
+ 
+ 		/* this page cannot be reused so discard it */
-- 
1.9.1

