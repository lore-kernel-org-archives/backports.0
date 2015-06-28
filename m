Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48617 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbbF1SF0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 14:05:26 -0400
Message-ID: <55903763.3030702@hauke-m.de> (sfid-20150628_200529_139203_81B2560A)
Date: Sun, 28 Jun 2015 20:05:23 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Florian Grandel <fgrandel@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] patches: fix v4l2 patch
References: <1435333743-28237-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1435333743-28237-1-git-send-email-fgrandel@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/26/2015 05:49 PM, Florian Grandel wrote:
> Fix to support next-20160626.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
>  .../media/0005-dma-no-sync/v4l2.patch              | 30 +++-------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
> index deeddd9..9b3329b 100644
> --- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
> +++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
> @@ -1,25 +1,3 @@
> ---- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
> -+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
> -@@ -570,7 +570,9 @@ static void vb2_dc_put_userptr(void *buf
> - 	if (sgt) {
> - 		DEFINE_DMA_ATTRS(attrs);
> - 
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> - 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> -+#endif
> - 		/*
> - 		 * No need to sync to CPU, it's already synced to the CPU
> - 		 * since the finish() memop will have been called before this.
> -@@ -637,7 +639,9 @@ static void *vb2_dc_get_userptr(void *al
> - 	unsigned long dma_align = dma_get_cache_alignment();
> - 	DEFINE_DMA_ATTRS(attrs);
> - 
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
> - 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
> -+#endif
> - 
> - 	/* Only cache aligned DMA transfers are reliable */
> - 	if (!IS_ALIGNED(vaddr | size, dma_align)) {

This part is still needed.

>  --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
>  +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
>  @@ -109,7 +109,9 @@ static void *vb2_dma_sg_alloc(void *allo
> @@ -42,17 +20,17 @@
>   		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
>   			buf->num_pages);
>   		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> -@@ -242,7 +246,9 @@ static void *vb2_dma_sg_get_userptr(void
> - 	struct sg_table *sgt;
> +@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
>   	DEFINE_DMA_ATTRS(attrs);
> + 	struct frame_vector *vec;
>   
>  +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
>   	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
>  +#endif
> - 
>   	buf = kzalloc(sizeof *buf, GFP_KERNEL);
>   	if (!buf)
> -@@ -354,7 +360,9 @@ static void vb2_dma_sg_put_userptr(void
> + 		return NULL;
> +@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
>   	int i = buf->num_pages;
>   	DEFINE_DMA_ATTRS(attrs);
>   
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
