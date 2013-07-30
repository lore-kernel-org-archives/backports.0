Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:58297 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436Ab3G3Jbz (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:31:55 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so5782174pbb.34
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:31:55 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 4/4] backports: refresh patches for next-20130729
Date: Tue, 30 Jul 2013 02:31:32 -0700
Message-Id: <1375176692-1878-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_113158_272541_726A4BEB)
In-Reply-To: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   20 +++++++++---------
 .../network/0001-netdev_ops/atl1e.patch            |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../network/0001-netdev_ops/wil6210.patch          |    4 ++--
 .../network/0005-netlink-portid/nl80211.patch      |   22 ++++++++++----------
 .../network/0010-disable-usb-net-asix.patch        |    2 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   12 +++++------
 .../drivers_net_wireless_mwifiex_sdio.patch        |    2 +-
 .../32-remove-ns-type/net_wireless_sysfs.patch     |    4 ++--
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +++---
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 22 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index 3167c0b..9218716 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1292,10 +1292,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1293,10 +1293,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 052a2c5..cc25a62 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1616,7 +1616,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1611,7 +1611,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index c00d346..d46f8b9 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1657,7 +1657,11 @@ int i915_driver_load(struct drm_device *
+@@ -1652,7 +1652,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -12,7 +12,7 @@
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1691,7 +1695,11 @@ int i915_driver_unload(struct drm_device
+@@ -1686,7 +1690,11 @@ int i915_driver_unload(struct drm_device
  
  	i915_teardown_sysfs(dev);
  
@@ -26,7 +26,7 @@
  	mutex_lock(&dev->struct_mutex);
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -53,10 +53,15 @@ static void i915_gem_object_update_fence
+@@ -54,10 +54,15 @@ static void i915_gem_object_update_fence
  					 struct drm_i915_fence_reg *fence,
  					 bool enable);
  
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4360,8 +4365,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4412,8 +4417,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4584,8 +4593,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4636,8 +4645,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,8 +70,8 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4594,7 +4609,12 @@ i915_gem_inactive_count(struct shrinker
- 	struct drm_device *dev = dev_priv->dev;
+@@ -4647,7 +4662,12 @@ i915_gem_inactive_count(struct shrinker
+ 	struct i915_address_space *vm = &dev_priv->gtt.base;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4606,6 +4626,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4659,6 +4679,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4619,6 +4650,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4672,6 +4703,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4652,3 +4684,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4705,3 +4737,4 @@ i915_gem_inactive_scan(struct shrinker *
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
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 58a38ab..05d91dd 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -749,7 +749,7 @@ static const struct net_device_ops mwifi
+@@ -799,7 +799,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index b7f935a..00d08bf 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1540,7 +1540,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1575,7 +1575,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch b/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
index 423ed53..ac8927a 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
@@ -7,5 +7,5 @@
 -	ndev->netdev_ops = &wil_netdev_ops;
 +	netdev_attach_ops(ndev, &wil_netdev_ops);
  	ndev->ieee80211_ptr = wdev;
- 	SET_NETDEV_DEV(ndev, wiphy_dev(wdev->wiphy));
- 	wdev->netdev = ndev;
+ 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+ 	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index d5a6a12..4664bc1 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6945,7 +6945,7 @@ static int nl80211_remain_on_channel(str
+@@ -6947,7 +6947,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7164,7 +7164,7 @@ static int nl80211_register_mgmt(struct
+@@ -7166,7 +7166,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7245,7 +7245,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7247,7 +7247,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7360,7 +7360,7 @@ static int nl80211_get_power_save(struct
+@@ -7362,7 +7362,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7671,7 +7671,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7673,7 +7673,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8096,7 +8096,7 @@ static int nl80211_register_unexpected_f
+@@ -8098,7 +8098,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8126,7 +8126,7 @@ static int nl80211_probe_client(struct s
+@@ -8128,7 +8128,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8170,13 +8170,13 @@ static int nl80211_register_beacons(stru
+@@ -8172,13 +8172,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8243,7 +8243,7 @@ static int nl80211_get_protocol_features
+@@ -8245,7 +8245,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8318,7 +8318,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8320,7 +8320,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10693,12 +10693,12 @@ static int nl80211_netlink_notify(struct
+@@ -10696,12 +10696,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
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
index fc7ef39..e6b963e 100644
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1379,7 +1379,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1381,7 +1381,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 0a3051d..4e861f9 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -323,6 +323,7 @@ err:
+@@ -353,6 +353,7 @@ err:
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -380,6 +381,16 @@ err:
+@@ -410,6 +411,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,7 +25,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -668,6 +679,87 @@ static void hidp_close(struct hid_device
+@@ -698,6 +709,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -113,7 +113,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -758,7 +850,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -775,7 +867,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -123,7 +123,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -776,6 +870,7 @@ fault:
+@@ -793,6 +887,7 @@ fault:
  
  	return err;
  }
@@ -131,7 +131,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -838,10 +933,17 @@ static int hidp_session_dev_add(struct h
+@@ -855,10 +950,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
index 8704889..d46f5ee 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -75,7 +75,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
+@@ -73,7 +73,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
  
  	card->func = func;
  
diff --git a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
index e68fab0..7db2dde 100644
--- a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
+++ b/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/sysfs.c
 +++ b/net/wireless/sysfs.c
-@@ -135,12 +135,14 @@ static int wiphy_resume(struct device *d
+@@ -138,12 +138,14 @@ static int wiphy_resume(struct device *d
  }
  #endif
  
@@ -15,7 +15,7 @@
  
  struct class ieee80211_class = {
  	.name = "ieee80211",
-@@ -152,8 +154,10 @@ struct class ieee80211_class = {
+@@ -155,8 +157,10 @@ struct class ieee80211_class = {
  	.suspend = wiphy_suspend,
  	.resume = wiphy_resume,
  #endif
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
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index 30bc0c2..c9e3345 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -288,8 +288,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -289,8 +289,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index 3f99e10..6118d59 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -997,7 +997,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1029,7 +1029,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
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
index 7bfe884..ff16065 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1382,7 +1382,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1384,7 +1384,9 @@ static struct usb_driver ath9k_hif_usb_d
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index 9e3e77b..1674af0 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1350,7 +1350,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1387,7 +1387,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 06c882d..fb20e84 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7815,7 +7815,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7817,7 +7817,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
-- 
1.7.10.4

