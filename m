Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63014 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbaDQSFr (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:47 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so608239pdj.40
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 8/8] backports: refresh patches for next-20140415
Date: Thu, 17 Apr 2014 11:04:56 -0700
Message-Id: <1397757896-32558-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200611_866026_3DE1375C)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This update required one collateral evolution to be addressed,
the rest was just a patch refresh.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
--refresh /home/mcgrof/linux-next /home/mcgrof/build/next-20140415
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m16.527s
user    10m47.068s
sys     0m37.412s

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.54              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.79              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.29             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.10             [  OK  ]
14  3.13.2              [  OK  ]
15  3.14-rc1            [  OK  ]

real    18m42.577s
user    498m48.572s
sys     64m0.560s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../0001-ethernet-igb/0001-igb_net_device_ops.patch               | 6 +++---
 .../0001-ethernet-igb/0002-igb_pci_sriov_configure.patch          | 8 ++++----
 .../0001-ethernet-igb/0008-igb_no_fcs.patch                       | 2 +-
 .../0001-ethernet-igb/0009-igb_vlan_rx_vid.patch                  | 6 +++---
 .../0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch          | 6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
index 6b80ad0..97ad8aa 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
@@ -16,7 +16,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7248,8 +7253,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7249,8 +7254,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +29,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7266,8 +7275,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7267,8 +7276,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +42,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7293,7 +7306,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7294,7 +7307,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
index 9b4ba5d..49c29ee 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
@@ -22,7 +22,7 @@ index f2a5abf..dd878b6 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7599,6 +7603,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7600,6 +7604,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7608,6 +7613,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7609,6 +7614,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -38,7 +38,7 @@ index f2a5abf..dd878b6 100644
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7625,6 +7631,8 @@ out:
+@@ -7626,6 +7632,8 @@ out:
  }
  
  #endif
@@ -47,7 +47,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7635,6 +7643,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7636,6 +7644,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
index f6d692a..8b5bb4a 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index fd6a103..a919cfa 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4766,9 +4766,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4765,9 +4765,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
index 83e8ccb..a2021ae 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
@@ -18,7 +18,7 @@ index 37e6062..6bf0a88 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7265,8 +7268,10 @@ static void igb_vlan_mode(struct net_dev
+@@ -7266,8 +7269,10 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
@@ -30,7 +30,7 @@ index 37e6062..6bf0a88 100644
  #endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7281,15 +7286,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7282,15 +7287,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@ index 37e6062..6bf0a88 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7305,7 +7314,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7306,7 +7315,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
index ad19752..a2c5ddb 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
@@ -23,7 +23,7 @@ index 35ac7d8..e609f71 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7934,6 +7938,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7935,6 +7939,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7960,6 +7965,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7961,6 +7966,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 35ac7d8..e609f71 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7972,7 +7978,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7973,7 +7979,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
-- 
1.9.1

