Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34007 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbaG0WKz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/9] backports: do not use dma_buf_vmap() on kernel < 3.5
Date: Mon, 28 Jul 2014 00:10:37 +0200
Message-Id: <1406499039-16212-8-git-send-email-hauke@hauke-m.de> (sfid-20140728_001102_853317_933FE66B)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The dma function dma_buf_vmap() is not available on kernel < 3.5,
remove the call from the media subsystem code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 218dc25..cb77442 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -206,7 +206,18 @@
  
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -267,6 +267,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -98,8 +98,10 @@ static void *vb2_dc_vaddr(void *buf_priv
+ {
+ 	struct vb2_dc_buf *buf = buf_priv;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	if (!buf->vaddr && buf->db_attach)
+ 		buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
++#endif
+ 
+ 	return buf->vaddr;
+ }
+@@ -270,6 +272,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  }
  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
  
@@ -230,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -849,6 +852,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -857,6 +862,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -238,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -857,7 +861,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -865,7 +871,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -248,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -865,10 +871,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -873,10 +881,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
-- 
1.9.1

