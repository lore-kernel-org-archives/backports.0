Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E103C4321E
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA61061052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJSVqE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJSVp6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45604C06176E
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLQ2HB1zQk1x;
        Tue, 19 Oct 2021 23:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKevlDWGo57TFgHFfpGmJdRH5BQ2/TBhPVh8OU/J7C4=;
        b=g/6NvWB99lZzQqX8GhklS2ZyCZk1nz5mZXQfAE/B8ZgP+dxfTLOaTz/fuLeJri9jPuSlgY
        iqBHuLU6PE8nZ+xzPcgG3PfMzPaEMpjJnoM68JMmi1++sL5GpcnPkvGg698I2CkPg83HLU
        5sgJYiHI6tRPjP6qV46G1NBcejZupAU5c0wXyWgBeAkN5gHW2gIh/Ps/rSmkjakLRN2YFr
        t3ARIz0q5kjEFZCyAZ2pPrlnH+nOR9OB6CJ/yxOQi47HiVFPrsl6rihsANBNgmDMshfuXd
        XjbBW/hPFzuDKwP5Z0N6H6GhWS5xb3/G6k+DmchEf9nf/7e4YzNHpjFM+FZdug==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/47] patches: Refresh patches on top of kernel 5.12.19
Date:   Tue, 19 Oct 2021 23:42:43 +0200
Message-Id: <20211019214320.2035704-11-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91DEB56A
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

* iwlwifi does not use napi->rx_list any more, not need to remove this
  in a patch.
* __ieee80211_rx_handle_8023() was added and gets a skb list, extend the
  existing patch
