Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4AC433E3
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C44920767
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgFVVic (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:32 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:37446 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgFVVic (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 49rN7l5H2gzQlGg;
        Mon, 22 Jun 2020 23:38:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id NzzW8yF4qJUZ; Mon, 22 Jun 2020 23:38:24 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] backports: patches: Refresh on kernel 5.8-rc2
Date:   Mon, 22 Jun 2020 23:37:58 +0200
Message-Id: <20200622213804.26477-2-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.21 / 15.00 / 15.00
X-Rspamd-Queue-Id: CA93217F3
X-Rspamd-UID: d47cbd
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The removed includes in rtw88 are not needed any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 ++--
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  6 +++---
 .../drivers_net_wireless_cw1200_sdio.patch    |  2 +-
 .../0013-fix-makefile-includes/rtw88.patch    | 20 -------------------
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0028-select_queue/mac80211.patch      |  4 ++--
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0070-mac80211-fils.patch              |  2 +-
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  4 ++--
 patches/0085-iwlwifi-pci-device-removal.patch |  4 ++--
 patches/0092-listified-rx/iwlwifi.patch       |  2 +-
 18 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 7ef4e282..ba34a516 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2686,6 +2686,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2680,6 +2680,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2707,6 +2708,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2701,6 +2702,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 678fdb79..c091180a 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4695,6 +4695,9 @@ struct wiphy_iftype_akm_suites {
+@@ -4755,6 +4755,9 @@ struct wiphy_iftype_akm_suites {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 7d34737f..d16a1cb8 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,7 +1,7 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -496,10 +496,6 @@ use_default_name:
- 	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
+@@ -493,10 +493,6 @@ use_default_name:
+ 	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
 -#ifdef CONFIG_CFG80211_WEXT
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1302,6 +1298,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1319,6 +1315,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
index 175561f9..7fa04588 100644
--- a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
 +++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
-@@ -251,6 +251,12 @@ static size_t cw1200_sdio_align_size(str
+@@ -244,6 +244,12 @@ static size_t cw1200_sdio_align_size(str
  	else
  		size = sdio_align_size(self->func, size);
  
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 4e2ea808..62aac393 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -8,23 +8,3 @@
  
  unsigned int rtw_fw_lps_deep_mode;
  EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
---- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
-+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
-@@ -14,6 +14,7 @@
- #include "reg.h"
- #include "debug.h"
- #include "bf.h"
-+#include <linux/module.h>
- 
- static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
- 				     u8 rx_path, bool is_tx2_path);
---- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
-+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
-@@ -15,6 +15,7 @@
- #include "debug.h"
- #include "util.h"
- #include "bf.h"
-+#include <linux/module.h>
- 
- static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
- 				     u8 rx_path, bool is_tx2_path);
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 0c3350b2..6410d71b 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8998,7 +8998,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -9037,7 +9037,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 1f183a84..f03b1b9c 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1314,6 +1314,7 @@ struct ieee80211_local {
+@@ -1319,6 +1319,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index be237b2a..32ab2a54 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1127,9 +1127,29 @@ static void ieee80211_uninit(struct net_
+@@ -1132,9 +1132,29 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -30,7 +30,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1172,9 +1192,29 @@ static const struct net_device_ops ieee8
+@@ -1177,9 +1197,29 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index e2015172..4060a720 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4838,12 +4838,12 @@ struct wiphy {
+@@ -4898,12 +4898,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index c9619b1c..d9e710dc 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2220,7 +2220,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2339,7 +2339,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index bb05f4c4..6ae534dc 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -60,7 +60,7 @@
  						     mvm->debugfs_dir, buf);
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2089,6 +2089,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
+@@ -2092,6 +2092,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index 9da4a8da..5fa5f54b 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -586,7 +586,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -591,7 +591,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index d14656e7..c4c49d99 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -666,7 +666,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -676,7 +676,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 22ba14f4..36ac2118 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3859,7 +3859,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3923,7 +3923,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 405df6ba..83a20094 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15140,7 +15140,7 @@ static const struct genl_ops nl80211_ops
+@@ -15241,7 +15241,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 6e67bd4e..b11a0861 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -629,6 +629,23 @@ static const struct net_device_ops brcmf
+@@ -626,6 +626,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -879,7 +896,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -876,7 +893,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index 08627746..c1c1dc39 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -2024,6 +2024,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2006,6 +2006,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -2032,6 +2035,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2014,6 +2017,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
index 4d3e25cc..0772aa0d 100644
--- a/patches/0092-listified-rx/iwlwifi.patch
+++ b/patches/0092-listified-rx/iwlwifi.patch
@@ -3,7 +3,7 @@ commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
 
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
-@@ -1581,11 +1581,13 @@ out:
+@@ -1603,11 +1603,13 @@ out:
  	if (napi->poll) {
  		napi_gro_flush(napi, false);
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
