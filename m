Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41042 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/21] patches: do not use vidioc_expbuf function pointer in v4l
Date: Sun, 14 Jun 2015 16:29:15 +0200
Message-Id: <1434292162-2261-15-git-send-email-hauke@hauke-m.de> (sfid-20150614_163352_200568_F6432159)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

More v4l drivers are now accessing the vidioc_expbuf function pointer
in struct v4l2_ioctl_ops which we can not backport to kernel < 3.5.
This adds some more checks around the places.

We should convert this to an spatch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 91c7cda..35950ec 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -508,6 +508,64 @@
  
  	.vidioc_s_std               = vidioc_s_std,
  	.vidioc_g_std               = vidioc_g_std,
+--- a/drivers/media/usb/stk1160/stk1160-v4l.c
++++ b/drivers/media/usb/stk1160/stk1160-v4l.c
+@@ -500,7 +500,9 @@ static const struct v4l2_ioctl_ops stk11
+ 	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
+ 	.vidioc_streamon      = vb2_ioctl_streamon,
+ 	.vidioc_streamoff     = vb2_ioctl_streamoff,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf        = vb2_ioctl_expbuf,
++#endif
+ 
+ 	.vidioc_log_status  = v4l2_ctrl_log_status,
+ 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+--- a/drivers/media/usb/uvc/uvc_queue.c
++++ b/drivers/media/usb/uvc/uvc_queue.c
+@@ -270,6 +270,7 @@ int uvc_queue_buffer(struct uvc_video_qu
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ int uvc_export_buffer(struct uvc_video_queue *queue,
+ 		      struct v4l2_exportbuffer *exp)
+ {
+@@ -281,6 +282,7 @@ int uvc_export_buffer(struct uvc_video_q
+ 
+ 	return ret;
+ }
++#endif
+ 
+ int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
+ 		       int nonblocking)
+--- a/drivers/media/usb/uvc/uvc_v4l2.c
++++ b/drivers/media/usb/uvc/uvc_v4l2.c
+@@ -720,6 +720,7 @@ static int uvc_ioctl_qbuf(struct file *f
+ 	return uvc_queue_buffer(&stream->queue, buf);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ static int uvc_ioctl_expbuf(struct file *file, void *fh,
+ 			    struct v4l2_exportbuffer *exp)
+ {
+@@ -731,6 +732,7 @@ static int uvc_ioctl_expbuf(struct file
+ 
+ 	return uvc_export_buffer(&stream->queue, exp);
+ }
++#endif
+ 
+ static int uvc_ioctl_dqbuf(struct file *file, void *fh, struct v4l2_buffer *buf)
+ {
+@@ -1487,7 +1489,9 @@ const struct v4l2_ioctl_ops uvc_ioctl_op
+ 	.vidioc_reqbufs = uvc_ioctl_reqbufs,
+ 	.vidioc_querybuf = uvc_ioctl_querybuf,
+ 	.vidioc_qbuf = uvc_ioctl_qbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf = uvc_ioctl_expbuf,
++#endif
+ 	.vidioc_dqbuf = uvc_ioctl_dqbuf,
+ 	.vidioc_create_bufs = uvc_ioctl_create_bufs,
+ 	.vidioc_streamon = uvc_ioctl_streamon,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
 @@ -379,9 +379,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
-- 
2.1.4

