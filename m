Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51835 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbbLUAGL (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] patches: refresh patches on next-20151218
Date: Mon, 21 Dec 2015 01:06:01 +0100
Message-Id: <1450656361-21259-7-git-send-email-hauke@hauke-m.de> (sfid-20151221_010622_033690_CA9B14DE)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.74              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.93             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.51             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.57             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.24             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.13              [  OK  ]
23  4.2.6               [  OK  ]
24  4.3.0               [  OK  ]
25  4.4-rc3             [  FAIL  ]

Build on kernel 4.4-rc3 failed because of a bug introduces in kernel
4.4 in this commit: aabc92bbe3cfe4c "net: add
__netdev_alloc_pcpu_stats() to indicate gfp flags"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0003-devnode_param_type/dvb-core.patch             |  2 +-
 .../network/0004-disable-wext-kconfig.patch                  |  2 +-
 .../network/0013-fix-makefile-includes/6lowpan.patch         |  4 ++--
 .../collateral-evolutions/network/0025-usb-sg/usbnet.patch   | 12 ++++++------
 .../network/0032-sriov_configure/igb_sriov_configure.patch   |  4 ++--
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch   |  8 ++++----
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch     | 10 +++++-----
 .../network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch       |  4 ++--
 .../network/0050-iov_iter/bluetooth.patch                    |  6 +++---
 .../network/0052-deactivate-ptp-pin/igb.patch                |  2 +-
 .../network/0053-remove_wait_on_bit_timeout/btusb.patch      | 12 ++++++------
 .../network/0053-remove_wait_on_bit_timeout/hci_intel.patch  | 10 +++++-----
 .../network/0062-acpi-gpio-remove/hci_intel.patch            |  6 +++---
 13 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
index 0ab1960..dc5c807 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/dvb-core/dvbdev.c
 +++ b/drivers/media/dvb-core/dvbdev.c
