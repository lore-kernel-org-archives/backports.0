Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CAC32792
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD9121848
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfJCP50 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:57:26 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38360 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbfJCP5X (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:23 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 9BEF9A222B;
        Thu,  3 Oct 2019 17:57:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id s0MJ-1011Z41; Thu,  3 Oct 2019 17:57:18 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: patches: refresh against kernel 5.4-rc1
Date:   Thu,  3 Oct 2019 17:56:32 +0200
Message-Id: <20191003155642.14909-2-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Manual modifications where needed to make the following patch apply:
patches/0013-fix-makefile-includes/rtw88.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 ...0002-disable-dump-adjust-on-old-kernels.patch |  4 ++--
 .../include_net_cfg80211.patch                   |  2 +-
 .../net_wireless_core.patch                      |  2 +-
 .../net_wireless_core.patch                      |  4 ++--
 patches/0013-fix-makefile-includes/rtw88.patch   | 16 ++++++++--------
 .../0014-netlink_seq/net_wireless_nl80211.patch  |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch   |  4 ++--
 patches/0025-usb-sg/usbnet.patch                 | 12 ++++++------
 patches/0028-select_queue/rtl8723bs.patch        |  2 +-
 patches/0053-possible_net_t.patch                |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch         |  2 +-
 patches/0071-skb-head_frag/wireless.patch        |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch           |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch      |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch    |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch    |  4 ++--
 patches/0085-iwlwifi-pci-device-removal.patch    |  4 ++--
 patches/0090-remove-GRO_CONSUMED.patch           |  4 ++--
 patches/devcoredump.patch                        |  4 ++--
 19 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 225ef6eb..1c7ef2e5 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2437,6 +2437,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2509,6 +2509,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2458,6 +2459,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2530,6 +2531,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index e5ee1e10..ab2b79ff 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4433,6 +4433,9 @@ struct cfg80211_pmsr_capabilities {
+@@ -4536,6 +4536,9 @@ struct cfg80211_pmsr_capabilities {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index d6cb1d2a..e1eca55d 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -404,6 +404,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -403,6 +403,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index b647639b..c5d8ddf9 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -497,10 +497,6 @@ use_default_name:
+@@ -496,10 +496,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1299,6 +1295,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1295,6 +1291,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 454c9f89..10bb1780 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/realtek/rtw88/main.c
 +++ b/drivers/net/wireless/realtek/rtw88/main.c
-@@ -12,6 +12,7 @@
+@@ -13,6 +13,7 @@
  #include "reg.h"
  #include "efuse.h"
  #include "debug.h"
@@ -10,7 +10,7 @@
  unsigned int rtw_debug_mask;
 --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
-@@ -12,6 +12,7 @@
+@@ -13,6 +13,7 @@
  #include "mac.h"
  #include "reg.h"
  #include "debug.h"
@@ -20,21 +20,21 @@
  				     u8 rx_path, bool is_tx2_path);
 --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
-@@ -12,6 +12,7 @@
- #include "mac.h"
+@@ -14,6 +14,7 @@
  #include "reg.h"
  #include "debug.h"
+ #include "util.h"
 +#include <linux/module.h>
  
  static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
  				     u8 rx_path, bool is_tx2_path);
 --- a/drivers/net/wireless/realtek/rtw88/pci.c
 +++ b/drivers/net/wireless/realtek/rtw88/pci.c
-@@ -9,6 +9,7 @@
- #include "tx.h"
+@@ -10,6 +10,7 @@
  #include "rx.h"
+ #include "fw.h"
  #include "debug.h"
 +#include <linux/interrupt.h>
  
- static u32 rtw_pci_tx_queue_idx_addr[] = {
- 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
+ static bool rtw_disable_msi;
+ module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 80e8c51c..fa52420b 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8606,7 +8606,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8727,7 +8727,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index c9cb687a..8fab382a 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -940,6 +940,7 @@ static int if_usb_suspend(struct usb_int
+@@ -941,6 +941,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -948,6 +949,7 @@ static int if_usb_suspend(struct usb_int
+@@ -949,6 +950,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index af20480f..30cce14f 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1302,6 +1302,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1310,6 +1310,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1334,6 +1335,12 @@ static int build_dma_sg(const struct sk_
+@@ -1342,6 +1343,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1390,12 +1397,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1398,12 +1405,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1467,7 +1481,9 @@ not_drop:
+@@ -1475,7 +1489,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1520,7 +1536,9 @@ static void usbnet_bh (struct timer_list
+@@ -1528,7 +1544,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  			/* fall through */
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
-@@ -1888,7 +1906,9 @@ int usbnet_resume (struct usb_interface
+@@ -1896,7 +1914,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index ab9914eb..94524bc0 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -398,8 +398,18 @@ static unsigned int rtw_classify8021d(st
+@@ -395,8 +395,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 06873e3b..85e6c24c 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4582,12 +4582,12 @@ struct wiphy {
+@@ -4685,12 +4685,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 3fcaec3d..563fcbd7 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -60,7 +60,7 @@
  						     mvm->debugfs_dir, buf);
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2155,6 +2155,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
+@@ -2081,6 +2081,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 6c01890c..f6999ad5 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -647,7 +647,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -661,7 +661,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index bd7eb2aa..fe434459 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1005,6 +1005,9 @@ void usbnet_get_stats64(struct net_devic
+@@ -1013,6 +1013,9 @@ void usbnet_get_stats64(struct net_devic
  	}
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 3c9c3039..5a485060 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3668,7 +3668,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3765,7 +3765,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 96905f7a..d2bcfc50 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14549,7 +14549,7 @@ static const struct genl_ops nl80211_ops
+@@ -14712,7 +14712,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index e5e7935f..3ee6da62 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -628,6 +628,23 @@ static const struct net_device_ops brcmf
+@@ -629,6 +629,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -801,7 +818,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -802,7 +819,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index 43f4e4b3..f858fe99 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1955,6 +1955,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1998,6 +1998,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1963,6 +1966,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2006,6 +2009,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0090-remove-GRO_CONSUMED.patch b/patches/0090-remove-GRO_CONSUMED.patch
index a2bf2cc6..b2abfa96 100644
--- a/patches/0090-remove-GRO_CONSUMED.patch
+++ b/patches/0090-remove-GRO_CONSUMED.patch
@@ -4,7 +4,7 @@ older kernel versions.
 
 --- a/drivers/net/wireless/ath/wil6210/txrx.c
 +++ b/drivers/net/wireless/ath/wil6210/txrx.c
-@@ -750,7 +750,9 @@ void wil_netif_rx_any(struct sk_buff *sk
+@@ -924,7 +924,9 @@ void wil_netif_rx(struct sk_buff *skb, s
  		[GRO_HELD]		= "GRO_HELD",
  		[GRO_NORMAL]		= "GRO_NORMAL",
  		[GRO_DROP]		= "GRO_DROP",
@@ -13,4 +13,4 @@ older kernel versions.
 +#endif /* > 4.11 */
  	};
  
- 	wil->txrx_ops.get_netif_rx_params(skb, &cid, &security);
+ 	if (wdev->iftype == NL80211_IFTYPE_STATION) {
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index 31ac0b7e..d28ca4af 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -65,7 +65,7 @@
  	.class_groups	= devcd_class_groups,
  };
  
-@@ -301,6 +312,11 @@ void dev_coredumpm(struct device *dev, s
+@@ -292,6 +303,11 @@ void dev_coredumpm(struct device *dev, s
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
@@ -77,7 +77,7 @@
  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
  			      "failing_device"))
  		/* nothing - symlink will be missing */;
-@@ -343,15 +359,13 @@ void dev_coredumpsg(struct device *dev,
+@@ -334,15 +350,13 @@ void dev_coredumpsg(struct device *dev,
  }
  EXPORT_SYMBOL_GPL(dev_coredumpsg);
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
