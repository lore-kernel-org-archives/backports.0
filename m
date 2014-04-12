Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46445 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbaDLBfa (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5932350pdi.19
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 10/10] backports: refresh patches for next-20140409 and next-20140411
Date: Fri, 11 Apr 2014 18:34:35 -0700
Message-Id: <1397266475-14442-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_040514_069405_1F9AD04A)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We were required to refresh patches for next-20140409 but for next-20140411
no changes were required. Since no actual commit is necessary next time
this happens (which can often, hence -- automatic backports --) I'll
just peg the results on the PGP signed tag for the release. I'll peg
this commit with both next tags because of this. Just run git describe
to find out the respective linux-next tag you should be using as that is
the latest validated one.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean --refresh \
	/home/mcgrof/linux-next /home/mcgrof/build/next-20140409
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m30.186s
user    9m25.180s
sys     0m24.428s

mcgrof@drvbp1 ~/build/next-20140409 $ time ckmake --allyesconfig
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

real    26m54.859s
user    744m15.764s
sys     83m47.440s

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
--refresh /home/mcgrof/linux-next /home/mcgrof/build/next-20140411
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m30.437s
user    9m22.812s
sys     0m24.484s

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

real    28m21.215s
user    786m8.468s
sys     86m46.564s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../generic/0001-sysfs-api/drivers_ssb.patch                 |  2 +-
 .../generic/0001-sysfs-api/net_ieee802154_wpan-class.patch   |  2 +-
 .../generic/0001-sysfs-api/net_wireless_sysfs.patch          |  4 ++--
 .../network/0002-disable-dump-adjust-on-old-kernels.patch    |  4 ++--
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch    |  2 +-
 .../network/0014-netlink_seq/net_wireless_nl80211.patch      |  2 +-
 .../network/0017-get_ts_info/drivers_net_usb_usbnet.patch    |  2 +-
 .../network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch  |  2 +-
 .../network/0024-led-blink-api/mac80211.patch                |  2 +-
 .../collateral-evolutions/network/0025-usb-sg/usbnet.patch   | 12 ++++++------
 .../network/0027-genl-const/ieee802154.patch                 |  2 +-
 .../network/0027-genl-const/nl80211.patch                    |  6 +++---
 .../network/0028-select_queue/mac80211.patch                 |  4 ++--
 .../network/0028-select_queue/mwifiex.patch                  |  2 +-
 .../0001-ethernet-igb/0001-igb_net_device_ops.patch          |  6 +++---
 .../0001-ethernet-igb/0002-igb_pci_sriov_configure.patch     |  8 ++++----
 .../0001-ethernet-igb/0006-igb_eee.patch                     |  2 +-
 .../0001-ethernet-igb/0007-igb_ethtool_ops.patch             |  4 ++--
 .../0001-ethernet-igb/0008-igb_no_fcs.patch                  |  2 +-
 .../0001-ethernet-igb/0009-igb_vlan_rx_vid.patch             |  6 +++---
 .../0001-ethernet-igb/0010-igb_ethtool_ops.patch             | 10 +++++-----
 .../0001-ethernet-igb/0011-igb_ethtool_ops.patch             |  2 +-
 .../0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch     |  8 ++++----
 23 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
index e9b0913..5fa2e98 100644
--- a/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
+++ b/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
@@ -25,7 +25,7 @@
  };
  
  static void ssb_buses_lock(void)
-@@ -1463,6 +1472,7 @@ static int __init ssb_modinit(void)
+@@ -1459,6 +1468,7 @@ static int __init ssb_modinit(void)
  {
  	int err;
  
diff --git a/patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
index 8099fab..a6338c6 100644
--- a/patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
+++ b/patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
@@ -25,7 +25,7 @@
  };
  
  static DEFINE_MUTEX(wpan_phy_mutex);
