Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41648 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbbKWXLO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/14] patches: remove access to fwnode member in struct device
Date: Tue, 24 Nov 2015 00:11:01 +0100
Message-Id: <1448320264-15070-12-git-send-email-hauke@hauke-m.de> (sfid-20151124_002252_223292_9AA6858E)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The firmware device node was added to struct device in ce793486e
"driver core / ACPI: Represent ACPI companions using fwnode_handle" do
not access it on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0007-no-fwnode/v4l2.patch                | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0007-no-fwnode/v4l2.patch

diff --git a/patches/collateral-evolutions/media/0007-no-fwnode/v4l2.patch b/patches/collateral-evolutions/media/0007-no-fwnode/v4l2.patch
new file mode 100644
index 0000000..1535749
--- /dev/null
+++ b/patches/collateral-evolutions/media/0007-no-fwnode/v4l2.patch
@@ -0,0 +1,26 @@
+--- a/drivers/media/v4l2-core/v4l2-device.c
++++ b/drivers/media/v4l2-core/v4l2-device.c
+@@ -131,7 +131,11 @@ void v4l2_device_unregister(struct v4l2_
+ 			 * re-created by just probing the V4L2 driver.
+ 			 */
+ 			if (client &&
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 			    !client->dev.of_node && !client->dev.fwnode)
++#else
++			    !client->dev.of_node)
++#endif
+ 				i2c_unregister_device(client);
+ 			continue;
+ 		}
+@@ -140,7 +144,11 @@ void v4l2_device_unregister(struct v4l2_
+ 		if (sd->flags & V4L2_SUBDEV_FL_IS_SPI) {
+ 			struct spi_device *spi = v4l2_get_subdevdata(sd);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 			if (spi && !spi->dev.of_node && !spi->dev.fwnode)
++#else
++			if (spi && !spi->dev.of_node)
++#endif
+ 				spi_unregister_device(spi);
+ 			continue;
+ 		}
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
