Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46754 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbaAHAf4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:56 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/17] backports: refresh on next-20131224
Date: Wed,  8 Jan 2014 01:34:34 +0100
Message-Id: <1389141274-2002-18-git-send-email-hauke@hauke-m.de> (sfid-20140108_013558_802734_2772D3C3)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

manual changes done to:
patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.52              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.70              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.20             [  OK  ]
27  3.11.9              [  OK  ]
28  3.12.1              [  OK  ]
29  3.13-rc1            [  FAIL  ]

With Kernel 3.13-rc7 I was able to build successfully.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-sysfs-api.patch                     |    6 ++--
 .../mac80211.patch                                 |    4 +--
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +--
 .../include_net_cfg80211.patch                     |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch |    4 +--
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +--
 .../net_wireless_core.patch                        |    4 +--
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +--
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +--
 .../drivers_net_wireless_zd1211rw_zd_mac.patch     |    2 +-
 .../include_net_mac80211.patch                     |   15 +--------
 .../net_mac80211_driver-ops.patch                  |   33 +-------------------
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |   16 +++-------
 .../25-multicast-list_head/net_mac80211_main.patch |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   12 +++----
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../61-netdev-addr_assign_type/usbnet.patch        |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch        |    8 ++---
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    6 ++--
 .../network/76-sysfs-api/drivers_bcma.patch        |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/78-usb-sg/usbnet.patch                 |   12 +++----
 .../network/81-genl-const/nfc.patch                |    4 +--
 .../network/81-genl-const/nl80211.patch            |    6 ++--
 31 files changed, 61 insertions(+), 113 deletions(-)

diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index 23c445d..fd22975 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/v4l2-dev.c
 +++ b/drivers/media/v4l2-core/v4l2-dev.c
-@@ -86,7 +86,12 @@ static struct attribute *video_device_at
+@@ -90,7 +90,12 @@ static struct attribute *video_device_at
  	&dev_attr_index.attr,
  	NULL,
  };
@@ -13,7 +13,7 @@
  
  /*
   *	Active devices
-@@ -221,7 +226,11 @@ static void v4l2_device_release(struct d
+@@ -225,7 +230,11 @@ static void v4l2_device_release(struct d
  
  static struct class video_class = {
  	.name = VIDEO_NAME,
@@ -25,7 +25,7 @@
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -990,6 +999,7 @@ static int __init videodev_init(void)
+@@ -999,6 +1008,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index ab1ed2b..ed89650 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1623,6 +1623,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1593,6 +1593,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1631,6 +1632,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1601,6 +1602,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 41dd968..739448e 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1664,6 +1664,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1682,6 +1682,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1684,6 +1685,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1702,6 +1703,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 7b86184..bc49087 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2792,6 +2792,9 @@ struct wiphy_coalesce_support {
+@@ -2828,6 +2828,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
index 4f7b302..516ed36 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -275,6 +275,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -266,6 +266,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
index 0059e0d..ef0df1f 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/internal.h
 +++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
-@@ -313,6 +313,9 @@ struct iwl_trans_pcie {
+@@ -311,6 +311,9 @@ struct iwl_trans_pcie {
  
  	/*protect hw register */
  	spinlock_t reg_lock;
@@ -9,4 +9,4 @@
 +#endif
  };
  
