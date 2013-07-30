Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53752 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab3G3Jpa (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:45:30 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so6959899pad.32
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:45:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3.11-rc3 2/2] backports: refresh patches for v3.11-rc3
Date: Tue, 30 Jul 2013 02:45:15 -0700
Message-Id: <1375177515-2537-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_114537_576553_3D7DFB2A)
In-Reply-To: <1375177515-2537-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375177515-2537-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

real    34m26.742s
user    929m30.328s
sys     128m39.452s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch    |    2 +-
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch         |    2 +-
 .../08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch  |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/atl1e.patch    |    2 +-
 .../network/0010-disable-usb-net-asix.patch                      |    2 +-
 patches/collateral-evolutions/network/05-usb/ath9k_htc.patch     |    2 +-
 .../drivers_net_ethernet_atheros_atl1e_atl1e_main.patch          |    6 +++---
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch      |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch      |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch    |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch                 |    2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index 3167c0b..6b4010b 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1292,10 +1292,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1290,10 +1290,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 486693b..ad0448f 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4147,9 +4147,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4154,9 +4154,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 052a2c5..59c7d94 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1616,7 +1616,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1614,7 +1614,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
index e359e87..4f129c9 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2192,7 +2192,7 @@ static int atl1e_init_netdev(struct net_
+@@ -2236,7 +2236,7 @@ static int atl1e_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
diff --git a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
index 9d1ad08..365ef0f 100644
--- a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
+++ b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
@@ -6,5 +6,5 @@
  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 -asix-y := asix_devices.o asix_common.o ax88172a.o
  obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
- obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
+ obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o r815x.o
  obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
diff --git a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
index fc7ef39..78ebbf8 100644
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1379,7 +1379,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1376,7 +1376,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index 5a84c32..e521eb3 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -16,7 +16,7 @@
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1910,7 +1912,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1954,7 +1956,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -28,7 +28,7 @@
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2180,8 +2186,10 @@ static const struct net_device_ops atl1e
+@@ -2224,8 +2230,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -39,7 +39,7 @@
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2201,10 +2209,15 @@ static int atl1e_init_netdev(struct net_
+@@ -2245,10 +2253,15 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
index 9735d1e..ce5b6d7 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -475,7 +475,9 @@ static struct usb_driver ath3k_driver =
+@@ -473,7 +473,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 82e4f89..9a2c9e3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1624,7 +1624,9 @@ static struct usb_driver btusb_driver =
+@@ -1623,7 +1623,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index c8da6e7..2fd4eed 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -752,7 +752,9 @@ static struct usb_driver cdc_driver = {
+@@ -757,7 +757,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
index 7bfe884..5753b5e 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1382,7 +1382,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1379,7 +1379,9 @@ static struct usb_driver ath9k_hif_usb_d
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
-- 
1.7.10.4

