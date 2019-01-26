Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335BDC282C7
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014922087F
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfAZWBC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:01:02 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28392 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfAZWBC (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:01:02 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 61054A11FC;
        Sat, 26 Jan 2019 23:01:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id cdH-kHu-Wm9m; Sat, 26 Jan 2019 23:00:57 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] backports: refresh patches on top of 5.0-rc3
Date:   Sat, 26 Jan 2019 23:00:33 +0100
Message-Id: <20190126220033.27634-8-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

No manual changes needed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch         | 4 ++--
 patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch | 2 +-
 patches/0003-cfg80211-wext-padding/net_wireless_core.patch    | 2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch  | 4 ++--
 patches/0014-netlink_seq/net_wireless_nl80211.patch           | 2 +-
 patches/0024-led-blink-api/mac80211.patch                     | 2 +-
 patches/0028-select_queue/mac80211.patch                      | 4 ++--
 patches/0053-possible_net_t.patch                             | 2 +-
 patches/0069-iwlwifi-pd-string-fix.patch                      | 4 ++--
 patches/0077-genl-ro-after-init/hwsim.patch                   | 2 +-
 patches/0077-genl-ro-after-init/nl80211.patch                 | 2 +-
 patches/0085-iwlwifi-pci-device-removal.patch                 | 4 ++--
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index fa379bfe..8e623c88 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2204,6 +2204,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2364,6 +2364,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2225,6 +2226,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2385,6 +2386,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 12f607d1..441095f2 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4031,6 +4031,9 @@ struct wiphy_iftype_ext_capab {
+@@ -4270,6 +4270,9 @@ struct cfg80211_pmsr_capabilities {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index 011e3741..e1eca55d 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -388,6 +388,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -403,6 +403,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 735599d5..65165cf3 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -481,10 +481,6 @@ use_default_name:
+@@ -496,10 +496,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1235,6 +1231,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1283,6 +1279,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index e1c730bf..67380322 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8158,7 +8158,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8381,7 +8381,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 00a4007c..35279826 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1291,6 +1291,7 @@ struct ieee80211_local {
+@@ -1292,6 +1292,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 82bf659f..bca6793a 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1128,10 +1128,25 @@ static void ieee80211_uninit(struct net_
+@@ -1131,10 +1131,25 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -26,7 +26,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1174,10 +1189,25 @@ static const struct net_device_ops ieee8
+@@ -1177,10 +1192,25 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 0fc1d23e..a7d7b75f 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4171,12 +4171,12 @@ struct wiphy {
+@@ -4412,12 +4412,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index ca7732d0..f6f7d60a 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -26,7 +26,7 @@
  			goto err;
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -1492,8 +1492,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1484,8 +1484,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -1539,15 +1544,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1531,15 +1536,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 6a1b7022..e12d8b4a 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3546,7 +3546,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3646,7 +3646,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index a897be35..e3505a0b 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -13904,7 +13904,7 @@ static const struct genl_ops nl80211_ops
+@@ -14145,7 +14145,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index f61f0172..84fa7f92 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index cc8c53dc0ab6..68296b65a680 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1941,6 +1941,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1968,6 +1968,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index cc8c53dc0ab6..68296b65a680 100644
  	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1949,6 +1952,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1976,6 +1979,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