- /**
+ #define IWL_TRANS_GET_PCIE_TRANS(_iwl_trans) \
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 9b1a6f6..34f8040 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -909,12 +909,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -899,12 +899,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1609,9 +1618,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1597,9 +1606,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 5c933d6..9c6b7ae 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -327,10 +327,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -318,10 +318,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -852,6 +848,15 @@ static int cfg80211_netdev_notifier_call
+@@ -846,6 +842,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
index 8208629..268f647 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -996,8 +996,13 @@ drop:
+@@ -1002,8 +1002,13 @@ drop:
  	goto done;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1171,8 +1176,12 @@ static struct proto hci_sk_proto = {
+@@ -1177,8 +1182,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index bbdee9c..7142517 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1750,6 +1750,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1717,6 +1717,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1786,6 +1787,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1753,6 +1754,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
index 27338cd..ba9845c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/zd1211rw/zd_mac.c
 +++ b/drivers/net/wireless/zd1211rw/zd_mac.c
-@@ -1215,17 +1215,34 @@ static void zd_process_intr(struct work_
+@@ -1214,17 +1214,34 @@ static void zd_process_intr(struct work_
  
  
  static u64 zd_op_prepare_multicast(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 6fefdf7..618df66 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2759,14 +2759,24 @@ struct ieee80211_ops {
+@@ -2787,7 +2787,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -12,16 +12,3 @@
  	void (*configure_filter)(struct ieee80211_hw *hw,
  				 unsigned int changed_flags,
  				 unsigned int *total_flags,
- 				 u64 multicast);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	void (*set_multicast_list)(struct ieee80211_hw *hw,
- 				   struct ieee80211_vif *vif, bool allmulti,
- 				   struct netdev_hw_addr_list *mc_list);
-+#else
-+	void (*set_multicast_list)(struct ieee80211_hw *hw,
-+				   struct ieee80211_vif *vif, bool allmulti,
-+				   int mc_count, struct dev_addr_list *ha);
-+#endif
- 
- 	int (*set_tim)(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
- 		       bool set);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
index 042cca7..0332c91 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -228,20 +228,35 @@ static inline void drv_bss_info_changed(
+@@ -228,14 +228,28 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -29,34 +29,3 @@
  
  	trace_drv_return_u64(local, ret);
  
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static inline void drv_set_multicast_list(struct ieee80211_local *local,
- 					  struct ieee80211_sub_if_data *sdata,
- 					  struct netdev_hw_addr_list *mc_list)
-@@ -257,6 +272,23 @@ static inline void drv_set_multicast_lis
- 					       allmulti, mc_list);
- 	trace_drv_return_void(local);
- }
-+#else
-+static inline void drv_set_multicast_list(struct ieee80211_local *local,
-+					  struct ieee80211_sub_if_data *sdata,
-+					  int mc_count, struct dev_addr_list *ha)
-+{
-+	bool allmulti = sdata->flags & IEEE80211_SDATA_ALLMULTI;
-+
-+	trace_drv_set_multicast_list(local, sdata, mc_count);
-+
-+	check_sdata_in_driver(sdata);
-+
-+	if (local->ops->set_multicast_list)
-+		local->ops->set_multicast_list(&local->hw, &sdata->vif,
-+					       allmulti, mc_count, ha);
-+	trace_drv_return_void(local);
-+}
-+#endif
- 
- static inline void drv_configure_filter(struct ieee80211_local *local,
- 					unsigned int changed_flags,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 22300b9..5b264d2 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1003,7 +1003,12 @@ struct ieee80211_local {
+@@ -1006,7 +1006,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 93014c9..361687c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -810,8 +810,13 @@ static void ieee80211_do_stop(struct iee
+@@ -808,8 +808,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,17 +14,9 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1027,10 +1032,20 @@ static void ieee80211_set_multicast_list
- 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		drv_set_multicast_list(local, sdata, &dev->mc);
-+#else
-+		drv_set_multicast_list(local, sdata, dev->mc_count,
-+				       dev->mc_list);
-+#endif
- 
+@@ -1009,7 +1014,12 @@ static void ieee80211_set_multicast_list
+ 		sdata->flags ^= IEEE80211_SDATA_PROMISC;
+ 	}
  	spin_lock_bh(&local->filter_lock);
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
index b1df3b7..b88e485 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
@@ -12,7 +12,7 @@
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -590,9 +594,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -586,9 +590,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 072db59..6940eb0 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2363,7 +2363,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2381,7 +2381,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index 741dcf6..552d1c8 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1199,6 +1199,10 @@ static void __exit ieee80211_exit(void)
+@@ -1195,6 +1195,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index c2a1f19..641d080 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -492,6 +492,7 @@ static void atl1c_set_rxbufsize(struct a
+@@ -494,6 +494,7 @@ static void atl1c_set_rxbufsize(struct a
  	adapter->rx_frag_size = roundup_pow_of_two(head_size);
  }
  
@@ -8,7 +8,7 @@
  static netdev_features_t atl1c_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -520,6 +521,7 @@ static int atl1c_set_features(struct net
+@@ -522,6 +523,7 @@ static int atl1c_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  /**
   * atl1c_change_mtu - Change the Maximum Transfer Unit
-@@ -552,8 +554,19 @@ static int atl1c_change_mtu(struct net_d
+@@ -554,8 +556,19 @@ static int atl1c_change_mtu(struct net_d
  		netdev->mtu = new_mtu;
  		adapter->hw.max_frame_size = new_mtu;
  		atl1c_set_rxbufsize(adapter, netdev);
@@ -36,7 +36,7 @@
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2493,8 +2506,10 @@ static const struct net_device_ops atl1c
+@@ -2495,8 +2508,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -47,7 +47,7 @@
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2512,6 +2527,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2514,6 +2529,7 @@ static int atl1c_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1c_set_ethtool_ops(netdev);
  
@@ -55,7 +55,7 @@
  	/* TODO: add when ready */
  	netdev->hw_features =	NETIF_F_SG		|
  				NETIF_F_HW_CSUM		|
