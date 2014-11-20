Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58152 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbaKTVQw (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Nov 2014 16:16:52 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so3778932pdj.25
        for <backports@vger.kernel.org>; Thu, 20 Nov 2014 13:16:51 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, oblinger@gmail.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 5/5] backports: refresh patches for next-20141117
Date: Thu, 20 Nov 2014 13:16:23 -0800
Message-Id: <1416518183-7347-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20141120_221654_221467_54F63E26)
In-Reply-To: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
References: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This required no manual changes.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	/home/mcgrof/linux-next /home/mcgrof/build/backports-20141117
Copy original source files ...
Applying patches from patches to /home/mcgrof/build/backports-20141117
...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m28.499s
user    13m25.112s
sys     0m47.804s

mcgrof@drvbp1 ~/build/backports-20141117 $ time \
	/home/mcgrof/backports/devel/ckmake --allyesconfig
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

real    42m18.874s
user    1179m40.500s
sys     138m54.452s

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 .../network/0032-sriov_configure/igb_sriov_configure.patch        | 8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch        | 8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch        | 6 +++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch                  | 2 +-
 .../collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch  | 8 ++++----
 .../network/0048-no_ndo_xmit_flush/igb.patch                      | 2 +-
 .../collateral-evolutions/network/0049-no-pfmemalloc/igb.patch    | 4 ++--
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index cad85cf..6ece3a2 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7524,6 +7528,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7521,6 +7525,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7533,6 +7538,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7530,6 +7535,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7550,6 +7556,7 @@ out:
+@@ -7547,6 +7553,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7560,6 +7567,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7557,6 +7564,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 886c9cb..3100a16 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7192,8 +7200,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7189,8 +7197,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7207,11 +7221,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7204,11 +7218,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7227,7 +7249,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7224,7 +7246,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7237,7 +7261,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7234,7 +7258,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index e098d14..04cbfe6 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7875,6 +7879,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7872,6 +7876,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7901,6 +7906,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7898,6 +7903,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7914,7 +7920,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7911,7 +7917,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index de77231..251dd80 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4800,9 +4800,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4797,9 +4797,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index be2ac2b..f6ed98e 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7857,8 +7865,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7854,8 +7862,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7867,6 +7879,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7864,6 +7876,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7880,7 +7893,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7877,7 +7890,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7921,8 +7944,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7918,8 +7941,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
index f3ed217..76b72ad 100644
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4982,7 +4982,10 @@ static void igb_tx_map(struct igb_ring *
+@@ -4979,7 +4979,10 @@ static void igb_tx_map(struct igb_ring *
  	/* Make sure there is space in the ring for the next send. */
  	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
  
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 2f9f747..49a0462 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index a2d72a8..85d7005 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6569,8 +6569,10 @@ static bool igb_can_reuse_rx_page(struct
+@@ -6566,8 +6566,10 @@ static bool igb_can_reuse_rx_page(struct
  	if (unlikely(page_to_nid(page) != numa_node_id()))
  		return false;
  
@@ -13,7 +13,7 @@ index a2d72a8..85d7005 100644
  
  #if (PAGE_SIZE < 8192)
  	/* if we are only owner of page we can reuse it */
-@@ -6638,8 +6640,12 @@ static bool igb_add_rx_frag(struct igb_r
+@@ -6635,8 +6637,12 @@ static bool igb_add_rx_frag(struct igb_r
  		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
  
  		/* we can reuse buffer as-is, just make sure it is local */
-- 
2.1.1

