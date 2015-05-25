Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57964 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbbEYVoP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:44:15 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] patches: refresh patches on next-20150525
Date: Mon, 25 May 2015 23:44:04 +0200
Message-Id: <1432590244-4101-4-git-send-email-hauke@hauke-m.de> (sfid-20150525_234420_462119_8E913353)
In-Reply-To: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
References: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.107             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.75             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.40             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.39             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.12             [  OK  ]
20  3.19.5              [  OK  ]
21  4.0.0               [  OK  ]
22  4.1-rc1             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/rhashtable.patch                |  2 +-
 .../network/0024-led-blink-api/mac80211.patch                |  2 +-
 .../network/0032-sriov_configure/igb_sriov_configure.patch   |  4 ++--
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch   |  8 ++++----
 .../network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch       |  4 ++--
 .../network/0049-no-pfmemalloc/igb.patch                     |  2 +-
 .../network/0050-iov_iter/bluetooth.patch                    |  6 +++---
 .../network/0053-remove_wait_on_bit_timeout/btusb.patch      | 12 ++++++------
 .../network/0054-struct-proto_ops-sig/ieee802154.patch       | 10 +++++-----
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/patches/backport-adjustments/rhashtable.patch b/patches/backport-adjustments/rhashtable.patch
index e007a15..798d9cb 100644
--- a/patches/backport-adjustments/rhashtable.patch
+++ b/patches/backport-adjustments/rhashtable.patch
@@ -1,6 +1,6 @@
 --- a/compat/lib-rhashtable.c
 +++ b/compat/lib-rhashtable.c
-@@ -25,6 +25,7 @@
+@@ -26,6 +26,7 @@
  #include <linux/random.h>
  #include <linux/rhashtable.h>
  #include <linux/err.h>
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 9683522..e7cbd5f 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1260,6 +1260,7 @@ struct ieee80211_local {
+@@ -1259,6 +1259,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index fa373d8..f847514 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7555,6 +7555,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7550,6 +7550,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7564,6 +7565,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7559,6 +7560,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index dc0e3d8..909d843 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7219,8 +7227,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7214,8 +7222,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7234,11 +7248,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7229,11 +7243,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7254,7 +7276,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7249,7 +7271,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7264,7 +7288,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7259,7 +7283,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 3f2583d..9a3ef6c 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7884,6 +7884,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7879,6 +7879,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7897,7 +7898,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7892,7 +7893,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 24af07f..53b319a 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6583,7 +6583,11 @@ static void igb_reuse_rx_page(struct igb
+@@ -6578,7 +6578,11 @@ static void igb_reuse_rx_page(struct igb
  
  static inline bool igb_page_is_reserved(struct page *page)
  {
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 6099ecb..724d02e 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -162,7 +162,7 @@
  static void l2cap_sock_destruct(struct sock *sk)
 --- a/net/bluetooth/smp.c
 +++ b/net/bluetooth/smp.c
-@@ -601,7 +601,12 @@ static void smp_send_cmd(struct l2cap_co
+@@ -613,7 +613,12 @@ static void smp_send_cmd(struct l2cap_co
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3037,6 +3042,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3049,6 +3054,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3085,6 +3093,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3097,6 +3105,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 22e8c2d..16e7669 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -2151,8 +2151,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1768,8 +1768,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -2169,8 +2173,12 @@ static void btusb_intel_secure_send_resu
+@@ -1786,8 +1790,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2569,6 +2577,7 @@ static int btusb_setup_intel_new(struct
+@@ -2172,6 +2180,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2583,6 +2592,31 @@ static int btusb_setup_intel_new(struct
+@@ -2186,6 +2195,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2622,6 +2656,7 @@ done:
+@@ -2225,6 +2259,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2635,6 +2670,33 @@ done:
+@@ -2238,6 +2273,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
index b737f44..cfb77f3 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/socket.c
 +++ b/net/ieee802154/socket.c
-@@ -98,12 +98,21 @@ static int ieee802154_sock_release(struc
+@@ -96,12 +96,21 @@ static int ieee802154_sock_release(struc
  	return 0;
  }
  
@@ -22,7 +22,7 @@
  }
  
  static int ieee802154_sock_bind(struct socket *sock, struct sockaddr *uaddr,
-@@ -255,7 +264,12 @@ static int raw_disconnect(struct sock *s
+@@ -253,7 +262,12 @@ static int raw_disconnect(struct sock *s
  	return 0;
  }
  
@@ -35,7 +35,7 @@
  {
  	struct net_device *dev;
  	unsigned int mtu;
-@@ -326,8 +340,13 @@ out:
+@@ -324,8 +338,13 @@ out:
  	return err;
  }
  
@@ -49,7 +49,7 @@
  {
  	size_t copied = 0;
  	int err = -EOPNOTSUPP;
-@@ -614,7 +633,12 @@ static int dgram_disconnect(struct sock
+@@ -612,7 +631,12 @@ static int dgram_disconnect(struct sock
  	return 0;
  }
  
@@ -62,7 +62,7 @@
  {
  	struct net_device *dev;
  	unsigned int mtu;
-@@ -713,8 +737,14 @@ out:
+@@ -711,8 +735,14 @@ out:
  	return err;
  }
  
-- 
2.1.4

