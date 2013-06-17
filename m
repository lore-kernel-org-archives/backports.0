Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44944 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933061Ab3FQNVp (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] backports: refresh patches on next-20130617
Date: Mon, 17 Jun 2013 15:21:07 +0200
Message-Id: <1371475267-27179-7-git-send-email-hauke@hauke-m.de> (sfid-20130617_152151_300052_2A27C41D)
In-Reply-To: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
References: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
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

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/dma-buf.patch         |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 +++---
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0005-netlink-portid/nl80211.patch      |   40 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +--
 .../net_wireless_core.patch                        |    6 +--
 .../drivers_net_wireless_ath_ath9k_pci.patch       |    4 +-
 .../drivers_net_wireless_iwlegacy_3945-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../drivers_net_wireless_orinoco_orinoco_usb.patch |    2 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +--
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../drivers_net_wireless_ath_ath6kl_usb.patch      |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../drivers_net_wireless_orinoco_orinoco_usb.patch |    2 +-
 .../drivers_net_wireless_rt2x00_rt2500usb.patch    |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../drivers_net_wireless_rt2x00_rt73usb.patch      |    2 +-
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   14 +++----
 38 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index faefc93..97abcbc 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -695,17 +721,15 @@ static inline void dma_buf_uninit_debugf
+@@ -692,17 +718,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index 1aeda52..9218716 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1296,10 +1296,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1293,10 +1293,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 23b8990..d58bdaf 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4065,9 +4065,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4185,9 +4185,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index fe2b832..7d42edc 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1620,7 +1620,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1617,7 +1617,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index 8d63086..f60bdf2 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4277,8 +4282,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4397,8 +4402,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4501,8 +4510,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4621,8 +4630,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4511,7 +4526,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4631,7 +4646,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4523,6 +4543,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4643,6 +4663,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4536,6 +4567,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4656,6 +4687,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4569,3 +4601,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4689,3 +4721,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 860230f..0567191 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -668,7 +668,7 @@ static const struct net_device_ops mwifi
+@@ -750,7 +750,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 71cf119..5f49cb3 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1565,7 +1565,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1564,7 +1564,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4204,7 +4204,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4206,7 +4206,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4253,7 +4253,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4255,7 +4255,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4517,7 +4517,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4519,7 +4519,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4870,7 +4870,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4878,7 +4878,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5549,7 +5549,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5557,7 +5557,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5785,7 +5785,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5793,7 +5793,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6452,7 +6452,7 @@ static int nl80211_testmode_dump(struct
+@@ -6460,7 +6460,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6531,7 +6531,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6539,7 +6539,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6897,7 +6897,7 @@ static int nl80211_remain_on_channel(str
+@@ -6905,7 +6905,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7116,7 +7116,7 @@ static int nl80211_register_mgmt(struct
+@@ -7124,7 +7124,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7186,7 +7186,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7205,7 +7205,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7301,7 +7301,7 @@ static int nl80211_get_power_save(struct
+@@ -7320,7 +7320,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7596,7 +7596,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7631,7 +7631,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8022,7 +8022,7 @@ static int nl80211_register_unexpected_f
+@@ -8056,7 +8056,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8052,7 +8052,7 @@ static int nl80211_probe_client(struct s
+@@ -8086,7 +8086,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8096,13 +8096,13 @@ static int nl80211_register_beacons(stru
+@@ -8130,13 +8130,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8169,7 +8169,7 @@ static int nl80211_get_protocol_features
+@@ -8203,7 +8203,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8244,7 +8244,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8278,7 +8278,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10643,12 +10643,12 @@ static int nl80211_netlink_notify(struct
+@@ -10652,12 +10652,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index c3150fb..c13d053 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1572,6 +1572,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1571,6 +1571,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 &cb->args[2],
  						 &cb->args[3]);
  			if (ret < 0) {
@@ -37,7 +37,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
 @@ -1591,6 +1592,7 @@ static int nl80211_dump_wiphy(struct sk_
- 					cb->min_dump_alloc = 4096;
+ 					rtnl_unlock();
  					return 1;
  				}
 +#endif
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 01bad15..3a7a9e2 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2609,6 +2609,9 @@ struct wiphy_wowlan_support {
+@@ -2615,6 +2615,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
index 3666d99..0059e0d 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/internal.h
 +++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
-@@ -311,6 +311,9 @@ struct iwl_trans_pcie {
+@@ -313,6 +313,9 @@ struct iwl_trans_pcie {
  
  	/*protect hw register */
  	spinlock_t reg_lock;
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index c4d6dda..d117011 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -773,12 +773,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -788,12 +788,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1566,9 +1575,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1581,9 +1590,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 0e925b1..50a8510 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6054,13 +6054,24 @@ static void wlcore_nvs_cb(const struct f
+@@ -6063,13 +6063,24 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -25,7 +25,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6135,7 +6146,11 @@ out_unreg:
+@@ -6138,7 +6149,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -37,7 +37,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6181,7 +6196,12 @@ int wlcore_remove(struct platform_device
+@@ -6184,7 +6199,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 17220f2..48074d7 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -324,10 +324,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -327,10 +327,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,9 +11,9 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -829,6 +825,15 @@ static int cfg80211_netdev_notifier_call
+@@ -828,6 +824,15 @@ static int cfg80211_netdev_notifier_call
+ 		}
  		wdev->netdev = dev;
- 		wdev->sme_state = CFG80211_SME_IDLE;
  #ifdef CONFIG_CFG80211_WEXT
 +#ifdef CONFIG_WIRELESS_EXT
 +		if (!dev->wireless_handlers)
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index 7d00628..5e0bf91 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -310,6 +310,9 @@ static int ath_pci_resume(struct device
+@@ -339,6 +339,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -328,7 +331,12 @@ static struct pci_driver ath_pci_driver
+@@ -357,7 +360,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
index 573933d..564c1fa 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3909,7 +3909,12 @@ static struct pci_driver il3945_driver =
+@@ -3910,7 +3910,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index ff98dd5..ca69e3d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6800,7 +6800,12 @@ static struct pci_driver il4965_driver =
+@@ -6819,7 +6819,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index eda4d00..3220c3f 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -20,7 +20,7 @@
  
 --- a/drivers/net/wireless/iwlegacy/common.h
 +++ b/drivers/net/wireless/iwlegacy/common.h
-@@ -1833,7 +1833,14 @@ __le32 il_add_beacon_time(struct il_priv
+@@ -1835,7 +1835,14 @@ __le32 il_add_beacon_time(struct il_priv
  			  u32 beacon_interval);
  
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 803a461..0d38b88 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -393,6 +393,9 @@ static int iwl_pci_resume(struct device
+@@ -397,6 +397,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -408,7 +411,12 @@ static struct pci_driver iwl_pci_driver
+@@ -412,7 +415,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 73d8d92..e8339e7 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1978,6 +1978,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1972,6 +1972,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2006,6 +2007,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2000,6 +2001,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index b9bc0fe..40c73e1 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2657,14 +2657,24 @@ struct ieee80211_ops {
+@@ -2660,14 +2660,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index f9b7a1c..40c37f1 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -925,7 +925,12 @@ struct ieee80211_local {
+@@ -926,7 +926,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
index aa08ba8..fa11d01 100644
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
+++ b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1553,7 +1553,7 @@ static const struct hermes_ops ezusb_ops
+@@ -1554,7 +1554,7 @@ static const struct hermes_ops ezusb_ops
  	.read_ltv = ezusb_read_ltv,
  	.write_ltv = ezusb_write_ltv,
  	.bap_pread = ezusb_bap_pread,
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
index 44bcd4f..2f34c83 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btmrvl_sdio.c
 +++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1082,6 +1082,7 @@ static void btmrvl_sdio_remove(struct sd
+@@ -1083,6 +1083,7 @@ static void btmrvl_sdio_remove(struct sd
  	}
  }
  
@@ -8,7 +8,7 @@
  static int btmrvl_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1177,6 +1178,7 @@ static const struct dev_pm_ops btmrvl_sd
+@@ -1178,6 +1179,7 @@ static const struct dev_pm_ops btmrvl_sd
  	.suspend	= btmrvl_sdio_suspend,
  	.resume		= btmrvl_sdio_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct sdio_driver bt_mrvl_sdio = {
  	.name		= "btmrvl_sdio",
-@@ -1185,7 +1187,9 @@ static struct sdio_driver bt_mrvl_sdio =
+@@ -1186,7 +1188,9 @@ static struct sdio_driver bt_mrvl_sdio =
  	.remove		= btmrvl_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index d8759fe..04e1cac 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1152,6 +1152,10 @@ static void __exit ieee80211_exit(void)
+@@ -1151,6 +1151,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 8ff76ba..f57cd4e 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5660,7 +5660,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5668,7 +5668,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index ec79e39..b9fe51b 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2156,16 +2156,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2161,16 +2161,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index 5a05393..de1e0d7 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -366,8 +366,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -285,8 +285,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 495ed1c..9a2c9e3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1620,7 +1620,9 @@ static struct usb_driver btusb_driver =
+@@ -1623,7 +1623,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index 5a22620..148925e 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -734,7 +734,9 @@ static struct usb_driver cdc_driver = {
+@@ -740,7 +740,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
index 8d61b4f..f57befe 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath6kl/usb.c
 +++ b/drivers/net/wireless/ath/ath6kl/usb.c
-@@ -1207,7 +1207,9 @@ static struct usb_driver ath6kl_usb_driv
+@@ -1225,7 +1225,9 @@ static struct usb_driver ath6kl_usb_driv
  	.disconnect = ath6kl_usb_remove,
  	.id_table = ath6kl_usb_ids,
  	.supports_autosuspend = true,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
index aa2ffed..b68f6ea 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1498,7 +1498,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1506,7 +1506,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
  	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
index 5272011..d9b1d71 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1758,7 +1758,9 @@ static struct usb_driver orinoco_driver
+@@ -1759,7 +1759,9 @@ static struct usb_driver orinoco_driver
  	.probe = ezusb_probe,
  	.disconnect = ezusb_disconnect,
  	.id_table = ezusb_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
index af9ee0b..d9b1dcc 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2500usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2500usb.c
-@@ -1990,7 +1990,9 @@ static struct usb_driver rt2500usb_drive
+@@ -1998,7 +1998,9 @@ static struct usb_driver rt2500usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index 30b9506..9e3e77b 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1375,7 +1375,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1350,7 +1350,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
index 6e145fd..dc6b99c 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt73usb.c
 +++ b/drivers/net/wireless/rt2x00/rt73usb.c
-@@ -2536,7 +2536,9 @@ static struct usb_driver rt73usb_driver
+@@ -2547,7 +2547,9 @@ static struct usb_driver rt73usb_driver
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
index aef5ffa..fcc1a97 100644
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
+++ b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/d3.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/d3.c
-@@ -101,7 +101,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
+@@ -102,7 +102,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
  	int idx = 0;
  
  	read_lock_bh(&idev->lock);
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index d351716..093b17a 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7740,7 +7740,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7775,7 +7775,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
index cee65ee..16cbf8e 100644
--- a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
@@ -1,6 +1,6 @@
 --- a/net/nfc/netlink.c
 +++ b/net/nfc/netlink.c
-@@ -68,7 +68,7 @@ static int nfc_genl_send_target(struct s
+@@ -70,7 +70,7 @@ static int nfc_genl_send_target(struct s
  {
  	void *hdr;
  
@@ -9,7 +9,7 @@
  			  &nfc_genl_family, flags, NFC_CMD_GET_TARGET);
  	if (!hdr)
  		return -EMSGSIZE;
-@@ -481,7 +481,7 @@ static int nfc_genl_dump_devices(struct
+@@ -545,7 +545,7 @@ static int nfc_genl_dump_devices(struct
  	while (dev) {
  		int rc;
  
@@ -18,7 +18,7 @@
  					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
  		if (rc < 0)
  			break;
-@@ -600,7 +600,7 @@ static int nfc_genl_get_device(struct sk
+@@ -664,7 +664,7 @@ static int nfc_genl_get_device(struct sk
  		goto out_putdev;
  	}
  
@@ -27,7 +27,7 @@
  				  NULL, 0);
  	if (rc < 0)
  		goto out_free;
-@@ -691,7 +691,7 @@ static int nfc_genl_start_poll(struct sk
+@@ -755,7 +755,7 @@ static int nfc_genl_start_poll(struct sk
  
  	rc = nfc_start_poll(dev, im_protocols, tm_protocols);
  	if (!rc)
@@ -36,7 +36,7 @@
  
  	mutex_unlock(&dev->genl_data.genl_data_mutex);
  
-@@ -725,7 +725,7 @@ static int nfc_genl_stop_poll(struct sk_
+@@ -789,7 +789,7 @@ static int nfc_genl_stop_poll(struct sk_
  
  	mutex_lock(&dev->genl_data.genl_data_mutex);
  
@@ -45,7 +45,7 @@
  		rc = -EBUSY;
  		goto out;
  	}
-@@ -851,7 +851,7 @@ static int nfc_genl_llc_get_params(struc
+@@ -915,7 +915,7 @@ static int nfc_genl_llc_get_params(struc
  		goto exit;
  	}
  
@@ -54,7 +54,7 @@
  
  exit:
  	device_unlock(&dev->dev);
-@@ -1134,12 +1134,12 @@ static int nfc_genl_rcv_nl_event(struct
+@@ -1315,12 +1315,12 @@ static int nfc_genl_rcv_nl_event(struct
  	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
  		goto out;
  
-- 
1.7.10.4

