Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B4C43219
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C619461052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJSVqB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD09C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLL3wqnzQk0m;
        Tue, 19 Oct 2021 23:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yj/vqODHm6Q5iqC8x+eBC6jg0LTc4fAfuR5vwSG7YVc=;
        b=VMLUl+rfQBIGlMAmOI7MXuwDpDBnjVwX+tVvQol0NwrPTmDH/LHI/GlfQlxrbb2Qi/Z/8g
        2Z8KAfKjPJ205L2QNySaPQlPNkjOIVUsAYmUlIvhBz0OkhSkRYnmhfq5/FYbxnN2Onx1+f
        zUMXkzsJ5U/z4PUsptTGMLtre501Na7I/tKDWkvO+SejdRJVo9+SkgGflrNpe2hKMHDqRt
        8FJn1PcKH6ahJceX+FoG5EJtVvggP2XXbboUB2FzxLtd+hqCX1Ty9wRI5POrKixn2g/xNh
        FSTaQJyAzLg/gTjECNbuK6I4Vnbc4iyyrb+Y6SYcWVWWFHh9W0ZcMugf5kUK5w==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/47] patches: Refresh on kernel 5.11.22
Date:   Tue, 19 Oct 2021 23:42:34 +0200
Message-Id: <20211019214320.2035704-2-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4AA01315
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The usbnet_get_stats64() function was removed and replaced with the
generic function dev_get_tstats64() which will be added later.
The patch adding bp_usbnet_get_stats64() can be removed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 .../0013-fix-makefile-includes/cfg80211.patch |  2 +-
 .../0013-fix-makefile-includes/rtw88.patch    |  4 ++--
 patches/0028-select_queue/mac80211.patch      |  4 ++--
 patches/0075-ndo-stats-64/usbnet.patch        | 24 -------------------
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0084-disable-some-staging-dirs.patch  |  4 ++--
 patches/0092-listified-rx/iwlwifi.patch       |  2 +-
 patches/0094-ndo-tx-timeout/usbnet.patch      |  2 +-
 patches/0095-spi-delay/wilc1000.patch         |  6 ++---
 patches/0097-skb-list/mac80211-rx.patch       | 16 ++++++-------
 patches/0097-skb-list/mac80211-status.patch   |  2 +-
 patches/0098-netdev_nested_priv/qtnfmac.patch |  6 ++---
 patches/0099-netlink-range/mac80211.patch     |  4 ++--
 patches/0100-revert-small_ops/mac80211.patch  |  4 ++--
 .../mac80211_hwsim.patch                      |  4 ++--
 18 files changed, 34 insertions(+), 58 deletions(-)
 delete mode 100644 patches/0075-ndo-stats-64/usbnet.patch

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 9d90ea82..fd465b15 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4883,6 +4883,9 @@ struct wiphy_iftype_akm_suites {
+@@ -4936,6 +4936,9 @@ struct wiphy_iftype_akm_suites {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 040225b0..42a11a09 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1273,6 +1269,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1267,6 +1263,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/cfg80211.patch b/patches/0013-fix-makefile-includes/cfg80211.patch
index ba4f0825..0e079911 100644
--- a/patches/0013-fix-makefile-includes/cfg80211.patch
+++ b/patches/0013-fix-makefile-includes/cfg80211.patch
@@ -6,7 +6,7 @@ the type is renamed.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -21,6 +21,7 @@
+@@ -22,6 +22,7 @@
  #include <linux/ieee80211.h>
  #include <linux/net.h>
  #include <net/regulatory.h>
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 961ef25c..a81a0542 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -8,8 +8,8 @@ linux/module.h include needed for kernel 3.18
  #include "bf.h"
 +#include <linux/module.h>
  
- unsigned int rtw_fw_lps_deep_mode;
- EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
+ bool rtw_disable_lps_deep_mode;
+ EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
 --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
 @@ -14,6 +14,7 @@
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 36738162..d4e39d5d 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -695,9 +695,21 @@ static void ieee80211_uninit(struct net_
+@@ -691,9 +691,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -719,9 +731,21 @@ static const struct net_device_ops ieee8
+@@ -715,9 +727,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
deleted file mode 100644
index 8d60d3a9..00000000
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/net/usb/usbnet.c
-+++ b/drivers/net/usb/usbnet.c
-@@ -988,6 +988,9 @@ void usbnet_get_stats64(struct net_devic
- 	dev_fetch_sw_netstats(stats, dev->stats64);
- }
- EXPORT_SYMBOL_GPL(usbnet_get_stats64);
-+#if LINUX_VERSION_IS_LESS(4,11,0)
-+EXPORT_SYMBOL_GPL(bp_usbnet_get_stats64);
-+#endif
- 
- u32 usbnet_get_link (struct net_device *net)
- {
---- a/include/linux/usb/usbnet.h
-+++ b/include/linux/usb/usbnet.h
-@@ -289,5 +289,9 @@ extern void usbnet_status_stop(struct us
- extern void usbnet_update_max_qlen(struct usbnet *dev);
- extern void usbnet_get_stats64(struct net_device *dev,
- 			       struct rtnl_link_stats64 *stats);
-+#if LINUX_VERSION_IS_LESS(4,11,0)
-+struct rtnl_link_stats64 *
-+bp_usbnet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
-+#endif
- 
- #endif /* __LINUX_USB_USBNET_H */
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index e9ef9c92..a877f147 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4034,7 +4034,7 @@ static const struct genl_small_ops hwsim
+@@ -4001,7 +4001,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 743d14e1..686f29a2 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15525,7 +15525,7 @@ static const struct genl_small_ops nl802
+@@ -15710,7 +15710,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0084-disable-some-staging-dirs.patch b/patches/0084-disable-some-staging-dirs.patch
index 9e550b3b..3852bc9b 100644
--- a/patches/0084-disable-some-staging-dirs.patch
+++ b/patches/0084-disable-some-staging-dirs.patch
@@ -9,9 +9,9 @@
  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
  obj-$(CONFIG_COMEDI)		+= comedi/
  obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
-@@ -48,4 +48,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldb
- obj-$(CONFIG_KPC2000)		+= kpc2000/
+@@ -46,4 +46,4 @@ obj-$(CONFIG_KPC2000)		+= kpc2000/
  obj-$(CONFIG_QLGE)		+= qlge/
+ obj-$(CONFIG_WIMAX)		+= wimax/
  obj-$(CONFIG_WFX)		+= wfx/
 -obj-y				+= hikey9xx/
 +#obj-y				+= hikey9xx/
diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
index 44ab1d64..8d7c216f 100644
--- a/patches/0092-listified-rx/iwlwifi.patch
+++ b/patches/0092-listified-rx/iwlwifi.patch
@@ -3,7 +3,7 @@ commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
 
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
-@@ -1606,11 +1606,13 @@ out:
+@@ -1549,11 +1549,13 @@ out:
  	if (napi->poll) {
  		napi_gro_flush(napi, false);
  
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
index 42b8fac5..2d0ef695 100644
--- a/patches/0094-ndo-tx-timeout/usbnet.patch
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -257,6 +257,7 @@ extern int usbnet_stop(struct net_device
+@@ -255,6 +255,7 @@ extern int usbnet_stop(struct net_device
  extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
  				     struct net_device *net);
  extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index 6565c432..d4876f4b 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -160,10 +160,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -161,10 +161,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -204,10 +208,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -205,10 +209,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -249,10 +257,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -250,10 +258,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 53b8f0bf..88e66a95 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4450,7 +4450,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4456,7 +4456,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -23,7 +23,7 @@ the older kernel instead. The list attributes where also backported to
   * ieee80211_rx_napi - receive frame from NAPI context
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -199,7 +199,11 @@ enum ieee80211_rx_flags {
+@@ -217,7 +217,11 @@ enum ieee80211_rx_flags {
  };
  
  struct ieee80211_rx_data {
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2602,7 +2602,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2528,7 +2528,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4542,7 +4546,11 @@ static bool ieee80211_invoke_fast_rx(str
+@@ -4446,7 +4450,11 @@ static bool ieee80211_invoke_fast_rx(str
  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
  	memset(skb->cb, 0, sizeof(skb->cb));
  	if (rx->list)
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  	else
  		netif_receive_skb(skb);
  
-@@ -4609,7 +4617,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4513,7 +4521,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4734,7 +4746,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4638,7 +4650,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4851,7 +4867,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4757,7 +4773,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -4868,8 +4890,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4774,8 +4796,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index ab968445..ee90303c 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -7,7 +7,7 @@ kernel versions.
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1132,7 +1132,11 @@ struct ieee80211_tx_status {
+@@ -1135,7 +1135,11 @@ struct ieee80211_tx_status {
  	struct ieee80211_tx_info *info;
  	struct sk_buff *skb;
  	struct rate_info *rate;
diff --git a/patches/0098-netdev_nested_priv/qtnfmac.patch b/patches/0098-netdev_nested_priv/qtnfmac.patch
index 7ff920c3..a177bed8 100644
--- a/patches/0098-netdev_nested_priv/qtnfmac.patch
+++ b/patches/0098-netdev_nested_priv/qtnfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/quantenna/qtnfmac/core.c
 +++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
-@@ -649,10 +649,16 @@ bool qtnf_netdev_is_qtn(const struct net
+@@ -643,10 +643,16 @@ bool qtnf_netdev_is_qtn(const struct net
  	return ndev->netdev_ops == &qtnf_netdev_ops;
  }
  
@@ -17,7 +17,7 @@
  
  	if (dev != ndev && netdev_port_same_parent_id(dev, ndev))
  		return -ENOTSUPP;
-@@ -665,9 +671,11 @@ static int qtnf_core_netdevice_event(str
+@@ -659,9 +665,11 @@ static int qtnf_core_netdevice_event(str
  {
  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
  	const struct netdev_notifier_changeupper_info *info;
@@ -29,7 +29,7 @@
  	struct net_device *brdev;
  	struct qtnf_vif *vif;
  	struct qtnf_bus *bus;
-@@ -707,7 +715,11 @@ static int qtnf_core_netdevice_event(str
+@@ -701,7 +709,11 @@ static int qtnf_core_netdevice_event(str
  		} else {
  			ret = netdev_walk_all_lower_dev(brdev,
  							qtnf_check_br_ports,
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 1490baf0..180b6082 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -12,7 +12,7 @@
  };
  
  static const struct nla_policy
-@@ -621,16 +623,26 @@ static const struct nla_policy nl80211_p
+@@ -633,16 +635,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -39,7 +39,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -685,10 +697,15 @@ static const struct nla_policy nl80211_p
+@@ -697,10 +709,15 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index 37c2fcff..fe89977b 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14690,9 +14690,11 @@ static const struct genl_ops nl80211_ops
+@@ -14875,9 +14875,11 @@ static const struct genl_ops nl80211_ops
  		.internal_flags = NL80211_FLAG_NEED_WIPHY |
  				  NL80211_FLAG_NEED_RTNL,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15554,8 +15556,10 @@ static struct genl_family nl80211_fam __
+@@ -15739,8 +15741,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index 42e52308..1a764336 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3997,7 +3997,11 @@ done:
+@@ -3964,7 +3964,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4041,8 +4045,13 @@ static struct genl_family hwsim_genl_fam
+@@ -4008,8 +4012,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
