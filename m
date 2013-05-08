Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60491 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3EHABQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 20:01:16 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so782339pbc.30
        for <backports@vger.kernel.org>; Tue, 07 May 2013 17:01:15 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] backports: refresh patches for next-20130405
Date: Tue,  7 May 2013 17:01:08 -0700
Message-Id: <1367971269-25440-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130508_020119_928244_F7A555B4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/backport-adjustments/dma-buf.patch                 |    4 ++--
 .../drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch   |    4 ++--
 .../media/0003-technisat-usb2-led-rename.patch             |   12 ++++++------
 .../network/0001-netdev_ops/rndis.patch                    |    2 +-
 .../network/0001-netdev_ops/usbnet.patch                   |    2 +-
 .../0003-netdev-needed_headroom_tailroom/mac80211.patch    |    4 ++--
 .../network/0009-disable-wext-kconfig.patch                |    4 ++--
 .../09-cfg80211-wext-padding/net_wireless_core.patch       |    2 +-
 .../10-add-wext-handlers-to-netdev/net_wireless_core.patch |    4 ++--
 .../network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch |    2 +-
 .../network/17-netdev-queue/net_mac80211_iface.patch       |    4 ++--
 .../25-multicast-list_head/include_net_mac80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch         |    2 +-
 .../46-use_other_workqueue/net_bluetooth_hci_core.patch    |    2 +-
 .../network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch   |    2 +-
 .../network/54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_btusb.patch        |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch      |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_rndis_host.patch     |    2 +-
 .../drivers_net_wireless_libertas_if_usb.patch             |    2 +-
 .../drivers_net_wireless_libertas_tf_if_usb.patch          |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch                |    6 +++---
 .../drivers_net_wireless_libertas_main.patch               |    2 +-
 .../drivers_net_wireless_ath_ath5k_led.patch               |    2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch  |    2 +-
 .../network/72-brcm80211-makefiles/brcmsmac.patch          |    4 ++--
 .../network/72-brcm80211-makefiles/brcmutil.patch          |    4 ++--
 28 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 789a108..a0f3393 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -11,7 +11,7 @@
  
  static inline int is_dma_buf_file(struct file *);
  
