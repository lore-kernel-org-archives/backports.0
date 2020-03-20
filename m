Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D9C4332B
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A4320752
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCTXkO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:14 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:48154 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTXkO (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48kgHb6612zQlFd;
        Sat, 21 Mar 2020 00:40:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 3IHGigg657r4; Sat, 21 Mar 2020 00:40:08 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: patches: Refresh against kernel 5.5.10
Date:   Sat, 21 Mar 2020 00:39:43 +0100
Message-Id: <20200320233950.32257-2-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +--
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 .../0013-fix-makefile-includes/rtw88.patch    | 28 ++++++-------------
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0022-define-tracing/wil6210.patch     |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0025-usb-sg/usbnet.patch              |  2 +-
 patches/0028-select_queue/mwifiex.patch       |  2 +-
 patches/0028-select_queue/rtl8723bs.patch     |  2 +-
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  4 +--
 patches/0090-remove-GRO_CONSUMED.patch        |  2 +-
 patches/lib-refcount.patch                    | 10 +++----
 18 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 04103f35..3d752359 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2542,6 +2542,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2549,6 +2549,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2563,6 +2564,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2570,6 +2571,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index ab2b79ff..11c50887 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4536,6 +4536,9 @@ struct cfg80211_pmsr_capabilities {
+@@ -4552,6 +4552,9 @@ struct cfg80211_pmsr_capabilities {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index c5d8ddf9..6b14d347 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1295,6 +1291,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1296,6 +1292,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 10bb1780..4e2ea808 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -1,40 +1,30 @@
 --- a/drivers/net/wireless/realtek/rtw88/main.c
 +++ b/drivers/net/wireless/realtek/rtw88/main.c
-@@ -13,6 +13,7 @@
- #include "reg.h"
- #include "efuse.h"
+@@ -15,6 +15,7 @@
+ #include "tx.h"
  #include "debug.h"
+ #include "bf.h"
 +#include <linux/module.h>
  
- static bool rtw_fw_support_lps;
- unsigned int rtw_debug_mask;
+ unsigned int rtw_fw_lps_deep_mode;
+ EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
 --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
-@@ -13,6 +13,7 @@
- #include "mac.h"
+@@ -14,6 +14,7 @@
  #include "reg.h"
  #include "debug.h"
+ #include "bf.h"
 +#include <linux/module.h>
  
  static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
  				     u8 rx_path, bool is_tx2_path);
 --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
-@@ -14,6 +14,7 @@
- #include "reg.h"
+@@ -15,6 +15,7 @@
  #include "debug.h"
  #include "util.h"
+ #include "bf.h"
 +#include <linux/module.h>
  
  static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
  				     u8 rx_path, bool is_tx2_path);
---- a/drivers/net/wireless/realtek/rtw88/pci.c
-+++ b/drivers/net/wireless/realtek/rtw88/pci.c
-@@ -10,6 +10,7 @@
- #include "rx.h"
- #include "fw.h"
- #include "debug.h"
-+#include <linux/interrupt.h>
- 
- static bool rtw_disable_msi;
- module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 8b7c33b0..28416330 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8765,7 +8765,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8780,7 +8780,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0022-define-tracing/wil6210.patch b/patches/0022-define-tracing/wil6210.patch
index 2e51beb1..a1093d16 100644
--- a/patches/0022-define-tracing/wil6210.patch
+++ b/patches/0022-define-tracing/wil6210.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/wil6210/trace.c
 +++ b/drivers/net/wireless/ath/wil6210/trace.c
-@@ -15,6 +15,9 @@
+@@ -4,6 +4,9 @@
   */
  
  #include <linux/module.h>
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 39fb6f0c..99b78d0c 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1306,6 +1306,7 @@ struct ieee80211_local {
+@@ -1310,6 +1310,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 30cce14f..47f49b5c 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -61,7 +61,7 @@
  			/* fall through */
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
-@@ -1896,7 +1914,9 @@ int usbnet_resume (struct usb_interface
+@@ -1903,7 +1921,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 0b4e9838..ffcb4cbb 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1276,9 +1276,28 @@ static struct net_device_stats *mwifiex_
+@@ -1277,9 +1277,28 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index 94524bc0..962c0cc9 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -395,8 +395,18 @@ static unsigned int rtw_classify8021d(st
+@@ -375,8 +375,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 85e6c24c..596aa90d 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4685,12 +4685,12 @@ struct wiphy {
+@@ -4701,12 +4701,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index c242a44a..c9619b1c 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2219,7 +2219,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2220,7 +2220,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 563fcbd7..f4580157 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -60,7 +60,7 @@
  						     mvm->debugfs_dir, buf);
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2081,6 +2081,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
+@@ -2085,6 +2085,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 5a485060..f3f46e5a 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3765,7 +3765,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3790,7 +3790,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index eee2ee3c..e4071840 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14750,7 +14750,7 @@ static const struct genl_ops nl80211_ops
+@@ -14768,7 +14768,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index f858fe99..08627746 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1998,6 +1998,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2024,6 +2024,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -2006,6 +2009,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2032,6 +2035,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0090-remove-GRO_CONSUMED.patch b/patches/0090-remove-GRO_CONSUMED.patch
index b2abfa96..ea0e1ea7 100644
--- a/patches/0090-remove-GRO_CONSUMED.patch
+++ b/patches/0090-remove-GRO_CONSUMED.patch
@@ -4,7 +4,7 @@ older kernel versions.
 
 --- a/drivers/net/wireless/ath/wil6210/txrx.c
 +++ b/drivers/net/wireless/ath/wil6210/txrx.c
-@@ -924,7 +924,9 @@ void wil_netif_rx(struct sk_buff *skb, s
+@@ -913,7 +913,9 @@ void wil_netif_rx(struct sk_buff *skb, s
  		[GRO_HELD]		= "GRO_HELD",
  		[GRO_NORMAL]		= "GRO_NORMAL",
  		[GRO_DROP]		= "GRO_DROP",
diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index 0f63ec6a..f375e1a2 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -2,15 +2,15 @@ diff --git a/compat/lib-refcount.c b/compat/lib-refcount.c
 index 5d0582a..8d108f9 100644
 --- a/compat/lib-refcount.c
 +++ b/compat/lib-refcount.c
-@@ -42,6 +42,7 @@
+@@ -7,6 +7,7 @@
  #include <linux/refcount.h>
  #include <linux/spinlock.h>
  #include <linux/bug.h>
 +#include <linux/export.h>
  
- /**
-  * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
-@@ -153,6 +153,8 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
+ #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
+ 
+@@ -152,6 +153,8 @@ bool refcount_dec_and_lock(refcount_t *r
  		return false;
  	}
  
@@ -19,7 +19,7 @@ index 5d0582a..8d108f9 100644
  	return true;
  }
  EXPORT_SYMBOL(refcount_dec_and_lock);
-@@ -182,6 +184,8 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+@@ -181,6 +184,8 @@ bool refcount_dec_and_lock_irqsave(refco
  		return false;
  	}
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