* The crypto/akcipher.h include was already removed in the upstream
  kernel from include/crypto/backport-public_key.h

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                |  4 +--
 .../net_wireless_core.patch                   |  2 +-
 .../net_wireless_core.patch                   |  4 +--
 .../0013-fix-makefile-includes/rtw88.patch    |  4 +--
 patches/0028-select_queue/mac80211.patch      |  4 +--
 patches/0028-select_queue/mwifiex.patch       |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  2 +-
 patches/0092-listified-rx/iwlwifi.patch       | 19 -------------
 patches/0097-skb-list/mac80211-rx.patch       | 28 +++++++++++++------
 patches/0097-skb-list/mac80211-status.patch   |  4 +--
 patches/0097-skb-list/mt76.patch              |  6 ++--
 patches/0098-netdev_nested_priv/qtnfmac.patch |  6 ++--
 patches/0099-netlink-range/mac80211.patch     |  6 ++--
 patches/0100-revert-small_ops/mac80211.patch  |  8 +++---
 .../mac80211_hwsim.patch                      |  4 +--
 patches/verify.patch                          | 10 +------
 18 files changed, 51 insertions(+), 66 deletions(-)
 delete mode 100644 patches/0092-listified-rx/iwlwifi.patch

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index fd465b15..580ab9b9 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,7 +1,7 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4936,6 +4936,9 @@ struct wiphy_iftype_akm_suites {
- struct wiphy {
+@@ -4947,6 +4947,9 @@ struct wiphy {
+ 
  	/* assign these fields before you register the wiphy */
  
 +#define WIPHY_COMPAT_PAD_SIZE	2048
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index 3d73e463..f175b1bc 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -405,6 +405,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -427,6 +427,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 42a11a09..8bd7c4f5 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -495,10 +495,6 @@ use_default_name:
+@@ -518,10 +518,6 @@ use_default_name:
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1267,6 +1263,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1311,6 +1307,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index a81a0542..e66439d9 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -18,5 +18,5 @@ linux/module.h include needed for kernel 3.18
  #include "bf.h"
 +#include <linux/module.h>
  
- static void rtw8821ce_efuse_parsing(struct rtw_efuse *efuse,
- 				    struct rtw8821c_efuse *map)
+ static const s8 lna_gain_table_0[8] = {22, 8, -6, -22, -31, -40, -46, -52};
+ static const s8 lna_gain_table_1[16] = {10, 6, 2, -2, -6, -10, -14, -17,
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index d4e39d5d..c92dc0e0 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -691,9 +691,21 @@ static void ieee80211_uninit(struct net_
+@@ -694,9 +694,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -715,9 +727,21 @@ static const struct net_device_ops ieee8
+@@ -718,9 +730,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 24d146ed..464332a9 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1279,9 +1279,20 @@ static struct net_device_stats *mwifiex_
+@@ -1284,9 +1284,20 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index a877f147..189b1822 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4001,7 +4001,7 @@ static const struct genl_small_ops hwsim
+@@ -4106,7 +4106,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 686f29a2..69f9b075 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15710,7 +15710,7 @@ static const struct genl_small_ops nl802
+@@ -15793,7 +15793,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 830f16cf..33e12792 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -21,7 +21,7 @@
 +}
 +#endif
 +
- int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
+ int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
 @@ -883,7 +900,11 @@ struct brcmf_if *brcmf_add_if(struct brc
diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
deleted file mode 100644
index 8d7c216f..00000000
--- a/patches/0092-listified-rx/iwlwifi.patch
+++ /dev/null
@@ -1,19 +0,0 @@
-The rx_count and rx_list attributes were only added in kernel 5.4 in
-commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
-
---- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
-+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
-@@ -1549,11 +1549,13 @@ out:
- 	if (napi->poll) {
- 		napi_gro_flush(napi, false);
- 
-+#if LINUX_VERSION_IS_GEQ(5,4,0)
- 		if (napi->rx_count) {
- 			netif_receive_skb_list(&napi->rx_list);
- 			INIT_LIST_HEAD(&napi->rx_list);
- 			napi->rx_count = 0;
- 		}
-+#endif
- 	}
- 
- 	iwl_pcie_rxq_restock(trans, rxq);
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 88e66a95..e2be9ddd 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4456,7 +4456,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4472,7 +4472,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -23,7 +23,7 @@ the older kernel instead. The list attributes where also backported to
   * ieee80211_rx_napi - receive frame from NAPI context
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -217,7 +217,11 @@ enum ieee80211_rx_flags {
+@@ -199,7 +199,11 @@ enum ieee80211_rx_flags {
  };
  
  struct ieee80211_rx_data {
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2528,7 +2528,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2591,7 +2591,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4446,7 +4450,11 @@ static bool ieee80211_invoke_fast_rx(str
+@@ -4440,7 +4444,11 @@ static void ieee80211_rx_8023(struct iee
  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
  	memset(skb->cb, 0, sizeof(skb->cb));
  	if (rx->list)
@@ -61,7 +61,19 @@ the older kernel instead. The list attributes where also backported to
  	else
  		netif_receive_skb(skb);
  
-@@ -4513,7 +4521,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4622,7 +4630,11 @@ static bool ieee80211_prepare_and_rx_han
+ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
+ 				       struct ieee80211_sta *pubsta,
+ 				       struct sk_buff *skb,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 				       struct list_head *list)
++#else
++				       struct sk_buff_head *list)
++#endif
+ {
+ 	struct ieee80211_local *local = hw_to_local(hw);
+ 	struct ieee80211_fast_rx *fast_rx;
+@@ -4663,7 +4675,11 @@ drop:
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -73,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4638,7 +4650,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4788,7 +4804,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +97,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4757,7 +4773,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4911,7 +4931,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +111,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -4774,8 +4796,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4928,8 +4954,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index ee90303c..8f5ac983 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -21,7 +21,7 @@ kernel versions.
  /**
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1033,7 +1033,11 @@ static void __ieee80211_tx_status(struct
+@@ -1029,7 +1029,11 @@ static void __ieee80211_tx_status(struct
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +33,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1183,7 +1187,11 @@ free:
+@@ -1179,7 +1183,11 @@ free:
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index c63b151d..d6d41fc0 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -30,7 +30,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-@@ -1030,7 +1030,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
+@@ -1053,7 +1053,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
  static void
  mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
  			  struct ieee80211_sta *sta, u8 stat,
@@ -42,7 +42,7 @@
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct ieee80211_tx_status status = {
-@@ -1094,10 +1098,16 @@ void mt7915_mac_tx_free(struct mt7915_de
+@@ -1116,10 +1120,16 @@ void mt7915_mac_tx_free(struct mt7915_de
  	struct mt76_phy *mphy_ext = mdev->phy2;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -60,7 +60,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1196,8 +1206,13 @@ void mt7915_mac_tx_free(struct mt7915_de
+@@ -1218,8 +1228,13 @@ void mt7915_mac_tx_free(struct mt7915_de
  
  	napi_consume_skb(skb, 1);
  
diff --git a/patches/0098-netdev_nested_priv/qtnfmac.patch b/patches/0098-netdev_nested_priv/qtnfmac.patch
index a177bed8..d525edfc 100644
--- a/patches/0098-netdev_nested_priv/qtnfmac.patch
+++ b/patches/0098-netdev_nested_priv/qtnfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/quantenna/qtnfmac/core.c
 +++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
-@@ -643,10 +643,16 @@ bool qtnf_netdev_is_qtn(const struct net
+@@ -644,10 +644,16 @@ bool qtnf_netdev_is_qtn(const struct net
  	return ndev->netdev_ops == &qtnf_netdev_ops;
  }
  
@@ -17,7 +17,7 @@
  
  	if (dev != ndev && netdev_port_same_parent_id(dev, ndev))
  		return -ENOTSUPP;
-@@ -659,9 +665,11 @@ static int qtnf_core_netdevice_event(str
+@@ -660,9 +666,11 @@ static int qtnf_core_netdevice_event(str
  {
  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
  	const struct netdev_notifier_changeupper_info *info;
@@ -29,7 +29,7 @@
  	struct net_device *brdev;
  	struct qtnf_vif *vif;
  	struct qtnf_bus *bus;
-@@ -701,7 +709,11 @@ static int qtnf_core_netdevice_event(str
+@@ -702,7 +710,11 @@ static int qtnf_core_netdevice_event(str
  		} else {
  			ret = netdev_walk_all_lower_dev(brdev,
  							qtnf_check_br_ports,
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 180b6082..d541e3e1 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -391,9 +391,11 @@ static const struct nla_policy
+@@ -411,9 +411,11 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -12,7 +12,7 @@
  };
  
  static const struct nla_policy
-@@ -633,16 +635,26 @@ static const struct nla_policy nl80211_p
+@@ -653,16 +655,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -39,7 +39,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -697,10 +709,15 @@ static const struct nla_policy nl80211_p
+@@ -717,10 +729,15 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index fe89977b..9c1359fd 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,8 +1,8 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14875,9 +14875,11 @@ static const struct genl_ops nl80211_ops
- 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
- 				  NL80211_FLAG_NEED_RTNL,
+@@ -15037,9 +15037,11 @@ static const struct genl_ops nl80211_ops
+ 		/* can be retrieved by unprivileged users */
+ 		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
  };
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15739,8 +15741,10 @@ static struct genl_family nl80211_fam __
+@@ -15822,8 +15824,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index 1a764336..6e8dff8c 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3964,7 +3964,11 @@ done:
+@@ -4069,7 +4069,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4008,8 +4012,13 @@ static struct genl_family hwsim_genl_fam
+@@ -4113,8 +4117,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
diff --git a/patches/verify.patch b/patches/verify.patch
index f1faff55..2d858b34 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -64,15 +64,7 @@
  	struct x509_certificate *signer;	/* Certificate that signed this one */
 --- a/include/crypto/backport-public_key.h
 +++ b/include/crypto/backport-public_key.h
-@@ -12,7 +12,6 @@
- 
- #include <linux/keyctl.h>
- #include <linux/oid_registry.h>
--#include <crypto/akcipher.h>
- 
- /*
-  * Cryptographic data for the public-key subtype of the asymmetric key type.
-@@ -53,34 +52,6 @@ extern void public_key_signature_free(st
+@@ -52,34 +52,6 @@ extern void public_key_signature_free(st
  
  extern struct asymmetric_key_subtype public_key_subtype;
  
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
