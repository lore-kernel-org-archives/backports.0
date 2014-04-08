Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35842 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDci (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:38 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so405388pab.9
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:38 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Ian Campbell <ian.campbell@citrix.com>
Subject: [PATCH 02/12] backports: backport APIs for manipulating skb page fragments
Date: Mon,  7 Apr 2014 20:32:13 -0700
Message-Id: <1396927943-25589-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053253_727628_511FFC58)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports the APIs for manipulating skb page fragments
introduced by Ian via commit 131ea6675c on v3.2. Use the
LINUX_BACKPORT() namespace to avoid clashes with similar ports.
We skip skb_frag_dma_map() as that was already backported.
We also don't backport skb_frag_page() as that was already
backported before.

Since the skb fragment page was moved into its own struct as
part of the fragment our backport ends up using the old access
mechanisms for the framgement page. For details see a8605c6063.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 131ea6675c
v3.2-rc1~129^2~421

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains a8605c6063
v3.2-rc1~182^2~29

commit 131ea6675c761f655d43b808dd0fe83d15d5cdd3
Author: Ian Campbell <Ian.Campbell@citrix.com>
Date:   Fri Aug 19 06:25:00 2011 +0000

    net: add APIs for manipulating skb page fragments.

    The primary aim is to add skb_frag_(ref|unref) in order to remove the use of
    bare get/put_page on SKB pages fragments and to isolate users from subsequent
    changes to the skb_frag_t data structure.

    Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Eric Dumazet <eric.dumazet@gmail.com>
    Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
    Cc: netdev@vger.kernel.org
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Ian Campbell <ian.campbell@citrix.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/skbuff.h | 159 +++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2a63e95..a7eca13 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -311,4 +311,163 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+
+#define __skb_fill_page_desc LINUX_BACKPORT(__skb_fill_page_desc)
+/**
+ * __skb_fill_page_desc - initialise a paged fragment in an skb
+ * @skb: buffer containing fragment to be initialised
+ * @i: paged fragment index to initialise
+ * @page: the page to use for this fragment
+ * @off: the offset to the data with @page
+ * @size: the length of the data
+ *
+ * Initialises the @i'th fragment of @skb to point to &size bytes at
+ * offset @off within @page.
+ *
+ * Does not take any additional reference on the fragment.
+ */
+static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
+					struct page *page, int off, int size)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+	/*
+	 * Propagate page->pfmemalloc to the skb if we can. The problem is
+	 * that not all callers have unique ownership of the page. If
+	 * pfmemalloc is set, we check the mapping as a mapping implies
+	 * page->index is set (index and pfmemalloc share space).
+	 * If it's a valid mapping, we cannot use page->pfmemalloc but we
+	 * do not lose pfmemalloc information as the pages would not be
+	 * allocated using __GFP_MEMALLOC.
+	 */
+	frag->page		  = page;
+	frag->page_offset	  = off;
+	skb_frag_size_set(frag, size);
+
+#if 0 /* we can't backport this for older kernels */
+	page = compound_head(page);
+	if (page->pfmemalloc && !page->mapping)
+		skb->pfmemalloc	= true;
+#endif
+}
+
+#define skb_fill_page_desc LINUX_BACKPORT(skb_fill_page_desc)
+/**
+ * skb_fill_page_desc - initialise a paged fragment in an skb
+ * @skb: buffer containing fragment to be initialised
+ * @i: paged fragment index to initialise
+ * @page: the page to use for this fragment
+ * @off: the offset to the data with @page
+ * @size: the length of the data
+ *
+ * As per __skb_fill_page_desc() -- initialises the @i'th fragment of
+ * @skb to point to @size bytes at offset @off within @page. In
+ * addition updates @skb such that @i is the last fragment.
+ *
+ * Does not take any additional reference on the fragment.
+ */
+static inline void skb_fill_page_desc(struct sk_buff *skb, int i,
+				      struct page *page, int off, int size)
+{
+	__skb_fill_page_desc(skb, i, page, off, size);
+	skb_shinfo(skb)->nr_frags = i + 1;
+}
+
+#define __skb_frag_ref LINUX_BACKPORT(__skb_frag_ref)
+/**
+ * __skb_frag_ref - take an addition reference on kb_frag_page paged fragment.
+ * @frag: the paged fragment
+ *
+ * Takes an additional reference on the paged fragment @frag.
+ */
+static inline void __skb_frag_ref(skb_frag_t *frag)
+{
+	get_page(skb_frag_page(frag));
+}
+
+#define skb_frag_ref LINUX_BACKPORT(skb_frag_ref)
+/**
+ * skb_frag_ref - take an addition reference on a paged fragment of an skb.
+ * @skb: the buffer
+ * @f: the fragment offset.
+ *
+ * Takes an additional reference on the @f'th paged fragment of @skb.
+ */
+static inline void skb_frag_ref(struct sk_buff *skb, int f)
+{
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+}
+
+#define __skb_frag_unref LINUX_BACKPORT(__skb_frag_unref)
+/**
+ * __skb_frag_unref - release a reference on a paged fragment.
+ * @frag: the paged fragment
+ *
+ * Releases a reference on the paged fragment @frag.
+ */
+static inline void __skb_frag_unref(skb_frag_t *frag)
+{
+	put_page(skb_frag_page(frag));
+}
+
+#define skb_frag_unref LINUX_BACKPORT(skb_frag_unref)
+/**
+ * skb_frag_unref - release a reference on a paged fragment of an skb.
+ * @skb: the buffer
+ * @f: the fragment offset
+ *
+ * Releases a reference on the @f'th paged fragment of @skb.
+ */
+static inline void skb_frag_unref(struct sk_buff *skb, int f)
+{
+	__skb_frag_unref(&skb_shinfo(skb)->frags[f]);
+}
+
+#define skb_frag_address_safe LINUX_BACKPORT(skb_frag_address_safe)
+/**
+ * skb_frag_address_safe - gets the address of the data contained in a paged fragment
+ * @frag: the paged fragment buffer
+ *
+ * Returns the address of the data within @frag. Checks that the page
+ * is mapped and returns %NULL otherwise.
+ */
+static inline void *skb_frag_address_safe(const skb_frag_t *frag)
+{
+	void *ptr = page_address(skb_frag_page(frag));
+	if (unlikely(!ptr))
+		return NULL;
+
+	return ptr + frag->page_offset;
+}
+
+#define __skb_frag_set_page LINUX_BACKPORT(__skb_frag_set_page)
+/**
+ * __skb_frag_set_page - sets the page contained in a paged fragment
+ * @frag: the paged fragment
+ * @page: the page to set
+ *
+ * Sets the fragment @frag to contain @page.
+ */
+static inline void __skb_frag_set_page(skb_frag_t *frag, struct page *page)
+{
+	frag->page = page;
+}
+
+#define skb_frag_set_page LINUX_BACKPORT(skb_frag_set_page)
+/**
+ * skb_frag_set_page - sets the page contained in a paged fragment of an skb
+ * @skb: the buffer
+ * @f: the fragment offset
+ * @page: the page to set
+ *
+ * Sets the @f'th fragment of @skb to contain @page.
+ */
+static inline void skb_frag_set_page(struct sk_buff *skb, int f,
+				     struct page *page)
+{
+	__skb_frag_set_page(&skb_shinfo(skb)->frags[f], page);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.5.3

