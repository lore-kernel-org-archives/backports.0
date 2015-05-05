Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51716 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422667AbbEEMiC (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 5 May 2015 08:38:02 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: update mac80211 LED patch
Date: Tue,  5 May 2015 14:37:58 +0200
Message-Id: <1430829478-13959-1-git-send-email-johannes@sipsolutions.net> (sfid-20150505_143804_674789_96E0A16D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The recent mac80211 LED changes broke the patch, fix it
up and make it apply again.

Change-Id: I4bf9595fb947886e68fa08592bd2cd3b7965f223
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/0024-led-blink-api/mac80211.patch      | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index dd0de8f957dd..9683522f62a7 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,51 +1,51 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1276,6 +1276,9 @@ struct ieee80211_local {
- 	u32 dot11TransmittedFrameCount;
+@@ -1260,6 +1260,7 @@ struct ieee80211_local {
+ 	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 +	int tx_led_counter, rx_led_counter;
-+#endif
- 	struct led_trigger *tx_led, *rx_led, *assoc_led, *radio_led;
- 	struct tpt_led_trigger *tpt_led_trigger;
- 	char tx_led_name[32], rx_led_name[32],
---- a/net/mac80211/led.c
-+++ b/net/mac80211/led.c
-@@ -16,18 +16,36 @@
- 
- void ieee80211_led_rx(struct ieee80211_local *local)
+ 	struct led_trigger tx_led, rx_led, assoc_led, radio_led;
+ 	struct led_trigger tpt_led;
+ 	atomic_t tx_led_active, rx_led_active, assoc_led_active;
+--- a/net/mac80211/led.h
++++ b/net/mac80211/led.h
+@@ -16,22 +16,36 @@
+ static inline void ieee80211_led_rx(struct ieee80211_local *local)
  {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	unsigned long led_delay = MAC80211_BLINK_DELAY;
-+#endif
- 	if (unlikely(!local->rx_led))
+ #ifdef CONFIG_MAC80211_LEDS
+-	unsigned long led_delay = MAC80211_BLINK_DELAY;
++	unsigned long led_delay __maybe_unused = MAC80211_BLINK_DELAY;
+ 
+ 	if (!atomic_read(&local->rx_led_active))
  		return;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	led_trigger_blink_oneshot(local->rx_led, &led_delay, &led_delay, 0);
+ 	led_trigger_blink_oneshot(&local->rx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->rx_led_counter++ % 2 == 0)
-+		led_trigger_event(local->rx_led, LED_OFF);
++		led_trigger_event(&local->rx_led, LED_OFF);
 +	else
-+		led_trigger_event(local->rx_led, LED_FULL);
++		led_trigger_event(&local->rx_led, LED_FULL);
 +#endif
+ #endif
  }
  
- void ieee80211_led_tx(struct ieee80211_local *local)
+ static inline void ieee80211_led_tx(struct ieee80211_local *local)
  {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	unsigned long led_delay = MAC80211_BLINK_DELAY;
-+#endif
- 	if (unlikely(!local->tx_led))
+ #ifdef CONFIG_MAC80211_LEDS
+-	unsigned long led_delay = MAC80211_BLINK_DELAY;
++	unsigned long led_delay __maybe_unused = MAC80211_BLINK_DELAY;
+ 
+ 	if (!atomic_read(&local->tx_led_active))
  		return;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	led_trigger_blink_oneshot(local->tx_led, &led_delay, &led_delay, 0);
+ 	led_trigger_blink_oneshot(&local->tx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->tx_led_counter++ % 2 == 0)
-+		led_trigger_event(local->tx_led, LED_OFF);
++		led_trigger_event(&local->tx_led, LED_OFF);
 +	else
-+		led_trigger_event(local->tx_led, LED_FULL);
++		led_trigger_event(&local->tx_led, LED_FULL);
 +#endif
+ #endif
  }
  
- void ieee80211_led_assoc(struct ieee80211_local *local, bool associated)
-- 
2.1.4

