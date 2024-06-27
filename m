Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E11A38D3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=rmTGq9PZHKqe5RAP5QE9ZBgHMAQx9FWj6g4CeIq6J2I6fmopC+9k8D0QawHB10P9cVBR0SsEWJgV+HmwnomNYXMYFwUnBxOoBSH6Vg8iRjv0zcamX6X2fhQqRf2xKIk7dLiqGx09COPM9zm+mWOSHQEyZy2trFO4iN7eWXTPLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=wXPWwYD+7yNPV0H3WvinXKTwiz/K1pj5yi427Kw3Jc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BivJ6tHPgasAIhgjCxH6NKT4A6NCITzvgA+sq9IElDSsFQoxMjjYOT4Lo6BC0kCoR8QOrsMpYLhr2vBzOG5OBh86yG3XPjjbYYjIasGvDqqV7nW7qWUX3FWEV552gtVIX7TcbJJ2a5b8f2/O4iGKOhI9sFg8mneu1AEPu+o8vGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=O9Y5PFah; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="O9Y5PFah"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdb4cq5z9t1s;
	Fri, 28 Jun 2024 01:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8xZjMYBxH82l8FHR4ub9IY9WsLttTrQwMhcQ47PAyU=;
	b=O9Y5PFahzdTLEMzrR82OjOiMuY/BlyDpFTaMC7bIn96Xy7qHqvAm0dBtrmoWW0JWdxBTD9
	+dm9C3mj3YUs3cBSKMD/AyRrd1qW69nRIKr4Xq3ECdHeeEh4QfJZ6IP6WhVDfA76cnaN0K
	CcLH6E2DmqWxYKQfQRux2mhaZoJTE5PsDCVDnXQcxkMrhpvcvOtppU7r7UJgIw/6cwysBX
	q88sE/jbk3fAyFGYeOvHH6cfggBU77qw/PjEB9S0UuoETmjG5O81kI9soA8CIU+ImOcKx2
	My56QHu04PImUXr3Th3ILSN36Mov9LCkeqFwMWDzkQWk/1usSLH0F92Vs/e1MQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 43/75] patches: Refresh on 6.1.95
Date: Fri, 28 Jun 2024 01:47:29 +0200
Message-ID: <20240627234808.1253337-44-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Some includes are removed because they are not needed with kernel 4.14
  and later any more
