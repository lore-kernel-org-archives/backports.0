Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41561 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859Ab3JXVEk (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 17:04:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh on next-20130927
Date: Thu, 24 Oct 2013 23:04:24 +0200
Message-Id: <1382648664-17110-4-git-send-email-hauke@hauke-m.de> (sfid-20131024_230442_611761_D22E3857)
In-Reply-To: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
References: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
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
20  3.12-rc3            [  OK  ]
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
 patches/collateral-evolutions/network/05-usb/p54usb.patch      |    2 +-
 .../09-threaded-irq/drivers_net_wireless_b43_main.patch        |    6 +++---
 .../11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch     |    4 ++--
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch        |    4 ++--
 .../network/16-bluetooth/net_bluetooth_rfcomm_tty.patch        |    6 +++---
 .../25-multicast-list_head/net_mac80211_driver-ops.patch       |    4 ++--
 .../network/25-multicast-list_head/net_mac80211_main.patch     |    4 ++--
 .../network/36-workqueue/net_mac80211_main.patch               |    2 +-
 .../drivers_net_wireless_b43_main.patch                        |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch    |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch    |    2 +-
 .../drivers_net_wireless_ath_carl9170_usb.patch                |    2 +-
 .../62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch    |    2 +-
 .../network/63-tty-termios/net_bluetooth_rfcomm_tty.patch      |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch                 |    2 +-
 18 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 88608c0..4afae5f 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -1,6 +1,6 @@
 --- a/compat/drivers-base-dma-buf.c
 +++ b/compat/drivers-base-dma-buf.c
-@@ -28,6 +28,10 @@
+@@ -27,6 +27,10 @@
  #include <linux/dma-buf.h>
  #include <linux/anon_inodes.h>
  #include <linux/export.h>
@@ -11,7 +11,7 @@
  #include <linux/debugfs.h>
  #include <linux/seq_file.h>
  
-@@ -180,6 +184,27 @@ struct dma_buf *dma_buf_export_named(voi
+@@ -179,6 +183,27 @@ struct dma_buf *dma_buf_export_named(voi
  }
  EXPORT_SYMBOL_GPL(dma_buf_export_named);
  
@@ -39,7 +39,7 @@
  
  /**
   * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -195,9 +220,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
+@@ -194,9 +219,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
  	if (!dmabuf || !dmabuf->file)
  		return -EINVAL;
  
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -725,17 +751,15 @@ static inline void dma_buf_uninit_debugf
+@@ -724,17 +750,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/network/05-usb/p54usb.patch b/patches/collateral-evolutions/network/05-usb/p54usb.patch
index 7862af8..8ea02ed 100644
--- a/patches/collateral-evolutions/network/05-usb/p54usb.patch
+++ b/patches/collateral-evolutions/network/05-usb/p54usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1137,7 +1137,9 @@ static struct usb_driver p54u_driver = {
+@@ -1139,7 +1139,9 @@ static struct usb_driver p54u_driver = {
  	.resume = p54u_resume,
  	.reset_resume = p54u_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index 32801a7..3d364d8 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4239,8 +4239,13 @@ redo:
+@@ -4238,8 +4238,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4286,9 +4291,17 @@ static int b43_wireless_core_start(struc
+@@ -4285,9 +4290,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5125,6 +5138,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5124,6 +5137,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index f7d48d0..5cf7fe8 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -558,6 +558,9 @@ static int ath_pci_resume(struct device
+@@ -751,6 +751,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -576,7 +579,12 @@ static struct pci_driver ath_pci_driver
+@@ -769,7 +772,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
index 564c1fa..e86b61a 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3910,7 +3910,12 @@ static struct pci_driver il3945_driver =
+@@ -3908,7 +3908,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index 0eebc4b..e0aa0e0 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6825,7 +6825,12 @@ static struct pci_driver il4965_driver =
+@@ -6823,7 +6823,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
index b95afec..9dd9a2c 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/p54pci.c
 +++ b/drivers/net/wireless/p54/p54pci.c
-@@ -684,6 +684,9 @@ static int p54p_resume(struct device *de
+@@ -683,6 +683,9 @@ static int p54p_resume(struct device *de
  	return pci_set_power_state(pdev, PCI_D0);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(p54pci_pm_ops, p54p_suspend, p54p_resume);
  
  #define P54P_PM_OPS (&p54pci_pm_ops)
-@@ -696,7 +699,12 @@ static struct pci_driver p54p_driver = {
+@@ -695,7 +698,12 @@ static struct pci_driver p54p_driver = {
  	.id_table	= p54p_table,
  	.probe		= p54p_probe,
  	.remove		= p54p_remove,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index ee71745..2caf2f3 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -794,7 +794,11 @@ static int rfcomm_tty_write_room(struct
+@@ -763,7 +763,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
  
@@ -12,7 +12,7 @@
  {
  	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
  
-@@ -1047,7 +1051,11 @@ static void rfcomm_tty_hangup(struct tty
+@@ -1016,7 +1020,11 @@ static void rfcomm_tty_hangup(struct tty
  		tty_port_put(&dev->port);
  }
  
@@ -24,7 +24,7 @@
  {
  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
  
-@@ -1056,7 +1064,11 @@ static int rfcomm_tty_tiocmget(struct tt
+@@ -1025,7 +1033,11 @@ static int rfcomm_tty_tiocmget(struct tt
  	return dev->modem_status;
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
index 5f4271b..042cca7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -229,20 +229,35 @@ static inline void drv_bss_info_changed(
+@@ -228,20 +228,35 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -36,7 +36,7 @@
  static inline void drv_set_multicast_list(struct ieee80211_local *local,
  					  struct ieee80211_sub_if_data *sdata,
  					  struct netdev_hw_addr_list *mc_list)
-@@ -258,6 +273,23 @@ static inline void drv_set_multicast_lis
+@@ -257,6 +272,23 @@ static inline void drv_set_multicast_lis
  					       allmulti, mc_list);
  	trace_drv_return_void(local);
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
index 781d7ea..b1df3b7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -72,7 +72,11 @@ void ieee80211_configure_filter(struct i
+@@ -71,7 +71,11 @@ void ieee80211_configure_filter(struct i
  	spin_lock_bh(&local->filter_lock);
  	changed_flags = local->filter_flags ^ new_flags;
  
@@ -12,7 +12,7 @@
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -591,9 +595,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -590,9 +594,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index fae6d38..043c325 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1140,6 +1140,10 @@ static void __exit ieee80211_exit(void)
+@@ -1139,6 +1139,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 3473edf..850e1a3 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3452,11 +3452,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3451,11 +3451,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
index 6a25832..d70c24b 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -501,7 +501,9 @@ static struct usb_driver ath3k_driver =
+@@ -503,7 +503,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index ad7942f..5c57bf8 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1627,7 +1627,9 @@ static struct usb_driver btusb_driver =
+@@ -1632,7 +1632,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
index 13fd478..cbd0ee5 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/carl9170/usb.c
 +++ b/drivers/net/wireless/ath/carl9170/usb.c
-@@ -1167,7 +1167,9 @@ static struct usb_driver carl9170_driver
+@@ -1166,7 +1166,9 @@ static struct usb_driver carl9170_driver
  	.resume = carl9170_usb_resume,
  	.reset_resume = carl9170_usb_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
index c419b27..1ec4a59 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1140,7 +1140,9 @@ static struct usb_driver p54u_driver = {
+@@ -1142,7 +1142,9 @@ static struct usb_driver p54u_driver = {
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
index 165577a..992e27f 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -845,7 +845,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -814,7 +814,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index d1b7d95..9bd5804 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1261,7 +1261,11 @@ static const struct file_operations fops
+@@ -1263,7 +1263,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

