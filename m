Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40747 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3IKMMl (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:41 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] backports: refresh patches for next-20130816
Date: Wed, 11 Sep 2013 14:11:55 +0200
Message-Id: <1378901515-14206-12-git-send-email-hauke@hauke-m.de> (sfid-20130911_141831_096765_F0F960F2)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
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
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   20 +++---
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |    4 +-
 .../network/0001-netdev_ops/ath6kl.patch           |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   72 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    6 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_ath_ath6kl_main.patch     |    6 +-
 ...net_wireless_brcm80211_brcmfmac_dhd_linux.patch |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    4 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_ath6kl_main.patch     |    8 +--
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../drivers_usb_class_cdc-wdm.patch                |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 29 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index eca5804..aefc83f 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1648,7 +1648,11 @@ int i915_driver_load(struct drm_device *
+@@ -1659,7 +1659,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -12,7 +12,7 @@
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1682,7 +1686,11 @@ int i915_driver_unload(struct drm_device
+@@ -1698,7 +1702,11 @@ int i915_driver_unload(struct drm_device
  
  	i915_teardown_sysfs(dev);
  
@@ -26,7 +26,7 @@
  	mutex_lock(&dev->struct_mutex);
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -56,10 +56,15 @@ static void i915_gem_object_update_fence
+@@ -57,10 +57,15 @@ static void i915_gem_object_update_fence
  					 struct drm_i915_fence_reg *fence,
  					 bool enable);
  
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4464,8 +4469,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4554,8 +4559,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4688,8 +4697,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4778,8 +4787,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4698,7 +4713,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4788,7 +4803,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4710,6 +4730,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4800,6 +4820,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,15 +101,15 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4800,6 +4831,7 @@ struct i915_vma *i915_gem_obj_to_vma(str
- 	return NULL;
+@@ -4879,6 +4910,7 @@ unsigned long i915_gem_obj_size(struct d
+ 	return 0;
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4833,3 +4865,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4912,3 +4944,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
index 51f470d..9a3074f 100644
--- a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem_gtt.c
 +++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
-@@ -872,6 +872,9 @@ static int i915_gmch_probe(struct drm_de
+@@ -881,6 +881,9 @@ static int i915_gmch_probe(struct drm_de
  {
  	struct drm_i915_private *dev_priv = dev->dev_private;
  	int ret;
@@ -10,7 +10,7 @@
  
  	ret = intel_gmch_probe(dev_priv->bridge_dev, dev_priv->dev->pdev, NULL);
  	if (!ret) {
-@@ -879,7 +882,16 @@ static int i915_gmch_probe(struct drm_de
+@@ -888,7 +891,16 @@ static int i915_gmch_probe(struct drm_de
  		return -EIO;
  	}
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch b/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
index fe710da..0057c41 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1289,7 +1289,7 @@ static const struct net_device_ops ath6k
+@@ -1292,7 +1292,7 @@ static const struct net_device_ops ath6k
  
  void init_netdev(struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index ae58ebb..a4894ab 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1097,7 +1097,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1105,7 +1105,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1260,7 +1260,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1268,7 +1268,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1298,7 +1298,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1307,7 +1307,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index 00d08bf..e0d6bd4 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1575,7 +1575,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1613,7 +1613,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 036f5c3..0e534e8 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1603,6 +1603,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1612,6 +1612,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1611,6 +1612,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1620,6 +1621,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index b78e595..26ddf9f 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1630,7 +1630,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1637,7 +1637,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
-@@ -1683,7 +1683,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1690,7 +1690,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       &state) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2258,7 +2258,7 @@ static int nl80211_dump_interface(struct
+@@ -2265,7 +2265,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				goto out;
-@@ -2287,7 +2287,7 @@ static int nl80211_get_interface(struct
+@@ -2294,7 +2294,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2520,7 +2520,7 @@ static int nl80211_new_interface(struct
+@@ -2527,7 +2527,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,16 +45,16 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2655,7 +2655,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2662,7 +2662,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
 -	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
 +	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
  			     NL80211_CMD_NEW_KEY);
- 	if (IS_ERR(hdr))
- 		return PTR_ERR(hdr);
-@@ -3624,7 +3624,7 @@ static int nl80211_dump_station(struct s
+ 	if (!hdr)
+ 		return -ENOBUFS;
+@@ -3631,7 +3631,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3670,7 +3670,7 @@ static int nl80211_get_station(struct sk
+@@ -3677,7 +3677,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4278,7 +4278,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4285,7 +4285,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4327,7 +4327,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4334,7 +4334,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4591,7 +4591,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4598,7 +4598,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4950,7 +4950,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4957,7 +4957,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5629,7 +5629,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5741,7 +5741,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5866,7 +5866,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5978,7 +5978,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6553,7 +6553,7 @@ static int nl80211_testmode_dump(struct
+@@ -6665,7 +6665,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6632,7 +6632,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6747,7 +6747,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,16 +144,16 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -7000,7 +7000,7 @@ static int nl80211_remain_on_channel(str
+@@ -7115,7 +7115,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
 -	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
 +	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
- 
- 	if (IS_ERR(hdr)) {
-@@ -7219,7 +7219,7 @@ static int nl80211_register_mgmt(struct
+ 	if (!hdr) {
+ 		err = -ENOBUFS;
+@@ -7333,7 +7333,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,16 +162,16 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7300,7 +7300,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7414,7 +7414,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
 -		hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
 +		hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
  				     NL80211_CMD_FRAME);
- 
- 		if (IS_ERR(hdr)) {
-@@ -7415,7 +7415,7 @@ static int nl80211_get_power_save(struct
+ 		if (!hdr) {
+ 			err = -ENOBUFS;
+@@ -7528,7 +7528,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7725,7 +7725,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7838,7 +7838,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8154,7 +8154,7 @@ static int nl80211_get_coalesce(struct s
+@@ -8267,7 +8267,7 @@ static int nl80211_get_coalesce(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -198,7 +198,7 @@
  			     NL80211_CMD_GET_COALESCE);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8407,7 +8407,7 @@ static int nl80211_register_unexpected_f
+@@ -8520,7 +8520,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -207,16 +207,16 @@
  	return 0;
  }
  
-@@ -8437,7 +8437,7 @@ static int nl80211_probe_client(struct s
+@@ -8550,7 +8550,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
 -	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
 +	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
  			     NL80211_CMD_PROBE_CLIENT);
- 
- 	if (IS_ERR(hdr)) {
-@@ -8481,13 +8481,13 @@ static int nl80211_register_beacons(stru
+ 	if (!hdr) {
+ 		err = -ENOBUFS;
+@@ -8593,13 +8593,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -232,7 +232,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8554,7 +8554,7 @@ static int nl80211_get_protocol_features
+@@ -8666,7 +8666,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -241,7 +241,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8629,7 +8629,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8741,7 +8741,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -11020,12 +11020,12 @@ static int nl80211_netlink_notify(struct
+@@ -11140,12 +11140,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index bffc763..a5d34eb 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1634,6 +1634,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1641,6 +1641,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1654,6 +1655,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1661,6 +1662,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
index e6b963e..806b54d 100644
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1381,7 +1381,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1365,7 +1365,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 6bbfedf..e8cc868 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2735,6 +2735,9 @@ struct wiphy_coalesce_support {
+@@ -2768,6 +2768,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 060789f..7193f16 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1514,9 +1523,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1491,9 +1500,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 8d83bbe..e580365 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -398,6 +398,9 @@ static int iwl_pci_resume(struct device
- 	return iwl_trans_resume(iwl_trans);
+@@ -404,6 +404,9 @@ static int iwl_pci_resume(struct device
+ 	return 0;
  }
  
 +compat_pci_suspend(iwl_pci_suspend)
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -413,7 +416,12 @@ static struct pci_driver iwl_pci_driver
+@@ -419,7 +422,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index c4ab559..70ea514 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1991,6 +1991,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1990,6 +1990,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2019,6 +2020,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2018,6 +2019,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 17e2bea..abe38a3 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1728,6 +1728,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1737,6 +1737,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1764,6 +1765,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1773,6 +1774,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index bd50a7a..565f0e2 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1474,6 +1474,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1473,6 +1473,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
index fecfbab..75e51fe 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1205,7 +1205,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1208,7 +1208,11 @@ static void ath6kl_set_multicast_list(st
  	list_for_each_entry_safe(mc_filter, tmp, &vif->mc_filter, list) {
  		found = false;
  		netdev_for_each_mc_addr(ha, ndev) {
@@ -12,7 +12,7 @@
  				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
  				found = true;
  				break;
-@@ -1239,7 +1243,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1242,7 +1246,11 @@ static void ath6kl_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		found = false;
  		list_for_each_entry(mc_filter, &vif->mc_filter, list) {
@@ -24,7 +24,7 @@
  				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
  				found = true;
  				break;
-@@ -1254,7 +1262,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1257,7 +1265,11 @@ static void ath6kl_set_multicast_list(st
  				goto out;
  			}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
index 57e4cc4..90a9936 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
-@@ -103,7 +103,11 @@ static void _brcmf_set_multicast_list(st
+@@ -116,7 +116,11 @@ static void _brcmf_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		if (!cnt)
  			break;
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index fc1af33..a3494e9 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2666,14 +2666,24 @@ struct ieee80211_ops {
+@@ -2681,14 +2681,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 204d0b4..3e32c54 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -957,7 +957,12 @@ struct ieee80211_local {
+@@ -964,7 +964,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index dc3d97a..840878c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -794,8 +794,13 @@ static void ieee80211_do_stop(struct iee
+@@ -800,8 +800,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1007,10 +1012,20 @@ static void ieee80211_set_multicast_list
+@@ -1015,10 +1020,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
index 3c6671c..3ed5e0e 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
@@ -18,7 +18,7 @@
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -406,7 +406,7 @@ static void brcmf_ops_sdio_remove(struct
+@@ -405,7 +405,7 @@ static void brcmf_ops_sdio_remove(struct
  	brcmf_dbg(SDIO, "Exit\n");
  }
  
@@ -27,7 +27,7 @@
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -456,7 +456,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -455,7 +455,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
  	.name = BRCMFMAC_SDIO_PDATA_NAME,
  	.id_table = brcmf_sdmmc_ids,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 66e9bb7..f38740d 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2333,7 +2333,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2340,7 +2340,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
index 50d057e..94e4c4a 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1116,6 +1116,7 @@ static struct net_device_stats *ath6kl_g
+@@ -1119,6 +1119,7 @@ static struct net_device_stats *ath6kl_g
  	return &vif->net_stats;
  }
  
@@ -8,7 +8,7 @@
  static int ath6kl_set_features(struct net_device *dev,
  			       netdev_features_t features)
  {
-@@ -1148,6 +1149,7 @@ static int ath6kl_set_features(struct ne
+@@ -1151,6 +1152,7 @@ static int ath6kl_set_features(struct ne
  
  	return err;
  }
@@ -16,7 +16,7 @@
  
  static void ath6kl_set_multicast_list(struct net_device *ndev)
  {
-@@ -1295,7 +1297,9 @@ static const struct net_device_ops ath6k
+@@ -1298,7 +1300,9 @@ static const struct net_device_ops ath6k
  	.ndo_stop               = ath6kl_close,
  	.ndo_start_xmit         = ath6kl_data_tx,
  	.ndo_get_stats          = ath6kl_get_stats,
@@ -26,7 +26,7 @@
  	.ndo_set_rx_mode	= ath6kl_set_multicast_list,
  };
  
-@@ -1312,7 +1316,11 @@ void init_netdev(struct net_device *dev)
+@@ -1315,7 +1319,11 @@ void init_netdev(struct net_device *dev)
  					WMI_MAX_TX_META_SZ +
  					ATH6KL_HTC_ALIGN_BYTES, 4);
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 7e4bd67..c32eb76 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5741,7 +5741,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5853,7 +5853,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
index ff16065..a25d021 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1384,7 +1384,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1368,7 +1368,9 @@ static struct usb_driver ath9k_hif_usb_d
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
index b68f6ea..5dcb5a3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1506,7 +1506,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1505,7 +1505,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
  	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
index eb7cb21..a75e993 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/usb/class/cdc-wdm.c
 +++ b/drivers/usb/class/cdc-wdm.c
-@@ -1060,7 +1060,9 @@ static struct usb_driver wdm_driver = {
+@@ -1065,7 +1065,9 @@ static struct usb_driver wdm_driver = {
  	.post_reset =	wdm_post_reset,
  	.id_table =	wdm_ids,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 78e6ff0..304ecfe 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7869,7 +7869,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7982,7 +7982,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index 0a58e45..d1b7d95 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1330,7 +1330,11 @@ static const struct file_operations fops
+@@ -1261,7 +1261,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

