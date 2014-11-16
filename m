Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37677 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbaKPUti (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/20] headers: cleanup linux/skbuff.h
Date: Sun, 16 Nov 2014 21:49:01 +0100
Message-Id: <1416170960-12868-2-git-send-email-hauke@hauke-m.de> (sfid-20141116_214942_773549_DE7FB761)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removes some used stuff from linux/skbuff.h.
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 197 -------------------------------
 1 file changed, 197 deletions(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 5a1725d..e74ef0b 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -96,52 +96,6 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
-/**
- *	__skb_alloc_pages - allocate pages for ps-rx on a skb and preserve pfmemalloc data
- *	@gfp_mask: alloc_pages_node mask. Set __GFP_NOMEMALLOC if not for network packet RX
- *	@skb: skb to set pfmemalloc on if __GFP_MEMALLOC is used
- *	@order: size of the allocation
- *
- * 	Allocate a new page.
- *
- * 	%NULL is returned if there is no free memory.
-*/
-static inline struct page *__skb_alloc_pages(gfp_t gfp_mask,
-					      struct sk_buff *skb,
-					      unsigned int order)
-{
-	struct page *page;
-
-	gfp_mask |= __GFP_COLD;
-#if 0
-	if (!(gfp_mask & __GFP_NOMEMALLOC))
-		gfp_mask |= __GFP_MEMALLOC;
-#endif
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
-#if 0
-	if (skb && page && page->pfmemalloc)
-		skb->pfmemalloc = true;
-#endif
-	return page;
-}
-
-/**
- *	__skb_alloc_page - allocate a page for ps-rx for a given skb and preserve pfmemalloc data
- *	@gfp_mask: alloc_pages_node mask. Set __GFP_NOMEMALLOC if not for network packet RX
- *	@skb: skb to set pfmemalloc on if __GFP_MEMALLOC is used
- *
- * 	Allocate a new page.
- *
- * 	%NULL is returned if there is no free memory.
- */
-static inline struct page *__skb_alloc_page(gfp_t gfp_mask,
-					     struct sk_buff *skb)
-{
-	return __skb_alloc_pages(gfp_mask, skb, 0);
-}
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #ifndef NETDEV_FRAG_PAGE_MAX_ORDER
 #define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
@@ -164,129 +118,6 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 
-#define skb_frag_size_set LINUX_BACKPORT(skb_frag_size_set)
-static inline void skb_frag_size_set(skb_frag_t *frag, unsigned int size)
-{
-	frag->size = size;
-}
-
-#define skb_frag_size_add LINUX_BACKPORT(skb_frag_size_add)
-static inline void skb_frag_size_add(skb_frag_t *frag, int delta)
-{
-	frag->size += delta;
-}
-
-#define __skb_fill_page_desc LINUX_BACKPORT(__skb_fill_page_desc)
-/**
- * __skb_fill_page_desc - initialise a paged fragment in an skb
- * @skb: buffer containing fragment to be initialised
- * @i: paged fragment index to initialise
- * @page: the page to use for this fragment
- * @off: the offset to the data with @page
- * @size: the length of the data
- *
- * Initialises the @i'th fragment of @skb to point to &size bytes at
- * offset @off within @page.
- *
- * Does not take any additional reference on the fragment.
- */
-static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
-					struct page *page, int off, int size)
-{
-	skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-
-	/*
-	 * Propagate page->pfmemalloc to the skb if we can. The problem is
-	 * that not all callers have unique ownership of the page. If
-	 * pfmemalloc is set, we check the mapping as a mapping implies
-	 * page->index is set (index and pfmemalloc share space).
-	 * If it's a valid mapping, we cannot use page->pfmemalloc but we
-	 * do not lose pfmemalloc information as the pages would not be
-	 * allocated using __GFP_MEMALLOC.
-	 */
-	frag->page		  = page;
-	frag->page_offset	  = off;
-	skb_frag_size_set(frag, size);
-
-#if 0 /* we can't backport this for older kernels */
-	page = compound_head(page);
-	if (page->pfmemalloc && !page->mapping)
-		skb->pfmemalloc	= true;
-#endif
-}
-
-#define skb_fill_page_desc LINUX_BACKPORT(skb_fill_page_desc)
-/**
- * skb_fill_page_desc - initialise a paged fragment in an skb
- * @skb: buffer containing fragment to be initialised
- * @i: paged fragment index to initialise
- * @page: the page to use for this fragment
- * @off: the offset to the data with @page
- * @size: the length of the data
- *
- * As per __skb_fill_page_desc() -- initialises the @i'th fragment of
- * @skb to point to @size bytes at offset @off within @page. In
- * addition updates @skb such that @i is the last fragment.
- *
- * Does not take any additional reference on the fragment.
- */
-static inline void skb_fill_page_desc(struct sk_buff *skb, int i,
-				      struct page *page, int off, int size)
-{
-	__skb_fill_page_desc(skb, i, page, off, size);
-	skb_shinfo(skb)->nr_frags = i + 1;
-}
-
-#define __skb_frag_ref LINUX_BACKPORT(__skb_frag_ref)
-/**
- * __skb_frag_ref - take an addition reference on kb_frag_page paged fragment.
- * @frag: the paged fragment
- *
- * Takes an additional reference on the paged fragment @frag.
- */
-static inline void __skb_frag_ref(skb_frag_t *frag)
-{
-	get_page(skb_frag_page(frag));
-}
-
-#define skb_frag_ref LINUX_BACKPORT(skb_frag_ref)
-/**
- * skb_frag_ref - take an addition reference on a paged fragment of an skb.
- * @skb: the buffer
- * @f: the fragment offset.
- *
- * Takes an additional reference on the @f'th paged fragment of @skb.
- */
-static inline void skb_frag_ref(struct sk_buff *skb, int f)
-{
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
-}
-
-#define __skb_frag_unref LINUX_BACKPORT(__skb_frag_unref)
-/**
- * __skb_frag_unref - release a reference on a paged fragment.
- * @frag: the paged fragment
- *
- * Releases a reference on the paged fragment @frag.
- */
-static inline void __skb_frag_unref(skb_frag_t *frag)
-{
-	put_page(skb_frag_page(frag));
-}
-
-#define skb_frag_unref LINUX_BACKPORT(skb_frag_unref)
-/**
- * skb_frag_unref - release a reference on a paged fragment of an skb.
- * @skb: the buffer
- * @f: the fragment offset
- *
- * Releases a reference on the @f'th paged fragment of @skb.
- */
-static inline void skb_frag_unref(struct sk_buff *skb, int f)
-{
-	__skb_frag_unref(&skb_shinfo(skb)->frags[f]);
-}
-
 #define skb_frag_address_safe LINUX_BACKPORT(skb_frag_address_safe)
 /**
  * skb_frag_address_safe - gets the address of the data contained in a paged fragment
@@ -303,34 +134,6 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 
 	return ptr + frag->page_offset;
 }
-
-#define __skb_frag_set_page LINUX_BACKPORT(__skb_frag_set_page)
-/**
- * __skb_frag_set_page - sets the page contained in a paged fragment
- * @frag: the paged fragment
- * @page: the page to set
- *
- * Sets the fragment @frag to contain @page.
- */
-static inline void __skb_frag_set_page(skb_frag_t *frag, struct page *page)
-{
-	frag->page = page;
-}
-
-#define skb_frag_set_page LINUX_BACKPORT(skb_frag_set_page)
-/**
- * skb_frag_set_page - sets the page contained in a paged fragment of an skb
- * @skb: the buffer
- * @f: the fragment offset
- * @page: the page to set
- *
- * Sets the @f'th fragment of @skb to contain @page.
- */
-static inline void skb_frag_set_page(struct sk_buff *skb, int f,
-				     struct page *page)
-{
-	__skb_frag_set_page(&skb_shinfo(skb)->frags[f], page);
-}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) && \
-- 
1.9.1

