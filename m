Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55512 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbcGOTBm (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 15 Jul 2016 15:01:42 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: luca@coelho.fi, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 1/2] backports: add some scatterlist backports for <3.9 and <3.11
Date: Fri, 15 Jul 2016 21:01:34 +0200
Message-Id: <1468609295-25792-1-git-send-email-johannes@sipsolutions.net> (sfid-20160715_210145_170482_5CDC9777)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

There were some changes and additions in kernel 3.9 and again in 3.11.
Add the needed backports accordingly.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/scatterlist.h |  92 ++++++++++++++
 backport/compat/Makefile                      |   1 +
 backport/compat/backport-3.11.c               | 124 +++++++++++++++++++
 backport/compat/compat-3.9.c                  | 166 ++++++++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 backport/backport-include/linux/scatterlist.h
 create mode 100644 backport/compat/backport-3.11.c

diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
new file mode 100644
index 000000000000..47335588ad85
--- /dev/null
+++ b/backport/backport-include/linux/scatterlist.h
@@ -0,0 +1,92 @@
+#ifndef __BACKPORT_SCATTERLIST_H
+#define __BACKPORT_SCATTERLIST_H
+#include_next <linux/scatterlist.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+/*
+ * sg page iterator
+ *
+ * Iterates over sg entries page-by-page.  On each successful iteration,
+ * @piter->page points to the current page, @piter->sg to the sg holding this
+ * page and @piter->sg_pgoffset to the page's page offset within the sg. The
+ * iteration will stop either when a maximum number of sg entries was reached
+ * or a terminating sg (sg_last(sg) == true) was reached.
+ */
+struct sg_page_iter {
+	struct page             *page;          /* current page */
+	struct scatterlist      *sg;            /* sg holding the page */
+	unsigned int            sg_pgoffset;    /* page offset within the sg */
+
+	/* these are internal states, keep away */
+	unsigned int            __nents;        /* remaining sg entries */
+	int                     __pg_advance;   /* nr pages to advance at the
+						 * next step */
+};
+
+struct backport_sg_mapping_iter {
+	/* the following three fields can be accessed directly */
+	struct page		*page;		/* currently mapped page */
+	void			*addr;		/* pointer to the mapped area */
+	size_t			length;		/* length of the mapped area */
+	size_t			consumed;	/* number of consumed bytes */
+	struct sg_page_iter	piter;		/* page iterator */
+
+	/* these are internal states, keep away */
+	unsigned int		__offset;	/* offset within page */
+	unsigned int		__remaining;	/* remaining bytes on page */
+	unsigned int		__flags;
+};
+#define sg_mapping_iter LINUX_BACKPORT(sg_mapping_iter)
+
+/**
+ * sg_page_iter_page - get the current page held by the page iterator
+ * @piter:	page iterator holding the page
+ */
+static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
+{
+	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+}
+
+bool __sg_page_iter_next(struct sg_page_iter *piter);
+void __sg_page_iter_start(struct sg_page_iter *piter,
+			  struct scatterlist *sglist, unsigned int nents,
+			  unsigned long pgoffset);
+
+void backport_sg_miter_start(struct sg_mapping_iter *miter, struct scatterlist *sgl,
+		    unsigned int nents, unsigned int flags);
+bool backport_sg_miter_next(struct sg_mapping_iter *miter);
+void backport_sg_miter_stop(struct sg_mapping_iter *miter);
+#define sg_miter_start LINUX_BACKPORT(sg_miter_start)
+#define sg_miter_next LINUX_BACKPORT(sg_miter_next)
+#define sg_miter_stop LINUX_BACKPORT(sg_miter_stop)
+
+/**
+ * for_each_sg_page - iterate over the pages of the given sg list
+ * @sglist:    sglist to iterate over
+ * @piter:     page iterator to hold current page, sg, sg_pgoffset
+ * @nents:     maximum number of sg entries to iterate over
+ * @pgoffset:  starting page offset
+ */
+#define for_each_sg_page(sglist, piter, nents, pgoffset)		\
+	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
+	     __sg_page_iter_next(piter);)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
+size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
+		      size_t buflen, off_t skip, bool to_buffer);
+
+#define sg_pcopy_to_buffer LINUX_BACKPORT(sg_pcopy_to_buffer)
+
+static inline
+size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
+			  void *buf, size_t buflen, off_t skip)
+{
+	return sg_copy_buffer(sgl, nents, buf, buflen, skip, true);
+}
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0) */
+
+#endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 6013083e22b1..8cf1a7b83c8f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -18,6 +18,7 @@ compat-$(CPTCFG_KERNEL_3_7) += compat-3.7.o
 compat-$(CPTCFG_KERNEL_3_8) += compat-3.8.o
 compat-$(CPTCFG_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_KERNEL_3_10) += backport-3.10.o
