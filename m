Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:38839 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaFHKmL (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 8 Jun 2014 06:42:11 -0400
Received: by mail-ve0-f180.google.com with SMTP id jw12so2454408veb.11
        for <backports@vger.kernel.org>; Sun, 08 Jun 2014 03:42:10 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 8 Jun 2014 16:12:09 +0530
Message-ID: <CAG+h2qi3htAKG0gbw2r1uB=sVso3z1pif8NcJ7dm_zW6OTtvqQ@mail.gmail.com> (sfid-20140608_124215_754717_11B0C41E)
Subject: [PATCH] backports: Fixes for handling rsi wireless driver for various
 kernel versions
From: Fariya <fariyaf@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Please find the attached patch which contains code to make the rsi
wireless driver to compile on various kernels.

Signed-off-by: Fariya Fatima <fariyaf@gmail.com>


diff -uprN rsi_original/rsi_91x_core.c rsi_patched/rsi_91x_core.c
--- rsi_original/rsi_91x_core.c    2014-06-08 16:31:39.922284046 +0530
+++ rsi_patched/rsi_91x_core.c    2014-06-08 03:15:01.064949776 +0530
@@ -340,5 +340,9 @@ void rsi_core_xmit(struct rsi_common *co
 xmit_fail:
     rsi_dbg(ERR_ZONE, "%s: Failed to queue packet\n", __func__);
     /* Dropping pkt here */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)//for 3.2 kernel
     ieee80211_free_txskb(common->priv->hw, skb);
+#else
+    dev_kfree_skb(skb);
+#endif
 }
diff -uprN rsi_original/rsi_91x_mac80211.c rsi_patched/rsi_91x_mac80211.c
--- rsi_original/rsi_91x_mac80211.c    2014-06-08 16:31:39.922284046 +0530
+++ rsi_patched/rsi_91x_mac80211.c    2014-06-08 02:59:46.464414507 +0530
@@ -237,14 +237,27 @@ void rsi_indicate_tx_status(struct rsi_h
  *
  * Return: None
  */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0)
 static void rsi_mac80211_tx(struct ieee80211_hw *hw,
                 struct ieee80211_tx_control *control,
                 struct sk_buff *skb)
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
+static void rsi_mac80211_tx(struct ieee80211_hw *hw,
+                struct sk_buff *skb)
+#else
+static int rsi_mac80211_tx(struct ieee80211_hw *hw,
+               struct sk_buff *skb)
+#endif
 {
     struct rsi_hw *adapter = hw->priv;
     struct rsi_common *common = adapter->priv;

     rsi_core_xmit(common, skb);
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 38)
+    return 0;
+#else
+    return;
+#endif
 }

 /**
@@ -358,7 +371,11 @@ static int rsi_mac80211_config(struct ie

     mutex_lock(&common->mutex);
     if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
         struct ieee80211_channel *curchan = hw->conf.chandef.chan;
+#else
+        struct ieee80211_channel *curchan = hw->conf.channel;
+#endif
         u16 channel = curchan->hw_value;

         rsi_dbg(INFO_ZONE,
@@ -382,12 +399,19 @@ static int rsi_mac80211_config(struct ie
  */
 u16 rsi_get_connected_channel(struct rsi_hw *adapter)
 {
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
     struct ieee80211_vif *vif = adapter->vifs[0];
     if (vif) {
         struct ieee80211_bss_conf *bss = &vif->bss_conf;
         struct ieee80211_channel *channel = bss->chandef.chan;
         return channel->hw_value;
     }
+#else
+    struct ieee80211_hw *hw = adapter->hw;
+    struct ieee80211_channel *channel = hw->conf.channel;
+    return channel->hw_value;
+#endif

     return 0;
 }
@@ -453,15 +477,25 @@ static void rsi_mac80211_conf_filter(str
  *
  * Return: 0 on success, negative error code on failure.
  */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)
 static int rsi_mac80211_conf_tx(struct ieee80211_hw *hw,
                 struct ieee80211_vif *vif, u16 queue,
                 const struct ieee80211_tx_queue_params *params)
+#else
+static int rsi_mac80211_conf_tx(struct ieee80211_hw *hw,
+                u16 queue,
+                const struct ieee80211_tx_queue_params *params)
+#endif
 {
     struct rsi_hw *adapter = hw->priv;
     struct rsi_common *common = adapter->priv;
     u8 idx = 0;

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)
     if (queue >= IEEE80211_NUM_ACS)