-@@ -584,7 +584,11 @@ static int dvb_uevent(struct device *dev
+@@ -838,7 +838,11 @@ static int dvb_uevent(struct device *dev
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 4dc31bc..2ebd366 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -25,7 +25,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -187,7 +169,7 @@ config CFG80211_CRDA_SUPPORT
+@@ -174,7 +156,7 @@ config CFG80211_CRDA_SUPPORT
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
  	depends on CFG80211
diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
index b337bdb..70d0dd5 100644
--- a/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
@@ -6,5 +6,5 @@
  #include <net/6lowpan.h>
 +#include <linux/if_arp.h>
  
- void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
- {
+ #include "6lowpan_i.h"
+ 
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 4e5864b..bcc5e95 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1267,6 +1267,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1270,6 +1270,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1299,6 +1300,12 @@ static int build_dma_sg(const struct sk_
+@@ -1302,6 +1303,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1355,12 +1362,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1358,12 +1365,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1427,7 +1441,9 @@ not_drop:
+@@ -1430,7 +1444,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1480,7 +1496,9 @@ static void usbnet_bh (unsigned long par
+@@ -1483,7 +1499,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1830,7 +1848,9 @@ int usbnet_resume (struct usb_interface
+@@ -1833,7 +1851,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 3f5470a..57b2fe1 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7535,6 +7535,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7543,6 +7543,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7544,6 +7545,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7552,6 +7553,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 4a2fe14..3e1483e 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7197,8 +7205,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7205,8 +7213,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7212,11 +7226,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7220,11 +7234,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7232,7 +7254,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7240,7 +7262,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7242,7 +7266,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7250,7 +7274,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 19ec02b..cef5ce3 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2850,19 +2850,28 @@ static void igb_ethtool_complete(struct
+@@ -2860,19 +2860,28 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -29,7 +29,7 @@
  	if (!indir)
  		return 0;
  	for (i = 0; i < IGB_RETA_SIZE; i++)
-@@ -2870,6 +2879,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2880,6 +2889,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2906,18 +2916,28 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2916,18 +2926,28 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -66,7 +66,7 @@
  	if (!indir)
  		return 0;
  
-@@ -2946,6 +2966,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2956,6 +2976,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -74,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3065,9 +3086,15 @@ static const struct ethtool_ops igb_etht
+@@ -3075,9 +3096,15 @@ static const struct ethtool_ops igb_etht
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 0415705..b0f4df0 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7863,6 +7863,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7871,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7876,7 +7877,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7884,7 +7885,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 6e242f7..4ff6f7f 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1014,6 +1021,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1012,6 +1019,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3084,6 +3089,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3089,6 +3094,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3132,6 +3140,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3137,6 +3145,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
index 3596d6c..c0812a0 100644
--- a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb.h
 +++ b/drivers/net/ethernet/intel/igb/igb.h
-@@ -442,7 +442,9 @@ struct igb_adapter {
+@@ -444,7 +444,9 @@ struct igb_adapter {
  	u32 tx_hwtstamp_timeouts;
  	u32 rx_hwtstamp_cleared;
  
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 9debb39..97f24fb 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1880,8 +1880,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1841,8 +1841,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1898,8 +1902,12 @@ static void btusb_intel_secure_send_resu
+@@ -1859,8 +1863,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2260,6 +2268,7 @@ static int btusb_setup_intel_new(struct
+@@ -2204,6 +2212,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2274,6 +2283,31 @@ static int btusb_setup_intel_new(struct
+@@ -2218,6 +2227,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2313,6 +2347,7 @@ done:
+@@ -2257,6 +2291,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2326,6 +2361,33 @@ done:
+@@ -2270,6 +2305,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
index 1e9a573..f53cd04 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -86,7 +86,7 @@
  
  	return err;
  }
-@@ -836,6 +888,7 @@ static int intel_setup(struct hci_uart *
+@@ -812,6 +864,7 @@ static int intel_setup(struct hci_uart *
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -94,7 +94,7 @@
  	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -850,6 +903,33 @@ static int intel_setup(struct hci_uart *
+@@ -826,6 +879,33 @@ static int intel_setup(struct hci_uart *
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -128,7 +128,7 @@
  
  	if (test_bit(STATE_FIRMWARE_FAILED, &intel->flags)) {
  		bt_dev_err(hdev, "Firmware loading failed");
-@@ -981,8 +1061,12 @@ static int intel_recv_event(struct hci_d
+@@ -957,8 +1037,12 @@ static int intel_recv_event(struct hci_d
  
  		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
  		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
@@ -141,7 +141,7 @@
  		}
  
  	/* When switching to the operational firmware the device
-@@ -992,8 +1076,12 @@ static int intel_recv_event(struct hci_d
+@@ -968,8 +1052,12 @@ static int intel_recv_event(struct hci_d
  	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		   skb->data[2] == 0x02) {
  		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
@@ -154,7 +154,7 @@
  		}
  	}
  recv:
-@@ -1032,15 +1120,23 @@ static int intel_recv_lpm(struct hci_dev
+@@ -1008,15 +1096,23 @@ static int intel_recv_lpm(struct hci_dev
  	case LPM_OP_SUSPEND_ACK:
  		set_bit(STATE_SUSPENDED, &intel->flags);
  		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
index a9a73da..f80b638 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
@@ -20,7 +20,7 @@
  
  		/* Provide to idev a hu reference which is used to run LPM
  		 * transactions (lpm suspend/resume) from PM callbacks.
-@@ -1330,14 +1334,17 @@ static int intel_probe(struct platform_d
+@@ -1306,14 +1310,17 @@ static int intel_probe(struct platform_d
  
  	idev->pdev = pdev;
  
@@ -38,7 +38,7 @@
  	if (idev->irq < 0) {
  		struct gpio_desc *host_wake;
  
-@@ -1356,12 +1363,15 @@ static int intel_probe(struct platform_d
+@@ -1332,12 +1339,15 @@ static int intel_probe(struct platform_d
  			goto no_irq;
  		}
  	}
@@ -54,7 +54,7 @@
  	platform_set_drvdata(pdev, idev);
  
  	/* Place this instance on the device list */
-@@ -1369,8 +1379,10 @@ no_irq:
+@@ -1345,8 +1355,10 @@ no_irq:
  	list_add_tail(&idev->list, &intel_device_list);
  	mutex_unlock(&intel_device_list_lock);
  
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
