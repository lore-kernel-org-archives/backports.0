Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33090 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbGAOHP (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 1 Jul 2015 10:07:15 -0400
Received: by wgck11 with SMTP id k11so37975112wgc.0
        for <backports@vger.kernel.org>; Wed, 01 Jul 2015 07:07:14 -0700 (PDT)
From: Florian Grandel <fgrandel@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Florian Grandel <fgrandel@gmail.com>
Subject: [PATCH v2] patches: fix v4l2 patch
Date: Wed,  1 Jul 2015 16:06:52 +0200
Message-Id: <1435759612-21587-1-git-send-email-fgrandel@gmail.com> (sfid-20150701_160718_206123_02E13620)
In-Reply-To: <1435333743-28237-1-git-send-email-fgrandel@gmail.com>
References: <1435333743-28237-1-git-send-email-fgrandel@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Fix to support next-20160626.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 .../media/0005-dma-no-sync/v4l2.patch.orig         | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig

diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig
new file mode 100644
index 0000000..7c99937
--- /dev/null
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig
@@ -0,0 +1,67 @@
+<<<<<<< HEAD
+--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
++++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
+@@ -470,7 +470,9 @@ static void vb2_dc_put_userptr(void *buf
+ 	if (sgt) {
+ 		DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 		/*
+ 		 * No need to sync to CPU, it's already synced to the CPU
+ 		 * since the finish() memop will have been called before this.
+@@ -534,7 +536,9 @@ static void *vb2_dc_get_userptr(void *al
+ 	unsigned long dma_align = dma_get_cache_alignment();
+ 	DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 
+ 	/* Only cache aligned DMA transfers are reliable */
+ 	if (!IS_ALIGNED(vaddr | size, dma_align)) {
+=======
+>>>>>>> patches: fix v4l2 patch
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
+@@ -185,7 +187,9 @@ static void vb2_dma_sg_put(void *buf_pri
+ 	if (atomic_dec_and_test(&buf->refcount)) {
+ 		DEFINE_DMA_ATTRS(attrs);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
+ 			buf->num_pages);
+ 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
+ 	DEFINE_DMA_ATTRS(attrs);
+ 	struct frame_vector *vec;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
++#endif
+ 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
+ 	if (!buf)
+ 		return NULL;
+@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
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

--
To unsubscribe from this list: send the line "unsubscribe backports" in