* The patch for the skb_queue_walk_safe() handling in mt76 needs many
  complicated changes, just make the driver depend on kernel 4.19 and
  later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                |   2 +-
 .../net_wireless_core.patch                   |   2 +-
 .../net_wireless_core.patch                   |   4 +-
 patches/0013-fix-makefile-includes/mt76.patch |  10 --
 .../0013-fix-makefile-includes/rtw88.patch    |  22 ---
 patches/0028-select_queue/mac80211.patch      |   4 +-
 patches/0028-select_queue/mwifiex.patch       |   2 +-
 patches/0028-select_queue/r8188eu.patch       |   2 +-
 patches/0089-unknown-dmi/brcmfmac.patch       |   6 +-
 patches/0089-unknown-dmi/mwifiex.patch        |   4 +-
 patches/0094-ndo-tx-timeout/usbnet.patch      |   2 +-
 patches/0095-spi-delay/wilc1000.patch         |   6 +-
 patches/0097-skb-list/mac80211-rx.patch       |  20 +--
 patches/0097-skb-list/mac80211-status.patch   |  10 +-
 patches/0097-skb-list/mt76.patch              | 150 ------------------
 patches/0099-netlink-range/mac80211.patch     |   6 +-
 patches/0100-revert-small_ops/mac80211.patch  |   8 +-
 .../mac80211_hwsim.patch                      |   6 +-
 patches/0101-net_device-threaded/mt76.patch   |   6 +-
 patches/0104-mhi-reg-len.patch                |   2 +-
 ...05-remove-const-from-rchan_callbacks.patch |   2 +-
 patches/lib-refcount.patch                    |   2 -
 22 files changed, 47 insertions(+), 231 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/rtw88.patch
 delete mode 100644 patches/0097-skb-list/mt76.patch

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index a602d1a0..85508ee5 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4990,6 +4990,9 @@ struct wiphy {
+@@ -5306,6 +5306,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index 6fbcc42f..50454ce3 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -420,6 +420,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -448,6 +448,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 2e1a9a47..e3c2a209 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -511,10 +511,6 @@ use_default_name:
+@@ -539,10 +539,6 @@ use_default_name:
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1299,6 +1295,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1387,6 +1383,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
index 46fe75c5..0e4b5f04 100644
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -2,16 +2,6 @@ linux/kthread.h include needed against kernel 4.19.
 
 --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
-@@ -9,6 +9,7 @@
- #include <linux/kernel.h>
- #include <linux/iopoll.h>
- #include <linux/module.h>
-+#include <linux/kthread.h>
- 
- #include <linux/mmc/host.h>
- #include <linux/mmc/sdio_ids.h>
---- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
 @@ -9,6 +9,7 @@
  #include <linux/kernel.h>
  #include <linux/iopoll.h>
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
deleted file mode 100644
index 41dea13e..00000000
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ /dev/null
@@ -1,22 +0,0 @@
-linux/module.h include needed for kernel 3.18
-
---- a/drivers/net/wireless/realtek/rtw88/main.c
-+++ b/drivers/net/wireless/realtek/rtw88/main.c
-@@ -17,6 +17,7 @@
- #include "tx.h"
- #include "debug.h"
- #include "bf.h"
-+#include <linux/module.h>
- 
- bool rtw_disable_lps_deep_mode;
- EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
---- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
-+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
-@@ -14,6 +14,7 @@
- #include "reg.h"
- #include "debug.h"
- #include "bf.h"
-+#include <linux/module.h>
- 
- static const s8 lna_gain_table_0[8] = {22, 8, -6, -22, -31, -40, -46, -52};
- static const s8 lna_gain_table_1[16] = {10, 6, 2, -2, -6, -10, -14, -17,
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 64a397b9..1eecc8ef 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -697,9 +697,21 @@ static void ieee80211_uninit(struct net_
+@@ -813,9 +813,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -721,9 +733,21 @@ static const struct net_device_ops ieee8
+@@ -837,9 +849,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 94b46abe..d341f02c 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1282,9 +1282,20 @@ static struct net_device_stats *mwifiex_
+@@ -1306,9 +1306,20 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0028-select_queue/r8188eu.patch b/patches/0028-select_queue/r8188eu.patch
index f1bf0381..09c01616 100644
--- a/patches/0028-select_queue/r8188eu.patch
+++ b/patches/0028-select_queue/r8188eu.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
 +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
-@@ -636,7 +636,15 @@ static unsigned int rtw_classify8021d(st
+@@ -276,7 +276,15 @@ static unsigned int rtw_classify8021d(st
  	return dscp >> 5;
  }
  
diff --git a/patches/0089-unknown-dmi/brcmfmac.patch b/patches/0089-unknown-dmi/brcmfmac.patch
index ab034040..dbd0337f 100644
--- a/patches/0089-unknown-dmi/brcmfmac.patch
+++ b/patches/0089-unknown-dmi/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
-@@ -58,7 +58,9 @@ static const struct dmi_system_id dmi_pl
+@@ -65,7 +65,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -10,7 +10,7 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -69,7 +71,9 @@ static const struct dmi_system_id dmi_pl
+@@ -76,7 +78,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -20,7 +20,7 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -80,7 +84,9 @@ static const struct dmi_system_id dmi_pl
+@@ -107,7 +111,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
diff --git a/patches/0089-unknown-dmi/mwifiex.patch b/patches/0089-unknown-dmi/mwifiex.patch
index 4bd68825..b7c98b2a 100644
--- a/patches/0089-unknown-dmi/mwifiex.patch
+++ b/patches/0089-unknown-dmi/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
 +++ b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
-@@ -34,7 +34,9 @@ static const struct dmi_system_id mwifie
+@@ -20,7 +20,9 @@ static const struct dmi_system_id mwifie
  		.matches = {
  			/* match for SKU here due to generic product name "Surface Pro" */
  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
@@ -10,7 +10,7 @@
  		},
  		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
  	},
-@@ -43,7 +45,9 @@ static const struct dmi_system_id mwifie
+@@ -29,7 +31,9 @@ static const struct dmi_system_id mwifie
  		.matches = {
  			/* match for SKU here due to generic product name "Surface Pro" */
  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
index 8069862d..28714b9b 100644
--- a/patches/0094-ndo-tx-timeout/usbnet.patch
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -256,6 +256,7 @@ extern int usbnet_stop(struct net_device
+@@ -249,6 +249,7 @@ extern int usbnet_stop(struct net_device
  extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
  				     struct net_device *net);
  extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index 1d3e6d6a..887942a5 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -218,10 +218,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -284,10 +284,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -262,10 +266,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -327,10 +331,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -307,10 +315,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -371,10 +379,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 9b95de51..dbd627a5 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4519,7 +4519,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4778,7 +4778,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -23,7 +23,7 @@ the older kernel instead. The list attributes where also backported to
   * ieee80211_rx_napi - receive frame from NAPI context
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -200,7 +200,11 @@ enum ieee80211_rx_flags {
+@@ -207,7 +207,11 @@ enum ieee80211_rx_flags {
  };
  
  struct ieee80211_rx_data {
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2612,7 +2612,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2641,7 +2641,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4703,7 +4707,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4895,7 +4899,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -60,8 +60,8 @@ the older kernel instead. The list attributes where also backported to
 +#endif
  {
  	struct ieee80211_local *local = hw_to_local(hw);
- 	struct ieee80211_fast_rx *fast_rx;
-@@ -4744,7 +4752,11 @@ drop:
+ 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+@@ -4983,7 +4991,11 @@ static bool ieee80211_rx_for_interface(s
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -72,8 +72,8 @@ the older kernel instead. The list attributes where also backported to
 +#endif
  {
  	struct ieee80211_local *local = hw_to_local(hw);
- 	struct ieee80211_sub_if_data *sdata;
-@@ -4869,7 +4881,11 @@ static void __ieee80211_rx_handle_packet
+ 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+@@ -5143,7 +5155,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4993,7 +5009,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5270,7 +5286,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -5010,8 +5032,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5287,8 +5309,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 1e8b0cb5..6cb81f72 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -7,8 +7,8 @@ kernel versions.
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1178,7 +1178,11 @@ struct ieee80211_tx_status {
- 	struct ieee80211_rate_status *rates;
+@@ -1218,7 +1218,11 @@ struct ieee80211_tx_status {
+ 	ktime_t ack_hwtstamp;
  	u8 n_rates;
  
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
@@ -21,7 +21,7 @@ kernel versions.
  /**
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1075,7 +1075,11 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
+@@ -1070,7 +1070,11 @@ static void __ieee80211_tx_status(struct
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,9 +33,9 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1228,7 +1232,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
+@@ -1220,7 +1224,11 @@ free:
  
- 	ieee80211_report_used_skb(local, skb, false);
+ 	ieee80211_report_used_skb(local, skb, false, status->ack_hwtstamp);
  	if (status->free_list)
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  		list_add_tail(&skb->list, status->free_list);
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
deleted file mode 100644
index 21a49be8..00000000
--- a/patches/0097-skb-list/mt76.patch
+++ /dev/null
@@ -1,150 +0,0 @@
---- a/drivers/net/wireless/mediatek/mt76/mac80211.c
-+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
-@@ -1026,7 +1026,13 @@ void mt76_rx_complete(struct mt76_dev *d
- 	struct ieee80211_sta *sta;
- 	struct ieee80211_hw *hw;
- 	struct sk_buff *skb, *tmp;
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 	LIST_HEAD(list);
-+#else
-+	struct sk_buff_head list;
-+
-+	__skb_queue_head_init(&list);
-+#endif
- 
- 	spin_lock(&dev->rx_lock);
- 	while ((skb = __skb_dequeue(frames)) != NULL) {
-@@ -1058,8 +1064,13 @@ void mt76_rx_complete(struct mt76_dev *d
- 		return;
- 	}
- 
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 	list_for_each_entry_safe(skb, tmp, &list, list) {
- 		skb_list_del_init(skb);
-+#else
-+	skb_queue_walk_safe(&list, skb, tmp) {
-+		__skb_unlink(skb, &list);
-+#endif
- 		napi_gro_receive(napi, skb);
- 	}
- }
---- a/drivers/net/wireless/mediatek/mt76/mt76.h
-+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
-@@ -1098,7 +1098,11 @@ struct sk_buff *mt76_tx_status_skb_get(s
- void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
- 			     struct sk_buff_head *list);
- void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 			    struct list_head *free_list);
-+#else
-+			    struct sk_buff_head *free_list);
-+#endif
- static inline void
- mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
- {
---- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-@@ -1114,7 +1114,11 @@ mt7915_txp_skb_unmap(struct mt76_dev *de
- 
- static void
- mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 		 struct ieee80211_sta *sta, struct list_head *free_list)
-+#else
-+		 struct ieee80211_sta *sta, struct sk_buff_head *free_list)
-+#endif
- {
- 	struct mt76_dev *mdev = &dev->mt76;
- 	struct mt76_wcid *wcid;
-@@ -1151,10 +1155,16 @@ mt7915_mac_tx_free(struct mt7915_dev *de
- 	struct mt76_phy *mphy_ext = mdev->phy2;
- 	struct mt76_txwi_cache *txwi;
- 	struct ieee80211_sta *sta = NULL;
--	LIST_HEAD(free_list);
- 	struct sk_buff *tmp;
- 	u8 i, count;
- 	bool wake = false;
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
-+	LIST_HEAD(free_list);
-+#else
-+	struct sk_buff_head free_list;
-+
-+	__skb_queue_head_init(&free_list);
-+#endif
- 
- 	/* clean DMA queues and unmap buffers first */
- 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1221,8 +1231,13 @@ mt7915_mac_tx_free(struct mt7915_dev *de
- 
- 	napi_consume_skb(skb, 1);
- 
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
- 		skb_list_del_init(skb);
-+#else
-+	skb_queue_walk_safe(&free_list, skb, tmp) {
-+		__skb_unlink(skb, &free_list);
-+#endif
- 		napi_consume_skb(skb, 1);
- 	}
- }
---- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
-@@ -988,7 +988,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
- static void
- mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
- 			  struct ieee80211_sta *sta, u8 stat,
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 			  struct list_head *free_list)
-+#else
-+			  struct sk_buff_head *free_list)
-+#endif
- {
- 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
- 	struct ieee80211_tx_status status = {
-@@ -1058,10 +1062,16 @@ void mt7921_mac_tx_free(struct mt7921_de
- 	struct mt76_dev *mdev = &dev->mt76;
- 	struct mt76_txwi_cache *txwi;
- 	struct ieee80211_sta *sta = NULL;
--	LIST_HEAD(free_list);
- 	struct sk_buff *tmp;
- 	bool wake = false;
- 	u8 i, count;
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
-+	LIST_HEAD(free_list);
-+#else
-+	struct sk_buff_head free_list;
-+
-+	__skb_queue_head_init(&free_list);
-+#endif
- 
- 	/* clean DMA queues and unmap buffers first */
- 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1139,8 +1149,13 @@ void mt7921_mac_tx_free(struct mt7921_de
- 
- 	napi_consume_skb(skb, 1);
- 
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
- 		skb_list_del_init(skb);
-+#else
-+	skb_queue_walk_safe(&free_list, skb, tmp) {
-+		__skb_unlink(skb, &free_list);
-+#endif
- 		napi_consume_skb(skb, 1);
- 	}
- 
---- a/drivers/net/wireless/mediatek/mt76/tx.c
-+++ b/drivers/net/wireless/mediatek/mt76/tx.c
-@@ -197,7 +197,11 @@ mt76_tx_check_non_aql(struct mt76_dev *d
- }
- 
- void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
- 			    struct list_head *free_list)
-+#else
-+			    struct sk_buff_head *free_list)
-+#endif
- {
- 	struct ieee80211_tx_status status = {
- 		.skb = skb,
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 9289b442..bb92b9f4 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -413,10 +413,15 @@ static const struct nla_policy
+@@ -422,10 +422,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -16,7 +16,7 @@
  };
  
  static const struct nla_policy
-@@ -511,7 +516,11 @@ static const struct nla_policy nl80211_p
+@@ -536,7 +541,11 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
  
  	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
@@ -28,7 +28,7 @@
  	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
  
  	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
-@@ -657,16 +666,26 @@ static const struct nla_policy nl80211_p
+@@ -682,16 +691,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index d25e785c..fe9e0399 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,8 +1,8 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15188,9 +15188,11 @@ static const struct genl_ops nl80211_ops
+@@ -16451,9 +16451,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
- 		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+ 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
  	},
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
  };
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15980,8 +15982,10 @@ static struct genl_family nl80211_fam __
+@@ -17290,8 +17292,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
@@ -20,6 +20,6 @@
  	.small_ops = nl80211_small_ops,
  	.n_small_ops = ARRAY_SIZE(nl80211_small_ops),
 +#endif
+ 	.resv_start_op = NL80211_CMD_REMOVE_LINK_STA + 1,
  	.mcgrps = nl80211_mcgrps,
  	.n_mcgrps = ARRAY_SIZE(nl80211_mcgrps),
- 	.parallel_ops = true,
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index a24d22f6..9df81e90 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4092,7 +4092,11 @@ done:
+@@ -5318,7 +5318,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4136,8 +4140,13 @@ static struct genl_family hwsim_genl_fam
+@@ -5362,8 +5366,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
@@ -23,6 +23,6 @@
 +	.ops = hwsim_ops,
 +	.n_ops = ARRAY_SIZE(hwsim_ops),
 +#endif
+ 	.resv_start_op = HWSIM_CMD_DEL_MAC_ADDR + 1,
  	.mcgrps = hwsim_mcgrps,
  	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
- };
diff --git a/patches/0101-net_device-threaded/mt76.patch b/patches/0101-net_device-threaded/mt76.patch
index 9cc1e126..e81a2b24 100644
--- a/patches/0101-net_device-threaded/mt76.patch
+++ b/patches/0101-net_device-threaded/mt76.patch
@@ -16,7 +16,7 @@
  
  int mt76_queues_read(struct seq_file *s, void *data)
  {
-@@ -130,8 +132,10 @@ mt76_register_debugfs_fops(struct mt76_d
+@@ -132,8 +134,10 @@ mt76_register_debugfs_fops(struct mt76_p
  	debugfs_create_u8("led_pin", 0600, dir, &dev->led_pin);
  	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
  	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
@@ -29,7 +29,7 @@
  		debugfs_create_blob("otp", 0400, dir, &dev->otp);
 --- a/drivers/net/wireless/mediatek/mt76/dma.c
 +++ b/drivers/net/wireless/mediatek/mt76/dma.c
-@@ -650,7 +650,9 @@ mt76_dma_init(struct mt76_dev *dev,
+@@ -755,7 +755,9 @@ mt76_dma_init(struct mt76_dev *dev,
  	init_dummy_netdev(&dev->tx_napi_dev);
  	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
  		 wiphy_name(dev->hw->wiphy));
@@ -38,4 +38,4 @@
 +#endif
  
  	mt76_for_each_q_rx(dev, i) {
- 		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll, 64);
+ 		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll);
diff --git a/patches/0104-mhi-reg-len.patch b/patches/0104-mhi-reg-len.patch
index 32d1e55a..c9f17fe5 100644
--- a/patches/0104-mhi-reg-len.patch
+++ b/patches/0104-mhi-reg-len.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath11k/mhi.c
 +++ b/drivers/net/wireless/ath/ath11k/mhi.c
-@@ -330,7 +330,9 @@ int ath11k_mhi_register(struct ath11k_pc
+@@ -397,7 +397,9 @@ int ath11k_mhi_register(struct ath11k_pc
  	mhi_ctrl->cntrl_dev = ab->dev;
  	mhi_ctrl->fw_image = ab_pci->amss_path;
  	mhi_ctrl->regs = ab->mem;
diff --git a/patches/0105-remove-const-from-rchan_callbacks.patch b/patches/0105-remove-const-from-rchan_callbacks.patch
index 16c14707..08f66149 100644
--- a/patches/0105-remove-const-from-rchan_callbacks.patch
+++ b/patches/0105-remove-const-from-rchan_callbacks.patch
@@ -14,7 +14,7 @@
  };
 --- a/drivers/net/wireless/ath/ath11k/spectral.c
 +++ b/drivers/net/wireless/ath/ath11k/spectral.c
-@@ -148,7 +148,11 @@ static int remove_buf_file_handler(struc
+@@ -147,7 +147,11 @@ static int remove_buf_file_handler(struc
  	return 0;
  }
  
diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index f375e1a2..05f73b60 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -1,5 +1,3 @@
-diff --git a/compat/lib-refcount.c b/compat/lib-refcount.c
-index 5d0582a..8d108f9 100644
 --- a/compat/lib-refcount.c
 +++ b/compat/lib-refcount.c
 @@ -7,6 +7,7 @@
-- 
2.45.2

