Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3538C65BB0
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F49A20834
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F49A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeLBLxA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:53:00 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:50480 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeLBLw7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:59 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 91E3242921;
        Sun,  2 Dec 2018 12:52:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id ekHOmUiBNbOm; Sun,  2 Dec 2018 12:52:50 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/12] backports: Refresh patches on kernel 4.20-rc4
Date:   Sun,  2 Dec 2018 12:52:15 +0100
Message-Id: <20181202115226.3594-2-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This patch was merged upstream and removed from backports:
 * patches/0090-use-skb_pad.patch

This patch was manually modified:
 * patches/0025-usb-sg/usbnet.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch         |  4 ++--
 patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch |  2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch  |  2 +-
 patches/0014-netlink_seq/net_wireless_nl80211.patch           |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch                |  4 ++--
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch              |  6 +++---
 patches/0021-umode_t-api-change/ath9k.patch                   |  2 +-
 patches/0024-led-blink-api/mac80211.patch                     |  2 +-
 patches/0025-usb-sg/usbnet.patch                              |  4 ++--
 patches/0053-possible_net_t.patch                             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch                  |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch                      |  8 ++++----
 patches/0070-mac80211-fils.patch                              |  2 +-
 patches/0071-skb-head_frag/wireless.patch                     |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch                   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch                 |  2 +-
 patches/0085-iwlwifi-pci-device-removal.patch                 |  4 ++--
 patches/0090-use-skb_pad.patch                                | 11 -----------
 18 files changed, 26 insertions(+), 37 deletions(-)
 delete mode 100644 patches/0090-use-skb_pad.patch

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index be1d9720..fa379bfe 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2174,6 +2174,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2204,6 +2204,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2195,6 +2196,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2225,6 +2226,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index f8159596..12f607d1 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3971,6 +3971,9 @@ struct wiphy_iftype_ext_capab {
+@@ -4031,6 +4031,9 @@ struct wiphy_iftype_ext_capab {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index e129648c..735599d5 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1215,6 +1211,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1235,6 +1231,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 3bbaf287..e1c730bf 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8206,7 +8206,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8158,7 +8158,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 6dace46d..22108262 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -938,6 +938,7 @@ static int if_usb_suspend(struct usb_int
+@@ -939,6 +939,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -946,6 +947,7 @@ static int if_usb_suspend(struct usb_int
+@@ -947,6 +948,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
index dba0a1de..d323f7ad 100644
--- a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
 +++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
-@@ -74,13 +74,16 @@ void __iwl_ ##fn(struct device *dev, con
+@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, con
  	struct va_format vaf = {				\
  		.fmt = fmt,					\
  	};							\
@@ -21,7 +21,7 @@
  }
  
  __iwl_fn(warn)
-@@ -99,13 +102,18 @@ void __iwl_err(struct device *dev, bool
+@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool
  	va_list args;
  
  	va_start(args, fmt);
@@ -41,7 +41,7 @@
  	trace_iwlwifi_err(&vaf);
  	va_end(args);
  }
-@@ -122,13 +130,19 @@ void __iwl_dbg(struct device *dev,
+@@ -117,13 +125,19 @@ void __iwl_dbg(struct device *dev,
  	va_list args;
  
  	va_start(args, fmt);
diff --git a/patches/0021-umode_t-api-change/ath9k.patch b/patches/0021-umode_t-api-change/ath9k.patch
index 9707a5a8..1be51cb9 100644
--- a/patches/0021-umode_t-api-change/ath9k.patch
+++ b/patches/0021-umode_t-api-change/ath9k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/common-spectral.c
 +++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
-@@ -1050,7 +1050,11 @@ static const struct file_operations fops
+@@ -1031,7 +1031,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 42a02533..00a4007c 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1285,6 +1285,7 @@ struct ieee80211_local {
+@@ -1291,6 +1291,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 50c2d274..cab07250 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -58,10 +58,10 @@
 +#if LINUX_VERSION_IS_GEQ(3,35,0)
  			kfree(entry->urb->sg);
 +#endif
+ 			/* fall through */
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
- 			dev_kfree_skb (skb);
-@@ -1893,7 +1911,9 @@ int usbnet_resume (struct usb_interface
+@@ -1894,7 +1912,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index e052a16a..0fc1d23e 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4113,12 +4113,12 @@ struct wiphy {
+@@ -4171,12 +4171,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index b9c9b390..ddf248cc 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2203,7 +2203,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2215,7 +2215,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index b2a6a512..ca7732d0 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-@@ -2419,12 +2419,23 @@ int iwl_dbgfs_register(struct iwl_priv *
+@@ -2414,12 +2414,23 @@ int iwl_dbgfs_register(struct iwl_priv *
  	 */
  	if (priv->mac80211_registered) {
  		char buf[100];
@@ -26,7 +26,7 @@
  			goto err;
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -1497,8 +1497,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1492,8 +1492,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -1544,15 +1549,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1539,15 +1544,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
@@ -71,7 +71,7 @@
  	IWL_ERR(mvm, "Can't create debugfs entity\n");
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2056,7 +2056,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
+@@ -2078,7 +2078,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index bdbc8a94..c277a642 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -570,7 +570,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -571,7 +571,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index d165630c..026a03e1 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -634,7 +634,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -637,7 +637,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 986e2a04..6a1b7022 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3553,7 +3553,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3546,7 +3546,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index bb9f9013..a897be35 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -13906,7 +13906,7 @@ static const struct genl_ops nl80211_ops
+@@ -13904,7 +13904,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index 6e1f1fff..f61f0172 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index cc8c53dc0ab6..68296b65a680 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1922,6 +1922,9 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+@@ -1941,6 +1941,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index cc8c53dc0ab6..68296b65a680 100644
  	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1930,6 +1933,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+@@ -1949,6 +1952,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0090-use-skb_pad.patch b/patches/0090-use-skb_pad.patch
deleted file mode 100644
index 086328c1..00000000
--- a/patches/0090-use-skb_pad.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/mediatek/mt76/usb.c
-+++ b/drivers/net/wireless/mediatek/mt76/usb.c
-@@ -535,7 +535,7 @@ int mt76u_skb_dma_info(struct sk_buff *s
- 	}
- 
- 	if (unlikely(pad)) {
--		if (__skb_pad(last, pad, true))
-+		if (skb_pad(last, pad))
- 			return -ENOMEM;
- 		__skb_put(last, pad);
- 	}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
