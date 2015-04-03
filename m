Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39194 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] patches: remove usage of vb2_ioctl_expbuf()
Date: Fri,  3 Apr 2015 19:15:40 +0200
Message-Id: <1428081342-5933-10-git-send-email-hauke@hauke-m.de> (sfid-20150403_192435_707041_286AA93A)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

vb2_ioctl_expbuf() was patched out in backports, but it was still used
in some drivers. This patch removes also the references to that missing
function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 2aced37..60690a5 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -386,6 +386,18 @@
  
  /* struct v4l2_file_operations helpers */
  
+--- a/drivers/media/platform/am437x/am437x-vpfe.c
++++ b/drivers/media/platform/am437x/am437x-vpfe.c
+@@ -2266,7 +2266,9 @@ static const struct v4l2_ioctl_ops vpfe_
+ 	.vidioc_querybuf		= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= vb2_ioctl_streamon,
+ 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+ 
 --- a/drivers/media/platform/coda/coda-common.c
 +++ b/drivers/media/platform/coda/coda-common.c
 @@ -831,7 +831,9 @@ static const struct v4l2_ioctl_ops coda_
@@ -398,6 +410,54 @@
  	.vidioc_dqbuf		= coda_dqbuf,
  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
  
+--- a/drivers/media/platform/davinci/vpbe_display.c
++++ b/drivers/media/platform/davinci/vpbe_display.c
+@@ -1249,7 +1249,9 @@ static const struct v4l2_ioctl_ops vpbe_
+ 	.vidioc_dqbuf		 = vb2_ioctl_dqbuf,
+ 	.vidioc_streamon	 = vb2_ioctl_streamon,
+ 	.vidioc_streamoff	 = vb2_ioctl_streamoff,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf		 = vb2_ioctl_expbuf,
++#endif
+ 
+ 	.vidioc_cropcap		 = vpbe_display_cropcap,
+ 	.vidioc_g_crop		 = vpbe_display_g_crop,
+--- a/drivers/media/platform/davinci/vpif_capture.c
++++ b/drivers/media/platform/davinci/vpif_capture.c
+@@ -1260,7 +1260,9 @@ static const struct v4l2_ioctl_ops vpif_
+ 	.vidioc_querybuf		= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= vb2_ioctl_streamon,
+ 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+ 
+--- a/drivers/media/platform/davinci/vpif_display.c
++++ b/drivers/media/platform/davinci/vpif_display.c
+@@ -1059,7 +1059,9 @@ static const struct v4l2_ioctl_ops vpif_
+ 	.vidioc_querybuf		= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= vb2_ioctl_streamon,
+ 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+ 
+--- a/drivers/media/platform/exynos4-is/fimc-capture.c
++++ b/drivers/media/platform/exynos4-is/fimc-capture.c
+@@ -1372,7 +1372,9 @@ static const struct v4l2_ioctl_ops fimc_
+ 	.vidioc_querybuf		= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+ 	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+ 
 --- a/drivers/media/platform/exynos4-is/fimc-m2m.c
 +++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
 @@ -538,7 +538,9 @@ static const struct v4l2_ioctl_ops fimc_
@@ -410,6 +470,18 @@
  	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
  	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
  	.vidioc_g_crop			= fimc_m2m_g_crop,
+--- a/drivers/media/platform/vivid/vivid-core.c
++++ b/drivers/media/platform/vivid/vivid-core.c
+@@ -572,7 +572,9 @@ static const struct v4l2_ioctl_ops vivid
+ 	.vidioc_querybuf		= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= vb2_ioctl_streamon,
+ 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+ 
 --- a/drivers/media/platform/vim2m.c
 +++ b/drivers/media/platform/vim2m.c
 @@ -697,7 +697,9 @@ static const struct v4l2_ioctl_ops vim2m
@@ -422,6 +494,18 @@
  
  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
  	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
+--- a/drivers/media/usb/au0828/au0828-video.c
++++ b/drivers/media/usb/au0828/au0828-video.c
+@@ -1678,7 +1678,9 @@ static const struct v4l2_ioctl_ops video
+ 	.vidioc_querybuf            = vb2_ioctl_querybuf,
+ 	.vidioc_qbuf                = vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf               = vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf               = vb2_ioctl_expbuf,
++#endif
+ 
+ 	.vidioc_s_std               = vidioc_s_std,
+ 	.vidioc_g_std               = vidioc_g_std,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
 @@ -373,9 +373,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
-- 
1.9.1