-@@ -126,6 +129,27 @@ struct dma_buf *dma_buf_export(void *pri
+@@ -126,6 +130,27 @@ struct dma_buf *dma_buf_export(void *pri
  }
  EXPORT_SYMBOL_GPL(dma_buf_export);
  
@@ -39,7 +39,7 @@
  
  /**
   * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -141,9 +165,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
+@@ -141,9 +166,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
  	if (!dmabuf || !dmabuf->file)
  		return -EINVAL;
  
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
index af4681c..ba7b019 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/drm_bufs.c
 +++ b/drivers/gpu/drm/drm_bufs.c
-@@ -1541,6 +1541,20 @@
+@@ -1541,6 +1541,20 @@ int drm_mapbufs(struct drm_device *dev,
  				retcode = -EINVAL;
  				goto done;
  			}
@@ -21,7 +21,7 @@
  			virtual = vm_mmap(file_priv->filp, 0, map->size,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED,
-@@ -1549,6 +1563,7 @@
+@@ -1549,6 +1563,7 @@ int drm_mapbufs(struct drm_device *dev,
  			virtual = vm_mmap(file_priv->filp, 0, dma->byte_count,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED, 0);
diff --git a/patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch b/patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch
index ddfc32e..4732392 100644
--- a/patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch
+++ b/patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch
@@ -3,7 +3,7 @@ also send this upstream eventually.
 
 --- a/drivers/media/usb/dvb-usb/technisat-usb2.c
 +++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
-@@ -214,10 +214,10 @@ static void technisat_usb2_frontend_reset(struct usb_device *udev)
+@@ -214,10 +214,10 @@ static void technisat_usb2_frontend_rese
  
  /* LED control */
  enum technisat_usb2_led_state {
@@ -18,7 +18,7 @@ also send this upstream eventually.
  };
  
  static int technisat_usb2_set_led(struct dvb_usb_device *d, int red, enum technisat_usb2_led_state state)
-@@ -229,14 +229,14 @@ static int technisat_usb2_set_led(struct dvb_usb_device *d, int red, enum techni
+@@ -229,14 +229,14 @@ static int technisat_usb2_set_led(struct
  		0
  	};
  
@@ -36,7 +36,7 @@ also send this upstream eventually.
  		led[1] = 0x82;
  		if (red) {
  			led[2] = 0x02;
-@@ -251,7 +251,7 @@ static int technisat_usb2_set_led(struct dvb_usb_device *d, int red, enum techni
+@@ -251,7 +251,7 @@ static int technisat_usb2_set_led(struct
  		break;
  
  	default:
@@ -45,7 +45,7 @@ also send this upstream eventually.
  		led[1] = 0x80;
  		break;
  	}
-@@ -310,11 +310,11 @@ static void technisat_usb2_green_led_control(struct work_struct *work)
+@@ -310,11 +310,11 @@ static void technisat_usb2_green_led_con
  				goto schedule;
  
  			if (ber > 1000)
@@ -60,7 +60,7 @@ also send this upstream eventually.
  	}
  
  schedule:
-@@ -365,9 +365,9 @@ static int technisat_usb2_power_ctrl(struct dvb_usb_device *d, int level)
+@@ -365,9 +365,9 @@ static int technisat_usb2_power_ctrl(str
  		return 0;
  
  	/* green led is turned off in any case - will be turned on when tuning */
@@ -72,7 +72,7 @@ also send this upstream eventually.
  	return 0;
  }
  
-@@ -667,7 +667,7 @@ static int technisat_usb2_rc_query(struct dvb_usb_device *d)
+@@ -667,7 +667,7 @@ static int technisat_usb2_rc_query(struc
  		return 0;
  
  	if (!disable_led_control)
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch b/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
index 3ced630..694e894 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/rndis_host.c
 +++ b/drivers/net/usb/rndis_host.c
-@@ -358,7 +358,7 @@
+@@ -358,7 +358,7 @@ generic_rndis_bind(struct usbnet *dev, s
  	dev->rx_urb_size &= ~(dev->maxpacket - 1);
  	u.init->max_transfer_size = cpu_to_le32(dev->rx_urb_size);
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index f2bf6ec..5052c1f 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1446,7 +1446,7 @@
+@@ -1446,7 +1446,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 2b6a8a4..e597274 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1518,6 +1518,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1513,6 +1513,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1526,6 +1527,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1521,6 +1522,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch
index 83752e8..9d32cfe 100644
--- a/patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch
@@ -24,8 +24,8 @@ so remove the Kconfig options for them.
 -
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
- 	depends on m
-@@ -135,7 +117,7 @@ config CFG80211_INTERNAL_REGDB
+ 	depends on RFKILL || !RFKILL
+@@ -134,7 +116,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility"
  	depends on CFG80211
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
index 051401a..db7ad0b 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -316,6 +316,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -314,6 +314,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index b047c32..744952f 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -373,10 +373,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -371,10 +371,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -947,6 +943,15 @@ static int cfg80211_netdev_notifier_call
+@@ -941,6 +937,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
index 5d5fd92..4fa1912 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
@@ -14,7 +14,7 @@
  	tty_driver_flush_buffer(tty);
  
  	return 0;
-@@ -524,7 +529,11 @@ static int hci_uart_tty_ioctl(struct tty
+@@ -527,7 +532,11 @@ static int hci_uart_tty_ioctl(struct tty
  		return hu->hdev_flags;
  
  	default:
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 5f14b99..87adf23 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1643,6 +1643,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1638,6 +1638,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1670,6 +1671,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1665,6 +1666,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index e1a1597..6482bab 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2604,14 +2604,24 @@ struct ieee80211_ops {
+@@ -2603,14 +2603,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index e9d4dc3..1b69dd1 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -816,7 +816,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -815,7 +815,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index ff3ac79..33f0fde 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2066,16 +2066,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2181,16 +2181,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
index 3ff960d..42f16cb 100644
--- a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -421,7 +421,10 @@ static int hci_uart_register_dev(struct
+@@ -424,7 +424,10 @@ static int hci_uart_register_dev(struct
  	hdev->close = hci_uart_close;
  	hdev->flush = hci_uart_flush;
  	hdev->send  = hci_uart_send_frame;
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index 0057f47..aa537ee 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -933,7 +933,9 @@
+@@ -933,7 +933,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 9a52c6b..2084db0 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1234,7 +1234,9 @@ static struct usb_driver btusb_driver =
+@@ -1246,7 +1246,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index e4b942a..214c576 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -720,7 +720,9 @@
+@@ -720,7 +720,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
index 2312632..ff18d42 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/rndis_host.c
 +++ b/drivers/net/usb/rndis_host.c
-@@ -642,7 +642,9 @@
+@@ -637,7 +637,9 @@ static struct usb_driver rndis_driver =
  	.disconnect =	usbnet_disconnect,
  	.suspend =	usbnet_suspend,
  	.resume =	usbnet_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
index d7d3bb3..dcac2af 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_usb.c
 +++ b/drivers/net/wireless/libertas/if_usb.c
-@@ -1015,7 +1015,9 @@ static struct usb_driver if_usb_driver =
+@@ -1013,7 +1013,9 @@ static struct usb_driver if_usb_driver =
  	.suspend = if_usb_suspend,
  	.resume = if_usb_resume,
  	.reset_resume = if_usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
index 421c630..fdc9253 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas_tf/if_usb.c
 +++ b/drivers/net/wireless/libertas_tf/if_usb.c
-@@ -922,7 +922,9 @@ static struct usb_driver if_usb_driver =
+@@ -920,7 +920,9 @@ static struct usb_driver if_usb_driver =
  	.id_table = if_usb_table,
  	.suspend = if_usb_suspend,
  	.resume = if_usb_resume,
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
index 53089df..72e1f65 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -31,6 +31,7 @@
+@@ -29,6 +29,7 @@
  #include <linux/dma-mapping.h>
  #include <linux/ssb/ssb.h>
  #include <linux/slab.h>
@@ -8,7 +8,7 @@
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1638,10 +1639,17 @@ static int b44_close(struct net_device *
+@@ -1636,10 +1637,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -26,7 +26,7 @@
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2130,7 +2138,11 @@ static const struct net_device_ops b44_n
+@@ -2128,7 +2136,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
diff --git a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch b/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
index 22c0465..c255478 100644
--- a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
+++ b/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/main.c
 +++ b/drivers/net/wireless/libertas/main.c
-@@ -592,7 +592,11 @@ static int lbs_thread(void *data)
+@@ -590,7 +590,11 @@ static int lbs_thread(void *data)
  
  			/* Reset card, but only when it isn't in the process
  			 * of being shutdown anyway. */
diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
index 15126b6..5b9583d 100644
--- a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
+++ b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath5k/led.c
 +++ b/drivers/net/wireless/ath/ath5k/led.c
-@@ -55,7 +55,7 @@
+@@ -53,7 +53,7 @@
  #define ATH_POLARITY(data) ((data) & 0xff)
  
  /* Devices we match on for LED config info (typically laptops) */
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 29e4edd..2a6c740 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7728,7 +7728,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7726,7 +7726,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
index 9321ed7..06a6af0 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/drm_sysfs.c
 +++ b/drivers/gpu/drm/drm_sysfs.c
-@@ -72,7 +72,11 @@
+@@ -72,7 +72,11 @@ static int drm_class_resume(struct devic
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
index 4a898c5..112c769 100644
--- a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
+++ b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
@@ -1,8 +1,8 @@
 --- a/drivers/net/wireless/brcm80211/brcmsmac/Makefile
 +++ b/drivers/net/wireless/brcm80211/brcmsmac/Makefile
 @@ -21,7 +21,7 @@ ccflags-y := \
- 	-I$(obj)/phy				\
- 	-I$(obj)/../include
+ 	-Idrivers/net/wireless/brcm80211/brcmsmac/phy \
+ 	-Idrivers/net/wireless/brcm80211/include
  
 -BRCMSMAC_OFILES := \
 +brcmsmac-y := \
diff --git a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
index ad1322b..3b84733 100644
--- a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
+++ b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
@@ -1,8 +1,8 @@
 --- a/drivers/net/wireless/brcm80211/brcmutil/Makefile
 +++ b/drivers/net/wireless/brcm80211/brcmutil/Makefile
 @@ -19,10 +19,5 @@ ccflags-y :=				\
- 	-I$(obj)			\
- 	-I$(obj)/../include
+ 	-Idrivers/net/wireless/brcm80211/brcmutil \
+ 	-Idrivers/net/wireless/brcm80211/include
  
 -BRCMUTIL_OFILES := \
 -	utils.o
-- 
1.7.10.4

