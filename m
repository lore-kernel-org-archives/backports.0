Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44136 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbaFOQfv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 1AEFD7E32
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:50 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] backports: activate some more media drivers
Date: Sun, 15 Jun 2014 18:35:23 +0200
Message-Id: <1402850123-22382-7-git-send-email-hauke@hauke-m.de> (sfid-20140615_183557_096581_220DCBBB)
In-Reply-To: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
References: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These new drivers are compile tested only.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list    |  3 +++
 dependencies | 61 ++++++------------------------------------------------------
 2 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/copy-list b/copy-list
index 4550d12..d3d4147 100644
--- a/copy-list
+++ b/copy-list
@@ -175,6 +175,9 @@ include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
 include/uapi/linux/vsp1.h
 include/trace/events/v4l2.h
+drivers/staging/media/cxd2099/cxd2099.h
+include/uapi/linux/ivtv.h
+include/uapi/linux/meye.h
 
 drivers/media/
 include/linux/platform_data/vsp1.h
diff --git a/dependencies b/dependencies
index 8646698..6ee37ec 100644
--- a/dependencies
+++ b/dependencies
@@ -84,71 +84,22 @@ REGULATOR_WM8994 3.8
 
 # Media
 MEDIA_SUPPORT 3.2
-# There's something wrong with backporting this/dma-buf to 3.2,
-# so disable it for now until Luis figures it out
-MEDIA_SUPPORT 3.3
-# Some media drivers however depend on module deferral mechanism
-# Lets not enable those unless that's available.
-VIDEO_S3C_CAMIF 3.4
-VIDEO_SAMSUNG_S5P_FIMC 3.4
-IR_GPIO_CIR 3.4
+USB_GSPCA_OV534 3.5
 # Some media drivers depend on the CONFIG_REGULATOR which
 # we only support on >= 3.4 give that reguatory itself depends
 # on -EPROBE_DEFER.
 SOC_CAMERA 3.4
-SOC_CAMERA_IMX074 3.4
-SOC_CAMERA_MT9M001 3.4
-SOC_CAMERA_MT9M111 3.4
-SOC_CAMERA_MT9T031 3.4
-SOC_CAMERA_MT9T112 3.4
-SOC_CAMERA_MT9V022 3.4
-SOC_CAMERA_OV2640 3.4
-SOC_CAMERA_OV5642 3.4
-SOC_CAMERA_OV6650 3.4
-SOC_CAMERA_OV772X 3.4
-SOC_CAMERA_OV9640 3.4
-SOC_CAMERA_OV9740 3.4
-SOC_CAMERA_RJ54N1 3.4
-SOC_CAMERA_TW9910 3.4
-# There are some odd comile errors here I don't want
-# to bother with right now
-VIDEO_MEM2MEM_DEINTERLACE DISABLE
 # 49920bc6 and 1003cab8 and while it seems there is a
 # one to one map DMA_FROM_DEVICE to DMA_DEV_TO_MEM
 # I can't verify this fully yet.
 VIDEO_TIMBERDALE 3.4
-# Can't figure this out yet either
-DVB_DDBRIDGE DISABLE
-# These require I2C_CLIENT_SCCB which can't be backported
-# since the core I2C code has to know about it
-VIDEO_OV7640 3.6
-VIDEO_EM28XX 3.6
 # someone has to backport "firewire: introduce fw_driver.probe and .remove methods"
 DVB_FIREDTV 3.11
-# I give up on these guys for now
-RADIO_MAXIRADIO DISABLE
-RADIO_SHARK DISABLE
-VIDEO_IVTV DISABLE
-VIDEO_MEYE DISABLE
-DVB_NGENE DISABLE
-DVB_USB_PCTV452E DISABLE
-USB_GSPCA DISABLE
-VIDEO_MXB DISABLE
-VIDEO_RENESAS_VSP1 3.6
-
-# Drivers that depend on I2C bus segments behind multiplexers to
-# have a clas, see eee543e8. This requires quite a bit of collateral,
-# folks involved in this and who want it can backport if it they wish.
-# This was added as of 3.7. Although we should be able to only enable
-# this for 3.7 DVB_USB_RTL28XXU ends up selecting DVB_RTL2832 and
-# that seems to currently require pegging both.
-#
-# DVB_USB_RTL28XXU has a nasty ccflag usage thoug that includes staging
-# headers introduced via commit bcf43393:
-# ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
-# Let's not support this nastiness.
-DVB_RTL2832 DISABLE
-DVB_USB_RTL28XXU DISABLE
+VIDEO_RENESAS_VSP1 3.4
+VIDEO_MEM2MEM_DEINTERLACE 3.3
+MEDIA_TUNER_E4000 3.4
+DVB_USB_RTL28XXU 3.4
+VIDEO_ADV7604 3.3
 
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
-- 
1.9.1

