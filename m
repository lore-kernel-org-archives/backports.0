Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39727 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab3FFNXm (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 6 Jun 2013 09:23:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refersh patches on next-20130606
Date: Thu,  6 Jun 2013 15:23:23 +0200
Message-Id: <1370525003-30531-3-git-send-email-hauke@hauke-m.de> (sfid-20130606_152345_859663_1A7CAFE5)
In-Reply-To: <1370525003-30531-1-git-send-email-hauke@hauke-m.de>
References: <1370525003-30531-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There was a manual adjustment needed in
patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch

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
 .../drivers_gpu_drm_i915_intel_fb.patch            |    2 +-
 .../drivers_gpu_drm_drm_bufs.patch                 |    4 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +--
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   46 ++++++++++----------
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_mwifiex_debugfs.patch     |    2 +-
 .../net_mac80211_driver-ops.patch                  |    4 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +--
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 23 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch b/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
index cdc08ba..c0fab51 100644
--- a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
+++ b/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/intel_fb.c
 +++ b/drivers/gpu/drm/i915/intel_fb.c
-@@ -151,7 +151,7 @@ static int intelfb_create(struct drm_fb_
+@@ -152,7 +152,7 @@ static int intelfb_create(struct drm_fb_
  	info->screen_size = size;
  
  	/* This driver doesn't need a VT switch to restore the mode on resume */
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
index ba7b019..5626d43 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/drm_bufs.c
 +++ b/drivers/gpu/drm/drm_bufs.c
-@@ -1541,6 +1541,20 @@ int drm_mapbufs(struct drm_device *dev,
+@@ -1551,6 +1551,20 @@ int drm_mapbufs(struct drm_device *dev,
  				retcode = -EINVAL;
  				goto done;
  			}
@@ -21,7 +21,7 @@
  			virtual = vm_mmap(file_priv->filp, 0, map->size,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED,
-@@ -1549,6 +1563,7 @@ int drm_mapbufs(struct drm_device *dev,
+@@ -1559,6 +1573,7 @@ int drm_mapbufs(struct drm_device *dev,
  			virtual = vm_mmap(file_priv->filp, 0, dma->byte_count,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED, 0);
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index c1bf49f..1aeda52 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1294,10 +1294,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1296,10 +1296,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 092014e..23b8990 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4051,9 +4051,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4065,9 +4065,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 7176300..fe2b832 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1618,7 +1618,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1620,7 +1620,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index 56424df..ae58ebb 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1080,7 +1080,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1097,7 +1097,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1243,7 +1243,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1260,7 +1260,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1281,7 +1281,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1298,7 +1298,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 610175c..036f5c3 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1586,6 +1586,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1603,6 +1603,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1594,6 +1595,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1611,6 +1612,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 788ae61..71cf119 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2435,7 +2435,7 @@ static int nl80211_new_interface(struct
+@@ -2445,7 +2445,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2570,7 +2570,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2580,7 +2580,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3542,7 +3542,7 @@ static int nl80211_dump_station(struct s
+@@ -3552,7 +3552,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3588,7 +3588,7 @@ static int nl80211_get_station(struct sk
+@@ -3598,7 +3598,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4194,7 +4194,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4204,7 +4204,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4243,7 +4243,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4253,7 +4253,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4507,7 +4507,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4517,7 +4517,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4860,7 +4860,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4870,7 +4870,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5539,7 +5539,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5549,7 +5549,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5775,7 +5775,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5785,7 +5785,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6442,7 +6442,7 @@ static int nl80211_testmode_dump(struct
+@@ -6452,7 +6452,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6521,7 +6521,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6531,7 +6531,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6887,7 +6887,7 @@ static int nl80211_remain_on_channel(str
+@@ -6897,7 +6897,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7106,7 +7106,7 @@ static int nl80211_register_mgmt(struct
+@@ -7116,7 +7116,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7176,7 +7176,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7186,7 +7186,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7291,7 +7291,7 @@ static int nl80211_get_power_save(struct
+@@ -7301,7 +7301,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7586,7 +7586,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7596,7 +7596,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8012,7 +8012,7 @@ static int nl80211_register_unexpected_f
+@@ -8022,7 +8022,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8042,7 +8042,7 @@ static int nl80211_probe_client(struct s
+@@ -8052,7 +8052,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8086,13 +8086,13 @@ static int nl80211_register_beacons(stru
+@@ -8096,13 +8096,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8159,7 +8159,7 @@ static int nl80211_get_protocol_features
+@@ -8169,7 +8169,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8234,7 +8234,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8244,7 +8244,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10633,12 +10633,12 @@ static int nl80211_netlink_notify(struct
+@@ -10643,12 +10643,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 9159fd6..01bad15 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2607,6 +2607,9 @@ struct wiphy_wowlan_support {
+@@ -2609,6 +2609,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index c46544d..eda4d00 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -23,7 +23,7 @@
 @@ -1833,7 +1833,14 @@ __le32 il_add_beacon_time(struct il_priv
  			  u32 beacon_interval);
  
- #ifdef CONFIG_PM
+ #ifdef CONFIG_PM_SLEEP
 +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29))
 +int il_pci_suspend_compat(struct pci_dev *pdev, pm_message_t state);
 +int il_pci_resume_compat(struct pci_dev *pdev);
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 11533d7..73d8d92 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1977,6 +1977,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1978,6 +1978,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2005,6 +2006,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2006,6 +2007,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index c2aa04d..17e2bea 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1711,6 +1711,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1728,6 +1728,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1747,6 +1748,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1764,6 +1765,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 01102c2..8ff53fc 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1454,6 +1454,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1455,6 +1455,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
index 0dca0d2..6add185 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/debugfs.c
 +++ b/drivers/net/wireless/mwifiex/debugfs.c
-@@ -215,7 +215,11 @@ mwifiex_info_read(struct file *file, cha
+@@ -227,7 +227,11 @@ mwifiex_info_read(struct file *file, cha
  
  		netdev_for_each_mc_addr(ha, netdev)
  			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
index 97dff3f..042cca7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -227,20 +227,35 @@ static inline void drv_bss_info_changed(
+@@ -228,20 +228,35 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -36,7 +36,7 @@
  static inline void drv_set_multicast_list(struct ieee80211_local *local,
  					  struct ieee80211_sub_if_data *sdata,
  					  struct netdev_hw_addr_list *mc_list)
-@@ -256,6 +271,23 @@ static inline void drv_set_multicast_lis
+@@ -257,6 +272,23 @@ static inline void drv_set_multicast_lis
  					       allmulti, mc_list);
  	trace_drv_return_void(local);
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 3fc956a..dc3d97a 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -781,8 +781,13 @@ static void ieee80211_do_stop(struct iee
+@@ -794,8 +794,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -990,10 +995,20 @@ static void ieee80211_set_multicast_list
+@@ -1007,10 +1012,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
index 67ab72a..44bcd4f 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btmrvl_sdio.c
 +++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1055,6 +1055,7 @@ static void btmrvl_sdio_remove(struct sd
+@@ -1082,6 +1082,7 @@ static void btmrvl_sdio_remove(struct sd
  	}
  }
  
@@ -8,7 +8,7 @@
  static int btmrvl_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1150,6 +1151,7 @@ static const struct dev_pm_ops btmrvl_sd
+@@ -1177,6 +1178,7 @@ static const struct dev_pm_ops btmrvl_sd
  	.suspend	= btmrvl_sdio_suspend,
  	.resume		= btmrvl_sdio_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct sdio_driver bt_mrvl_sdio = {
  	.name		= "btmrvl_sdio",
-@@ -1158,7 +1160,9 @@ static struct sdio_driver bt_mrvl_sdio =
+@@ -1185,7 +1187,9 @@ static struct sdio_driver bt_mrvl_sdio =
  	.remove		= btmrvl_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 8f66c74..95f8cf3 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2257,7 +2257,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2258,7 +2258,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 5c0b100..8ff76ba 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5650,7 +5650,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5660,7 +5660,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index cfa4e87..ec79e39 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2152,16 +2152,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2156,16 +2156,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
index b68f6ea..aa2ffed 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1506,7 +1506,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1498,7 +1498,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
  	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 38f6340..d351716 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7730,7 +7730,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7740,7 +7740,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index e2b1afe..0688cea 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1162,7 +1162,11 @@ static const struct file_operations fops
+@@ -1209,7 +1209,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

