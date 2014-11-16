Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37678 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaKPUti (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/20] headers: add dev_alloc_page()
Date: Sun, 16 Nov 2014 21:49:02 +0100
Message-Id: <1416170960-12868-3-git-send-email-hauke@hauke-m.de> (sfid-20141116_214940_363518_43EA574D)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the igb driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index e74ef0b..df0eb62 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -199,4 +199,61 @@ static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+/**
+ * __dev_alloc_pages - allocate page for network Rx
+ * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
+ * @order: size of the allocation
+ *
+ * Allocate a new page.
+ *
+ * %NULL is returned if there is no free memory.
+*/
+#define __dev_alloc_pages LINUX_BACKPORT(__dev_alloc_pages)
+static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
+					     unsigned int order)
+{
+	/* This piece of code contains several assumptions.
+	 * 1.  This is for device Rx, therefor a cold page is preferred.
+	 * 2.  The expectation is the user wants a compound page.
+	 * 3.  If requesting a order 0 page it will not be compound
+	 *     due to the check to see if order has a value in prep_new_page
+	 * 4.  __GFP_MEMALLOC is ignored if __GFP_NOMEMALLOC is set due to
+	 *     code in gfp_to_alloc_flags that should be enforcing this.
+	 */
+	gfp_mask |= __GFP_COLD | __GFP_COMP;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+	gfp_mask |= __GFP_MEMALLOC;
+#endif
+
+	return alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
+}
+
+#define dev_alloc_pages LINUX_BACKPORT(dev_alloc_pages)
+static inline struct page *dev_alloc_pages(unsigned int order)
+{
+	return __dev_alloc_pages(GFP_ATOMIC, order);
+}
+
+/**
+ * __dev_alloc_page - allocate a page for network Rx
+ * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
+ *
+ * Allocate a new page.
+ *
+ * %NULL is returned if there is no free memory.
+ */
+#define __dev_alloc_page LINUX_BACKPORT(__dev_alloc_page)
+static inline struct page *__dev_alloc_page(gfp_t gfp_mask)
+{
+	return __dev_alloc_pages(gfp_mask, 0);
+}
+
+#define dev_alloc_page LINUX_BACKPORT(dev_alloc_page)
+static inline struct page *dev_alloc_page(void)
+{
+	return __dev_alloc_page(GFP_ATOMIC);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.9.1

