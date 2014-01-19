Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58390 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbaASQsu (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/16] backports: refresh on next-20140117
Date: Sun, 19 Jan 2014 17:47:37 +0100
Message-Id: <1390150057-11652-17-git-send-email-hauke@hauke-m.de> (sfid-20140119_174922_495935_66FB2666)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

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
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.77              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.27             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.8              [  OK  ]
29  3.13-rc8            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/media/0004-sysfs-api.patch       |    6 +++---
 .../0003-netdev-needed_headroom_tailroom/mac80211.patch        |    4 ++--
 .../network/0006-disable-dump-adjust-on-old-kernels.patch      |    4 ++--
 .../09-threaded-irq/drivers_net_wireless_b43_main.patch        |    6 +++---
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch              |    4 ++--
 .../09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch  |    6 +++---
 .../12-mac80211-disable-tx-status/net_mac80211_tx.patch        |    4 ++--
 .../network/16-bluetooth/net_bluetooth_l2cap_sock.patch        |    6 +++---
 .../network/16-bluetooth/net_bluetooth_rfcomm_sock.patch       |    2 +-
 .../network/16-bluetooth/net_bluetooth_rfcomm_tty.patch        |    8 ++++----
 .../network/17-netdev-queue/net_mac80211_iface.patch           |    4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch                |    2 +-
 .../network/25-multicast-list_head/include_net_mac80211.patch  |    2 +-
 .../network/30-bridge-port/net_wireless_nl80211.patch          |    2 +-
 .../network/37-vsnprintk/drivers_net_wireless_ath_main.patch   |    6 +++---
 .../drivers_net_ethernet_atheros_alx_main.patch                |    4 ++--
 .../drivers_net_ethernet_atheros_atl1c_atl1c_main.patch        |    6 +++---
 .../drivers_net_ethernet_atheros_atlx_atl1.patch               |    8 ++++----
 .../network/42-netlink_seq/net_wireless_nl80211.patch          |    2 +-
 .../drivers_net_wireless_b43_main.patch                        |    2 +-
 .../drivers_net_ethernet_atheros_atl1c_atl1c_main.patch        |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch               |    2 +-
 .../network/63-tty-termios/net_bluetooth_rfcomm_tty.patch      |    2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch     |    2 +-
 .../network/76-sysfs-api/drivers_ssb.patch                     |    2 +-
 .../collateral-evolutions/network/81-genl-const/hwsim.patch    |    2 +-
 .../collateral-evolutions/network/81-genl-const/nl80211.patch  |    6 +++---
 27 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index fd22975..23c445d 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/v4l2-dev.c
 +++ b/drivers/media/v4l2-core/v4l2-dev.c
-@@ -90,7 +90,12 @@ static struct attribute *video_device_at
+@@ -86,7 +86,12 @@ static struct attribute *video_device_at
  	&dev_attr_index.attr,
  	NULL,
  };
@@ -13,7 +13,7 @@
  
  /*
   *	Active devices
-@@ -225,7 +230,11 @@ static void v4l2_device_release(struct d
+@@ -221,7 +226,11 @@ static void v4l2_device_release(struct d
  
  static struct class video_class = {
  	.name = VIDEO_NAME,
@@ -25,7 +25,7 @@
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -999,6 +1008,7 @@ static int __init videodev_init(void)
+@@ -990,6 +999,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 2b3ae36..e7995a6 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1596,6 +1596,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1598,6 +1598,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1604,6 +1605,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1606,6 +1607,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 46728b2..55a086b 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1708,6 +1708,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1705,6 +1705,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1728,6 +1729,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1725,6 +1726,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index 3d364d8..d8c85d4 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4238,8 +4238,13 @@ redo:
+@@ -4243,8 +4243,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4285,9 +4290,17 @@ static int b43_wireless_core_start(struc
+@@ -4290,9 +4295,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5124,6 +5137,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5123,6 +5136,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 69a1c86..8067684 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -878,12 +878,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -900,12 +900,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1584,9 +1593,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1606,9 +1615,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 9d4cb79..9381b59 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6064,15 +6064,27 @@ static void wlcore_nvs_cb(const struct f
+@@ -6073,15 +6073,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -28,7 +28,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6118,7 +6130,11 @@ out_unreg:
+@@ -6127,7 +6139,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -40,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6164,7 +6180,12 @@ int wlcore_remove(struct platform_device
+@@ -6173,7 +6189,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index ebfbf16..1e10d38 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2049,6 +2049,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2054,6 +2054,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2077,6 +2078,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2082,6 +2083,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index fb4e8cb..d0959db 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -723,8 +723,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -736,8 +736,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1521,8 +1526,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1534,8 +1539,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1534,7 +1543,11 @@ static int l2cap_sock_create(struct net
+@@ -1547,7 +1556,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index 88c8f31..0ecfca3 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -667,7 +672,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -672,7 +677,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index 2caf2f3..1013610 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -763,7 +763,11 @@ static int rfcomm_tty_write_room(struct
+@@ -796,7 +796,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
  
@@ -12,8 +12,8 @@
  {
  	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
  
-@@ -1016,7 +1020,11 @@ static void rfcomm_tty_hangup(struct tty
- 		tty_port_put(&dev->port);
+@@ -1045,7 +1049,11 @@ static void rfcomm_tty_hangup(struct tty
+ 	tty_port_hangup(&dev->port);
  }
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
@@ -24,7 +24,7 @@
  {
  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
  
-@@ -1025,7 +1033,11 @@ static int rfcomm_tty_tiocmget(struct tt
+@@ -1054,7 +1062,11 @@ static int rfcomm_tty_tiocmget(struct tt
  	return dev->modem_status;
  }
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index fbca21c..06b23fb 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1720,6 +1720,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1722,6 +1722,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1756,6 +1757,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1758,6 +1759,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 23e3c9b..cfb030b 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1510,6 +1510,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1515,6 +1515,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 618df66..3f7a360 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2787,7 +2787,11 @@ struct ieee80211_ops {
+@@ -2789,7 +2789,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index a4151b8..65a4ddd 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2407,7 +2407,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2379,7 +2379,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch b/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
index 2a3d304..b63faee 100644
--- a/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
+++ b/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
@@ -1,14 +1,14 @@
 --- a/drivers/net/wireless/ath/main.c
 +++ b/drivers/net/wireless/ath/main.c
-@@ -59,6 +59,7 @@ struct sk_buff *ath_rxbuf_alloc(struct a
+@@ -67,6 +67,7 @@ bool ath_is_mybeacon(struct ath_common *
  }
- EXPORT_SYMBOL(ath_rxbuf_alloc);
+ EXPORT_SYMBOL(ath_is_mybeacon);
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
  void ath_printk(const char *level, const struct ath_common* common,
  		const char *fmt, ...)
  {
-@@ -78,4 +79,24 @@ void ath_printk(const char *level, const
+@@ -86,4 +87,24 @@ void ath_printk(const char *level, const
  
  	va_end(args);
  }
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index af38787..e9a4a9e 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -34,7 +34,7 @@
  	if (netif_running(netdev))
  		alx_reinit(alx);
  	return 0;
-@@ -1176,7 +1188,9 @@ static const struct net_device_ops alx_n
+@@ -1226,7 +1238,9 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1294,7 +1308,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1344,7 +1358,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index 641d080..be9c1b8 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -36,7 +36,7 @@
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2495,8 +2508,10 @@ static const struct net_device_ops atl1c
+@@ -2504,8 +2517,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -47,7 +47,7 @@
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2514,6 +2529,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2523,6 +2538,7 @@ static int atl1c_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1c_set_ethtool_ops(netdev);
  
@@ -55,7 +55,7 @@
  	/* TODO: add when ready */
  	netdev->hw_features =	NETIF_F_SG		|
  				NETIF_F_HW_CSUM		|
