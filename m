Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44266 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971Ab3GKWNP (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:13:15 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/19] backports: refresh patches on v3.10
Date: Fri, 12 Jul 2013 00:11:42 +0200
Message-Id: <1373580702-24752-21-git-send-email-hauke@hauke-m.de> (sfid-20130712_001326_574978_7FD0A00F)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
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
17  3.0.85              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.0              [  OK  ]
20  3.2.48              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.52              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.9               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_radeon_radeon_bios.patch       |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +--
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   54 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../drivers_net_wireless_b43_main.patch            |    6 +--
 .../net_wireless_core.patch                        |    2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../drivers_net_wireless_mwifiex_debugfs.patch     |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +--
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 ...drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 24 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index c1bf49f..fd7a981 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1294,10 +1294,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1291,10 +1291,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 722f39f..be24455 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4011,9 +4011,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4006,9 +4006,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 7176300..389e405 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1618,7 +1618,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1615,7 +1615,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
index bf04724..29c2bb8 100644
--- a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
+++ b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/radeon/radeon_bios.c
 +++ b/drivers/gpu/drm/radeon/radeon_bios.c
-@@ -577,12 +577,21 @@ static bool radeon_acpi_vfct_bios(struct
+@@ -581,12 +581,21 @@ static bool radeon_acpi_vfct_bios(struct
  {
  	bool ret = false;
  	struct acpi_table_header *hdr;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index 04c9132..56424df 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1069,7 +1069,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1080,7 +1080,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1232,7 +1232,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1243,7 +1243,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1270,7 +1270,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1281,7 +1281,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 74f2c8e..9780e99 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -6,6 +6,6 @@
  {
 -	dev->netdev_ops = &mwifiex_netdev_ops;
 +	netdev_attach_ops(dev, &mwifiex_netdev_ops);
+ 	dev->destructor = free_netdev;
  	/* Initialize private structure */
  	priv->current_key_index = 0;
- 	priv->media_connected = false;
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 83749a5..610175c 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1565,6 +1565,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1586,6 +1586,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1573,6 +1574,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1594,6 +1595,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 89c6213..b932ad9 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1604,7 +1604,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1611,7 +1611,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI,
  						 split, &cb->args[1],
-@@ -1653,7 +1653,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1660,7 +1660,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       false, NULL, NULL, NULL) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2233,7 +2233,7 @@ static int nl80211_dump_interface(struct
+@@ -2240,7 +2240,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -2264,7 +2264,7 @@ static int nl80211_get_interface(struct
+@@ -2271,7 +2271,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2489,7 +2489,7 @@ static int nl80211_new_interface(struct
+@@ -2496,7 +2496,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2624,7 +2624,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2631,7 +2631,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3565,7 +3565,7 @@ static int nl80211_dump_station(struct s
+@@ -3572,7 +3572,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3611,7 +3611,7 @@ static int nl80211_get_station(struct sk
+@@ -3618,7 +3618,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4211,7 +4211,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4218,7 +4218,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4260,7 +4260,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4267,7 +4267,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4524,7 +4524,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4531,7 +4531,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4874,7 +4874,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4881,7 +4881,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5574,7 +5574,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5581,7 +5581,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5810,7 +5810,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5817,7 +5817,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6468,7 +6468,7 @@ static int nl80211_testmode_dump(struct
+@@ -6475,7 +6475,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6547,7 +6547,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6554,7 +6554,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6907,7 +6907,7 @@ static int nl80211_remain_on_channel(str
+@@ -6914,7 +6914,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7126,7 +7126,7 @@ static int nl80211_register_mgmt(struct
+@@ -7133,7 +7133,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7196,7 +7196,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7203,7 +7203,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7311,7 +7311,7 @@ static int nl80211_get_power_save(struct
+@@ -7318,7 +7318,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7603,7 +7603,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7612,7 +7612,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8027,7 +8027,7 @@ static int nl80211_register_unexpected_f
+@@ -8036,7 +8036,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8057,7 +8057,7 @@ static int nl80211_probe_client(struct s
+@@ -8066,7 +8066,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8101,13 +8101,13 @@ static int nl80211_register_beacons(stru
+@@ -8110,13 +8110,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8182,7 +8182,7 @@ static int nl80211_get_protocol_features
+@@ -8191,7 +8191,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8257,7 +8257,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8266,7 +8266,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10661,12 +10661,12 @@ static int nl80211_netlink_notify(struct
+@@ -10672,12 +10672,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index fa73e2a..e19168a 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1611,6 +1611,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1618,6 +1618,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 &cb->args[2],
  						 &cb->args[3]);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1631,6 +1632,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1638,6 +1639,7 @@ static int nl80211_dump_wiphy(struct sk_
  					mutex_unlock(&cfg80211_mutex);
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index c2a4344..aaa0aa0 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4243,8 +4243,13 @@ redo:
+@@ -4236,8 +4236,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4290,9 +4295,17 @@ static int b43_wireless_core_start(struc
+@@ -4283,9 +4288,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5115,6 +5128,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5108,6 +5121,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 744952f..80a75a4 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -941,6 +937,15 @@ static int cfg80211_netdev_notifier_call
+@@ -944,6 +940,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index 79805b0..ff98dd5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6801,7 +6801,12 @@ static struct pci_driver il4965_driver =
+@@ -6800,7 +6800,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
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
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 7a4404d..16e905f 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1690,6 +1690,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1711,6 +1711,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1717,6 +1718,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1747,6 +1748,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
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
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 895287e..3fc956a 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -770,8 +770,13 @@ static void ieee80211_do_stop(struct iee
+@@ -781,8 +781,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -979,10 +984,20 @@ static void ieee80211_set_multicast_list
+@@ -990,10 +995,20 @@ static void ieee80211_set_multicast_list
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
index 434b59c..0255fc7 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2309,7 +2309,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2316,7 +2316,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 5da8151..9d32a62 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5685,7 +5685,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5692,7 +5692,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index f37f09e..1e33058 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2202,16 +2202,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2211,16 +2211,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 0c0e7e7..43c2163 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3456,11 +3456,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3449,11 +3449,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
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
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
index fd1467d..28b2173 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -384,7 +384,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -385,7 +385,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 608f2a2..ba0434b 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7746,7 +7746,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7755,7 +7755,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
-- 
1.7.10.4

