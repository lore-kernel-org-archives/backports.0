Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60051 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaBHNom (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:44:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] backports: add led_trigger_blink{_oneshot}()
Date: Sat,  8 Feb 2014 14:44:25 +0100
Message-Id: <1391867070-20031-2-git-send-email-hauke@hauke-m.de> (sfid-20140208_144444_761299_A9DD81DA)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When led support is deactivated in the kernel and
CPTCFG_BACKPORT_BUILD_LEDS is set mac80211 references
led_trigger_blink_oneshot() but it is not declared anywhere.

This fixes the following build error:
net/mac80211/led.c: In function 'ieee80211_led_rx':
net/mac80211/led.c:25:2: error: implicit declaration of function 'led_trigger_blink_oneshot' [-Werror=implicit-function-declaration]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/backport/leds-disabled.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/backport/leds-disabled.h b/backport/backport-include/backport/leds-disabled.h
index 634b62f..501f2a0 100644
--- a/backport/backport-include/backport/leds-disabled.h
+++ b/backport/backport-include/backport/leds-disabled.h
@@ -163,6 +163,19 @@ static inline void led_trigger_event(struct led_trigger *trigger,
 				     enum led_brightness event)
 {
 }
+
+static inline void led_trigger_blink(struct led_trigger *trigger,
+				     unsigned long *delay_on,
+				     unsigned long *delay_off)
+{
+}
+
+static inline void led_trigger_blink_oneshot(struct led_trigger *trigger,
+					     unsigned long *delay_on,
+					     unsigned long *delay_off,
+					     int invert)
+{
+}
 #endif
 
 #endif /* __BACKPORT_LED_DISABLED_SUPPORT */
-- 
1.7.10.4

