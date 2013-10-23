Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35357 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab3JWS2E (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:28:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: refresh on next-20130830
Date: Wed, 23 Oct 2013 20:27:32 +0200
Message-Id: <1382552852-15916-6-git-send-email-hauke@hauke-m.de> (sfid-20131023_202808_197987_12F4024C)
In-Reply-To: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
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
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  FAIL  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/dma-buf.patch                     |    8 ++++----
 patches/collateral-evolutions/media/0004-sysfs-api.patch       |    2 +-
 .../network/0001-netdev_ops/mac80211.patch                     |    6 +++---
 .../network/0001-netdev_ops/mwifiex.patch                      |    2 +-
 .../0003-netdev-needed_headroom_tailroom/mac80211.patch        |    4 ++--
 .../network/0005-netlink-portid/nl80211.patch                  |    2 +-
 .../09-threaded-irq/drivers_net_wireless_b43_main.patch        |    6 +++---
 .../09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch  |    6 +++---
 .../11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch     |    4 ++--
 .../12-mac80211-disable-tx-status/net_mac80211_tx.patch        |    4 ++--
 .../network/17-netdev-queue/net_mac80211_iface.patch           |    4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch                |    2 +-
 .../network/25-multicast-list_head/include_net_mac80211.patch  |    2 +-
 .../25-multicast-list_head/net_mac80211_driver-ops.patch       |    4 ++--
 .../network/25-multicast-list_head/net_mac80211_iface.patch    |    4 ++--
 .../network/25-multicast-list_head/net_mac80211_main.patch     |    4 ++--
 .../network/36-workqueue/net_mac80211_main.patch               |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch                    |    2 +-
 .../drivers_net_wireless_b43_main.patch                        |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch   |    2 +-
 .../drivers_net_wireless_ath_carl9170_usb.patch                |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch                |    2 +-
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 97abcbc..fec0cc3 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -1,6 +1,6 @@
 --- a/compat/drivers-base-dma-buf.c
 +++ b/compat/drivers-base-dma-buf.c
-@@ -27,6 +27,10 @@
+@@ -28,6 +28,10 @@
  #include <linux/dma-buf.h>
  #include <linux/anon_inodes.h>
  #include <linux/export.h>
@@ -11,7 +11,7 @@
  #include <linux/debugfs.h>
  #include <linux/seq_file.h>
  
-@@ -147,6 +151,27 @@ struct dma_buf *dma_buf_export_named(voi
+@@ -148,6 +152,27 @@ struct dma_buf *dma_buf_export_named(voi
  }
  EXPORT_SYMBOL_GPL(dma_buf_export_named);
  
@@ -39,7 +39,7 @@
  
  /**
   * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -162,9 +187,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
+@@ -163,9 +188,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
  	if (!dmabuf || !dmabuf->file)
  		return -EINVAL;
  
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -692,17 +718,15 @@ static inline void dma_buf_uninit_debugf
+@@ -693,17 +719,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index 1fcc610..d6c1338 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -22,7 +22,7 @@ index b0f49b0..461e3e1 100644
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -991,6 +996,7 @@ static int __init videodev_init(void)
+@@ -990,6 +995,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index a4894ab..f0f47c2 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1105,7 +1105,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1108,7 +1108,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1268,7 +1268,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1271,7 +1271,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1307,7 +1307,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1310,7 +1310,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 2acfc59..033ee2c 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -806,7 +806,7 @@ static const struct net_device_ops mwifi
+@@ -792,7 +792,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 0e534e8..5cb4623 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1612,6 +1612,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1615,6 +1615,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1620,6 +1621,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1623,6 +1624,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index e72e590..8932897 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -11148,12 +11148,12 @@ static int nl80211_netlink_notify(struct
+@@ -11150,12 +11150,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index 46e881e..32801a7 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4238,8 +4238,13 @@ redo:
+@@ -4239,8 +4239,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4285,9 +4290,17 @@ static int b43_wireless_core_start(struc
+@@ -4286,9 +4291,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5110,6 +5123,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5125,6 +5138,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index aefb69e..05f6111 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5931,13 +5931,24 @@ static void wlcore_nvs_cb(const struct f
+@@ -5932,13 +5932,24 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -25,7 +25,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -5983,7 +5994,11 @@ out_unreg:
+@@ -5984,7 +5995,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -37,7 +37,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6029,7 +6044,12 @@ int wlcore_remove(struct platform_device
+@@ -6030,7 +6045,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index 1344605..f7d48d0 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -491,6 +491,9 @@ static int ath_pci_resume(struct device
+@@ -558,6 +558,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -509,7 +512,12 @@ static struct pci_driver ath_pci_driver
+@@ -576,7 +579,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 2268b00..3108c1b 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1992,6 +1992,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1994,6 +1994,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2020,6 +2021,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2022,6 +2023,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index abe38a3..fa5bb4b 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1737,6 +1737,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1740,6 +1740,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1773,6 +1774,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1776,6 +1777,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index e0e88ad..3649f7a 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1475,6 +1475,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1477,6 +1477,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 43265cf..e6d4d46 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2694,14 +2694,24 @@ struct ieee80211_ops {
+@@ -2695,14 +2695,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
index 042cca7..5f4271b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -228,20 +228,35 @@ static inline void drv_bss_info_changed(
+@@ -229,20 +229,35 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -36,7 +36,7 @@
  static inline void drv_set_multicast_list(struct ieee80211_local *local,
  					  struct ieee80211_sub_if_data *sdata,
  					  struct netdev_hw_addr_list *mc_list)
-@@ -257,6 +272,23 @@ static inline void drv_set_multicast_lis
+@@ -258,6 +273,23 @@ static inline void drv_set_multicast_lis
  					       allmulti, mc_list);
  	trace_drv_return_void(local);
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 840878c..d06607c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -800,8 +800,13 @@ static void ieee80211_do_stop(struct iee
+@@ -803,8 +803,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1015,10 +1020,20 @@ static void ieee80211_set_multicast_list
+@@ -1018,10 +1023,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
index b1df3b7..781d7ea 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -71,7 +71,11 @@ void ieee80211_configure_filter(struct i
+@@ -72,7 +72,11 @@ void ieee80211_configure_filter(struct i
  	spin_lock_bh(&local->filter_lock);
  	changed_flags = local->filter_flags ^ new_flags;
  
@@ -12,7 +12,7 @@
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -590,9 +594,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -591,9 +595,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index e0c2c04..fae6d38 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1142,6 +1142,10 @@ static void __exit ieee80211_exit(void)
+@@ -1140,6 +1140,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index c9e3345..6c5aa7c 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -289,8 +289,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -290,8 +290,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 850e1a3..3473edf 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3451,11 +3451,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3452,11 +3452,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
index fb9cff4..e966384 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -417,7 +417,9 @@ static struct usb_driver cdc_mbim_driver
+@@ -421,7 +421,9 @@ static struct usb_driver cdc_mbim_driver
  	.resume = cdc_mbim_resume,
  	.reset_resume =	cdc_mbim_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
index cbd0ee5..13fd478 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/carl9170/usb.c
 +++ b/drivers/net/wireless/ath/carl9170/usb.c
-@@ -1166,7 +1166,9 @@ static struct usb_driver carl9170_driver
+@@ -1167,7 +1167,9 @@ static struct usb_driver carl9170_driver
  	.resume = carl9170_usb_resume,
  	.reset_resume = carl9170_usb_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index 2f0dbf8..c0acdf4 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1378,7 +1378,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1379,7 +1379,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
-- 
1.7.10.4