+compat-$(CPTCFG_KERNEL_3_11) += backport-3.11.o
 compat-$(CPTCFG_KERNEL_3_12) += backport-3.12.o
 compat-$(CPTCFG_KERNEL_3_13) += backport-3.13.o
 compat-$(CPTCFG_KERNEL_3_14) += backport-3.14.o
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
new file mode 100644
index 000000000000..7f9ff3419344
--- /dev/null
+++ b/backport/compat/backport-3.11.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) 2016 Intel Deutschland GmbH
+ *
+ * Backport functionality introduced in Linux 3.11.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+
+static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
+{
+	if (!miter->__remaining) {
+		struct scatterlist *sg;
+		unsigned long pgoffset;
+
+		if (!__sg_page_iter_next(&miter->piter))
+			return false;
+
+		sg = miter->piter.sg;
+		pgoffset = miter->piter.sg_pgoffset;
+
+		miter->__offset = pgoffset ? 0 : sg->offset;
+		miter->__remaining = sg->offset + sg->length -
+				(pgoffset << PAGE_SHIFT) - miter->__offset;
+		miter->__remaining = min_t(unsigned long, miter->__remaining,
+					   PAGE_SIZE - miter->__offset);
+	}
+
+	return true;
+}
+
+/**
+ * sg_miter_skip - reposition mapping iterator
+ * @miter: sg mapping iter to be skipped
+ * @offset: number of bytes to plus the current location
+ *
+ * Description:
+ *   Sets the offset of @miter to its current location plus @offset bytes.
+ *   If mapping iterator @miter has been proceeded by sg_miter_next(), this
+ *   stops @miter.
+ *
+ * Context:
+ *   Don't care if @miter is stopped, or not proceeded yet.
+ *   Otherwise, preemption disabled if the SG_MITER_ATOMIC is set.
+ *
+ * Returns:
+ *   true if @miter contains the valid mapping.  false if end of sg
+ *   list is reached.
+ */
+static bool sg_miter_skip(struct sg_mapping_iter *miter, off_t offset)
+{
+	sg_miter_stop(miter);
+
+	while (offset) {
+		off_t consumed;
+
+		if (!sg_miter_get_next_page(miter))
+			return false;
+
+		consumed = min_t(off_t, offset, miter->__remaining);
+		miter->__offset += consumed;
+		miter->__remaining -= consumed;
+		offset -= consumed;
+	}
+
+	return true;
+}
+
+/**
+ * sg_copy_buffer - Copy data between a linear buffer and an SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy from
+ * @buflen:		 The number of bytes to copy
+ * @skip:		 Number of bytes to skip before copying
+ * @to_buffer:		 transfer direction (true == from an sg list to a
+ *			 buffer, false == from a buffer to an sg list
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
+		      size_t buflen, off_t skip, bool to_buffer)
+{
+	unsigned int offset = 0;
+	struct sg_mapping_iter miter;
+	unsigned long flags;
+	unsigned int sg_flags = SG_MITER_ATOMIC;
+
+	if (to_buffer)
+		sg_flags |= SG_MITER_FROM_SG;
+	else
+		sg_flags |= SG_MITER_TO_SG;
+
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+
+	if (!sg_miter_skip(&miter, skip))
+		return false;
+
+	local_irq_save(flags);
+
+	while (sg_miter_next(&miter) && offset < buflen) {
+		unsigned int len;
+
+		len = min(miter.length, buflen - offset);
+
+		if (to_buffer)
+			memcpy(buf + offset, miter.addr, len);
+		else
+			memcpy(miter.addr, buf + offset, len);
+
+		offset += len;
+	}
+
+	sg_miter_stop(&miter);
+
+	local_irq_restore(flags);
+	return offset;
+}
+EXPORT_SYMBOL_GPL(sg_copy_buffer);
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 5a4f52390cbe..93889b550327 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -15,6 +15,8 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <linux/scatterlist.h>
+#include <linux/highmem.h>
 #include <net/inet_frag.h>
 #include <net/sock.h>
 
@@ -70,3 +72,167 @@ void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
 		LIMIT_NETDEBUG(KERN_WARNING "%s%s", prefix, msg);
 }
 EXPORT_SYMBOL_GPL(inet_frag_maybe_warn_overflow);
+
+void __sg_page_iter_start(struct sg_page_iter *piter,
+			  struct scatterlist *sglist, unsigned int nents,
+			  unsigned long pgoffset)
+{
+	piter->__pg_advance = 0;
+	piter->__nents = nents;
+
+	piter->page = NULL;
+	piter->sg = sglist;
+	piter->sg_pgoffset = pgoffset;
+}
+EXPORT_SYMBOL_GPL(__sg_page_iter_start);
+
+static int sg_page_count(struct scatterlist *sg)
+{
+	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
+}
+
+bool __sg_page_iter_next(struct sg_page_iter *piter)
+{
+	if (!piter->__nents || !piter->sg)
+		return false;
+
+	piter->sg_pgoffset += piter->__pg_advance;
+	piter->__pg_advance = 1;
+
+	while (piter->sg_pgoffset >= sg_page_count(piter->sg)) {
+		piter->sg_pgoffset -= sg_page_count(piter->sg);
+		piter->sg = sg_next(piter->sg);
+		if (!--piter->__nents || !piter->sg)
+			return false;
+	}
+	piter->page = nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(__sg_page_iter_next);
+
+static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
+{
+	if (!miter->__remaining) {
+		struct scatterlist *sg;
+		unsigned long pgoffset;
+
+		if (!__sg_page_iter_next(&miter->piter))
+			return false;
+
+		sg = miter->piter.sg;
+		pgoffset = miter->piter.sg_pgoffset;
+
+		miter->__offset = pgoffset ? 0 : sg->offset;
+		miter->__remaining = sg->offset + sg->length -
+				(pgoffset << PAGE_SHIFT) - miter->__offset;
+		miter->__remaining = min_t(unsigned long, miter->__remaining,
+					   PAGE_SIZE - miter->__offset);
+	}
+
+	return true;
+}
+
+/**
+ * sg_miter_start - start mapping iteration over a sg list
+ * @miter: sg mapping iter to be started
+ * @sgl: sg list to iterate over
+ * @nents: number of sg entries
+ *
+ * Description:
+ *   Starts mapping iterator @miter.
+ *
+ * Context:
+ *   Don't care.
+ */
+void backport_sg_miter_start(struct sg_mapping_iter *miter, struct scatterlist *sgl,
+		    unsigned int nents, unsigned int flags)
+{
+	memset(miter, 0, sizeof(struct sg_mapping_iter));
+
+	__sg_page_iter_start(&miter->piter, sgl, nents, 0);
+	WARN_ON(!(flags & (SG_MITER_TO_SG | SG_MITER_FROM_SG)));
+	miter->__flags = flags;
+}
+EXPORT_SYMBOL_GPL(backport_sg_miter_start);
+
+/**
+ * sg_miter_next - proceed mapping iterator to the next mapping
+ * @miter: sg mapping iter to proceed
+ *
+ * Description:
+ *   Proceeds @miter to the next mapping.  @miter should have been started
+ *   using sg_miter_start().  On successful return, @miter->page,
+ *   @miter->addr and @miter->length point to the current mapping.
+ *
+ * Context:
+ *   Preemption disabled if SG_MITER_ATOMIC.  Preemption must stay disabled
+ *   till @miter is stopped.  May sleep if !SG_MITER_ATOMIC.
+ *
+ * Returns:
+ *   true if @miter contains the next mapping.  false if end of sg
+ *   list is reached.
+ */
+bool backport_sg_miter_next(struct sg_mapping_iter *miter)
+{
+	sg_miter_stop(miter);
+
+	/*
+	 * Get to the next page if necessary.
+	 * __remaining, __offset is adjusted by sg_miter_stop
+	 */
+	if (!sg_miter_get_next_page(miter))
+		return false;
+
+	miter->page = sg_page_iter_page(&miter->piter);
+	miter->consumed = miter->length = miter->__remaining;
+
+	if (miter->__flags & SG_MITER_ATOMIC)
+		miter->addr = kmap_atomic(miter->page) + miter->__offset;
+	else
+		miter->addr = kmap(miter->page) + miter->__offset;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(backport_sg_miter_next);
+
+/**
+ * sg_miter_stop - stop mapping iteration
+ * @miter: sg mapping iter to be stopped
+ *
+ * Description:
+ *   Stops mapping iterator @miter.  @miter should have been started
+ *   using sg_miter_start().  A stopped iteration can be resumed by
+ *   calling sg_miter_next() on it.  This is useful when resources (kmap)
+ *   need to be released during iteration.
+ *
+ * Context:
+ *   Preemption disabled if the SG_MITER_ATOMIC is set.  Don't care
+ *   otherwise.
+ */
+void backport_sg_miter_stop(struct sg_mapping_iter *miter)
+{
+	WARN_ON(miter->consumed > miter->length);
+
+	/* drop resources from the last iteration */
+	if (miter->addr) {
+		miter->__offset += miter->consumed;
+		miter->__remaining -= miter->consumed;
+
+		if ((miter->__flags & SG_MITER_TO_SG) &&
+		    !PageSlab(miter->page))
+			flush_kernel_dcache_page(miter->page);
+
+		if (miter->__flags & SG_MITER_ATOMIC) {
+			WARN_ON_ONCE(preemptible());
+			kunmap_atomic(miter->addr);
+		} else
+			kunmap(miter->page);
+
+		miter->page = NULL;
+		miter->addr = NULL;
+		miter->length = 0;
+		miter->consumed = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(backport_sg_miter_stop);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
