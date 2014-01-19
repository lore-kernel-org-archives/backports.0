Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58365 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaASQs3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:29 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/16] backports: fix led_trigger warning with old kernel versions
Date: Sun, 19 Jan 2014 17:47:32 +0100
Message-Id: <1390150057-11652-12-git-send-email-hauke@hauke-m.de> (sfid-20140119_174922_216064_E335BE7B)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

/drivers/net/wireless/at76c50x-usb.c: In function ‘at76_mod_init’:
/drivers/net/wireless/at76c50x-usb.c:2472:2: warning: passing argument 2 of ‘led_trigger_register_simple’ from incompatible pointer type [enabled by default]
  led_trigger_register_simple("at76_usb-tx", &ledtrig_tx);
  ^
In file included from /backport-include/linux/leds.h:3:0,
                 from /drivers/net/wireless/at76c50x-usb.c:45:
include/linux/leds.h:97:13: note: expected ‘struct led_trigger **’ but argument is of type ‘struct backport_led_trigger **’
 extern void led_trigger_register_simple(const char *name,
             ^
/drivers/net/wireless/at76c50x-usb.c: In function ‘at76_mod_exit’:
/drivers/net/wireless/at76c50x-usb.c:2484:2: warning: passing argument 1 of ‘led_trigger_unregister_simple’ from incompatible pointer type [enabled by default]
  led_trigger_unregister_simple(ledtrig_tx);
  ^
In file included from /backport-include/linux/leds.h:3:0,
                 from /drivers/net/wireless/at76c50x-usb.c:45:
include/linux/leds.h:99:13: note: expected ‘struct led_trigger *’ but argument is of type ‘struct backport_led_trigger *’
 extern void led_trigger_unregister_simple(struct led_trigger *trigger);
             ^

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/backport/leds-disabled.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/backport/leds-disabled.h b/backport/backport-include/backport/leds-disabled.h
index 1a9abec..634b62f 100644
--- a/backport/backport-include/backport/leds-disabled.h
+++ b/backport/backport-include/backport/leds-disabled.h
@@ -99,6 +99,10 @@ struct led_trigger {
 #define led_trigger_register LINUX_BACKPORT(led_trigger_register)
 #undef led_trigger_unregister
 #define led_trigger_unregister LINUX_BACKPORT(led_trigger_unregister)
+#undef led_trigger_register_simple
+#define led_trigger_register_simple LINUX_BACKPORT(led_trigger_register_simple)
+#undef led_trigger_unregister_simple
+#define led_trigger_unregister_simple LINUX_BACKPORT(led_trigger_unregister_simple)
 #undef led_trigger_event
 #define led_trigger_event LINUX_BACKPORT(led_trigger_event)
 
@@ -115,6 +119,15 @@ static inline void led_classdev_unregister(struct led_classdev *led_cdev)
 {
 }
 
+static inline void led_trigger_register_simple(const char *name,
+					       struct led_trigger **trigger)
+{
+}
+
+static inline void led_trigger_unregister_simple(struct led_trigger *trigger)
+{
+}
+
 static inline void led_blink_set(struct led_classdev *led_cdev,
 				 unsigned long *delay_on,
 				 unsigned long *delay_off)
-- 
1.7.10.4

