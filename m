Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37445 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbbLFNSg (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:36 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/12] header: add led_set_brightness_sync() for kernel 4.4
Date: Sun,  6 Dec 2015 14:18:22 +0100
Message-Id: <1449407908-15547-7-git-send-email-hauke@hauke-m.de> (sfid-20151206_141840_722732_D55204E1)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

led_set_brightness_sync() is not available in kernel 4.4-rc3, add it
also for this kernel version. In addition fix the LINUX_BACKPORT line.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/leds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index d6e2cef..53b3066 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -38,9 +38,9 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
 #endif
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && \
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) && \
     LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
-#define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
+#define led_set_brightness_sync LINUX_BACKPORT(led_set_brightness_sync)
 /**
  * led_set_brightness_sync - set LED brightness synchronously
  * @led_cdev: the LED to set
@@ -54,7 +54,7 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
  */
 extern int led_set_brightness_sync(struct led_classdev *led_cdev,
 				   enum led_brightness value);
-#endif /* < 4.4 && >= 3.19 */
+#endif /* < 4.5 && >= 3.19 */
 
 #include <backport/leds-disabled.h>
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
