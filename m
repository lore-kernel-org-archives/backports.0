Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37619 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490Ab3HGWyK (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:54:10 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] backports: refresh patches for next-20130719
Date: Thu,  8 Aug 2013 00:53:25 +0200
Message-Id: <1375916005-16411-11-git-send-email-hauke@hauke-m.de> (sfid-20130808_010908_743456_EB5CBC51)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

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
17  3.0.89              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.5              [  OK  ]
20  3.11-rc4            [  OK  ]
21  3.2.50              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.56              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch |    6 +++---
 .../drivers_gpu_drm_i915_i915_gem.patch              |    2 +-
 .../drm/14-shrinkers-api/drivers_gpu_drm_i915.patch  |   18 +++++++++---------
 .../network/0001-netdev_ops/atl1e.patch              |    2 +-
 .../network/0010-disable-usb-net-asix.patch          |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch       |   12 ++++++------
 ...drivers_net_wireless_ath_ath5k_mac80211-ops.patch |    2 +-
 ...ivers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +++---
 .../drivers_net_usb_cdc_ether.patch                  |    2 +-
 9 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index c1e6acc..9722df0 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4147,8 +4147,10 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4184,8 +4184,10 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
@@ -9,5 +9,5 @@
  		return -EIO;
 +#endif
  
- 	if (IS_HASWELL(dev) && (I915_READ(0x120010) == 1))
- 		I915_WRITE(0x9008, I915_READ(0x9008) | 0xf0000);
+ 	if (dev_priv->ellc_size)
+ 		I915_WRITE(HSW_IDICR, I915_READ(HSW_IDICR) | IDIHASHMSK(0xf));
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 052a2c5..7d42edc 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1616,7 +1616,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1617,7 +1617,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index 651f2c6..c983ced 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1657,7 +1657,11 @@ int i915_driver_load(struct drm_device *
+@@ -1665,7 +1665,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -12,7 +12,7 @@
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1691,7 +1695,11 @@ int i915_driver_unload(struct drm_device
+@@ -1699,7 +1703,11 @@ int i915_driver_unload(struct drm_device
  
  	i915_teardown_sysfs(dev);
  
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4360,8 +4365,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4411,8 +4416,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4584,8 +4593,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4635,8 +4644,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,8 +70,8 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4594,7 +4609,12 @@ i915_gem_inactive_count(struct shrinker
- 	struct drm_device *dev = dev_priv->dev;
+@@ -4646,7 +4661,12 @@ i915_gem_inactive_count(struct shrinker
+ 	struct i915_address_space *vm = &dev_priv->gtt.base;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4606,6 +4626,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4658,6 +4678,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4619,6 +4650,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4671,6 +4702,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4652,3 +4684,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4704,3 +4736,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
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
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 0a3051d..75bc7dc 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -323,6 +323,7 @@ err:
+@@ -348,6 +348,7 @@ err:
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -380,6 +381,16 @@ err:
+@@ -405,6 +406,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,7 +25,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -668,6 +679,87 @@ static void hidp_close(struct hid_device
+@@ -693,6 +704,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -113,7 +113,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -758,7 +850,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -770,7 +862,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -123,7 +123,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -776,6 +870,7 @@ fault:
+@@ -788,6 +882,7 @@ fault:
  
  	return err;
  }
@@ -131,7 +131,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -838,10 +933,17 @@ static int hidp_session_dev_add(struct h
+@@ -850,10 +945,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
index 485ab8b..741c49a 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
@@ -19,7 +19,7 @@
 +#endif
  
  	mfilt[0] = 0;
- 	mfilt[1] = 1;
+ 	mfilt[1] = 0;
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	netdev_hw_addr_list_for_each(ha, mc_list) {
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
-- 
1.7.10.4

