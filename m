Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41596 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab3EKA1x (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:53 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so9210021iea.32
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 09/12] backports: refresh patches for next-20130415
Date: Fri, 10 May 2013 17:27:00 -0700
Message-Id: <1368232023-23817-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022755_872518_412909A2)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m38.595s
user    808m49.549s
sys     127m31.602s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/backport-adjustments/dma-buf.patch                   |    2 +-
 .../network/0001-netdev_ops/ipw2100.patch                    |    2 +-
 .../network/0001-netdev_ops/mac80211.patch                   |    6 +++---
 .../network/0001-netdev_ops/mac80211_hwsim.patch             |    2 +-
 .../network/0001-netdev_ops/usbnet.patch                     |    2 +-
 .../0003-netdev-needed_headroom_tailroom/mac80211.patch      |    4 ++--
 .../network/0005-netlink-portid/mac80211_hwsim.patch         |    4 ++--
 .../09-cfg80211-wext-padding/include_net_cfg80211.patch      |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch              |    4 ++--
 .../drivers_net_wireless_ipw2x00_ipw2100.patch               |    2 +-
 .../network/16-bluetooth/net_bluetooth_sco.patch             |    2 +-
 .../network/17-netdev-queue/net_mac80211_iface.patch         |    4 ++--
 .../drivers_net_wireless_adm8211.patch                       |    2 +-
 .../drivers_net_wireless_ath_carl9170_main.patch             |    2 +-
 .../25-multicast-list_head/drivers_net_wireless_mwl8k.patch  |    6 +++---
 .../25-multicast-list_head/include_net_mac80211.patch        |    2 +-
 .../25-multicast-list_head/net_mac80211_ieee80211_i.patch    |    2 +-
 .../network/25-multicast-list_head/net_mac80211_iface.patch  |    6 +++---
 .../network/25-multicast-list_head/net_mac80211_main.patch   |    2 +-
 ...rivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |   10 +++++-----
 .../network/36-workqueue/net_mac80211_main.patch             |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch  |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch        |    2 +-
 23 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 75d7b73..faefc93 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -696,17 +722,15 @@ static inline void dma_buf_uninit_debugf
