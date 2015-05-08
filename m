Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:36274 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbbEHUnF (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 8 May 2015 16:43:05 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] network: led-blink: update mac80211 patch
Date: Fri, 8 May 2015 22:42:59 +0200
Message-ID: <1431117779-21388-1-git-send-email-arend@broadcom.com> (sfid-20150508_224307_242020_AB5455B2)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 .../network/0024-led-blink-api/mac80211.patch      | 36 ++++++++++++----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index de7f5b2..0f443f1 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,51 +1,55 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1277,6 +1277,9 @@ struct ieee80211_local {
- 	u32 dot11TransmittedFrameCount;
+@@ -1260,6 +1260,9 @@ struct ieee80211_local {
+ 	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 +	int tx_led_counter, rx_led_counter;
 +#endif
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
+@@ -16,22 +16,38 @@
+ static inline void ieee80211_led_rx(struct ieee80211_local *local)
  {
+ #ifdef CONFIG_MAC80211_LEDS
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  	unsigned long led_delay = MAC80211_BLINK_DELAY;
+-
 +#endif
- 	if (unlikely(!local->rx_led))
+ 	if (!atomic_read(&local->rx_led_active))
  		return;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	led_trigger_blink_oneshot(local->rx_led, &led_delay, &led_delay, 0);
+ 	led_trigger_blink_oneshot(&local->rx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->rx_led_counter++ % 2 == 0)
 +		led_trigger_event(local->rx_led, LED_OFF);
 +	else
 +		led_trigger_event(local->rx_led, LED_FULL);
 +#endif
+ #endif
  }
  
- void ieee80211_led_tx(struct ieee80211_local *local)
+ static inline void ieee80211_led_tx(struct ieee80211_local *local)
  {
+ #ifdef CONFIG_MAC80211_LEDS
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  	unsigned long led_delay = MAC80211_BLINK_DELAY;
+-
 +#endif
- 	if (unlikely(!local->tx_led))
+ 	if (!atomic_read(&local->tx_led_active))
  		return;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	led_trigger_blink_oneshot(local->tx_led, &led_delay, &led_delay, 0);
+ 	led_trigger_blink_oneshot(&local->tx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->tx_led_counter++ % 2 == 0)
 +		led_trigger_event(local->tx_led, LED_OFF);
 +	else
 +		led_trigger_event(local->tx_led, LED_FULL);
 +#endif
+ #endif
  }
  
- void ieee80211_led_assoc(struct ieee80211_local *local, bool associated)
-- 
1.9.1

