Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:45688 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab3EFVw1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 17:52:27 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so2258513pdc.14
        for <backports@vger.kernel.org>; Mon, 06 May 2013 14:52:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 2/4] compat: backport soc_camera_power_[on|off] for 3.3
Date: Mon,  6 May 2013 14:52:06 -0700
Message-Id: <1367877128-10812-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235228_822481_B6CB3DBD)
In-Reply-To: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We are only backporting CONFIG_SOC_CAMERA for kernels >= 3.4
but there is an exported symbol from there that some media
drivers that we do support on 3.3 need. Handle this special
case.

SOC_CAMERA is only enabled on 3.4 as it depends on some
newer regulator functionality, however there are some SOC
cameras that can rely on the 3.3 regulatory built-in core
and the 3.3 SOC_CAMERA module however two routines are
not exported in that version of SOC_CAMERA that newer
SOC cameras do require. Backport that functionality.

Technically this should go into <media/soc_camera.h>
given that is where its where its exported on linux-next
but in practice only placing it on <linux/v4l2-mediabus.h>
actually fixes linking errors for 3.3 for all SOC camera
drivers we make available for 3.3:

  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/imx074.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/mt9m001.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/mt9m111.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/mt9t031.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/mt9t112.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/mt9v022.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov2640.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov5642.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov6650.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov772x.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov9640.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/ov9740.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/rj54n1cb0c.ko
  LD [M]  /home/mcgrof/build/drivers/media/i2c/soc_camera/tw9910.ko

This fixes all pending linking errors on 3.3.

$ time ckmake --check-exports --allyesconfig

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  LINK  ]
22  3.5.7               [  LINK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

real    30m14.581s
user    796m34.495s
sys     126m46.807s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile.kernel                           |    1 +
 .../backport-include/uapi/linux/v4l2-mediabus.h    |   39 +++++++++++
 backport/compat/compat-3.4.c                       |   73 ++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 backport/backport-include/uapi/linux/v4l2-mediabus.h

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 6781533..f3544da 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -5,6 +5,7 @@ backport-cc-disable-warning = $(call try-run,\
 
 NOSTDINC_FLAGS := \
 	-I$(M)/backport-include/ \
+	-I$(M)/backport-include/uapi \
 	-I$(M)/include/ \
 	-I$(M)/include/uapi \
 	-I$(M)/include/drm \
diff --git a/backport/backport-include/uapi/linux/v4l2-mediabus.h b/backport/backport-include/uapi/linux/v4l2-mediabus.h
new file mode 100644
index 0000000..9979c23
--- /dev/null
+++ b/backport/backport-include/uapi/linux/v4l2-mediabus.h
@@ -0,0 +1,39 @@
+#ifndef __BACKPORT_LINUX_V4L2_MEDIABUS_H
+#define __BACKPORT_LINUX_V4L2_MEDIABUS_H
+#include <linux/version.h>
+
+/*
+ * SOC_CAMERA is only enabled on 3.4 as it depends on some
+ * newer regulator functionality, however there are some SOC
+ * cameras that can rely on the 3.3 regulatory built-in core
+ * and the 3.3 SOC_CAMERA module however two routines are
+ * not exported in that version of SOC_CAMERA that newer
+ * SOC cameras do require. Backport that functionality.
+ *
+ * Technically this should go into <media/soc_camera.h>
+ * given that is where its where its exported on linux-next
+ * but in practice only placing it here actually fixes linking
+ * errors for 3.3 for all SOC camera drivers we make available
+ * for 3.3.
+ */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#if defined(CPTCFG_VIDEO_DEV_MODULE)
+
+struct soc_camera_subdev_desc;
+
+#define soc_camera_power_on LINUX_BACKPORT(soc_camera_power_on)
+int soc_camera_power_on(struct device *dev,
+			struct soc_camera_subdev_desc *ssdd);
+
+#define soc_camera_power_off LINUX_BACKPORT(soc_camera_power_off)
+int soc_camera_power_off(struct device *dev,
+			struct soc_camera_subdev_desc *ssdd);
+
+#endif /* defined(CPTCFG_VIDEO_DEV_MODULE) */
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
+
+#include_next <linux/v4l2-mediabus.h>
+
+#endif /* __BACKPORT_LINUX_V4L2_MEDIABUS_H */
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index eec311a..1718cd2 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -16,9 +16,82 @@
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#if defined(CPTCFG_VIDEO_DEV_MODULE)
+#include <media/soc_camera.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-dev.h>
+#include <media/videobuf-core.h>
+#include <media/videobuf2-core.h>
+#include <media/soc_mediabus.h>
+#include <linux/regulator/consumer.h>
+#endif /* defined(CPTCFG_VIDEO_DEV_MODULE) */
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+
+#if defined(CPTCFG_VIDEO_V4L2_MODULE)
+int soc_camera_power_on(struct device *dev,
+			struct soc_camera_subdev_desc *ssdd)
+{
+	int ret = regulator_bulk_enable(ssdd->num_regulators,
+					ssdd->regulators);
+	if (ret < 0) {
+		dev_err(dev, "Cannot enable regulators\n");
+		return ret;
+	}
+
+	if (ssdd->power) {
+		ret = ssdd->power(dev, 1);
+		if (ret < 0) {
+			dev_err(dev,
+				"Platform failed to power-on the camera.\n");
+			regulator_bulk_disable(ssdd->num_regulators,
+					       ssdd->regulators);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(soc_camera_power_on);
+
+int soc_camera_power_off(struct device *dev,
+			 struct soc_camera_subdev_desc *ssdd)
+{
+	int ret = 0;
+	int err;
+
+	if (ssdd->power) {
+		err = ssdd->power(dev, 0);
+		if (err < 0) {
+			dev_err(dev,
+			        "Platform failed to power-off the camera.\n");
+			ret = err;
+		}
+	}
+
+	err = regulator_bulk_disable(ssdd->num_regulators,
+				     ssdd->regulators);
+	if (err < 0) {
+		dev_err(dev, "Cannot disable regulators\n");
+		ret = ret ? : err;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(soc_camera_power_off);
+#endif /* defined(CPTCFG_VIDEO_V4L2_MODULE) */
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)) */
+
 #if defined(CONFIG_REGMAP)
 static void devm_regmap_release(struct device *dev, void *res)
 {
-- 
1.7.10.4

