Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50904 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab3JEWoy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 09/15] backports: remove scatterlist
Date: Sun,  6 Oct 2013 00:43:58 +0200
Message-Id: <1381013044-7724-10-git-send-email-hauke@hauke-m.de> (sfid-20131006_004455_515596_057E899E)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/scatterlist.h |   69 -------------------------
 backport/compat/compat-3.9.c                  |   43 ---------------
 2 files changed, 112 deletions(-)

diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index bb2b5a4..f939e8c 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -12,73 +12,4 @@ int sg_alloc_table_from_pages(struct sg_table *sgt,
 			      gfp_t gfp_mask);
 #endif /* < 3.6 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
-
-/* Lets expect distributions might backport this */
-#ifndef for_each_sg_page
-/*
- * sg page iterator
- *
- * Iterates over sg entries page-by-page.  On each successful iteration,
- * @piter->page points to the current page, @piter->sg to the sg holding this
- * page and @piter->sg_pgoffset to the page's page offset within the sg. The
- * iteration will stop either when a maximum number of sg entries was reached
- * or a terminating sg (sg_last(sg) == true) was reached.
- */
-struct sg_page_iter {
-	struct page		*page;		/* current page */
-	struct scatterlist	*sg;		/* sg holding the page */
-	unsigned int		sg_pgoffset;	/* page offset within the sg */
-
-	/* these are internal states, keep away */
-	unsigned int		__nents;	/* remaining sg entries */
-	int			__pg_advance;	/* nr pages to advance at the
-						 * next step */
-};
-
-#define __sg_page_iter_next LINUX_BACKPORT(__sg_page_iter_next)
-bool __sg_page_iter_next(struct sg_page_iter *piter);
-#define __sg_page_iter_start LINUX_BACKPORT(__sg_page_iter_start)
-void __sg_page_iter_start(struct sg_page_iter *piter,
-			  struct scatterlist *sglist, unsigned int nents,
-			  unsigned long pgoffset);
-
-/**
- * for_each_sg_page - iterate over the pages of the given sg list
- * @sglist:	sglist to iterate over
- * @piter:	page iterator to hold current page, sg, sg_pgoffset
- * @nents:	maximum number of sg entries to iterate over
- * @pgoffset:	starting page offset
- */
-#define for_each_sg_page(sglist, piter, nents, pgoffset)		   \
-	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
-	     __sg_page_iter_next(piter);)
-
-#endif /* for_each_sg_page assumption */
-#endif /* version < 3.9 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0))
-
-#define sg_page_iter_page LINUX_BACKPORT(sg_page_iter_page)
-/**
- * sg_page_iter_page - get the current page held by the page iterator
- * @piter:     page iterator holding the page
- */
-static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
-{
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
-}
-
-#define sg_page_iter_dma_address LINUX_BACKPORT(sg_page_iter_dma_address)
-/**
- * sg_page_iter_dma_address - get the dma address of the current page held by
- * the page iterator.
- * @piter:     page iterator holding the page
- */
-static inline dma_addr_t sg_page_iter_dma_address(struct sg_page_iter *piter)
-{
-	return sg_dma_address(piter->sg) + (piter->sg_pgoffset << PAGE_SHIFT);
-}
-#endif /* version < 3.10 */
-
 #endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index d85a79f..df10d7d 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/netdevice.h>
@@ -17,46 +16,6 @@
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 
-#ifdef __sg_page_iter_next
-
-void __sg_page_iter_start(struct sg_page_iter *piter,
-			  struct scatterlist *sglist, unsigned int nents,
-			  unsigned long pgoffset)
-{
-	piter->__pg_advance = 0;
-	piter->__nents = nents;
-
-	piter->page = NULL;
-	piter->sg = sglist;
-	piter->sg_pgoffset = pgoffset;
-}
-EXPORT_SYMBOL_GPL(__sg_page_iter_start);
-
-static int sg_page_count(struct scatterlist *sg)
-{
-	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
-}
-
-bool __sg_page_iter_next(struct sg_page_iter *piter)
-{
-	if (!piter->__nents || !piter->sg)
-		return false;
-
-	piter->sg_pgoffset += piter->__pg_advance;
-	piter->__pg_advance = 1;
-
-	while (piter->sg_pgoffset >= sg_page_count(piter->sg)) {
-		piter->sg_pgoffset -= sg_page_count(piter->sg);
-		piter->sg = sg_next(piter->sg);
-		if (!--piter->__nents || !piter->sg)
-			return false;
-	}
-	piter->page = nth_page(sg_page(piter->sg), piter->sg_pgoffset);
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(__sg_page_iter_next);
-
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 {
 	void __iomem *dest_ptr;
@@ -97,5 +56,3 @@ void eth_commit_mac_addr_change(struct net_device *dev, void *p)
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
 }
 EXPORT_SYMBOL_GPL(eth_commit_mac_addr_change);
-
-#endif /* __sg_page_iter_next */
-- 
1.7.10.4

