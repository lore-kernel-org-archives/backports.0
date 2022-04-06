Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F481C4332F
	for <backports@archiver.kernel.org>; Wed,  6 Apr 2022 22:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiDFWFl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiDFWFk (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Apr 2022 18:05:40 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF81D08C2
        for <backports@vger.kernel.org>; Wed,  6 Apr 2022 15:03:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4KYdnM1Rv0z9sRD;
        Thu,  7 Apr 2022 00:03:35 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649282613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=te71ClLptfIpZOxY74cjf1J2hdqZwpXZj0Q904qeAWw=;
        b=AJQgYp6goVAReEqN8YB7lZNBmLnUZ2h/VQgr+wPVs07Zh1w5HuEtSo2ry8R3iMY9wiZkdl
        OuK/Nf1V83uHLpCrk7f9jcV2bP5bXT4/TW70Di+4o+rEv9qtjnjA3L/Ew+8lH9c6F4ucZb
        VmwggZfxQ4QA0nIgWuxGvC8xIi7hwmL8YpiiOrHrqFFS+fTbVNIDEsCwJaEvnTgkdx3bG7
        OZMLl8y37g7yLDGcarmPOcL7qGuj3oCpBLhtC6N70TBt0eqBTh+sRBrANu8ew4VyFUValm
        bGKfStBuhNle4wZ2oxHJsXxiA5q8ofL28eWysU95OuGv+zlc+NsTTMkBdoMvuw==
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] patches: Refresh on top of kernel 5.15.32
Date:   Thu,  7 Apr 2022 00:03:18 +0200
Message-Id: <20220406220321.3864576-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

patches/0097-skb-list/mac80211-rx.patch was adapted manually.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../net_wireless_core.patch                   |  2 +-
 .../net_wireless_core.patch                   |  4 ++--
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0095-spi-delay/wilc1000.patch         |  6 ++---
 patches/0097-skb-list/mac80211-rx.patch       | 24 +++++--------------
 patches/0097-skb-list/mt76.patch              | 12 +++++-----
 patches/0100-revert-small_ops/mac80211.patch  |  4 ++--
 .../mac80211_hwsim.patch                      |  4 ++--
 9 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index f175b1bc..34ed4474 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -427,6 +427,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -418,6 +418,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index b61ffd61..823013f2 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -518,10 +518,6 @@ use_default_name:
+@@ -509,10 +509,6 @@ use_default_name:
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1306,6 +1302,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1297,6 +1293,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 7dc66712..61608978 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4103,7 +4103,7 @@ static const struct genl_small_ops hwsim
+@@ -4116,7 +4116,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 301d0bea..f1887d91 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15913,7 +15913,7 @@ static const struct genl_small_ops nl802
+@@ -15925,7 +15925,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index 1cf5014b..71111710 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -217,10 +217,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -219,10 +219,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -261,10 +265,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -263,10 +267,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -306,10 +314,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -308,10 +316,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 21dfddbd..65189dd9 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2610,7 +2610,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2611,7 +2611,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,19 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4520,7 +4524,11 @@ static void ieee80211_rx_8023(struct iee
- 	skb->protocol = eth_type_trans(skb, fast_rx->dev);
- 	memset(skb->cb, 0, sizeof(skb->cb));
- 	if (rx->list)
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 		list_add_tail(&skb->list, rx->list);
-+#else
-+		__skb_queue_tail(rx->list, skb);
-+#endif
- 	else
- 		netif_receive_skb(skb);
- 
-@@ -4702,7 +4710,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4698,7 +4702,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -73,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_fast_rx *fast_rx;
-@@ -4743,7 +4755,11 @@ drop:
+@@ -4739,7 +4747,11 @@ drop:
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -85,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4868,7 +4884,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4864,7 +4876,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -97,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4992,7 +5012,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4988,7 +5004,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -111,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -5009,8 +5035,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5005,8 +5027,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index daa7d1f9..1131ea4d 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -44,7 +44,7 @@
  {
 --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-@@ -1104,7 +1104,11 @@ mt7915_txp_skb_unmap(struct mt76_dev *de
+@@ -1111,7 +1111,11 @@ mt7915_txp_skb_unmap(struct mt76_dev *de
  
  static void
  mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
@@ -56,7 +56,7 @@
  {
  	struct mt76_dev *mdev = &dev->mt76;
  	struct mt76_wcid *wcid;
-@@ -1141,10 +1145,16 @@ mt7915_mac_tx_free(struct mt7915_dev *de
+@@ -1148,10 +1152,16 @@ mt7915_mac_tx_free(struct mt7915_dev *de
  	struct mt76_phy *mphy_ext = mdev->phy2;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -74,7 +74,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1211,8 +1221,13 @@ mt7915_mac_tx_free(struct mt7915_dev *de
+@@ -1218,8 +1228,13 @@ mt7915_mac_tx_free(struct mt7915_dev *de
  
  	napi_consume_skb(skb, 1);
  
@@ -90,7 +90,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
-@@ -979,7 +979,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
+@@ -986,7 +986,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
  static void
  mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
  			  struct ieee80211_sta *sta, u8 stat,
@@ -102,7 +102,7 @@
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct ieee80211_tx_status status = {
-@@ -1049,10 +1053,16 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -1056,10 +1060,16 @@ void mt7921_mac_tx_free(struct mt7921_de
  	struct mt76_dev *mdev = &dev->mt76;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -120,7 +120,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1130,8 +1140,13 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -1137,8 +1147,13 @@ void mt7921_mac_tx_free(struct mt7921_de
  
  	napi_consume_skb(skb, 1);
  
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index 9f85a12f..d69cbff6 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15149,9 +15149,11 @@ static const struct genl_ops nl80211_ops
+@@ -15164,9 +15164,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15942,8 +15944,10 @@ static struct genl_family nl80211_fam __
+@@ -15957,8 +15959,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index a68428c0..bfbb17b9 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4066,7 +4066,11 @@ done:
+@@ -4079,7 +4079,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4110,8 +4114,13 @@ static struct genl_family hwsim_genl_fam
+@@ -4123,8 +4127,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
