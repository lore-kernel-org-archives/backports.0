Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60881 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab3HRXj3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:39:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 11/19] backports: refresh on next-20130726
Date: Mon, 19 Aug 2013 01:37:56 +0200
Message-Id: <1376869084-16513-12-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_125913_3505409F)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
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
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   18 ++++++++--------
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/qmi_wwan.patch         |    2 +-
 .../network/0001-netdev_ops/sierra_net.patch       |    2 +-
 .../network/0001-netdev_ops/wil6210.patch          |    4 ++--
 .../network/0005-netlink-portid/nl80211.patch      |   22 ++++++++++----------
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   12 +++++------
 .../drivers_net_wireless_cw1200_sta.patch          |    8 +++----
 .../drivers_net_wireless_cw1200_sdio.patch         |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   10 ++++-----
 .../32-remove-ns-type/net_wireless_sysfs.patch     |    4 ++--
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_mbim.patch                 |    2 +-
 .../drivers_net_usb_cdc_ncm.patch                  |    2 +-
 .../drivers_net_usb_qmi_wwan.patch                 |    2 +-
 .../drivers_net_usb_sierra_net.patch               |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../drivers_usb_class_cdc-wdm.patch                |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../75-cw1200-workqueues/cw1200_workqueues.patch   |    8 ++-----
 28 files changed, 61 insertions(+), 65 deletions(-)

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
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 9722df0..4913df8 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4184,8 +4184,10 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4182,8 +4182,10 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 7d42edc..cc25a62 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1617,7 +1617,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1611,7 +1611,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index c983ced..96333f8 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1665,7 +1665,11 @@ int i915_driver_load(struct drm_device *
+@@ -1652,7 +1652,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -12,7 +12,7 @@
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1699,7 +1703,11 @@ int i915_driver_unload(struct drm_device
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
-@@ -4411,8 +4416,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4409,8 +4414,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4635,8 +4644,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4633,8 +4642,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4646,7 +4661,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4644,7 +4659,12 @@ i915_gem_inactive_count(struct shrinker
  	struct i915_address_space *vm = &dev_priv->gtt.base;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4658,6 +4678,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4656,6 +4676,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4671,6 +4702,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4669,6 +4700,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4704,3 +4736,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4702,3 +4734,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 58a38ab..16e6051 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -749,7 +749,7 @@ static const struct net_device_ops mwifi
+@@ -759,7 +759,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
index 6281c8d..17bafe5 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -331,7 +331,7 @@
+@@ -331,7 +331,7 @@ next_desc:
  		dev->net->dev_addr[0] |= 0x02;	/* set local assignment bit */
  		dev->net->dev_addr[0] &= 0xbf;	/* clear "IP" bit */
  	}
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch b/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
index e7ff14b..8120a03 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/sierra_net.c
 +++ b/drivers/net/usb/sierra_net.c
-@@ -695,7 +695,7 @@
+@@ -695,7 +695,7 @@ static int sierra_net_bind(struct usbnet
  
  	priv->usbnet = dev;
  	priv->ifnum = ifacenum;
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
index 75bc7dc..4e861f9 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -348,6 +348,7 @@ err:
+@@ -353,6 +353,7 @@ err:
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -405,6 +406,16 @@ err:
+@@ -410,6 +411,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,7 +25,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -693,6 +704,87 @@ static void hidp_close(struct hid_device
+@@ -698,6 +709,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -113,7 +113,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -770,7 +862,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -775,7 +867,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -123,7 +123,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -788,6 +882,7 @@ fault:
+@@ -793,6 +887,7 @@ fault:
  
  	return err;
  }
@@ -131,7 +131,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -850,10 +945,17 @@ static int hidp_session_dev_add(struct h
+@@ -855,10 +950,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
index 269a696..166de17 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/cw1200/sta.c
 +++ b/drivers/net/wireless/cw1200/sta.c
-@@ -530,8 +530,13 @@ void cw1200_set_beacon_wakeup_period_work(struct work_struct *work)
+@@ -530,8 +530,13 @@ void cw1200_set_beacon_wakeup_period_wor
  				     priv->join_dtim_period, 0);
  }
  
@@ -14,7 +14,7 @@
  {
  	static u8 broadcast_ipv6[ETH_ALEN] = {
  		0x33, 0x33, 0x00, 0x00, 0x00, 0x01
-@@ -540,13 +545,16 @@ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+@@ -540,13 +545,16 @@ u64 cw1200_prepare_multicast(struct ieee
  		0x01, 0x00, 0x5e, 0x00, 0x00, 0x01
  	};
  	struct cw1200_common *priv = hw->priv;
@@ -31,7 +31,7 @@
  	if (netdev_hw_addr_list_count(mc_list) > WSM_MAX_GRP_ADDRTABLE_ENTRIES)
  		return 0;
  
-@@ -560,13 +568,26 @@ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+@@ -560,13 +568,26 @@ u64 cw1200_prepare_multicast(struct ieee
  			priv->has_multicast_subscription = true;
  		count++;
  	}
@@ -61,7 +61,7 @@
  void cw1200_configure_filter(struct ieee80211_hw *dev,
 --- a/drivers/net/wireless/cw1200/sta.h
 +++ b/drivers/net/wireless/cw1200/sta.h
-@@ -42,8 +42,13 @@ int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+@@ -42,8 +42,13 @@ int cw1200_set_rts_threshold(struct ieee
  
  void cw1200_flush(struct ieee80211_hw *hw, u32 queues, bool drop);
  
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
index 2533051..0e18379 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/cw1200/cw1200_sdio.c
 +++ b/drivers/net/wireless/cw1200/cw1200_sdio.c
-@@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(struct hwbus_priv *self, size_t size)
+@@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(str
  	else
  		size = sdio_align_size(self->func, size);
  
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
index 8704889..ab9b14a 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -75,7 +75,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
+@@ -76,7 +76,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
  
  	card->func = func;
  
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 06c18bc..8d2d67d 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -140,8 +140,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -141,8 +141,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	wait_for_completion(&adapter->fw_load);
  
  	if (user_rmmod) {
@@ -11,7 +11,7 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -158,6 +160,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -159,6 +161,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	kfree(card);
  }
  
@@ -19,7 +19,7 @@
  /*
   * SDIO suspend.
   *
-@@ -257,6 +260,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -258,6 +261,7 @@ static int mwifiex_sdio_resume(struct de
  
  	return 0;
  }
@@ -27,7 +27,7 @@
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -282,10 +286,12 @@ static const struct sdio_device_id mwifi
+@@ -283,10 +287,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +40,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -294,7 +300,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -295,7 +301,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
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
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
index 0feffc8..fb9cff4 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -417,7 +417,9 @@
+@@ -417,7 +417,9 @@ static struct usb_driver cdc_mbim_driver
  	.resume = cdc_mbim_resume,
  	.reset_resume =	cdc_mbim_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
index c6419fe..bce40fb 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ncm.c
 +++ b/drivers/net/usb/cdc_ncm.c
-@@ -1271,7 +1271,9 @@
+@@ -1271,7 +1271,9 @@ static struct usb_driver cdc_ncm_driver
  	.resume = usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
index 8f3355d..c4c2130 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -672,7 +672,9 @@
+@@ -674,7 +674,9 @@ static struct usb_driver qmi_wwan_driver
  	.resume		      =	qmi_wwan_resume,
  	.reset_resume         = qmi_wwan_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
index 553f2ca..c9060b4 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/sierra_net.c
 +++ b/drivers/net/usb/sierra_net.c
-@@ -959,7 +959,9 @@
+@@ -959,7 +959,9 @@ static struct usb_driver sierra_net_driv
  	.suspend = usbnet_suspend,
  	.resume = usbnet_resume,
  	.no_dynamic_id = 1,
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
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
index c3af4a1..eb7cb21 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/usb/class/cdc-wdm.c
 +++ b/drivers/usb/class/cdc-wdm.c
-@@ -1060,7 +1060,9 @@
+@@ -1060,7 +1060,9 @@ static struct usb_driver wdm_driver = {
  	.post_reset =	wdm_post_reset,
  	.id_table =	wdm_ids,
  	.supports_autosuspend = 1,
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
diff --git a/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch b/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
index 3bf3197..eee33dd 100644
--- a/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
+++ b/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/wireless/cw1200/bh.c b/drivers/net/wireless/cw1200/bh.c
-index c1ec2a4..5dcbb4e 100644
 --- a/drivers/net/wireless/cw1200/bh.c
 +++ b/drivers/net/wireless/cw1200/bh.c
 @@ -48,16 +48,22 @@ enum cw1200_bh_pm_state {
@@ -25,7 +23,7 @@ index c1ec2a4..5dcbb4e 100644
  	/* Realtime workqueue */
  	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
  				WQ_MEM_RECLAIM | WQ_HIGHPRI
-@@ -67,6 +73,7 @@ int cw1200_register_bh(struct cw1200_common *priv)
+@@ -67,6 +73,7 @@ int cw1200_register_bh(struct cw1200_com
  		return -ENOMEM;
  
  	INIT_WORK(&priv->bh_work, cw1200_bh_work);
@@ -33,7 +31,7 @@ index c1ec2a4..5dcbb4e 100644
  
  	pr_debug("[BH] register.\n");
  
-@@ -81,20 +88,44 @@ int cw1200_register_bh(struct cw1200_common *priv)
+@@ -81,20 +88,44 @@ int cw1200_register_bh(struct cw1200_com
  	init_waitqueue_head(&priv->bh_wq);
  	init_waitqueue_head(&priv->bh_evt_wq);
  
@@ -95,8 +93,6 @@ index c1ec2a4..5dcbb4e 100644
  	}
  	return 0;
  }
-diff --git a/drivers/net/wireless/cw1200/cw1200.h b/drivers/net/wireless/cw1200/cw1200.h
-index 1ad7d36..300dbbb 100644
 --- a/drivers/net/wireless/cw1200/cw1200.h
 +++ b/drivers/net/wireless/cw1200/cw1200.h
 @@ -23,12 +23,18 @@
-- 
1.7.10.4

