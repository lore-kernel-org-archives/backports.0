Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FBC5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2421479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGAVuF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:05 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40636 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfGAVuE (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:04 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 285BF4D3B2;
        Mon,  1 Jul 2019 23:50:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id QsDcv_9j-K6h; Mon,  1 Jul 2019 23:49:53 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/18] patches: Make patches apply on top of kernel 5.2-rc6
Date:   Mon,  1 Jul 2019 23:49:00 +0200
Message-Id: <20190701214914.8066-6-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The cordic.c file was moved and the driver from drivers/staging/rtlwifi/
was removed in mainline kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig                       |  2 +-
 copy-list                                     |  1 -
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +--
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 patches/0004-disable-wext-kconfig.patch       |  5 ++--
 .../net_wireless_core.patch                   |  4 +--
 .../drivers_net_wireless_cw1200_sdio.patch    |  2 +-
 .../net_wireless_nl80211.patch                |  2 +-
 ...drivers_net_wireless_ipw2x00_ipw2100.patch |  2 +-
 ...drivers_net_wireless_libertas_if_usb.patch |  4 +--
 patches/0022-define-tracing/mt7601u.patch     |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  4 +--
 patches/0025-usb-sg/usbnet.patch              | 12 ++++----
 patches/0026-ipv6_stub/cdc_mbim.patch         |  6 ++--
 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch   |  6 ++--
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0060-trace_field_struct/mt7601u.patch |  4 +--
 patches/0069-iwlwifi-pd-string-fix.patch      | 28 ++++++-------------
 patches/0070-mac80211-fils.patch              |  8 +++---
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0083-timer_list.patch                 |  2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  4 +--
 patches/devcoredump.patch                     |  4 +--
 patches/verify.patch                          | 10 +++----
 28 files changed, 59 insertions(+), 71 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index bb5d864c..20f34f1a 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -69,7 +69,7 @@ config BPAUTO_BUILD_CORDIC
 	default m if BPAUTO_CORDIC
 	default m if BPAUTO_USERSEL_BUILD_ALL
 	#module-name cordic
-	#c-file lib/cordic.c
+	#c-file lib/math/cordic.c
 
 config BPAUTO_CORDIC
 	bool
diff --git a/copy-list b/copy-list
index 1ad03985..328e92d0 100644
--- a/copy-list
+++ b/copy-list
@@ -121,7 +121,6 @@ drivers/net/usb/usbnet.c
 
 drivers/staging/Makefile
 drivers/staging/Kconfig
-drivers/staging/rtlwifi/
 drivers/staging/rtl8188eu/
 drivers/staging/rtl8723bs/
 
diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index bf48eade..c4515077 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2357,6 +2357,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2434,6 +2434,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2378,6 +2379,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2455,6 +2456,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 338bedb1..74366dad 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4334,6 +4334,9 @@ struct cfg80211_pmsr_capabilities {
+@@ -4404,6 +4404,9 @@ struct cfg80211_pmsr_capabilities {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index e1eca55d..d6cb1d2a 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -403,6 +403,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -404,6 +404,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0004-disable-wext-kconfig.patch b/patches/0004-disable-wext-kconfig.patch
index bcb60788..5d06600d 100644
--- a/patches/0004-disable-wext-kconfig.patch
+++ b/patches/0004-disable-wext-kconfig.patch
@@ -3,7 +3,8 @@ so remove the Kconfig options for them.
 
 --- a/net/wireless/Kconfig
 +++ b/net/wireless/Kconfig
-@@ -1,21 +1,3 @@
+@@ -1,22 +1,4 @@
+ # SPDX-License-Identifier: GPL-2.0-only
 -config WIRELESS_EXT
 -	bool
 -
@@ -25,7 +26,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -187,7 +169,7 @@ config CFG80211_CRDA_SUPPORT
+@@ -188,7 +170,7 @@ config CFG80211_CRDA_SUPPORT
  
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 92b299c3..976b50e0 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -496,10 +496,6 @@ use_default_name:
+@@ -497,10 +497,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1285,6 +1281,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1286,6 +1282,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
index dd5c53a5..175561f9 100644
--- a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
 +++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
-@@ -254,6 +254,12 @@ static size_t cw1200_sdio_align_size(str
+@@ -251,6 +251,12 @@ static size_t cw1200_sdio_align_size(str
  	else
  		size = sdio_align_size(self->func, size);
  
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index ea0fcdde..100a9263 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8406,7 +8406,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8600,7 +8600,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
index d3dc0a0d..3b3499e2 100644
--- a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ b/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
-@@ -175,7 +175,11 @@ that only one external action is invoked
+@@ -161,7 +161,11 @@ that only one external action is invoked
  #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
  #define DRV_COPYRIGHT	"Copyright(c) 2003-2006 Intel Corporation"
  
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 22108262..c9cb687a 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -939,6 +939,7 @@ static int if_usb_suspend(struct usb_int
+@@ -940,6 +940,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -947,6 +948,7 @@ static int if_usb_suspend(struct usb_int
+@@ -948,6 +949,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/0022-define-tracing/mt7601u.patch b/patches/0022-define-tracing/mt7601u.patch
index 1682a763..7649944b 100644
--- a/patches/0022-define-tracing/mt7601u.patch
+++ b/patches/0022-define-tracing/mt7601u.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mediatek/mt7601u/trace.c
 +++ b/drivers/net/wireless/mediatek/mt7601u/trace.c
-@@ -13,6 +13,9 @@
+@@ -5,6 +5,9 @@
   */
  
  #include <linux/module.h>
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index fd4e4102..39fb6f0c 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1309,6 +1309,7 @@ struct ieee80211_local {
+@@ -1306,6 +1306,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
@@ -10,7 +10,7 @@
  	atomic_t tx_led_active, rx_led_active, assoc_led_active;
 --- a/net/mac80211/led.h
 +++ b/net/mac80211/led.h
-@@ -16,22 +16,36 @@
+@@ -13,22 +13,36 @@
  static inline void ieee80211_led_rx(struct ieee80211_local *local)
  {
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index cab07250..af20480f 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1313,6 +1313,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1302,6 +1302,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1345,6 +1346,12 @@ static int build_dma_sg(const struct sk_
+@@ -1334,6 +1335,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1401,12 +1408,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1390,12 +1397,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1473,7 +1487,9 @@ not_drop:
+@@ -1467,7 +1481,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1526,7 +1542,9 @@ static void usbnet_bh (struct timer_list
+@@ -1520,7 +1536,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  			/* fall through */
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
-@@ -1894,7 +1912,9 @@ int usbnet_resume (struct usb_interface
+@@ -1888,7 +1906,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0026-ipv6_stub/cdc_mbim.patch b/patches/0026-ipv6_stub/cdc_mbim.patch
index c6abb101..868928bb 100644
--- a/patches/0026-ipv6_stub/cdc_mbim.patch
+++ b/patches/0026-ipv6_stub/cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -302,6 +302,7 @@ error:
+@@ -300,6 +300,7 @@ error:
  	return NULL;
  }
  
@@ -8,7 +8,7 @@
  /* Some devices are known to send Neigbor Solicitation messages and
   * require Neigbor Advertisement replies.  The IPv6 core will not
   * respond since IFF_NOARP is set, so we must handle them ourselves.
-@@ -362,6 +363,7 @@ static bool is_neigh_solicit(u8 *buf, si
+@@ -360,6 +361,7 @@ static bool is_neigh_solicit(u8 *buf, si
  		msg->icmph.icmp6_code == 0 &&
  		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
  }
@@ -16,7 +16,7 @@
  
  
  static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
-@@ -378,8 +380,10 @@ static struct sk_buff *cdc_mbim_process_
+@@ -376,8 +378,10 @@ static struct sk_buff *cdc_mbim_process_
  			proto = htons(ETH_P_IP);
  			break;
  		case 0x60:
diff --git a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch b/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
index 2441af6e..5938950a 100644
--- a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
+++ b/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -70,7 +70,13 @@ static int cdc_mbim_wdm_manage_power(str
+@@ -68,7 +68,13 @@ static int cdc_mbim_wdm_manage_power(str
  	return cdc_mbim_manage_power(dev, status);
  }
  
@@ -14,7 +14,7 @@
  {
  	struct usbnet *dev = netdev_priv(netdev);
  	struct cdc_mbim_state *info = (void *)&dev->data;
-@@ -78,13 +84,21 @@ static int cdc_mbim_rx_add_vid(struct ne
+@@ -76,13 +82,21 @@ static int cdc_mbim_rx_add_vid(struct ne
  	/* creation of this VLAN is a request to tag IP session 0 */
  	if (vid == MBIM_IPS0_VID)
  		info->flags |= FLAG_IPS0_VLAN;
@@ -36,7 +36,7 @@
  {
  	struct usbnet *dev = netdev_priv(netdev);
  	struct cdc_mbim_state *info = (void *)&dev->data;
-@@ -92,7 +106,9 @@ static int cdc_mbim_rx_kill_vid(struct n
+@@ -90,7 +104,9 @@ static int cdc_mbim_rx_kill_vid(struct n
  	/* this is a request for an untagged IP session 0 */
  	if (vid == MBIM_IPS0_VID)
  		info->flags &= ~FLAG_IPS0_VLAN;
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 4ebbb3a1..c401e5d1 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4482,12 +4482,12 @@ struct wiphy {
+@@ -4552,12 +4552,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0060-trace_field_struct/mt7601u.patch b/patches/0060-trace_field_struct/mt7601u.patch
index 8b4af1f3..ca9dea53 100644
--- a/patches/0060-trace_field_struct/mt7601u.patch
+++ b/patches/0060-trace_field_struct/mt7601u.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/mediatek/mt7601u/trace.h b/drivers/net/wireles
 index 2898973..7fa1b96 100644
 --- a/drivers/net/wireless/mediatek/mt7601u/trace.h
 +++ b/drivers/net/wireless/mediatek/mt7601u/trace.h
-@@ -252,6 +252,7 @@ TRACE_EVENT(freq_cal_offset,
+@@ -244,6 +244,7 @@ TRACE_EVENT(freq_cal_offset,
  		  DEV_PR_ARG, __entry->phy_mode, __entry->freq_off)
  );
  
@@ -10,7 +10,7 @@ index 2898973..7fa1b96 100644
  TRACE_EVENT(mt_rx,
  	TP_PROTO(struct mt7601u_dev *dev, struct mt7601u_rxwi *rxwi, u32 f),
  	TP_ARGS(dev, rxwi, f),
-@@ -306,6 +307,20 @@ TRACE_EVENT(mt_tx,
+@@ -298,6 +299,20 @@ TRACE_EVENT(mt_tx,
  		  __entry->h.ack_ctl, __entry->h.wcid,
  		  le16_to_cpu(__entry->h.len_ctl))
  );
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 8a2ae81a..dfb5c1af 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-@@ -2386,12 +2386,23 @@ void iwl_dbgfs_register(struct iwl_priv
+@@ -2373,12 +2373,23 @@ void iwl_dbgfs_register(struct iwl_priv
  	 */
  	if (priv->mac80211_registered) {
  		char buf[100];
@@ -26,10 +26,10 @@
  	}
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -776,8 +776,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
- 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
+@@ -774,8 +774,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  
- 	if (!mvmvif->dbgfs_dir) {
+ 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
+ 	if (IS_ERR_OR_NULL(mvmvif->dbgfs_dir)) {
 +#if LINUX_VERSION_IS_GEQ(3,12,0)
  		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
  			dbgfs_dir);
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -806,15 +811,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -804,9 +809,17 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
@@ -58,20 +58,9 @@
  
  	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
  						     mvm->debugfs_dir, buf);
- 	if (!mvmvif->dbgfs_slink)
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 		IWL_ERR(mvm, "Can't create debugfs symbolic link under %pd\n",
- 			dbgfs_dir);
-+#else
-+		IWL_ERR(mvm, "Can't create debugfs symbolic link under %s\n",
-+			dbgfs_dir->d_name.name);
-+#endif
- 	return;
- err:
- 	IWL_ERR(mvm, "Can't create debugfs entity\n");
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2211,7 +2211,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
+@@ -2131,6 +2131,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
@@ -82,6 +71,5 @@
 +		 dbgfs_dir->d_parent->d_parent->d_name.name,
 +		 dbgfs_dir->d_parent->d_name.name);
 +#endif
- 	if (!debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir, buf))
- 		goto err;
- 
+ 	debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir, buf);
+ }
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index d3f249c5..aa2d6051 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -2,17 +2,17 @@
 +++ b/net/mac80211/fils_aead.c
 @@ -1,3 +1,4 @@
 +#if LINUX_VERSION_IS_GEQ(4,3,0)
+ // SPDX-License-Identifier: GPL-2.0-only
  /*
   * FILS AEAD for (Re)Association Request/Response frames
-  * Copyright 2016, Qualcomm Atheros, Inc.
-@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee8
+@@ -329,3 +330,4 @@ int fils_decrypt_assoc_resp(struct ieee8
  	*frame_len -= AES_BLOCK_SIZE;
  	return 0;
  }
 +#endif
 --- a/net/mac80211/fils_aead.h
 +++ b/net/mac80211/fils_aead.h
-@@ -10,10 +10,27 @@
+@@ -7,10 +7,27 @@
  #ifndef FILS_AEAD_H
  #define FILS_AEAD_H
  
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -573,7 +573,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -570,7 +570,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 6acea216..6c01890c 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -638,7 +638,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -647,7 +647,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index ac66d212..bd7eb2aa 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1016,6 +1016,9 @@ void usbnet_get_stats64(struct net_devic
+@@ -1005,6 +1005,9 @@ void usbnet_get_stats64(struct net_devic
  	}
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index f97af731..ada56d34 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3654,7 +3654,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3664,7 +3664,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index ceba57bd..227cd5fe 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14199,7 +14199,7 @@ static const struct genl_ops nl80211_ops
+@@ -14497,7 +14497,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0083-timer_list.patch b/patches/0083-timer_list.patch
index dca3b948..413b26dc 100644
--- a/patches/0083-timer_list.patch
+++ b/patches/0083-timer_list.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/atmel/at76c50x-usb.c
 +++ b/drivers/net/wireless/atmel/at76c50x-usb.c
-@@ -518,11 +518,19 @@ exit:
+@@ -513,11 +513,19 @@ exit:
  
  /* LED trigger */
  static int tx_activity;
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index b7536d93..fb3f37cf 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1926,6 +1926,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1948,6 +1948,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1934,6 +1937,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1956,6 +1959,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index 1dbec579..31ac0b7e 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -97,7 +97,7 @@
 -__exitcall(devcoredump_exit);
 --- a/include/linux/backport-devcoredump.h
 +++ b/include/linux/backport-devcoredump.h
-@@ -66,7 +66,7 @@ static inline void _devcd_free_sgtable(s
+@@ -51,7 +51,7 @@ static inline void _devcd_free_sgtable(s
  }
  
  
@@ -106,7 +106,7 @@
  void dev_coredumpv(struct device *dev, void *data, size_t datalen,
  		   gfp_t gfp);
  
-@@ -100,6 +100,6 @@ static inline void dev_coredumpsg(struct
+@@ -85,6 +85,6 @@ static inline void dev_coredumpsg(struct
  {
  	_devcd_free_sgtable(table);
  }
diff --git a/patches/verify.patch b/patches/verify.patch
index d52b7ce4..5adba0e6 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -1,6 +1,6 @@
 --- a/compat/verification/pkcs7_trust.c
 +++ b/compat/verification/pkcs7_trust.c
-@@ -116,7 +116,7 @@ static int pkcs7_validate_trust_one(stru
+@@ -112,7 +112,7 @@ static int pkcs7_validate_trust_one(stru
  	return -ENOKEY;
  
  matched:
@@ -11,7 +11,7 @@
  		if (ret == -ENOMEM)
 --- a/compat/verification/x509_public_key.c
 +++ b/compat/verification/x509_public_key.c
-@@ -13,11 +13,8 @@
+@@ -9,11 +9,8 @@
  #include <linux/module.h>
  #include <linux/kernel.h>
  #include <linux/slab.h>
@@ -23,7 +23,7 @@
  #include "x509_parser.h"
  
  /*
-@@ -155,6 +152,7 @@ not_self_signed:
+@@ -150,6 +147,7 @@ not_self_signed:
  	return 0;
  }
  
@@ -31,7 +31,7 @@
  /*
   * Attempt to parse a data blob for a key as an X509 certificate.
   */
-@@ -273,3 +271,4 @@ module_exit(x509_key_exit);
+@@ -268,3 +266,4 @@ module_exit(x509_key_exit);
  MODULE_DESCRIPTION("X.509 certificate parser");
  MODULE_AUTHOR("Red Hat, Inc.");
  MODULE_LICENSE("GPL");
@@ -51,7 +51,7 @@
  #endif /* CPTCFG_BPAUTO_PKCS7 */
 --- a/compat/verification/x509_parser.h
 +++ b/compat/verification/x509_parser.h
-@@ -13,6 +13,10 @@
+@@ -9,6 +9,10 @@
  #include <crypto/public_key.h>
  #include <keys/asymmetric-type.h>
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
