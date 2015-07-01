Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50504 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbGAVbp (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Jul 2015 17:31:45 -0400
Message-ID: <55945C3E.4070805@hauke-m.de> (sfid-20150701_233146_948090_65E705B5)
Date: Wed, 01 Jul 2015 23:31:42 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Florian Grandel <fgrandel@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v2] patches: fix v4l2 patch
References: <1435333743-28237-1-git-send-email-fgrandel@gmail.com> <1435759612-21587-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1435759612-21587-1-git-send-email-fgrandel@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/01/2015 04:06 PM, Florian Grandel wrote:
> Fix to support next-20160626.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
>  .../media/0005-dma-no-sync/v4l2.patch.orig         | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig

Why do you want to add a .orig file?

A similar fix is already in backports. It went into in this commit:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=c1a416852f24d166c51d8203703a1bddff1ad6f8

The current release based on kernel next-20160626 was compile tested
against all the last minor versions of kernel 3.0 to 4.1 on x86. There
could still be some problems with different kernel configurations or
with different architectures.

> 
> diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig
> new file mode 100644
> index 0000000..7c99937
> --- /dev/null
> +++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch.orig
> @@ -0,0 +1,67 @@
> +<<<<<<< HEAD
> +--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
> ++++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
> +@@ -470,7 +470,9 @@ static void vb2_dc_put_userptr(void *buf
> + 	if (sgt) {
> + 		DEFINE_DMA_ATTRS(attrs);
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 		/*
> + 		 * No need to sync to CPU, it's already synced to the CPU
> + 		 * since the finish() memop will have been called before this.
> +@@ -534,7 +536,9 @@ static void *vb2_dc_get_userptr(void *al
> + 	unsigned long dma_align = dma_get_cache_alignment();
> + 	DEFINE_DMA_ATTRS(attrs);
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 
> + 	/* Only cache aligned DMA transfers are reliable */
> + 	if (!IS_ALIGNED(vaddr | size, dma_align)) {
> +=======
> +>>>>>>> patches: fix v4l2 patch

It looks like you want to add a merge conflict here.


> +--- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
> ++++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
> +@@ -109,7 +109,9 @@ static void *vb2_dma_sg_alloc(void *allo
> + 	int num_pages;
> + 	DEFINE_DMA_ATTRS(attrs);
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 
> + 	if (WARN_ON(alloc_ctx == NULL))
> + 		return NULL;
> +@@ -185,7 +187,9 @@ static void vb2_dma_sg_put(void *buf_pri
> + 	if (atomic_dec_and_test(&buf->refcount)) {
> + 		DEFINE_DMA_ATTRS(attrs);
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
> + 			buf->num_pages);
> + 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> +@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
> + 	DEFINE_DMA_ATTRS(attrs);
> + 	struct frame_vector *vec;
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
> + 	if (!buf)
> + 		return NULL;
> +@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
> + 	int i = buf->num_pages;
> + 	DEFINE_DMA_ATTRS(attrs);
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> + 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> ++#endif
> + 
> + 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
> + 	       __func__, buf->num_pages);
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
