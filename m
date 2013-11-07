Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55866 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab3KGU2j (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] backports: remove soc_camera_power_{on,off}()
Date: Thu,  7 Nov 2013 21:27:57 +0100
Message-Id: <1383856078-19823-11-git-send-email-hauke@hauke-m.de> (sfid-20131107_212840_523971_0FA65517)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

backports already exports these functions in
drivers/media/platform/soc_camera/soc_camera.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../backport-include/uapi/linux/v4l2-mediabus.h    |   43 ---------
 backport/compat/compat-3.4.c                       |   91 --------------------
 2 files changed, 134 deletions(-)
 delete mode 100644 backport/backport-include/uapi/linux/v4l2-mediabus.h

diff --git a/backport/backport-include/uapi/linux/v4l2-mediabus.h b/backport/backport-include/uapi/linux/v4l2-mediabus.h
deleted file mode 100644
index 962f044..0000000
--- a/backport/backport-include/uapi/linux/v4l2-mediabus.h
+++ /dev/null
@@ -1,43 +0,0 @@
-#ifndef __BACKPORT_LINUX_V4L2_MEDIABUS_H
-#define __BACKPORT_LINUX_V4L2_MEDIABUS_H
-#include <linux/version.h>
-
-/*
- * SOC_CAMERA is only enabled on 3.4 as it depends on some
- * newer regulator functionality, however there are some SOC
- * cameras that can rely on the 3.3 regulatory built-in core
- * and the 3.3 SOC_CAMERA module however two routines are
- * not exported in that version of SOC_CAMERA that newer
- * SOC cameras do require. Backport that functionality.
- *
- * Technically this should go into <media/soc_camera.h>
- * given that is where its where its exported on linux-next
- * but in practice only placing it here actually fixes linking
- * errors for 3.3 for all SOC camera drivers we make available
- * for 3.3.
- */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-#if defined(CPTCFG_VIDEO_DEV_MODULE)
-
-#include <media/v4l2-clk.h>
-
-struct soc_camera_subdev_desc;
-
-#define soc_camera_power_on LINUX_BACKPORT(soc_camera_power_on)
-int soc_camera_power_on(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd,
-			struct v4l2_clk *clk);
-
-#define soc_camera_power_off LINUX_BACKPORT(soc_camera_power_off)
-int soc_camera_power_off(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd,
-			struct v4l2_clk *clk);
-
-#endif /* defined(CPTCFG_VIDEO_DEV_MODULE) */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
-
-#include_next <linux/v4l2-mediabus.h>
-
-#endif /* __BACKPORT_LINUX_V4L2_MEDIABUS_H */
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index f1d6178..fafe0df 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -16,101 +16,10 @@
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-#if defined(CPTCFG_VIDEO_DEV_MODULE)
-#include <media/soc_camera.h>
-#include <media/v4l2-common.h>
-#include <media/v4l2-ioctl.h>
-#include <media/v4l2-dev.h>
-#include <media/videobuf-core.h>
-#include <media/videobuf2-core.h>
-#include <media/soc_mediabus.h>
-#include <linux/regulator/consumer.h>
-#endif /* defined(CPTCFG_VIDEO_DEV_MODULE) */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-
-#if defined(CPTCFG_VIDEO_V4L2_MODULE)
-#include <media/v4l2-clk.h>
-int soc_camera_power_on(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd,
-			struct v4l2_clk *clk)
-{
-	int ret = clk ? v4l2_clk_enable(clk) : 0;
-	if (ret < 0) {
-		dev_err(dev, "Cannot enable clock: %d\n", ret);
-		return ret;
-	}
-	ret = regulator_bulk_enable(ssdd->num_regulators,
-					ssdd->regulators);
-	if (ret < 0) {
-		dev_err(dev, "Cannot enable regulators\n");
-		goto eregenable;
-	}
-
-	if (ssdd->power) {
-		ret = ssdd->power(dev, 1);
-		if (ret < 0) {
-			dev_err(dev,
-				"Platform failed to power-on the camera.\n");
-			goto epwron;
-		}
-	}
-
-	return 0;
-
-epwron:
-	regulator_bulk_disable(ssdd->num_regulators,
-			       ssdd->regulators);
-eregenable:
-	if (clk)
-		v4l2_clk_disable(clk);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(soc_camera_power_on);
-
-int soc_camera_power_off(struct device *dev,
-			 struct soc_camera_subdev_desc *ssdd,
-			 struct v4l2_clk *clk)
-{
-	int ret = 0;
-	int err;
-
-	if (ssdd->power) {
-		err = ssdd->power(dev, 0);
-		if (err < 0) {
-			dev_err(dev,
-			        "Platform failed to power-off the camera.\n");
-			ret = err;
-		}
-	}
-
-	err = regulator_bulk_disable(ssdd->num_regulators,
-				     ssdd->regulators);
-	if (err < 0) {
-		dev_err(dev, "Cannot disable regulators\n");
-		ret = ret ? : err;
-	}
-
-	if (clk)
-		v4l2_clk_disable(clk);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(soc_camera_power_off);
-#endif /* defined(CPTCFG_VIDEO_V4L2_MODULE) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
-
 #if defined(CONFIG_REGMAP)
 static void devm_regmap_release(struct device *dev, void *res)
 {
-- 
1.7.10.4