-@@ -2522,6 +2538,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2531,6 +2547,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features	|
  				NETIF_F_HW_VLAN_CTAG_TX;
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index 9d3a16b..894bcc7 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2909,8 +2909,10 @@ static const struct net_device_ops atl1_
+@@ -2916,8 +2916,10 @@ static const struct net_device_ops atl1_
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1_set_mac,
  	.ndo_change_mtu		= atl1_change_mtu,
@@ -11,7 +11,7 @@
  	.ndo_do_ioctl		= atlx_ioctl,
  	.ndo_tx_timeout		= atlx_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3020,11 +3022,13 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3027,11 +3029,13 @@ static int atl1_probe(struct pci_dev *pd
  	netdev->features |= NETIF_F_SG;
  	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
  
@@ -25,7 +25,7 @@
  
  	/*
  	 * patch for some L1 of old version,
-@@ -3608,6 +3612,14 @@ static int atl1_set_pauseparam(struct ne
+@@ -3615,6 +3619,14 @@ static int atl1_set_pauseparam(struct ne
  	return 0;
  }
  
@@ -40,7 +40,7 @@
  static void atl1_get_strings(struct net_device *netdev, u32 stringset,
  	u8 *data)
  {
-@@ -3680,6 +3692,12 @@ static const struct ethtool_ops atl1_eth
+@@ -3687,6 +3699,12 @@ static const struct ethtool_ops atl1_eth
  	.nway_reset		= atl1_nway_reset,
  	.get_ethtool_stats	= atl1_get_ethtool_stats,
  	.get_sset_count		= atl1_get_sset_count,
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 3edda0e..cad8792 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6014,7 +6014,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5977,7 +5977,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 850e1a3..0c0e7e7 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3451,11 +3451,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3456,11 +3456,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index d26d40e..34e5951 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2658,7 +2658,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2667,7 +2667,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
index 2584d87..7cdb943 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3052,7 +3052,9 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3059,7 +3059,9 @@ static int atl1_probe(struct pci_dev *pd
  	/* copy the MAC address out of the EEPROM */
  	if (atl1_read_mac_addr(&adapter->hw)) {
  		/* mark random mac */
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
index 992e27f..5905539 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -814,7 +814,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -847,7 +847,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 2fd9569..ab511cf 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8239,7 +8239,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8202,7 +8202,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch b/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
index 36a0464..e9b0913 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
@@ -25,7 +25,7 @@
  };
  
  static void ssb_buses_lock(void)
-@@ -1461,6 +1470,7 @@ static int __init ssb_modinit(void)
+@@ -1463,6 +1472,7 @@ static int __init ssb_modinit(void)
  {
  	int err;
  
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
index 4a31f4f..ddb47de 100644
--- a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2112,7 +2112,7 @@ out:
+@@ -2449,7 +2449,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 2d9895c..3695e74 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9190,7 +9190,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9153,7 +9153,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9259,7 +9259,7 @@ static int nl80211_pre_doit(const struct
+@@ -9222,7 +9222,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9276,7 +9276,7 @@ static void nl80211_post_doit(const stru
+@@ -9239,7 +9239,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
-- 
1.7.10.4

