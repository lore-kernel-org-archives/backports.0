Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AA3C4167B
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18FF610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJSVqG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B60C061771
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLT1wn9zQjbF;
        Tue, 19 Oct 2021 23:43:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXhtbGAvc1sE0TW+MCaaTH840AdrS1TCxLXmaYK3qRo=;
        b=KHMLgEe5hTDh/BY6Nxg/XD9y7tZyn1RSclW2Pu69xAYFeRUmBCjemvfBftS+nJVzBm9w88
        nHcJU8/LEXcxaRpQWpKKVYA1k/xnwaO8unh46N8f62Emjf18B+yoeYAFfxccEOILZR2TGs
        8vUV0L/HxjyBQhaAn7N654T6dUVcncWihd60LTsDW3MIln5NRPCRXFquZRw10RgM/uK8cg
        AGMErDo5PoFsn4H4qKg1QXOZUQe5EWh50yqOJ+bqxJj184ILE9+I1RZLsdKLwGCf6PalqT
        322xDPstx29z2mA4QacZnkPdsXDu/ZqNJIPaoZybzwO6Hy22ej62xVCNemeY9Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/47] patches: Refresh on top of kernel 5.13.19
Date:   Tue, 19 Oct 2021 23:42:51 +0200
Message-Id: <20211019214320.2035704-19-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 810151315
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                   |  2 +-
 .../net_wireless_core.patch                      |  2 +-
 .../0013-fix-makefile-includes/wilc1000.patch    |  4 ++--
 patches/0028-select_queue/mac80211.patch         |  4 ++--
 patches/0028-select_queue/rtl8188eu.patch        |  2 +-
 patches/0028-select_queue/rtl8723bs.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch    |  2 +-
 patches/0084-disable-some-staging-dirs.patch     |  6 +++---
 patches/0094-ndo-tx-timeout/usbnet.patch         |  2 +-
 patches/0095-spi-delay/wilc1000.patch            |  6 +++---
 patches/0097-skb-list/mac80211-rx.patch          | 16 ++++++++--------
 patches/0097-skb-list/mt76.patch                 | 16 ++++++++--------
 patches/0099-netlink-range/mac80211.patch        | 13 +++++++------
 patches/0100-revert-small_ops/mac80211.patch     |  4 ++--
 patches/verify.patch                             |  4 ++--
 15 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 580ab9b9..52d72227 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4947,6 +4947,9 @@ struct wiphy {
+@@ -4951,6 +4951,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 8bd7c4f5..d7be390e 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1311,6 +1307,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1312,6 +1308,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/wilc1000.patch b/patches/0013-fix-makefile-includes/wilc1000.patch
index 819a1593..6304b3d7 100644
--- a/patches/0013-fix-makefile-includes/wilc1000.patch
+++ b/patches/0013-fix-makefile-includes/wilc1000.patch
@@ -24,10 +24,10 @@ linux/module.h include needed for kernel 3.18
  #include "cfg80211.h"
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -7,6 +7,7 @@
- #include <linux/clk.h>
+@@ -8,6 +8,7 @@
  #include <linux/spi/spi.h>
  #include <linux/crc7.h>
+ #include <linux/crc-itu-t.h>
 +#include <linux/module.h>
  
  #include "netdev.h"
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index c92dc0e0..36738162 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -694,9 +694,21 @@ static void ieee80211_uninit(struct net_
+@@ -695,9 +695,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -718,9 +730,21 @@ static const struct net_device_ops ieee8
+@@ -719,9 +731,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
index 95b555a8..cd0fb42b 100644
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -17,5 +17,5 @@
 +			    select_queue_fallback_t fallback)
 +#endif
  {
- 	struct adapter *padapter = rtw_netdev_priv(dev);
+ 	struct adapter *padapter = netdev_priv(dev);
  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index 962c0cc9..b3c2a9dc 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -375,8 +375,18 @@ static unsigned int rtw_classify8021d(st
+@@ -364,8 +364,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 69f9b075..3976dcaf 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15793,7 +15793,7 @@ static const struct genl_small_ops nl802
+@@ -15795,7 +15795,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0084-disable-some-staging-dirs.patch b/patches/0084-disable-some-staging-dirs.patch
index 3852bc9b..2fb803e4 100644
--- a/patches/0084-disable-some-staging-dirs.patch
+++ b/patches/0084-disable-some-staging-dirs.patch
@@ -7,11 +7,11 @@
 -obj-y				+= media/
 +#obj-y				+= media/
  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
- obj-$(CONFIG_COMEDI)		+= comedi/
  obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
-@@ -46,4 +46,4 @@ obj-$(CONFIG_KPC2000)		+= kpc2000/
+ obj-$(CONFIG_RTL8192U)		+= rtl8192u/
+@@ -42,4 +42,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldb
+ obj-$(CONFIG_KPC2000)		+= kpc2000/
  obj-$(CONFIG_QLGE)		+= qlge/
- obj-$(CONFIG_WIMAX)		+= wimax/
  obj-$(CONFIG_WFX)		+= wfx/
 -obj-y				+= hikey9xx/
 +#obj-y				+= hikey9xx/
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
index 2d0ef695..8069862d 100644
--- a/patches/0094-ndo-tx-timeout/usbnet.patch
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -255,6 +255,7 @@ extern int usbnet_stop(struct net_device
+@@ -256,6 +256,7 @@ extern int usbnet_stop(struct net_device
  extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
  				     struct net_device *net);
  extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index d4876f4b..56bbaf9a 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -161,10 +161,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -213,10 +213,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -205,10 +209,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -257,10 +261,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -250,10 +258,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -302,10 +310,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index e2be9ddd..bbfb9744 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4472,7 +4472,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4476,7 +4476,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2591,7 +2591,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2592,7 +2592,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4440,7 +4444,11 @@ static void ieee80211_rx_8023(struct iee
+@@ -4441,7 +4445,11 @@ static void ieee80211_rx_8023(struct iee
  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
  	memset(skb->cb, 0, sizeof(skb->cb));
  	if (rx->list)
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  	else
  		netif_receive_skb(skb);
  
-@@ -4622,7 +4630,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4623,7 +4631,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_fast_rx *fast_rx;
-@@ -4663,7 +4675,11 @@ drop:
+@@ -4664,7 +4676,11 @@ drop:
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4788,7 +4804,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4789,7 +4805,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -97,7 +97,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4911,7 +4931,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4912,7 +4932,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -111,7 +111,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -4928,8 +4954,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4929,8 +4955,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index e67d4db9..890b4c3c 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
 +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
-@@ -922,7 +922,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -998,7 +998,13 @@ void mt76_rx_complete(struct mt76_dev *d
  	struct ieee80211_sta *sta;
  	struct ieee80211_hw *hw;
  	struct sk_buff *skb, *tmp;
@@ -14,7 +14,7 @@
  
  	spin_lock(&dev->rx_lock);
  	while ((skb = __skb_dequeue(frames)) != NULL) {
-@@ -941,8 +947,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -1030,8 +1036,13 @@ void mt76_rx_complete(struct mt76_dev *d
  		return;
  	}
  
@@ -30,7 +30,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-@@ -1053,7 +1053,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
+@@ -1086,7 +1086,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
  static void
  mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
  			  struct ieee80211_sta *sta, u8 stat,
@@ -42,7 +42,7 @@
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct ieee80211_tx_status status = {
-@@ -1116,10 +1120,16 @@ void mt7915_mac_tx_free(struct mt7915_de
+@@ -1149,10 +1153,16 @@ void mt7915_mac_tx_free(struct mt7915_de
  	struct mt76_phy *mphy_ext = mdev->phy2;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -60,7 +60,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1218,8 +1228,13 @@ void mt7915_mac_tx_free(struct mt7915_de
+@@ -1240,8 +1250,13 @@ void mt7915_mac_tx_free(struct mt7915_de
  
  	napi_consume_skb(skb, 1);
  
@@ -76,7 +76,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
-@@ -866,7 +866,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
+@@ -870,7 +870,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
  static void
  mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
  			  struct ieee80211_sta *sta, u8 stat,
@@ -88,7 +88,7 @@
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct ieee80211_tx_status status = {
-@@ -936,10 +940,16 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -940,10 +944,16 @@ void mt7921_mac_tx_free(struct mt7921_de
  	struct mt76_dev *mdev = &dev->mt76;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -106,7 +106,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1028,8 +1038,13 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -1021,8 +1031,13 @@ void mt7921_mac_tx_free(struct mt7921_de
  
  	napi_consume_skb(skb, 1);
  
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index d541e3e1..e1037a58 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,18 +1,19 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -411,9 +411,11 @@ static const struct nla_policy
+@@ -412,10 +412,12 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
- 	NLA_POLICY_RANGE(NLA_BINARY,
- 			 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
- 			 IEEE80211_MAX_DATA_LEN),
+ 	[NL80211_FILS_DISCOVERY_ATTR_TMPL] =
+ 			NLA_POLICY_RANGE(NLA_BINARY,
+ 					 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
+ 					 IEEE80211_MAX_DATA_LEN),
 +#endif
  };
  
  static const struct nla_policy
-@@ -653,16 +655,26 @@ static const struct nla_policy nl80211_p
+@@ -655,16 +657,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -39,7 +40,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -717,10 +729,15 @@ static const struct nla_policy nl80211_p
+@@ -719,10 +731,15 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index 9c1359fd..c5e3bc84 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15037,9 +15037,11 @@ static const struct genl_ops nl80211_ops
+@@ -15039,9 +15039,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15822,8 +15824,10 @@ static struct genl_family nl80211_fam __
+@@ -15824,8 +15826,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/verify.patch b/patches/verify.patch
index 2d858b34..e32816e9 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -23,7 +23,7 @@
  #include "x509_parser.h"
  
  /*
-@@ -153,6 +150,7 @@ not_self_signed:
+@@ -155,6 +152,7 @@ not_self_signed:
  	return 0;
  }
  
@@ -31,7 +31,7 @@
  /*
   * Attempt to parse a data blob for a key as an X509 certificate.
   */
-@@ -271,3 +269,4 @@ module_exit(x509_key_exit);
+@@ -273,3 +271,4 @@ module_exit(x509_key_exit);
  MODULE_DESCRIPTION("X.509 certificate parser");
  MODULE_AUTHOR("Red Hat, Inc.");
  MODULE_LICENSE("GPL");
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