+@@ -695,17 +721,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch b/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
index 1cde9f4..0d174d3 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6086,7 +6086,7 @@ static struct net_device *ipw2100_alloc_
+@@ -6068,7 +6068,7 @@ static struct net_device *ipw2100_alloc_
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index 6b67fb7..d8b4169 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1028,7 +1028,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1068,7 +1068,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1191,7 +1191,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1231,7 +1231,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1229,7 +1229,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1269,7 +1269,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
index a9842b2..f23c3e4 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1695,7 +1695,7 @@ static const struct net_device_ops hwsim
+@@ -1707,7 +1707,7 @@ static const struct net_device_ops hwsim
  
  static void hwsim_mon_setup(struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index 5052c1f..b12acc9 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1446,7 +1446,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1474,7 +1474,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 6099f45..0d48e3c 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1524,6 +1524,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1564,6 +1564,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1532,6 +1533,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1572,6 +1573,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
index c1ab942..3910fd8 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2019,10 +2019,10 @@ static int hwsim_register_received_nl(st
+@@ -2031,10 +2031,10 @@ static int hwsim_register_received_nl(st
  	if (info == NULL)
  		goto out;
  
@@ -13,7 +13,7 @@
  
  	return 0;
  out:
-@@ -2059,7 +2059,7 @@ static int mac80211_hwsim_netlink_notify
+@@ -2071,7 +2071,7 @@ static int mac80211_hwsim_netlink_notify
  	if (state != NETLINK_URELEASE)
  		return NOTIFY_DONE;
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index fa82867..8ac85f7 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2561,6 +2561,9 @@ struct wiphy_wowlan_support {
+@@ -2565,6 +2565,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 8e9e9af..900e355 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -347,6 +347,9 @@ static int iwl_pci_resume(struct device
+@@ -348,6 +348,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -362,7 +365,12 @@ static struct pci_driver iwl_pci_driver
+@@ -363,7 +366,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
index d7a6a6d..1d515a7 100644
--- a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ b/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6089,7 +6089,11 @@ static struct net_device *ipw2100_alloc_
+@@ -6071,7 +6071,11 @@ static struct net_device *ipw2100_alloc_
  	netdev_attach_ops(dev, &ipw2100_netdev_ops);
  	dev->ethtool_ops = &ipw2100_ethtool_ops;
  	dev->wireless_handlers = &ipw2100_wx_handler_def;
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index b165915..6b6d9a5 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -676,7 +680,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -675,7 +679,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index afe9ec4..c38ea75 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1649,6 +1649,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1689,6 +1689,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1676,6 +1677,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1716,6 +1717,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
index 049512c..7793f2c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/adm8211.c
 +++ b/drivers/net/wireless/adm8211.c
-@@ -1320,19 +1320,37 @@ static void adm8211_bss_info_changed(str
+@@ -1321,19 +1321,37 @@ static void adm8211_bss_info_changed(str
  }
  
  static u64 adm8211_prepare_multicast(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
index 57a303b..5b7e439 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/carl9170/main.c
 +++ b/drivers/net/wireless/ath/carl9170/main.c
-@@ -967,17 +967,35 @@ out:
+@@ -970,17 +970,35 @@ out:
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
index dbeffcc..6f36d72 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
@@ -50,7 +50,7 @@
  		}
  	}
  
-@@ -5022,7 +5042,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5026,7 +5046,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -62,7 +62,7 @@
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5033,7 +5057,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5037,7 +5061,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -74,7 +74,7 @@
  
  	return (unsigned long)cmd;
  }
-@@ -5155,7 +5183,11 @@ static void mwl8k_configure_filter(struc
+@@ -5159,7 +5187,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 6482bab..e2393b4 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2603,14 +2603,24 @@ struct ieee80211_ops {
+@@ -2612,14 +2612,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 5936ffb..629007d 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -908,7 +908,12 @@ struct ieee80211_local {
+@@ -907,7 +907,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 7f5e679..e08b4d0 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -754,8 +754,13 @@ static void ieee80211_do_stop(struct iee
+@@ -770,8 +770,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -13,8 +13,8 @@
 +#endif
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
- 
-@@ -938,10 +943,20 @@ static void ieee80211_set_multicast_list
+ 	}
+@@ -978,10 +983,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
index 0cbdac5..38a8540 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
@@ -12,7 +12,7 @@
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -592,9 +596,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -599,9 +603,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
index f0b8544..ab95682 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
-@@ -71,7 +71,7 @@ static bool
+@@ -70,7 +70,7 @@ static bool
  brcmf_pm_resume_error(struct brcmf_sdio_dev *sdiodev)
  {
  	bool is_err = false;
@@ -9,7 +9,7 @@
  	is_err = atomic_read(&sdiodev->suspend);
  #endif
  	return is_err;
-@@ -80,7 +80,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
+@@ -79,7 +79,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
  static void
  brcmf_pm_resume_wait(struct brcmf_sdio_dev *sdiodev, wait_queue_head_t *wq)
  {
@@ -18,7 +18,7 @@
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -546,7 +546,7 @@ static void brcmf_ops_sdio_remove(struct
+@@ -516,7 +516,7 @@ static void brcmf_ops_sdio_remove(struct
  	brcmf_dbg(SDIO, "Exit\n");
  }
  
@@ -27,9 +27,9 @@
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -596,7 +596,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -566,7 +566,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
- 	.name = "brcmfmac",
+ 	.name = BRCMFMAC_SDIO_PDATA_NAME,
  	.id_table = brcmf_sdmmc_ids,
 -#ifdef CONFIG_PM_SLEEP
 +#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index d8759fe..04e1cac 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1152,6 +1152,10 @@ static void __exit ieee80211_exit(void)
+@@ -1151,6 +1151,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 2084db0..e93af5f 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1246,7 +1246,9 @@ static struct usb_driver btusb_driver =
+@@ -1242,7 +1242,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index 214c576..8b54e5f 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -720,7 +720,9 @@ static struct usb_driver cdc_driver = {
+@@ -717,7 +717,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