+#else
+    if (queue >= IEEE80211_MAX_QUEUES)
+#endif
         return 0;

     rsi_dbg(INFO_ZONE,
@@ -612,6 +646,14 @@ static int rsi_mac80211_set_key(struct i
  *
  * Return: status: 0 on success, negative error code on failure.
  */
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 38)
+static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
+                     struct ieee80211_vif *vif,
+                     enum ieee80211_ampdu_mlme_action action,
+                     struct ieee80211_sta *sta,
+                     unsigned short tid,
+                     unsigned short *ssn)
+#else
 static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
                      struct ieee80211_vif *vif,
                      enum ieee80211_ampdu_mlme_action action,
@@ -619,12 +661,17 @@ static int rsi_mac80211_ampdu_action(str
                      unsigned short tid,
                      unsigned short *ssn,
                      unsigned char buf_size)
+#endif
 {
     int status = -EOPNOTSUPP;
     struct rsi_hw *adapter = hw->priv;
     struct rsi_common *common = adapter->priv;
     u16 seq_no = 0;
     u8 ii = 0;
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 38)
+    u8 buf_size = 6;
+    /* FIXME hw->max_tx_aggregation_subframes; */
+#endif

     for (ii = 0; ii < RSI_MAX_VIFS; ii++) {
         if (vif == adapter->vifs[ii])
@@ -658,9 +705,13 @@ static int rsi_mac80211_ampdu_action(str
         ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
         break;

+#if LINUX_VERSION_CODE > KERNEL_VERSION(3, 8, 0)
     case IEEE80211_AMPDU_TX_STOP_CONT:
     case IEEE80211_AMPDU_TX_STOP_FLUSH:
     case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+#else
+    case IEEE80211_AMPDU_TX_STOP:
+#endif
         status = rsi_send_aggregation_params_frame(common,
                                tid,
                                seq_no,
@@ -708,6 +759,7 @@ static int rsi_mac80211_set_rts_threshol
     return 0;
 }

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
 /**
  * rsi_mac80211_set_rate_mask() - This function sets bitrate_mask to be used.
  * @hw: Pointer to the ieee80211_hw structure
@@ -727,17 +779,27 @@ static int rsi_mac80211_set_rate_mask(st

     common->fixedrate_mask[IEEE80211_BAND_2GHZ] = 0;

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 4, 0)
     if (mask->control[IEEE80211_BAND_2GHZ].legacy == 0xfff) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0)
         common->fixedrate_mask[IEEE80211_BAND_2GHZ] =
             (mask->control[IEEE80211_BAND_2GHZ].ht_mcs[0] << 12);
+#else
+        common->fixedrate_mask[IEEE80211_BAND_2GHZ] =
+            (mask->control[IEEE80211_BAND_2GHZ].mcs[0] << 12);
+#endif
     } else {
+#endif
         common->fixedrate_mask[IEEE80211_BAND_2GHZ] =
             mask->control[IEEE80211_BAND_2GHZ].legacy;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 4, 0)
     }
+#endif
     mutex_unlock(&common->mutex);

     return 0;
 }
+#endif

 /**
  * rsi_fill_rx_status() - This function fills rx status in
@@ -774,7 +836,11 @@ static void rsi_fill_rx_status(struct ie
     else
         rxs->band = IEEE80211_BAND_5GHZ;

+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 38)
+    freq = ieee80211_channel_to_frequency(channel);
+#else
     freq = ieee80211_channel_to_frequency(channel, rxs->band);
+#endif

     if (freq)
         rxs->freq = freq;
@@ -822,7 +888,11 @@ static void rsi_set_min_rate(struct ieee
                  struct ieee80211_sta *sta,
                  struct rsi_common *common)
 {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
     u8 band = hw->conf.chandef.chan->band;
+#else
+    u8 band = hw->conf.channel->band;
+#endif
     u8 ii;
     u32 rate_bitmap;
     bool matched = false;
@@ -844,6 +914,7 @@ static void rsi_set_min_rate(struct ieee

     common->vif_info[0].is_ht = sta->ht_cap.ht_supported;

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 4, 0)
     if ((common->vif_info[0].is_ht) && (rate_bitmap >> 12)) {
         for (ii = 0; ii < ARRAY_SIZE(rsi_mcsrates); ii++) {
             if ((rate_bitmap >> 12) & BIT(ii)) {
@@ -853,6 +924,7 @@ static void rsi_set_min_rate(struct ieee
             }
         }
     }
+#endif

     if (!matched)
         common->min_rate = 0xffff;
@@ -934,7 +1006,9 @@ static struct ieee80211_ops mac80211_ops
     .configure_filter = rsi_mac80211_conf_filter,
     .set_key = rsi_mac80211_set_key,
     .set_rts_threshold = rsi_mac80211_set_rts_threshold,
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
     .set_bitrate_mask = rsi_mac80211_set_rate_mask,
+#endif
     .ampdu_action = rsi_mac80211_ampdu_action,
     .sta_add = rsi_mac80211_sta_add,
     .sta_remove = rsi_mac80211_sta_remove,
@@ -980,13 +1054,20 @@ int rsi_mac80211_attach(struct rsi_commo
     hw->max_rates = 1;
     hw->max_rate_tries = MAX_RETRIES;

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
     hw->max_tx_aggregation_subframes = 6;
+#endif
     rsi_register_rates_channels(adapter, IEEE80211_BAND_2GHZ);
     hw->rate_control_algorithm = "AARF";

     SET_IEEE80211_PERM_ADDR(hw, common->mac_addr);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0)
     ether_addr_copy(hw->wiphy->addr_mask, addr_mask);

+#else
+    memcpy(hw->wiphy->addr_mask, addr_mask, ETH_ALEN);
+
+#endif
     wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
     wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
     wiphy->retry_short = RETRY_SHORT;
diff -uprN rsi_original/rsi_91x_mgmt.c rsi_patched/rsi_91x_mgmt.c
--- rsi_original/rsi_91x_mgmt.c    2014-06-08 16:31:39.922284046 +0530
+++ rsi_patched/rsi_91x_mgmt.c    2014-06-08 03:00:11.072536532 +0530
@@ -285,7 +285,9 @@ static int rsi_load_radio_caps(struct rs
               0xf0, 0xf0, 0xf0, 0xf0,
               0xf0, 0xf0, 0xf0, 0xf0,
               0xf0, 0xf0, 0xf0, 0xf0};
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
     struct ieee80211_conf *conf = &hw->conf;
+#endif
     struct sk_buff *skb;

     rsi_dbg(INFO_ZONE, "%s: Sending rate symbol req frame\n", __func__);
@@ -313,7 +315,11 @@ static int rsi_load_radio_caps(struct rs
             radio_caps->desc_word[5] |= cpu_to_le16(FULL40M_ENABLE);
         }

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
         if (conf_is_ht40_minus(conf)) {
+#else
+        if (hw->conf.channel_type == NL80211_CHAN_HT40MINUS) {
+#endif
             radio_caps->desc_word[5] = 0;
             radio_caps->desc_word[5] |=
                 cpu_to_le16(LOWER_20_ENABLE);
@@ -321,7 +327,11 @@ static int rsi_load_radio_caps(struct rs
                 cpu_to_le16(LOWER_20_ENABLE >> 12);
         }

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
         if (conf_is_ht40_plus(conf)) {
+#else
+        if (hw->conf.channel_type == NL80211_CHAN_HT40PLUS) {
+#endif
             radio_caps->desc_word[5] = 0;
             radio_caps->desc_word[5] |=
                 cpu_to_le16(UPPER_20_ENABLE);
@@ -477,7 +487,11 @@ static int rsi_hal_send_sta_notify_frame
     }

     peer_notify->command |= cpu_to_le16((aid & 0xfff) << 4);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0)
     ether_addr_copy(peer_notify->mac_addr, bssid);
+#else
+    memcpy(peer_notify->mac_addr, bssid, ETH_ALEN);
+#endif

     peer_notify->sta_flags = cpu_to_le32((qos_enable) ? 1 : 0);

@@ -537,7 +551,9 @@ int rsi_send_aggregation_params_frame(st

     if (event == STA_TX_ADDBA_DONE) {
         mgmt_frame->desc_word[4] = cpu_to_le16(ssn);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 38)
         mgmt_frame->desc_word[5] = cpu_to_le16(buf_size);
+#endif
         mgmt_frame->desc_word[7] =
         cpu_to_le16((tid | (START_AMPDU_AGGR << 4) | (peer_id << 8)));
     } else if (event == STA_RX_ADDBA_DONE) {
@@ -948,7 +964,11 @@ static int rsi_send_auto_rate_request(st
     struct rsi_auto_rate *auto_rate;
     int ii = 0, jj = 0, kk = 0;
     struct ieee80211_hw *hw = common->priv->hw;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
     u8 band = hw->conf.chandef.chan->band;
+#else
+    u8 band = hw->conf.channel->band;
+#endif
     u8 num_supported_rates = 0;
     u8 rate_offset = 0;
     u32 rate_bitmap = common->bitrate_mask[band];
diff -uprN rsi_original/rsi_main.h rsi_patched/rsi_main.h
--- rsi_original/rsi_main.h    2014-06-08 16:31:39.922284046 +0530
+++ rsi_patched/rsi_main.h    2014-06-08 03:18:51.402091947 +0530
@@ -17,6 +17,8 @@
 #ifndef __RSI_MAIN_H__
 #define __RSI_MAIN_H__

+#include <linux/module.h>
+#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/skbuff.h>
 #include <net/mac80211.h>


-- 
-Fariya Fatima
