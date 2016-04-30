Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49610 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/16] backports: add devm_led_trigger_register()
Date: Sat, 30 Apr 2016 23:00:43 +0200
Message-Id: <1462050048-8953-12-git-send-email-hauke@hauke-m.de> (sfid-20160430_230722_446062_FF590D1F)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

devm_led_trigger_register() was added in Linux commit 9534cc31d "leds:
core: add managed version of led_trigger_register"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/leds.h |  6 ++++++
 backport/compat/backport-4.5.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 53b3066..fb4d7b3 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -56,6 +56,12 @@ extern int led_set_brightness_sync(struct led_classdev *led_cdev,
 				   enum led_brightness value);
 #endif /* < 4.5 && >= 3.19 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#define devm_led_trigger_register LINUX_BACKPORT(devm_led_trigger_register)
+extern int devm_led_trigger_register(struct device *dev,
+				     struct led_trigger *trigger);
+#endif /* < 4.5 */
+
 #include <backport/leds-disabled.h>
 
 #endif /* __BACKPORT_LINUX_LEDS_H */
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index 16306e1..bbf4f3b 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/leds.h>
 #include <linux/phy.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
@@ -122,3 +123,31 @@ void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
 	}
 }
 EXPORT_SYMBOL_GPL(phy_attached_print);
+
+static void devm_led_trigger_release(struct device *dev, void *res)
+{
+	led_trigger_unregister(*(struct led_trigger **)res);
+}
+
+int devm_led_trigger_register(struct device *dev,
+			      struct led_trigger *trig)
+{
+	struct led_trigger **dr;
+	int rc;
+
+	dr = devres_alloc(devm_led_trigger_release, sizeof(*dr),
+			  GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	*dr = trig;
+
+	rc = led_trigger_register(trig);
+	if (rc)
+		devres_free(dr);
+	else
+		devres_add(dev, dr);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(devm_led_trigger_register);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
