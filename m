Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56035 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbaEaRRH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:17:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 769677E62
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:17:05 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/13] backports: refresh patches on next-20140501
Date: Sat, 31 May 2014 19:16:09 +0200
Message-Id: <1401556570-3363-13-git-send-email-hauke@hauke-m.de> (sfid-20140531_192147_959380_D8F8638A)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0002-disable-dump-adjust-on-old-kernels.patch      |  4 ++--
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch      |  2 +-
 .../network/0003-cfg80211-wext-padding/net_wireless_core.patch |  2 +-
 .../network/0004-disable-wext-kconfig.patch                    |  2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch   |  4 ++--
 .../network/0014-netlink_seq/net_wireless_nl80211.patch        |  2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch             |  8 ++++----
 .../network/0024-led-blink-api/mac80211.patch                  |  2 +-
 .../collateral-evolutions/network/0027-genl-const/hwsim.patch  |  2 +-
 .../network/0027-genl-const/nl80211.patch                      |  6 +++---
 .../network/0028-select_queue/mac80211.patch                   |  4 ++--
 .../network/0028-select_queue/mwifiex.patch                    |  2 +-
 .../network/0032-sriov_configure/igb_sriov_configure.patch     |  8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch     | 10 +++++-----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch     | 10 +++++-----
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch               |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch             |  8 ++++----
 .../network/0037-ethtool_get_module/igb_get_module.patch       |  6 +++---
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch       | 10 +++++-----
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch                 |  2 +-
 .../network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch   | 10 +++++-----
 .../igb-devm_hwmon_device_register_with_groups.patch           |  6 +++---
 .../0042-pci_error_handlers/igb_pci_error_handlers.patch       |  2 +-
 23 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 195633c..84a6a9a 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1731,6 +1731,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1751,6 +1751,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1752,6 +1753,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1772,6 +1773,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 15f501e..d2e7bdd 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2909,6 +2909,9 @@ struct wiphy_vendor_command {
+@@ -2929,6 +2929,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index 5cd257b..c585c51 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -269,6 +269,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -308,6 +308,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 9d32cfe..4166487 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -25,7 +25,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -134,7 +116,7 @@ config CFG80211_INTERNAL_REGDB
+@@ -171,7 +153,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility"
  	depends on CFG80211
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 1e7e6b2..811f94b 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -321,10 +321,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -360,10 +360,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -844,6 +840,15 @@ static int cfg80211_netdev_notifier_call
+@@ -884,6 +880,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 65d92f6..cfcc156 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6092,7 +6092,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6108,7 +6108,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 1409834..38f11f5 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 7c8b9bf..75606be 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+@@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_d
  	}
  }
  
