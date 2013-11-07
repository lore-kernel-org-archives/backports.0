Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55875 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab3KGU2r (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] backports: refresh on next-20131107
Date: Thu,  7 Nov 2013 21:27:58 +0100
Message-Id: <1383856078-19823-12-git-send-email-hauke@hauke-m.de> (sfid-20131107_212849_878948_66F54FB5)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

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
18  3.10.17             [  OK  ]
19  3.11.6              [  OK  ]
20  3.12-rc7            [  OK  ]
21  3.2.52              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.67              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0001-netdev_ops/mac80211.patch |    2 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch                 |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch |    2 +-
 .../network/0003-netdev-needed_headroom_tailroom/mac80211.patch  |    4 ++--
 .../network/0006-disable-dump-adjust-on-old-kernels.patch        |    4 ++--
 .../network/09-cfg80211-wext-padding/include_net_cfg80211.patch  |    2 +-
 .../09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch    |    6 +++---
 .../09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch  |    2 +-
 .../network/12-mac80211-disable-tx-status/net_mac80211_tx.patch  |    4 ++--
 .../network/17-netdev-queue/net_mac80211_iface.patch             |    4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch                  |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch                    |    4 ++--
 .../network/25-multicast-list_head/include_net_mac80211.patch    |    2 +-
 .../25-multicast-list_head/net_mac80211_ieee80211_i.patch        |    2 +-
 .../29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch       |    6 +++---
 .../network/30-bridge-port/net_wireless_nl80211.patch            |    2 +-
 .../network/42-netlink_seq/net_wireless_nl80211.patch            |    2 +-
 .../drivers_net_wireless_ti_wl12xx_main.patch                    |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch      |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch     |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch      |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch     |    2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch       |    2 +-
 .../network/77-led-blink-api/mac80211.patch                      |    2 +-
 24 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index abb3856..3e674eb 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1314,7 +1314,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1317,7 +1317,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
index dff66ab..9670949 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1740,7 +1740,7 @@ static const struct net_device_ops hwsim
+@@ -1761,7 +1761,7 @@ static const struct net_device_ops hwsim
  
  static void hwsim_mon_setup(struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
index 26f419c..a9c4616 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -345,7 +345,7 @@ next_desc:
+@@ -343,7 +343,7 @@ next_desc:
  		dev->net->dev_addr[0] |= 0x02;	/* set local assignment bit */
  		dev->net->dev_addr[0] &= 0xbf;	/* clear "IP" bit */
  	}
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 56c2fdb..80c269a 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1619,6 +1619,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1622,6 +1622,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1627,6 +1628,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1630,6 +1631,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index a5d34eb..ecb3c91 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1641,6 +1641,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1644,6 +1644,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1661,6 +1662,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1664,6 +1665,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 6b81270..df6d643 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2778,6 +2778,9 @@ struct wiphy_coalesce_support {
+@@ -2790,6 +2790,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index a271e47..106b730 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6036,15 +6036,27 @@ static void wlcore_nvs_cb(const struct f
+@@ -6065,15 +6065,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -28,7 +28,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6090,7 +6102,11 @@ out_unreg:
+@@ -6119,7 +6131,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -40,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6136,7 +6152,12 @@ int wlcore_remove(struct platform_device
+@@ -6165,7 +6181,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
index 67e0bc1..4c7b66e 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/wlcore.h
 +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
-@@ -175,7 +175,9 @@ struct wl1271 {
+@@ -176,7 +176,9 @@ struct wl1271 {
  	bool initialized;
  	struct ieee80211_hw *hw;
  	bool mac80211_registered;
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index ff957c3..2dbe945 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1995,6 +1995,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2024,6 +2024,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2023,6 +2024,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2052,6 +2053,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index a79b685..a6105b5 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1744,6 +1744,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1747,6 +1747,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1780,6 +1781,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1783,6 +1784,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 083644c..2dab885 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1478,6 +1478,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1507,6 +1507,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
index 71c1cce..762bda0 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -3010,11 +3010,20 @@ struct wl1271_filter_params {
+@@ -3039,11 +3039,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -21,7 +21,7 @@
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -3023,16 +3032,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -3052,16 +3061,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 64f1a9e..1635cd0 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2715,14 +2715,24 @@ struct ieee80211_ops {
+@@ -2719,14 +2719,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 0f1fc1f..4605cfa 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -965,7 +965,12 @@ struct ieee80211_local {
+@@ -980,7 +980,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
index f7046b8..5d0023b 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btmrvl_sdio.c
 +++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1081,6 +1081,7 @@ static void btmrvl_sdio_remove(struct sd
+@@ -1075,6 +1075,7 @@ static void btmrvl_sdio_remove(struct sd
  	}
  }
  
@@ -8,7 +8,7 @@
  static int btmrvl_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1176,6 +1177,7 @@ static const struct dev_pm_ops btmrvl_sd
+@@ -1170,6 +1171,7 @@ static const struct dev_pm_ops btmrvl_sd
  	.suspend	= btmrvl_sdio_suspend,
  	.resume		= btmrvl_sdio_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct sdio_driver bt_mrvl_sdio = {
  	.name		= "btmrvl_sdio",
-@@ -1184,7 +1186,9 @@ static struct sdio_driver bt_mrvl_sdio =
+@@ -1178,7 +1180,9 @@ static struct sdio_driver bt_mrvl_sdio =
  	.remove		= btmrvl_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index f38740d..addbdc7 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2340,7 +2340,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2343,7 +2343,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 28067ea..b34a124 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5874,7 +5874,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5920,7 +5920,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
index c2a040d..dea351e 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wl12xx/main.c
 +++ b/drivers/net/wireless/ti/wl12xx/main.c
-@@ -1815,16 +1815,20 @@ out:
+@@ -1825,16 +1825,20 @@ out:
  	return wlcore_remove(pdev);
  }
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
index d70c24b..3b7ee0e 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -503,7 +503,9 @@ static struct usb_driver ath3k_driver =
+@@ -505,7 +505,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
index e966384..b58c9bf 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -421,7 +421,9 @@ static struct usb_driver cdc_mbim_driver
+@@ -481,7 +481,9 @@ static struct usb_driver cdc_mbim_driver
  	.resume = cdc_mbim_resume,
  	.reset_resume =	cdc_mbim_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
index bce40fb..27c1ae9 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ncm.c
 +++ b/drivers/net/usb/cdc_ncm.c
-@@ -1271,7 +1271,9 @@ static struct usb_driver cdc_ncm_driver
+@@ -1212,7 +1212,9 @@ static struct usb_driver cdc_ncm_driver
  	.resume = usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
index adfeb22..4b1511f 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -820,7 +820,9 @@ static struct usb_driver qmi_wwan_driver
+@@ -818,7 +818,9 @@ static struct usb_driver qmi_wwan_driver
  	.resume		      =	qmi_wwan_resume,
  	.reset_resume         = qmi_wwan_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 6c7c603..769e850 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8011,7 +8011,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8060,7 +8060,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index e87ab17..05910bd 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1107,6 +1107,9 @@ struct ieee80211_local {
+@@ -1122,6 +1122,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
-- 
1.7.10.4

