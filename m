Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40647 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbaJYSpx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: refresh patches on next-20141023
Date: Sat, 25 Oct 2014 13:39:39 +0200
Message-Id: <1414237179-10199-3-git-send-email-hauke@hauke-m.de> (sfid-20141025_204557_723241_C4B601B5)
In-Reply-To: <1414237179-10199-1-git-send-email-hauke@hauke-m.de>
References: <1414237179-10199-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.104             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.58             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.31             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.22             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.6              [  OK  ]
18  3.17.1              [  OK  ]
19  3.18-rc1            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0006-ieee802154-6lowpan-namespace.patch               | 2 +-
 .../network/0007-lowpan-inet_frag_lru_move.patch                  | 2 +-
 patches/collateral-evolutions/network/0008-net-user-ns.patch      | 2 +-
 .../network/0030-qdisc_tx_busylock/ieee802154.patch               | 4 ++--
 .../network/0032-sriov_configure/igb_sriov_configure.patch        | 8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch        | 8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch        | 6 +++---
 .../collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch  | 8 ++++----
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
index bcf9544..7e1fef3 100644
--- a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
@@ -16,7 +16,7 @@ idea yet.
  
  	spin_lock(&fq->q.lock);
  
-@@ -393,24 +397,44 @@ static int zero;
+@@ -395,24 +399,44 @@ static int zero;
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
diff --git a/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch b/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
index de22c92..d0b2c67 100644
--- a/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
+++ b/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
@@ -23,7 +23,7 @@ and then domain specific inet_frag_lru_move() define.
 +#include <linux/spinlock.h>
  
  struct lowpan_create_arg {
- 	__be16 tag;
+ 	u16 tag;
 @@ -19,8 +20,32 @@ struct lowpan_frag_queue {
  	u16			d_size;
  	struct ieee802154_addr	saddr;
diff --git a/patches/collateral-evolutions/network/0008-net-user-ns.patch b/patches/collateral-evolutions/network/0008-net-user-ns.patch
index 02ae368..f2a7e5d 100644
--- a/patches/collateral-evolutions/network/0008-net-user-ns.patch
+++ b/patches/collateral-evolutions/network/0008-net-user-ns.patch
@@ -3,7 +3,7 @@ via commit 038e7332b8.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -479,9 +479,11 @@ static int __net_init lowpan_frags_ns_sy
+@@ -481,9 +481,11 @@ static int __net_init lowpan_frags_ns_sy
  		table[1].extra2 = &ieee802154_lowpan->frags.high_thresh;
  		table[2].data = &ieee802154_lowpan->frags.timeout;
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 0533c20..7b0d9c7 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -442,7 +442,9 @@ static struct header_ops lowpan_header_o
+@@ -444,7 +444,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -457,7 +459,9 @@ static void lowpan_set_lockdep_class_one
+@@ -459,7 +461,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 486660a..10fdda1 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7533,6 +7537,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7520,6 +7524,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7542,6 +7547,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7529,6 +7534,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7559,6 +7565,7 @@ out:
+@@ -7546,6 +7552,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7569,6 +7576,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7556,6 +7563,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 4150731..0bca051 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7201,8 +7209,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7188,8 +7196,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7216,11 +7230,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7203,11 +7217,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7236,7 +7258,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7223,7 +7245,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7246,7 +7270,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7233,7 +7257,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index c993cdd..b8d18ed 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7884,6 +7888,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7871,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7910,6 +7915,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7897,6 +7902,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7923,7 +7929,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7910,7 +7916,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index b0af473..498b271 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7866,8 +7874,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7853,8 +7861,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7876,6 +7888,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7863,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7889,7 +7902,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7876,7 +7889,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7930,8 +7953,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7917,8 +7940,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-- 
1.9.1

