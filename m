Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41644 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727AbbKWXLN (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/14] backports: add led_set_brightness_sync()
Date: Tue, 24 Nov 2015 00:10:58 +0100
Message-Id: <1448320264-15070-9-git-send-email-hauke@hauke-m.de> (sfid-20151124_001116_986855_A6EFEFE5)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/leds.h | 18 ++++++++++++++++++
 backport/compat/Makefile               |  1 +
 backport/compat/backport-4.5.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 backport/compat/backport-4.5.c

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 2044abf..d6e2cef 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -38,6 +38,24 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+#define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
+/**
+ * led_set_brightness_sync - set LED brightness synchronously
+ * @led_cdev: the LED to set
+ * @brightness: the brightness to set it to
+ *
+ * Set an LED's brightness immediately. This function will block
+ * the caller for the time required for accessing device registers,
+ * and it can sleep.
+ *
+ * Returns: 0 on success or negative error value on failure
+ */
+extern int led_set_brightness_sync(struct led_classdev *led_cdev,
+				   enum led_brightness value);
+#endif /* < 4.4 && >= 3.19 */
+
 #include <backport/leds-disabled.h>
 
 #endif /* __BACKPORT_LINUX_LEDS_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index fa992e7..be9e5c6 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -30,6 +30,7 @@ compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
+compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
new file mode 100644
index 0000000..e8f9b12
--- /dev/null
+++ b/backport/compat/backport-4.5.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright(c) 2015 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.5.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/leds.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+int led_set_brightness_sync(struct led_classdev *led_cdev,
+			    enum led_brightness value)
+{
+	if (led_cdev->blink_delay_on || led_cdev->blink_delay_off)
+		return -EBUSY;
+
+	led_cdev->brightness = min(value, led_cdev->max_brightness);
+
+	if (led_cdev->flags & LED_SUSPENDED)
+		return 0;
+
+	if (led_cdev->brightness_set_sync)
+		return led_cdev->brightness_set_sync(led_cdev,
+							 led_cdev->brightness);
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(led_set_brightness_sync);
+#endif /* >= 3.19 */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
