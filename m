Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39121 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbbHBWh6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] patches: refresh on next-20150731
Date: Mon,  3 Aug 2015 00:37:47 +0200
Message-Id: <1438555067-15301-9-git-send-email-hauke@hauke-m.de> (sfid-20150803_003812_822011_5161453D)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.69              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.108             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.84             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.44             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.48             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.19             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.3               [  OK  ]
23  4.2-rc3             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/crypto-ccm.patch              |  4 ++--
 .../network/0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0028-select_queue/mwifiex.patch                |  2 +-
 .../network/0032-sriov_configure/igb_sriov_configure.patch |  4 ++--
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++++----
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 +++++-----
 .../network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 ++--
 .../network/0050-iov_iter/bluetooth.patch                  | 14 +++++++-------
 .../network/0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++++++------
 9 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/patches/backport-adjustments/crypto-ccm.patch b/patches/backport-adjustments/crypto-ccm.patch
index 9b722fa..6a86d54 100644
--- a/patches/backport-adjustments/crypto-ccm.patch
+++ b/patches/backport-adjustments/crypto-ccm.patch
@@ -46,7 +46,7 @@
  
  struct ccm_instance_ctx {
  	struct crypto_skcipher_spawn ctr;
-@@ -841,7 +872,7 @@ static struct crypto_template crypto_rfc
+@@ -901,7 +932,7 @@ static struct crypto_template crypto_rfc
  	.module = THIS_MODULE,
  };
  
@@ -55,7 +55,7 @@
  {
  	int err;
  
-@@ -867,18 +898,9 @@ out_undo_base:
+@@ -927,18 +958,9 @@ out_undo_base:
  	goto out;
  }
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 2ca653f..4d991be 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6650,7 +6650,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6651,7 +6651,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 93bec6c..36a42c6 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -1082,9 +1082,19 @@ static struct net_device_stats *mwifiex_
+@@ -1137,9 +1137,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index f847514..8376697 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7550,6 +7550,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7506,6 +7506,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7559,6 +7560,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7515,6 +7516,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 909d843..78baa28 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7214,8 +7222,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7170,8 +7178,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7229,11 +7243,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7185,11 +7199,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7249,7 +7271,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7205,7 +7227,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7259,7 +7283,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7215,7 +7239,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 4f66a27..6b36a9c 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2837,19 +2837,28 @@ static void igb_ethtool_complete(struct
+@@ -2854,19 +2854,28 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -29,7 +29,7 @@
  	if (!indir)
  		return 0;
  	for (i = 0; i < IGB_RETA_SIZE; i++)
-@@ -2857,6 +2866,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2874,6 +2883,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2893,18 +2903,28 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2910,18 +2920,28 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -66,7 +66,7 @@
  	if (!indir)
  		return 0;
  
-@@ -2933,6 +2953,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2950,6 +2970,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -74,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3049,9 +3070,15 @@ static const struct ethtool_ops igb_etht
+@@ -3066,9 +3087,15 @@ static const struct ethtool_ops igb_etht
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index ebc84bb..32559f6 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7878,6 +7878,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7834,6 +7834,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7891,7 +7892,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7847,7 +7848,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index c04b0f6..c7729b9 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1050,6 +1057,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1053,6 +1060,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -80,7 +80,7 @@
  	.defer			= l2cap_chan_no_defer,
 --- a/net/bluetooth/a2mp.c
 +++ b/net/bluetooth/a2mp.c
-@@ -62,7 +62,12 @@ static void a2mp_send(struct amp_mgr *mg
+@@ -63,7 +63,12 @@ static void a2mp_send(struct amp_mgr *mg
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -93,7 +93,7 @@
  
  	l2cap_chan_send(chan, &msg, total_len);
  
-@@ -738,6 +743,9 @@ static const struct l2cap_ops a2mp_chan_
+@@ -753,6 +758,9 @@ static const struct l2cap_ops a2mp_chan_
  	.resume = l2cap_chan_no_resume,
  	.set_shutdown = l2cap_chan_no_set_shutdown,
  	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
@@ -134,7 +134,7 @@
  		sent += count;
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -1354,6 +1354,15 @@ static struct sk_buff *l2cap_sock_alloc_
+@@ -1360,6 +1360,15 @@ static struct sk_buff *l2cap_sock_alloc_
  	return skb;
  }
  
@@ -150,7 +150,7 @@
  static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
  {
  	struct sock *sk = chan->data;
-@@ -1438,6 +1447,9 @@ static const struct l2cap_ops l2cap_chan
+@@ -1444,6 +1453,9 @@ static const struct l2cap_ops l2cap_chan
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3054,6 +3059,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3058,6 +3063,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3102,6 +3110,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3106,6 +3114,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 2ce2ece..ee19313 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1756,8 +1756,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1759,8 +1759,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1774,8 +1778,12 @@ static void btusb_intel_secure_send_resu
+@@ -1777,8 +1781,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2130,6 +2138,7 @@ static int btusb_setup_intel_new(struct
+@@ -2133,6 +2141,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2144,6 +2153,31 @@ static int btusb_setup_intel_new(struct
+@@ -2147,6 +2156,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2183,6 +2217,7 @@ done:
+@@ -2186,6 +2220,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2196,6 +2231,33 @@ done:
+@@ -2199,6 +2234,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