-@@ -2520,6 +2536,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2522,6 +2538,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features	|
  				NETIF_F_HW_VLAN_CTAG_TX;
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 106783e..d8155f8 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5959,7 +5959,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5988,7 +5988,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index 5e2cfaa..788df56 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1026,7 +1026,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1025,7 +1025,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index 6961c1a..d26d40e 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2656,7 +2656,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2658,7 +2658,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
index 11338bd..c8e72e7 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1672,9 +1672,11 @@ usbnet_probe (struct usb_interface *udev
+@@ -1671,9 +1671,11 @@ usbnet_probe (struct usb_interface *udev
  		dev->rx_urb_size = dev->hard_mtu;
  	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
  
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
index bbb8c97..a16ba7d 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
@@ -1,14 +1,14 @@
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -29,6 +29,7 @@
- #include <linux/dma-mapping.h>
+@@ -31,6 +31,7 @@
  #include <linux/ssb/ssb.h>
  #include <linux/slab.h>
+ #include <linux/phy.h>
 +#include <linux/u64_stats_sync.h>
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1646,10 +1647,17 @@ static int b44_close(struct net_device *
+@@ -1670,10 +1671,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -26,7 +26,7 @@
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2134,7 +2142,11 @@ static const struct net_device_ops b44_n
+@@ -2183,7 +2191,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 1ed8f4d..88d716c 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8095,7 +8095,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8176,7 +8176,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index bf041df..7f85a49 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
---- a/drivers/net/wireless/ath/ath9k/debug.c
-+++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1266,7 +1266,11 @@ static const struct file_operations fops
+--- a/drivers/net/wireless/ath/ath9k/spectral.c
++++ b/drivers/net/wireless/ath/ath9k/spectral.c
+@@ -478,7 +478,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
index 68214b6..e5dcaaf 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
@@ -25,7 +25,7 @@
  };
  
  static u16 bcma_cc_core_id(struct bcma_bus *bus)
-@@ -492,6 +501,7 @@ static int __init bcma_modinit(void)
+@@ -493,6 +502,7 @@ static int __init bcma_modinit(void)
  {
  	int err;
  
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index efb823c..d5f8878 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1150,6 +1150,9 @@ struct ieee80211_local {
+@@ -1154,6 +1154,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index 6e2cdfe..7b1c4d9 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1231,6 +1231,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1230,6 +1230,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1263,6 +1264,12 @@ static int build_dma_sg(const struct sk_
+@@ -1262,6 +1263,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1319,12 +1326,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1318,12 +1325,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1379,7 +1393,9 @@ not_drop:
+@@ -1378,7 +1392,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1432,7 +1448,9 @@ static void usbnet_bh (unsigned long par
+@@ -1431,7 +1447,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1787,7 +1805,9 @@ int usbnet_resume (struct usb_interface
+@@ -1786,7 +1804,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/81-genl-const/nfc.patch b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
index 3a34016..f3bc515 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nfc.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
@@ -1,6 +1,6 @@
 --- a/net/nfc/netlink.c
 +++ b/net/nfc/netlink.c
-@@ -30,7 +30,7 @@
+@@ -28,7 +28,7 @@
  #include "nfc.h"
  #include "llcp.h"
  
@@ -9,7 +9,7 @@
  	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
  };
  
-@@ -1364,7 +1364,7 @@ static int nfc_genl_se_io(struct sk_buff
+@@ -1362,7 +1362,7 @@ static int nfc_genl_se_io(struct sk_buff
  	return dev->ops->se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
  }
  
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 6e50898..e4a5858 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -8890,7 +8890,7 @@ static int nl80211_crit_protocol_stop(st
+@@ -9076,7 +9076,7 @@ EXPORT_SYMBOL_GPL(cfg80211_vendor_cmd_re
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -8959,7 +8959,7 @@ static int nl80211_pre_doit(const struct
+@@ -9145,7 +9145,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -8976,7 +8976,7 @@ static void nl80211_post_doit(const stru
+@@ -9162,7 +9162,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
-- 
1.7.10.4

