Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48706 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/14] header: add led_trigger_remove() prototpye
Date: Sun, 28 Jun 2015 23:59:13 +0200
Message-Id: <1435528760-19913-8-git-send-email-hauke@hauke-m.de> (sfid-20150628_235938_233382_E3C24F5B)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The led_trigger_remove() function is exported on older kernel versions,
but there is no pubic prototype for this function. Now the first driver
makes use of this function and this patch adds the prototype.
There is no LINUX_BACKPORT() guard here because we want it to point to
the original function which is exported normally.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/leds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 22679cf..2044abf 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -26,6 +26,18 @@
 #define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+/*
+ * There is no LINUX_BACKPORT() guard here because we want it to point to
+ * the original function which is exported normally.
+ */
+#ifdef CONFIG_LEDS_TRIGGERS
+extern void led_trigger_remove(struct led_classdev *led_cdev);
+#else
+static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
+#endif
+#endif
+
 #include <backport/leds-disabled.h>
 
 #endif /* __BACKPORT_LINUX_LEDS_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