-@@ -203,6 +212,7 @@ EXPORT_SYMBOL(wpan_phy_free);
+@@ -197,6 +206,7 @@ EXPORT_SYMBOL(wpan_phy_free);
  static int __init wpan_phy_class_init(void)
  {
  	int rc;
diff --git a/patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
index e676219..9c532c2 100644
--- a/patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
+++ b/patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
@@ -13,7 +13,7 @@
  
  static void wiphy_dev_release(struct device *dev)
  {
-@@ -151,7 +156,11 @@ struct class ieee80211_class = {
+@@ -149,7 +154,11 @@ struct class ieee80211_class = {
  	.name = "ieee80211",
  	.owner = THIS_MODULE,
  	.dev_release = wiphy_dev_release,
@@ -25,7 +25,7 @@
  	.dev_uevent = wiphy_uevent,
  #ifdef CONFIG_PM
  	.suspend = wiphy_suspend,
-@@ -165,6 +174,7 @@ struct class ieee80211_class = {
+@@ -161,6 +170,7 @@ struct class ieee80211_class = {
  
  int wiphy_sysfs_init(void)
  {
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 94dc764..195633c 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1727,6 +1727,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1731,6 +1731,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1748,6 +1749,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1752,6 +1753,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 23c6743..15f501e 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2906,6 +2906,9 @@ struct wiphy_vendor_command {
+@@ -2909,6 +2909,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index c445ea0..65d92f6 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6074,7 +6074,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6092,7 +6092,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
index 5221573..c19f6b1 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1020,7 +1020,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1022,7 +1022,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
index 5993b92..780d0b9 100644
--- a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -873,7 +873,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -869,7 +869,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index bddfd78..f623788 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1165,6 +1165,9 @@ struct ieee80211_local {
+@@ -1160,6 +1160,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 9aaf581..81b451a 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1225,6 +1225,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1227,6 +1227,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1257,6 +1258,12 @@ static int build_dma_sg(const struct sk_
+@@ -1259,6 +1260,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1313,12 +1320,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1315,12 +1322,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1373,7 +1387,9 @@ not_drop:
+@@ -1375,7 +1389,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1426,7 +1442,9 @@ static void usbnet_bh (unsigned long par
+@@ -1428,7 +1444,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1781,7 +1799,9 @@ int usbnet_resume (struct usb_interface
+@@ -1783,7 +1801,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
index f6e20aa..22e45e6 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
@@ -10,7 +10,7 @@
  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
  			ieee802154_dump_phy),
 @@ -126,7 +126,7 @@ static const struct genl_ops ieee8021154
- 			ieee802154_dump_iface),
+ 	IEEE802154_OP(IEEE802154_SET_MACPARAMS, ieee802154_set_macparams),
  };
  
 -static const struct genl_multicast_group ieee802154_mcgrps[] = {
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 3fbd8df..b78d2bc 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9270,7 +9270,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9288,7 +9288,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9339,7 +9339,7 @@ static int nl80211_pre_doit(const struct
+@@ -9357,7 +9357,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9356,7 +9356,7 @@ static void nl80211_post_doit(const stru
+@@ -9374,7 +9374,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index b4b8151..2e695f5 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -2,7 +2,7 @@ diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
 index 088111a..dcf149a 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1062,10 +1062,19 @@ static void ieee80211_uninit(struct net_
+@@ -1052,10 +1052,19 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@ index 088111a..dcf149a 100644
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1081,10 +1090,19 @@ static const struct net_device_ops ieee8
+@@ -1071,10 +1080,19 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index db9ed6e..215a0f4 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/mwifiex/main.c b/drivers/net/wireless/mwifiex/
 index 9d3d275..f8b16f4 100644
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -746,9 +746,18 @@ static struct net_device_stats *mwifiex_
+@@ -747,9 +747,18 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
index c038717..6b80ad0 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
@@ -16,7 +16,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7209,8 +7214,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7248,8 +7253,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +29,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7227,8 +7236,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7266,8 +7275,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +42,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7254,7 +7267,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7293,7 +7306,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
index fc3c09c..9b4ba5d 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
@@ -22,7 +22,7 @@ index f2a5abf..dd878b6 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7560,6 +7564,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7599,6 +7603,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7569,6 +7574,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7608,6 +7613,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -38,7 +38,7 @@ index f2a5abf..dd878b6 100644
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7586,6 +7592,8 @@ out:
+@@ -7625,6 +7631,8 @@ out:
  }
  
  #endif
@@ -47,7 +47,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7596,6 +7604,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7635,6 +7643,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
index 5dd34e1..04e1503 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
@@ -18,7 +18,7 @@ index 9b15820..9767f11 100644
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3018,8 +3020,10 @@ static const struct ethtool_ops igb_etht
+@@ -3020,8 +3022,10 @@ static const struct ethtool_ops igb_etht
  	.get_ts_info		= igb_get_ts_info,
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
index 116b5db..01525f2 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
@@ -26,7 +26,7 @@ index 9767f11..3cf9600 100644
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2811,6 +2814,7 @@ static int igb_get_module_eeprom(struct
+@@ -2813,6 +2816,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 9767f11..3cf9600 100644
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3017,15 +3021,19 @@ static const struct ethtool_ops igb_etht
+@@ -3019,15 +3023,19 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
index 7b24fa1..f6d692a 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index fd6a103..a919cfa 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4730,9 +4730,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4766,9 +4766,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
index 1757539..83e8ccb 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
@@ -18,7 +18,7 @@ index 37e6062..6bf0a88 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7226,8 +7229,10 @@ static void igb_vlan_mode(struct net_dev
+@@ -7265,8 +7268,10 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
@@ -30,7 +30,7 @@ index 37e6062..6bf0a88 100644
  #endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7242,15 +7247,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7281,15 +7286,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@ index 37e6062..6bf0a88 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7266,7 +7275,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7305,7 +7314,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
index b99aaf7..9676dad 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 3cf9600..5e519ce 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2829,6 +2829,7 @@ static void igb_ethtool_complete(struct
+@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -10,7 +10,7 @@ index 3cf9600..5e519ce 100644
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
-@@ -2844,6 +2845,7 @@ static int igb_get_rxfh_indir(struct net
+@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 3cf9600..5e519ce 100644
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2880,6 +2882,7 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -26,7 +26,7 @@ index 3cf9600..5e519ce 100644
  static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2912,6 +2915,7 @@ static int igb_set_rxfh_indir(struct net
+@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 3cf9600..5e519ce 100644
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3034,9 +3038,11 @@ static const struct ethtool_ops igb_etht
+@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
index e438e76..9b64c21 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
@@ -18,7 +18,7 @@ index 5e519ce..9f61f1d 100644
  
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
-@@ -3028,8 +3030,10 @@ static const struct ethtool_ops igb_etht
+@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_etht
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	.get_ts_info		= igb_get_ts_info,
  #endif
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
index 69f4748..ad19752 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
@@ -13,7 +13,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2075,7 +2077,9 @@ static const struct net_device_ops igb_n
+@@ -2104,7 +2106,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
@@ -23,7 +23,7 @@ index 35ac7d8..e609f71 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7895,6 +7899,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7934,6 +7938,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7921,6 +7926,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7960,6 +7965,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 35ac7d8..e609f71 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7933,7 +7939,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7972,7 +7978,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
-- 
1.9.1

