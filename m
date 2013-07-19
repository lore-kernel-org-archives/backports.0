Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45797 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3GSWQA (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 18:16:00 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4736958pdi.41
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 15:16:00 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 08/10] backports: add clock enable/disable on soc_camera_power_[on|off]()
Date: Fri, 19 Jul 2013 15:13:27 -0700
Message-Id: <1374272009-26152-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001602_208673_97665CBD)
In-Reply-To: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

v4l2-core now supports enabling and disabling its own clock
on turning the camera on / off. We backport v4l2-core fully
so just backport the soc calls appropriately to let SOC cameras
to turn the clock on / off when the v4l2-core clock ops are
implemented on a device driver.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../backport-include/uapi/linux/v4l2-mediabus.h    |    8 +++--
 backport/compat/compat-3.4.c                       |   31 ++++++++++++++++----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/backport/backport-include/uapi/linux/v4l2-mediabus.h b/backport/backport-include/uapi/linux/v4l2-mediabus.h
index 9979c23..962f044 100644
--- a/backport/backport-include/uapi/linux/v4l2-mediabus.h
+++ b/backport/backport-include/uapi/linux/v4l2-mediabus.h
@@ -20,15 +20,19 @@
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
 #if defined(CPTCFG_VIDEO_DEV_MODULE)
 
+#include <media/v4l2-clk.h>
+
 struct soc_camera_subdev_desc;
 
 #define soc_camera_power_on LINUX_BACKPORT(soc_camera_power_on)
 int soc_camera_power_on(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd);
+			struct soc_camera_subdev_desc *ssdd,
+			struct v4l2_clk *clk);
 
 #define soc_camera_power_off LINUX_BACKPORT(soc_camera_power_off)
 int soc_camera_power_off(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd);
+			struct soc_camera_subdev_desc *ssdd,
+			struct v4l2_clk *clk);
 
 #endif /* defined(CPTCFG_VIDEO_DEV_MODULE) */
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index b72c69c..99dfb0c 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -38,14 +38,21 @@
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
 
 #if defined(CPTCFG_VIDEO_V4L2_MODULE)
+#include <media/v4l2-clk.h>
 int soc_camera_power_on(struct device *dev,
-			struct soc_camera_subdev_desc *ssdd)
+			struct soc_camera_subdev_desc *ssdd,
+			struct v4l2_clk *clk)
 {
-	int ret = regulator_bulk_enable(ssdd->num_regulators,
+	int ret = clk ? v4l2_clk_enable(clk) : 0;
+	if (ret < 0) {
+		dev_err(dev, "Cannot enable clock: %d\n", ret);
+		return ret;
+	}
+	ret = regulator_bulk_enable(ssdd->num_regulators,
 					ssdd->regulators);
 	if (ret < 0) {
 		dev_err(dev, "Cannot enable regulators\n");
-		return ret;
+		goto eregenable;
 	}
 
 	if (ssdd->power) {
@@ -53,17 +60,26 @@ int soc_camera_power_on(struct device *dev,
 		if (ret < 0) {
 			dev_err(dev,
 				"Platform failed to power-on the camera.\n");
-			regulator_bulk_disable(ssdd->num_regulators,
-					       ssdd->regulators);
+			goto epwron;
 		}
 	}
 
+	return 0;
+
+epwron:
+	regulator_bulk_disable(ssdd->num_regulators,
+			       ssdd->regulators);
+eregenable:
+	if (clk)
+		v4l2_clk_disable(clk);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(soc_camera_power_on);
 
 int soc_camera_power_off(struct device *dev,
-			 struct soc_camera_subdev_desc *ssdd)
+			 struct soc_camera_subdev_desc *ssdd,
+			 struct v4l2_clk *clk)
 {
 	int ret = 0;
 	int err;
@@ -84,6 +100,9 @@ int soc_camera_power_off(struct device *dev,
 		ret = ret ? : err;
 	}
 
+	if (clk)
+		v4l2_clk_disable(clk);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(soc_camera_power_off);
-- 
1.7.10.4