@@ -10,7 +10,7 @@ index 7c8b9bf..75606be 100644
  static int igb_get_ts_info(struct net_device *dev,
  			   struct ethtool_ts_info *info)
  {
-@@ -2405,6 +2406,7 @@ static int igb_get_ts_info(struct net_device *dev,
+@@ -2405,6 +2406,7 @@ static int igb_get_ts_info(struct net_de
  		return -EOPNOTSUPP;
  	}
  }
@@ -18,7 +18,7 @@ index 7c8b9bf..75606be 100644
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -3019,7 +3021,9 @@ static const struct ethtool_ops igb_ethtool_ops = {
+@@ -3017,7 +3019,9 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
@@ -27,4 +27,4 @@ index 7c8b9bf..75606be 100644
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.get_eee		= igb_get_eee,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index f623788..fa5fa3d 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1160,6 +1160,9 @@ struct ieee80211_local {
+@@ -1170,6 +1170,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 925b391..e3ba9c3 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2478,7 +2478,7 @@ static int hwsim_destroy_radio_nl(struct
+@@ -2481,7 +2481,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index b78d2bc..0d5b34d 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9288,7 +9288,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9304,7 +9304,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9357,7 +9357,7 @@ static int nl80211_pre_doit(const struct
+@@ -9373,7 +9373,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9374,7 +9374,7 @@ static void nl80211_post_doit(const stru
+@@ -9390,7 +9390,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index d21a56b..77d3e2f 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -2,7 +2,7 @@ diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
 index 088111a..dcf149a 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1052,10 +1052,19 @@ static void ieee80211_uninit(struct net_
+@@ -1063,10 +1063,19 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@ index 088111a..dcf149a 100644
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1071,10 +1080,19 @@ static const struct net_device_ops ieee8
+@@ -1082,10 +1091,19 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index e53683e..7391bdd 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/mwifiex/main.c b/drivers/net/wireless/mwifiex/
 index 9d3d275..f8b16f4 100644
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -747,9 +747,18 @@ static struct net_device_stats *mwifiex_
+@@ -745,9 +745,18 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 1e4df5d..3453e74 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 0270da9..09564d0 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -198,7 +198,9 @@ static const struct dev_pm_ops igb_pm_ops = {
+@@ -198,7 +198,9 @@ static const struct dev_pm_ops igb_pm_op
  };
  #endif
  static void igb_shutdown(struct pci_dev *);
@@ -22,7 +22,7 @@ index 0270da9..09564d0 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7591,6 +7595,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
+@@ -7591,6 +7595,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index 0270da9..09564d0 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7600,6 +7605,7 @@ static int igb_pci_disable_sriov(struct pci_dev *dev)
+@@ -7600,6 +7605,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -46,7 +46,7 @@ index 0270da9..09564d0 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7627,6 +7634,7 @@ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+@@ -7627,6 +7634,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 58930f7..adb2d97 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 09564d0..325f244 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -157,8 +157,16 @@ static void igb_tx_timeout(struct net_device *);
+@@ -157,8 +157,16 @@ static void igb_tx_timeout(struct net_de
  static void igb_reset_task(struct work_struct *);
  static void igb_vlan_mode(struct net_device *netdev,
  			  netdev_features_t features);
@@ -19,7 +19,7 @@ index 09564d0..325f244 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7261,8 +7269,14 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
+@@ -7261,8 +7269,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -34,7 +34,7 @@ index 09564d0..325f244 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7276,11 +7290,19 @@ static int igb_vlan_rx_add_vid(struct net_device *netdev,
+@@ -7276,11 +7290,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -54,7 +54,7 @@ index 09564d0..325f244 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7296,7 +7318,9 @@ static int igb_vlan_rx_kill_vid(struct net_device *netdev,
+@@ -7296,7 +7318,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -64,7 +64,7 @@ index 09564d0..325f244 100644
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7306,7 +7330,11 @@ static void igb_restore_vlan(struct igb_adapter *adapter)
+@@ -7306,7 +7330,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 5864a90..1e6eda5 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 325f244..ccd8f36 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
+@@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net
  static int igb_ndo_set_vf_vlan(struct net_device *netdev,
  			       int vf, u16 vlan, u8 qos);
  static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate);
@@ -13,7 +13,7 @@ index 325f244..ccd8f36 100644
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2097,7 +2099,9 @@ static const struct net_device_ops igb_netdev_ops = {
+@@ -2097,7 +2099,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
@@ -23,7 +23,7 @@ index 325f244..ccd8f36 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7937,6 +7941,7 @@ static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate)
+@@ -7937,6 +7941,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 325f244..ccd8f36 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7963,6 +7968,7 @@ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
+@@ -7963,6 +7968,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 325f244..ccd8f36 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7975,7 +7981,9 @@ static int igb_ndo_get_vf_config(struct net_device *netdev,
+@@ -7975,7 +7981,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index d4aee27..e0c54ce 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index ccd8f36..132cef8 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4768,9 +4768,10 @@ static u32 igb_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
+@@ -4768,9 +4768,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index dcc5b2b..8663c39 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 333a2b0..7c8b9bf 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2589,6 +2589,7 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+@@ -2591,6 +2591,7 @@ static int igb_set_rxnfc(struct net_devi
  	return ret;
  }
  
@@ -10,7 +10,7 @@ index 333a2b0..7c8b9bf 100644
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2730,6 +2731,7 @@ static int igb_set_eee(struct net_device *netdev,
+@@ -2732,6 +2733,7 @@ static int igb_set_eee(struct net_device
  
  	return 0;
  }
@@ -18,8 +18,8 @@ index 333a2b0..7c8b9bf 100644
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3020,8 +3022,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
- 	.get_ts_info		= igb_get_ts_info,
+@@ -3024,8 +3026,10 @@ static const struct ethtool_ops igb_etht
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index 851fdc8..4c2f181 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 75606be..6662b3b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2735,6 +2735,7 @@ static int igb_set_eee(struct net_device *netdev,
+@@ -2735,6 +2735,7 @@ static int igb_set_eee(struct net_device
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  
@@ -10,7 +10,7 @@ index 75606be..6662b3b 100644
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2815,6 +2816,7 @@ static int igb_get_module_eeprom(struct net_device *netdev,
+@@ -2815,6 +2816,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 75606be..6662b3b 100644
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
+@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_etht
  	.get_eee		= igb_get_eee,
  	.set_eee		= igb_set_eee,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 93a0396..9568482 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 6662b3b..03fe81a 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct net_device *netdev)
+@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -10,7 +10,7 @@ index 6662b3b..03fe81a 100644
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
-@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net_device *netdev, u32 *indir)
+@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 6662b3b..03fe81a 100644
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
+@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -26,7 +26,7 @@ index 6662b3b..03fe81a 100644
  static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
+@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 6662b3b..03fe81a 100644
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_ethtool_ops = {
+@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
index 875b97a..daec82c 100644
--- a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 03fe81a..f561b7b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2450,8 +2450,13 @@ static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
+@@ -2450,8 +2450,13 @@ static int igb_get_rss_hash_opts(struct
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
index 5783b3f..5b4713d 100644
--- a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index f561b7b..b611f5b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -245,10 +245,12 @@ static int igb_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+@@ -245,10 +245,12 @@ static int igb_get_settings(struct net_d
  	else
  		ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
  
@@ -15,7 +15,7 @@ index f561b7b..b611f5b 100644
  
  	return 0;
  }
-@@ -267,6 +269,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+@@ -267,6 +269,7 @@ static int igb_set_settings(struct net_d
  		return -EINVAL;
  	}
  
@@ -23,7 +23,7 @@ index f561b7b..b611f5b 100644
  	/* MDI setting is only allowed when autoneg enabled because
  	 * some hardware doesn't allow MDI setting when speed or
  	 * duplex is forced.
-@@ -281,6 +284,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+@@ -281,6 +284,7 @@ static int igb_set_settings(struct net_d
  			return -EINVAL;
  		}
  	}
@@ -31,7 +31,7 @@ index f561b7b..b611f5b 100644
  
  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
  		usleep_range(1000, 2000);
-@@ -324,6 +328,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+@@ -324,6 +328,7 @@ static int igb_set_settings(struct net_d
  		}
  	}
  
@@ -39,7 +39,7 @@ index f561b7b..b611f5b 100644
  	/* MDI-X => 2; MDI => 1; Auto => 3 */
  	if (ecmd->eth_tp_mdix_ctrl) {
  		/* fix up the value for auto (3 => 0) as zero is mapped
-@@ -334,6 +339,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+@@ -334,6 +339,7 @@ static int igb_set_settings(struct net_d
  		else
  			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
  	}
diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
index 9f4f40e..057dc28 100644
--- a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
+++ b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/i
 index 2eee9bb..ad08b1f 100644
 --- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
 +++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-@@ -173,7 +173,9 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+@@ -173,7 +173,9 @@ int igb_sysfs_init(struct igb_adapter *a
  {
  	struct hwmon_buff *igb_hwmon;
  	struct i2c_client *client;
@@ -12,7 +12,7 @@ index 2eee9bb..ad08b1f 100644
  	unsigned int i;
  	int rc = 0;
  
-@@ -230,6 +232,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+@@ -230,6 +232,7 @@ int igb_sysfs_init(struct igb_adapter *a
  	igb_hwmon->groups[0] = &igb_hwmon->group;
  	igb_hwmon->group.attrs = igb_hwmon->attrs;
  
@@ -20,7 +20,7 @@ index 2eee9bb..ad08b1f 100644
  	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
  							   client->name,
  							   igb_hwmon,
-@@ -242,6 +245,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+@@ -242,6 +245,7 @@ int igb_sysfs_init(struct igb_adapter *a
  	goto exit;
  
  err:
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
index cedff12..06af19b 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 132cef8..0e616a7 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *,
+@@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_det
  static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
  static void igb_io_resume(struct pci_dev *);
  
-- 
1.9.1

