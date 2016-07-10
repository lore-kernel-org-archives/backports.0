Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56157 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273AbcGJVPD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/19] patches: refresh on next-20160324
Date: Sun, 10 Jul 2016 23:14:42 +0200
Message-Id: <1468185285-28265-17-git-send-email-hauke@hauke-m.de> (sfid-20160711_013914_250402_842E5224)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.81              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.112             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.102            [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.61             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.73             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.36             [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.36             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.27              [  OK  ]
23  4.2.8               [  OK  ]
24  4.3.6               [  OK  ]
25  4.4.14              [  OK  ]
26  4.5.7               [  OK  ]

Manual changes done to:
patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-missing-include/media-device.patch  |  2 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 ++--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 23 ++++++++++++++--------
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 ++--
 .../network/0052-deactivate-ptp-pin/igb.patch      | 16 +++++++--------
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++++------
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  2 +-
 .../network/0072-netdevice-ndo_fdb_add/igb.patch   |  2 +-
 16 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/patches/collateral-evolutions/media/0004-missing-include/media-device.patch b/patches/collateral-evolutions/media/0004-missing-include/media-device.patch
index 9e0128a..01fbe79 100644
--- a/patches/collateral-evolutions/media/0004-missing-include/media-device.patch
+++ b/patches/collateral-evolutions/media/0004-missing-include/media-device.patch
@@ -7,6 +7,6 @@ index d385589..6d9a84d 100644
  #define _MEDIA_DEVICE_H
  
 +#include <linux/idr.h>
+ #include <linux/kref.h>
  #include <linux/list.h>
  #include <linux/mutex.h>
- #include <linux/spinlock.h>
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index c5332f5..64e4f91 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1817,6 +1817,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1846,6 +1846,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1838,6 +1839,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1867,6 +1868,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 959ad9e..78ef3d6 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3188,6 +3188,9 @@ struct wiphy_vendor_command {
+@@ -3222,6 +3222,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index ccc1fab..437775c 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1036,6 +1032,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1043,6 +1039,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 362c26c..d51f911 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6853,7 +6853,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6955,7 +6955,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index e7b9b84..46b919b 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1252,6 +1252,7 @@ struct ieee80211_local {
+@@ -1255,6 +1255,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index bcc5e95..e9c204d 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1833,7 +1851,9 @@ int usbnet_resume (struct usb_interface
+@@ -1840,7 +1858,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 57b2fe1..2167b7c 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7543,6 +7543,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7682,6 +7682,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7552,6 +7553,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7691,6 +7692,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 3e1483e..5d174c2 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -157,8 +157,16 @@ static void igb_tx_timeout(struct net_de
+@@ -158,8 +158,16 @@ static void igb_tx_timeout(struct net_de
  static void igb_reset_task(struct work_struct *);
  static void igb_vlan_mode(struct net_device *netdev,
  			  netdev_features_t features);
@@ -17,8 +17,8 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7205,8 +7213,14 @@ static void igb_vlan_mode(struct net_dev
- 	igb_rlpml_set(adapter);
+@@ -7349,8 +7357,14 @@ static void igb_vlan_mode(struct net_dev
+ 	igb_set_vf_vlan_strip(adapter, adapter->vfs_allocated_count, enable);
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7220,11 +7234,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7362,11 +7376,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -51,8 +51,8 @@
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7240,7 +7262,9 @@ static int igb_vlan_rx_kill_vid(struct n
+ 	int pf_id = adapter->vfs_allocated_count;
+@@ -7378,7 +7400,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,10 +62,17 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7250,7 +7274,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7386,10 +7410,18 @@ static void igb_restore_vlan(struct igb_
+ 	u16 vid = 1;
+ 
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ 	igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), 0);
++#else
++	igb_vlan_rx_add_vid(adapter->netdev, 0);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
  
- 	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
+ 	for_each_set_bit_from(vid, adapter->active_vlans, VLAN_N_VID)
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
 +#else
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index b0f4df0..6dea4e1 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7871,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -8013,6 +8013,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7884,7 +7885,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -8026,7 +8027,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
index c0812a0..4e09f6f 100644
--- a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb.h
 +++ b/drivers/net/ethernet/intel/igb/igb.h
-@@ -444,7 +444,9 @@ struct igb_adapter {
+@@ -443,7 +443,9 @@ struct igb_adapter {
  	u32 tx_hwtstamp_timeouts;
  	u32 rx_hwtstamp_cleared;
  
@@ -68,7 +68,7 @@
  static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
  				const struct timespec64 *ts)
  {
-@@ -597,6 +604,7 @@ static int igb_ptp_feature_enable_i210(s
+@@ -598,6 +605,7 @@ static int igb_ptp_feature_enable_i210(s
  
  	return -EOPNOTSUPP;
  }
@@ -76,7 +76,7 @@
  
  static int igb_ptp_feature_enable(struct ptp_clock_info *ptp,
  				  struct ptp_clock_request *rq, int on)
-@@ -604,6 +612,7 @@ static int igb_ptp_feature_enable(struct
+@@ -605,6 +613,7 @@ static int igb_ptp_feature_enable(struct
  	return -EOPNOTSUPP;
  }
  
@@ -84,7 +84,7 @@
  static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  			      enum ptp_pin_function func, unsigned int chan)
  {
-@@ -617,6 +626,7 @@ static int igb_ptp_verify_pin(struct ptp
+@@ -618,6 +627,7 @@ static int igb_ptp_verify_pin(struct ptp
  	}
  	return 0;
  }
@@ -92,7 +92,7 @@
  
  /**
   * igb_ptp_tx_work
-@@ -1009,7 +1019,9 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1010,7 +1020,9 @@ void igb_ptp_init(struct igb_adapter *ad
  {
  	struct e1000_hw *hw = &adapter->hw;
  	struct net_device *netdev = adapter->netdev;
@@ -102,7 +102,7 @@
  
  	switch (hw->mac.type) {
  	case e1000_82576:
-@@ -1050,6 +1062,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1051,6 +1063,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -110,7 +110,7 @@
  	case e1000_i210:
  	case e1000_i211:
  		for (i = 0; i < IGB_N_SDP; i++) {
-@@ -1076,6 +1089,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1077,6 +1090,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -118,7 +118,7 @@
  	default:
  		adapter->ptp_clock = NULL;
  		return;
-@@ -1087,11 +1101,14 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1088,11 +1102,14 @@ void igb_ptp_init(struct igb_adapter *ad
  	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
  
  	/* Initialize the clock and overflow work for devices that need it. */
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index f70dd80..12a7a51 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3314,12 +3314,12 @@ struct wiphy {
+@@ -3350,12 +3350,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 97f24fb..3c4e87b 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1841,8 +1841,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1845,8 +1845,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1859,8 +1863,12 @@ static void btusb_intel_secure_send_resu
+@@ -1863,8 +1867,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2204,6 +2212,7 @@ static int btusb_setup_intel_new(struct
+@@ -2208,6 +2216,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2218,6 +2227,31 @@ static int btusb_setup_intel_new(struct
+@@ -2222,6 +2231,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2257,6 +2291,7 @@ done:
+@@ -2261,6 +2295,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2270,6 +2305,33 @@ done:
+@@ -2274,6 +2309,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index b8213bc..9915786 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2198,7 +2198,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2208,7 +2208,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index 7df646f..db98d4b 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -66,7 +66,7 @@
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E1A", 0 },
  	{ "BCM2E39", 0 },
-@@ -840,7 +848,9 @@ static struct platform_driver bcm_driver
+@@ -843,7 +851,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
diff --git a/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch b/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch
index c50fe51..429e676 100644
--- a/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch
+++ b/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 55a1405c..31edad7 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -2077,7 +2077,11 @@ static int igb_set_features(struct net_d
+@@ -2078,7 +2078,11 @@ static int igb_set_features(struct net_d
  
  static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
  			   struct net_device *dev,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
