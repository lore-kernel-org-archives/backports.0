Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40721 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab3IKMM2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] backports: use old led api on old kernel versions.
Date: Wed, 11 Sep 2013 14:11:51 +0200
Message-Id: <1378901515-14206-8-git-send-email-hauke@hauke-m.de> (sfid-20130911_141229_451723_9ABE245B)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Usage of a new led api was introduced in mac80211, this patch make
backports use the old api on older kernel versions. This could cause a
problem with the led, the transmit led could stay on if nothing is
transfered.

This backports the following upstream commit:
commit e47f2509e5f182f4df144406de6f2bc78179d57e
Author: Fabio Baltieri <fabio.baltieri@gmail.com>
Date:   Thu Jul 25 12:00:26 2013 +0200

    mac80211: use oneshot blink API for LED triggers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/77-led-blink-api/INFO                  |   13 +++++
 .../network/77-led-blink-api/mac80211.patch        |   51 ++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/77-led-blink-api/INFO
 create mode 100644 patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch

diff --git a/patches/collateral-evolutions/network/77-led-blink-api/INFO b/patches/collateral-evolutions/network/77-led-blink-api/INFO
new file mode 100644
index 0000000..f5f4d30
--- /dev/null
+++ b/patches/collateral-evolutions/network/77-led-blink-api/INFO
@@ -0,0 +1,13 @@
+backports: use old led api on old kernel versions.
+
+Usage of a new led api was introduced in mac80211, this patch make
+backports use the old api on older kernel versions. This could cause a
+problem with the led, the transmit led could stay on if nothing is
+transfered.
+
+This backports the following upstream commit:
+commit e47f2509e5f182f4df144406de6f2bc78179d57e
+Author: Fabio Baltieri <fabio.baltieri@gmail.com>
+Date:   Thu Jul 25 12:00:26 2013 +0200
+
+    mac80211: use oneshot blink API for LED triggers
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
new file mode 100644
index 0000000..c06ba67
--- /dev/null
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -0,0 +1,51 @@
+--- a/net/mac80211/ieee80211_i.h
++++ b/net/mac80211/ieee80211_i.h
+@@ -1106,6 +1106,9 @@ struct ieee80211_local {
+ 	u32 dot11TransmittedFrameCount;
+ 
+ #ifdef CONFIG_MAC80211_LEDS
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
++	int tx_led_counter, rx_led_counter;
++#endif
+ 	struct led_trigger *tx_led, *rx_led, *assoc_led, *radio_led;
+ 	struct tpt_led_trigger *tpt_led_trigger;
+ 	char tx_led_name[32], rx_led_name[32],
+--- a/net/mac80211/led.c
++++ b/net/mac80211/led.c
+@@ -16,18 +16,36 @@
+ 
+ void ieee80211_led_rx(struct ieee80211_local *local)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	unsigned long led_delay = MAC80211_BLINK_DELAY;
++#endif
+ 	if (unlikely(!local->rx_led))
+ 		return;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	led_trigger_blink_oneshot(local->rx_led, &led_delay, &led_delay, 0);
++#else
++	if (local->rx_led_counter++ % 2 == 0)
++		led_trigger_event(local->rx_led, LED_OFF);
++	else
++		led_trigger_event(local->rx_led, LED_FULL);
++#endif
+ }
+ 
+ void ieee80211_led_tx(struct ieee80211_local *local)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	unsigned long led_delay = MAC80211_BLINK_DELAY;
++#endif
+ 	if (unlikely(!local->tx_led))
+ 		return;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	led_trigger_blink_oneshot(local->tx_led, &led_delay, &led_delay, 0);
++#else
++	if (local->tx_led_counter++ % 2 == 0)
++		led_trigger_event(local->tx_led, LED_OFF);
++	else
++		led_trigger_event(local->tx_led, LED_FULL);
++#endif
+ }
+ 
+ void ieee80211_led_assoc(struct ieee80211_local *local, bool associated)
-- 
1.7.10.4

