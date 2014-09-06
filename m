Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48148 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbaIFXX6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 19:23:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] backports: refresh patches on next-20140905
Date: Sun,  7 Sep 2014 01:23:37 +0200
Message-Id: <1410045817-4112-5-git-send-email-hauke@hauke-m.de> (sfid-20140907_012405_087661_CD9282FA)
In-Reply-To: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
References: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.103             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.54             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.27             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.18             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.2              [  OK  ]
18  3.17-rc3            [  OK  ]

manual changes were done in:
patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch   |  2 +-
 .../network/0006-ieee802154-6lowpan-namespace.patch         | 13 +------------
 .../collateral-evolutions/network/0008-net-user-ns.patch    |  4 ++--
 .../net_wireless_core.patch                                 |  2 +-
 .../0011-mac80211-disable-tx-status/net_mac80211_tx.patch   |  4 ++--
 .../network/0014-netlink_seq/net_wireless_nl80211.patch     |  2 +-
 .../network/0027-genl-const/nl80211.patch                   |  6 +++---
 .../network/0032-sriov_configure/igb_sriov_configure.patch  |  8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch  |  8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch  |  6 +++---
 .../network/0043-ndo_set_vf_rate/igb.patch                  |  8 ++++----
 11 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index efcf56d..428e267 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2951,6 +2951,9 @@ struct wiphy_vendor_command {
+@@ -2953,6 +2953,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
index 609bf20..bcf9544 100644
--- a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
@@ -16,7 +16,7 @@ idea yet.
  
  	spin_lock(&fq->q.lock);
  
-@@ -393,31 +397,55 @@ static int zero;
+@@ -393,24 +397,44 @@ static int zero;
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
@@ -61,14 +61,3 @@ idea yet.
  		.maxlen		= sizeof(int),
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_jiffies,
- 	},
- 	{
- 		.procname	= "6lowpanfrag_max_datagram_size",
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
- 		.data		= &init_net.ieee802154_lowpan.max_dsize,
-+#else
-+		.data		= &ieee802154_lowpan.max_dsize,
-+#endif
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec
diff --git a/patches/collateral-evolutions/network/0008-net-user-ns.patch b/patches/collateral-evolutions/network/0008-net-user-ns.patch
index d9cea85..02ae368 100644
--- a/patches/collateral-evolutions/network/0008-net-user-ns.patch
+++ b/patches/collateral-evolutions/network/0008-net-user-ns.patch
@@ -3,9 +3,9 @@ via commit 038e7332b8.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -491,9 +491,11 @@ static int __net_init lowpan_frags_ns_sy
+@@ -479,9 +479,11 @@ static int __net_init lowpan_frags_ns_sy
+ 		table[1].extra2 = &ieee802154_lowpan->frags.high_thresh;
  		table[2].data = &ieee802154_lowpan->frags.timeout;
- 		table[3].data = &ieee802154_lowpan->max_dsize;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
  		/* Don't export sysctls to unprivileged users */
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index b7b93e4..f45685b 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -925,6 +921,15 @@ static int cfg80211_netdev_notifier_call
+@@ -918,6 +914,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
index 05c4565..ed792ad 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2067,6 +2067,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2070,6 +2070,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2095,6 +2096,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2098,6 +2099,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index a995a7c..16f1cab 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6149,7 +6149,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6157,7 +6157,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 0565390..59dbd0c 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9372,7 +9372,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9380,7 +9380,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9441,7 +9441,7 @@ static int nl80211_pre_doit(const struct
+@@ -9449,7 +9449,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9458,7 +9458,7 @@ static void nl80211_post_doit(const stru
+@@ -9466,7 +9466,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 49d894b..6d20e13 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7639,6 +7643,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7640,6 +7644,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7648,6 +7653,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7649,6 +7654,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7665,6 +7671,7 @@ out:
+@@ -7666,6 +7672,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7675,6 +7682,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7676,6 +7683,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 8ef2e21..c203886 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7307,8 +7315,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7308,8 +7316,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7322,11 +7336,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7323,11 +7337,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7342,7 +7364,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7343,7 +7365,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7352,7 +7376,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7353,7 +7377,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 742e2bc..45adb7e 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7990,6 +7994,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7991,6 +7995,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -8016,6 +8021,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -8017,6 +8022,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -8029,7 +8035,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -8030,7 +8036,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index ed1db41..c1786fc 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7972,8 +7980,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7973,8 +7981,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7982,6 +7994,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7983,6 +7995,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7995,7 +8008,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7996,7 +8009,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -8036,8 +8059,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -8037,8 +8060,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-- 
1.9.1

