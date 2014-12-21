Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36602 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbaLURgn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 12/16] patches: do not use DMA_ATTR_SKIP_CPU_SYNC
Date: Sun, 21 Dec 2014 18:36:26 +0100
Message-Id: <1419183390-22169-13-git-send-email-hauke@hauke-m.de> (sfid-20141221_184347_640371_6A419C35)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

DMA_ATTR_SKIP_CPU_SYNC was added to the enum with kernel 3.6. This
patch removes all calls to dma_set_attr() with this value on
kernel < 3.6.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0005-dma-no-sync/v4l2.patch              | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch

diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
new file mode 100644
index 0000000..bdb2ff3
--- /dev/null
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -0,0 +1,64 @@
+--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
++++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
+@@ -564,7 +564,9 @@ static void vb2_dc_put_userptr(void *buf
+ 	if (sgt) {
+ 		DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 		/*
+ 		 * No need to sync to CPU, it's already synced to the CPU
+ 		 * since the finish() memop will have been called before this.
+@@ -629,7 +631,9 @@ static void *vb2_dc_get_userptr(void *al
+ 	unsigned long dma_align = dma_get_cache_alignment();
+ 	DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 
+ 	/* Only cache aligned DMA transfers are reliable */
+ 	if (!IS_ALIGNED(vaddr | size, dma_align)) {
+--- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
++++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
+@@ -109,7 +109,9 @@ static void *vb2_dma_sg_alloc(void *allo
+ 	int num_pages;
+ 	DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 
+ 	if (WARN_ON(alloc_ctx == NULL))
+ 		return NULL;
+@@ -184,7 +186,9 @@ static void vb2_dma_sg_put(void *buf_pri
+ 	if (atomic_dec_and_test(&buf->refcount)) {
+ 		DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
+ 			buf->num_pages);
+ 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->nents,
+@@ -241,7 +245,9 @@ static void *vb2_dma_sg_get_userptr(void
+ 	struct sg_table *sgt;
+ 	DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 
+ 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
+ 	if (!buf)
+@@ -347,7 +353,9 @@ static void vb2_dma_sg_put_userptr(void
+ 	int i = buf->num_pages;
+ 	DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 
+ 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
+ 	       __func__, buf->num_pages);
-- 
1.9.1

