Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55537 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933915AbaGWWLg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] backports: refresh patches on next-20140710
Date: Thu, 24 Jul 2014 00:11:28 +0200
Message-Id: <1406153488-23896-12-git-send-email-hauke@hauke-m.de> (sfid-20140724_002108_078346_C244F594)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.60              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.93              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.43             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.22             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.7              [  OK  ]
16  3.15.0              [  OK  ]
17  3.16-rc1            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch      |  2 +-
 .../network/0003-cfg80211-wext-padding/net_wireless_core.patch |  2 +-
 .../network/0006-ieee802154-6lowpan-namespace.patch            |  2 +-
 patches/collateral-evolutions/network/0008-net-user-ns.patch   |  2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch   |  4 ++--
 .../0011-mac80211-disable-tx-status/net_mac80211_tx.patch      |  4 ++--
 .../network/0014-netlink_seq/net_wireless_nl80211.patch        |  2 +-
 .../network/0024-led-blink-api/mac80211.patch                  |  2 +-
 .../collateral-evolutions/network/0027-genl-const/hwsim.patch  |  2 +-
 .../network/0027-genl-const/nl80211.patch                      |  6 +++---
 .../network/0030-qdisc_tx_busylock/ieee802154.patch            |  4 ++--
 .../network/0032-sriov_configure/igb_sriov_configure.patch     |  8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch     |  8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch     |  8 ++++----
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch               |  2 +-
 .../network/0042-pci_error_handlers/atl1e.patch                |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch                     | 10 +++++-----
 .../network/0044-no_user_ns_in_net/ieee802154.patch            |  4 ++--
 18 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 589009e..efcf56d 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2971,6 +2971,9 @@ struct wiphy_vendor_command {
+@@ -2951,6 +2951,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index 051401a..96b5c56 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -316,6 +316,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -315,6 +315,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
index 4122289..82d7ae3 100644
--- a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
@@ -16,7 +16,7 @@ idea yet.
  
  	spin_lock(&fq->q.lock);
  
-@@ -396,28 +400,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
+@@ -397,28 +401,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
diff --git a/patches/collateral-evolutions/network/0008-net-user-ns.patch b/patches/collateral-evolutions/network/0008-net-user-ns.patch
index add44fc..d3a55d8 100644
--- a/patches/collateral-evolutions/network/0008-net-user-ns.patch
+++ b/patches/collateral-evolutions/network/0008-net-user-ns.patch
@@ -3,7 +3,7 @@ via commit 038e7332b8.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -478,9 +478,11 @@ static int __net_init lowpan_frags_ns_sy
+@@ -479,9 +479,11 @@ static int __net_init lowpan_frags_ns_sy
  		table[2].data = &ieee802154_lowpan->frags.timeout;
  		table[3].data = &ieee802154_lowpan->max_dsize;
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index d1015c1..b7b93e4 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -368,10 +368,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -367,10 +367,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -926,6 +922,15 @@ static int cfg80211_netdev_notifier_call
+@@ -925,6 +921,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
index e481d68..05c4565 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2065,6 +2065,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2067,6 +2067,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2093,6 +2094,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2095,6 +2096,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 748e1ab..f416739 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6159,7 +6159,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6148,7 +6148,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 57a717f..c38e1af 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1173,6 +1173,9 @@ struct ieee80211_local {
+@@ -1212,6 +1212,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index e3ba9c3..925b391 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2481,7 +2481,7 @@ static int hwsim_destroy_radio_nl(struct
+@@ -2478,7 +2478,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 76ee887..1d0d9c8 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9379,7 +9379,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9371,7 +9371,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9448,7 +9448,7 @@ static int nl80211_pre_doit(const struct
+@@ -9440,7 +9440,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9465,7 +9465,7 @@ static void nl80211_post_doit(const stru
+@@ -9457,7 +9457,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 3478546..893ac4f 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -393,7 +393,9 @@ static struct header_ops lowpan_header_o
+@@ -397,7 +397,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -408,7 +410,9 @@ static void lowpan_set_lockdep_class_one
+@@ -412,7 +414,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 8cf5383..a75e3aa 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7596,6 +7600,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7598,6 +7602,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7605,6 +7610,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7607,6 +7612,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7622,6 +7628,7 @@ out:
+@@ -7624,6 +7630,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7632,6 +7639,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7634,6 +7641,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 0cb392d..7911110 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7266,8 +7274,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7268,8 +7276,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7281,11 +7295,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7283,11 +7297,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7301,7 +7323,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7303,7 +7325,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7311,7 +7335,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7313,7 +7337,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index f8b64b6..eed470e 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -11,7 +11,7 @@
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2097,7 +2099,9 @@ static const struct net_device_ops igb_n
+@@ -2099,7 +2101,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7947,6 +7951,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7949,6 +7953,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7973,6 +7978,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7975,6 +7980,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7986,7 +7992,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7988,7 +7994,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index caef10f..8ae57b6 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4773,9 +4773,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4775,9 +4775,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
index 3ef2f93..1c6f705 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2559,7 +2559,11 @@ static void atl1e_io_resume(struct pci_d
+@@ -2556,7 +2556,11 @@ static void atl1e_io_resume(struct pci_d
  	netif_device_attach(netdev);
  }
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index 59a22e5..daa85b5 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -12,7 +12,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting);
-@@ -2102,7 +2106,11 @@ static const struct net_device_ops igb_n
+@@ -2104,7 +2108,11 @@ static const struct net_device_ops igb_n
  	.ndo_vlan_rx_kill_vid	= igb_vlan_rx_kill_vid,
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7929,8 +7937,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7931,8 +7939,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7939,6 +7951,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7941,6 +7953,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7952,7 +7965,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7954,7 +7967,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7993,8 +8016,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7995,8 +8018,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
index d5f951b..2532316 100644
--- a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/dgram.c
 +++ b/net/ieee802154/dgram.c
-@@ -483,8 +483,13 @@ static int dgram_setsockopt(struct sock
+@@ -485,8 +485,13 @@ static int dgram_setsockopt(struct sock
  		ro->want_ack = !!val;
  		break;
  	case WPAN_SECURITY:
@@ -14,7 +14,7 @@
  			err = -EPERM;
  			break;
  		}
-@@ -507,8 +512,13 @@ static int dgram_setsockopt(struct sock
+@@ -509,8 +514,13 @@ static int dgram_setsockopt(struct sock
  		}
  		break;
  	case WPAN_SECURITY_LEVEL:
-- 
1.9.1

