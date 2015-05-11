Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49114 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbbEKVq6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:46:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] patches: add ifdef around vb2_ioctl_expbuf()
Date: Mon, 11 May 2015 23:46:46 +0200
Message-Id: <1431380808-28885-2-git-send-email-hauke@hauke-m.de> (sfid-20150511_234701_854684_CC785F92)
In-Reply-To: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
References: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There are some new places where vb2_ioctl_expbuf() is used, add ifdefs
around these palaces.

This should be replaced by a spatch or something else.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index ed096b7..827cce2 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -552,3 +552,39 @@
  	.cookie		= vb2_dma_sg_cookie,
  };
  EXPORT_SYMBOL_GPL(vb2_dma_sg_memops);
+--- a/drivers/media/platform/xilinx/xilinx-dma.c
++++ b/drivers/media/platform/xilinx/xilinx-dma.c
+@@ -628,7 +628,9 @@ static const struct v4l2_ioctl_ops xvip_
+ 	.vidioc_qbuf			= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+ 	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= vb2_ioctl_streamon,
+ 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+ };
+--- a/drivers/media/platform/marvell-ccic/mcam-core.c
++++ b/drivers/media/platform/marvell-ccic/mcam-core.c
+@@ -1586,7 +1586,9 @@ static const struct v4l2_ioctl_ops mcam_
+ 	.vidioc_querybuf	= vb2_ioctl_querybuf,
+ 	.vidioc_qbuf		= vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf		= vb2_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf		= vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon	= vb2_ioctl_streamon,
+ 	.vidioc_streamoff	= vb2_ioctl_streamoff,
+ 	.vidioc_g_parm		= mcam_vidioc_g_parm,
+--- a/drivers/media/pci/dt3155/dt3155.c
++++ b/drivers/media/pci/dt3155/dt3155.c
+@@ -415,7 +415,9 @@ static const struct v4l2_ioctl_ops dt315
+ 	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+ 	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+ 	.vidioc_querybuf = vb2_ioctl_querybuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf = vb2_ioctl_expbuf,
++#endif
+ 	.vidioc_qbuf = vb2_ioctl_qbuf,
+ 	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+ 	.vidioc_streamon = vb2_ioctl_streamon,
-- 
2.1.4

