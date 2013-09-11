Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40718 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3IKMM0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] backports: refresh patches for next-20130802
Date: Wed, 11 Sep 2013 14:11:49 +0200
Message-Id: <1378901515-14206-6-git-send-email-hauke@hauke-m.de> (sfid-20130911_141228_724192_970CAC97)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
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
16  3.0.89              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.5              [  OK  ]
19  3.11-rc4            [  OK  ]
20  3.2.50              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.56              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   22 ++++----
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   56 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../drivers_net_wireless_ath_ath9k_pci.patch       |    4 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 13 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index ec1b046..eca5804 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1652,7 +1652,11 @@ int i915_driver_load(struct drm_device *
+@@ -1648,7 +1648,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -12,7 +12,7 @@
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1686,7 +1690,11 @@ int i915_driver_unload(struct drm_device
+@@ -1682,7 +1686,11 @@ int i915_driver_unload(struct drm_device
  
  	i915_teardown_sysfs(dev);
  
@@ -26,7 +26,7 @@
  	mutex_lock(&dev->struct_mutex);
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -54,10 +54,15 @@ static void i915_gem_object_update_fence
+@@ -56,10 +56,15 @@ static void i915_gem_object_update_fence
  					 struct drm_i915_fence_reg *fence,
  					 bool enable);
  
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4394,8 +4399,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4464,8 +4469,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4618,8 +4627,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4688,8 +4697,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,8 +70,8 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4629,7 +4644,12 @@ i915_gem_inactive_count(struct shrinker
- 	struct i915_address_space *vm = &dev_priv->gtt.base;
+@@ -4698,7 +4713,12 @@ i915_gem_inactive_count(struct shrinker
+ 	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4641,6 +4661,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4710,6 +4730,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,15 +101,15 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4654,6 +4685,7 @@ i915_gem_inactive_count(struct shrinker
- 	return count;
+@@ -4800,6 +4831,7 @@ struct i915_vma *i915_gem_obj_to_vma(str
+ 	return NULL;
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4687,3 +4719,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4833,3 +4865,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
index 400b065..51f470d 100644
--- a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem_gtt.c
 +++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
-@@ -859,6 +859,9 @@ static int i915_gmch_probe(struct drm_de
+@@ -872,6 +872,9 @@ static int i915_gmch_probe(struct drm_de
  {
  	struct drm_i915_private *dev_priv = dev->dev_private;
  	int ret;
@@ -10,7 +10,7 @@
  
  	ret = intel_gmch_probe(dev_priv->bridge_dev, dev_priv->dev->pdev, NULL);
  	if (!ret) {
-@@ -866,7 +869,16 @@ static int i915_gmch_probe(struct drm_de
+@@ -879,7 +882,16 @@ static int i915_gmch_probe(struct drm_de
  		return -EIO;
  	}
  
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index dc8b9b1..b78e595 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1628,7 +1628,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1630,7 +1630,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
-@@ -1681,7 +1681,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1683,7 +1683,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       &state) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2256,7 +2256,7 @@ static int nl80211_dump_interface(struct
+@@ -2258,7 +2258,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				goto out;
-@@ -2285,7 +2285,7 @@ static int nl80211_get_interface(struct
+@@ -2287,7 +2287,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2518,7 +2518,7 @@ static int nl80211_new_interface(struct
+@@ -2520,7 +2520,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2653,7 +2653,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2655,7 +2655,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3622,7 +3622,7 @@ static int nl80211_dump_station(struct s
+@@ -3624,7 +3624,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3668,7 +3668,7 @@ static int nl80211_get_station(struct sk
+@@ -3670,7 +3670,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4276,7 +4276,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4278,7 +4278,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4325,7 +4325,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4327,7 +4327,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4589,7 +4589,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4591,7 +4591,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4948,7 +4948,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4950,7 +4950,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5627,7 +5627,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5629,7 +5629,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5864,7 +5864,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5866,7 +5866,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6551,7 +6551,7 @@ static int nl80211_testmode_dump(struct
+@@ -6553,7 +6553,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6630,7 +6630,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6632,7 +6632,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6998,7 +6998,7 @@ static int nl80211_remain_on_channel(str
+@@ -7000,7 +7000,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7217,7 +7217,7 @@ static int nl80211_register_mgmt(struct
+@@ -7219,7 +7219,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7298,7 +7298,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7300,7 +7300,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7413,7 +7413,7 @@ static int nl80211_get_power_save(struct
+@@ -7415,7 +7415,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7723,7 +7723,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7725,7 +7725,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8152,7 +8152,7 @@ static int nl80211_get_coalesce(struct s
+@@ -8154,7 +8154,7 @@ static int nl80211_get_coalesce(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -198,7 +198,7 @@
  			     NL80211_CMD_GET_COALESCE);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8405,7 +8405,7 @@ static int nl80211_register_unexpected_f
+@@ -8407,7 +8407,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -207,7 +207,7 @@
  	return 0;
  }
  
-@@ -8435,7 +8435,7 @@ static int nl80211_probe_client(struct s
+@@ -8437,7 +8437,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -216,7 +216,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8479,13 +8479,13 @@ static int nl80211_register_beacons(stru
+@@ -8481,13 +8481,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -232,7 +232,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8552,7 +8552,7 @@ static int nl80211_get_protocol_features
+@@ -8554,7 +8554,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -241,7 +241,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8627,7 +8627,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8629,7 +8629,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -11018,12 +11018,12 @@ static int nl80211_netlink_notify(struct
+@@ -11020,12 +11020,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 5141592..bffc763 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1632,6 +1632,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1634,6 +1634,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1652,6 +1653,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1654,6 +1655,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 8468d96..060789f 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1587,9 +1596,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1514,9 +1523,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 7b3aa4e..d89c441 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -837,6 +833,15 @@ static int cfg80211_netdev_notifier_call
+@@ -838,6 +834,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index edc345c..1344605 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -411,6 +411,9 @@ static int ath_pci_resume(struct device
+@@ -491,6 +491,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -429,7 +432,12 @@ static struct pci_driver ath_pci_driver
+@@ -509,7 +512,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index 3220c3f..33cfa04 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4935,8 +4935,17 @@ il_pci_resume(struct device *device)
+@@ -4936,8 +4936,17 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index b4fa41b..66e9bb7 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2331,7 +2331,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2333,7 +2333,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 0ae1e69..7e4bd67 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5739,7 +5739,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5741,7 +5741,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
index fcc1a97..11c2ed8 100644
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
+++ b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
@@ -11,4 +11,4 @@
 +#endif
  		mvmvif->target_ipv6_addrs[idx] = ifa->addr;
  		idx++;
- 		if (idx >= IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS)
+ 		if (idx >= IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_MAX)
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index f8f9809..78e6ff0 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7867,7 +7867,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7869,7 +7869,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index c72b054..0a58e45 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1328,7 +1328,11 @@ static const struct file_operations fops
+@@ -1330,7 +1330,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

