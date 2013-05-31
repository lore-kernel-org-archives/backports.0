Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59714 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756761Ab3EaTP6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 May 2013 15:15:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh patches for next-20130531
Date: Fri, 31 May 2013 21:15:24 +0200
Message-Id: <1370027724-22627-3-git-send-email-hauke@hauke-m.de> (sfid-20130531_211610_215452_EA2404D5)
In-Reply-To: <1370027724-22627-1-git-send-email-hauke@hauke-m.de>
References: <1370027724-22627-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

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
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   60 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    6 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../net_wireless_core.patch                        |    6 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    6 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../32-remove-ns-type/net_wireless_sysfs.patch     |    8 +--
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 19 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index c81c602..092014e 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4042,9 +4042,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4051,9 +4051,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
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
index bb4062c..788ae61 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1604,7 +1604,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1565,7 +1565,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI,
  						 split, &cb->args[1],
-@@ -1653,7 +1653,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1613,7 +1613,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       false, NULL, NULL, NULL) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2233,7 +2233,7 @@ static int nl80211_dump_interface(struct
+@@ -2183,7 +2183,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -26,8 +26,8 @@
 +			if (nl80211_send_iface(skb, NETLINK_CB_PORTID(cb->skb),
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
- 				mutex_unlock(&rdev->devlist_mtx);
-@@ -2264,7 +2264,7 @@ static int nl80211_get_interface(struct
+ 				goto out;
+@@ -2212,7 +2212,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2489,7 +2489,7 @@ static int nl80211_new_interface(struct
+@@ -2435,7 +2435,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2624,7 +2624,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2570,7 +2570,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3565,7 +3565,7 @@ static int nl80211_dump_station(struct s
+@@ -3542,7 +3542,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3611,7 +3611,7 @@ static int nl80211_get_station(struct sk
+@@ -3588,7 +3588,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4211,7 +4211,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4194,7 +4194,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4260,7 +4260,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4243,7 +4243,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4524,7 +4524,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4507,7 +4507,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,16 +99,16 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4874,7 +4874,7 @@ static int nl80211_get_reg(struct sk_buf
- 		goto out;
- 	}
+@@ -4860,7 +4860,7 @@ static int nl80211_get_reg(struct sk_buf
+ 	if (!msg)
+ 		return -ENOBUFS;
  
 -	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
 +	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5574,7 +5574,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5539,7 +5539,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5810,7 +5810,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5775,7 +5775,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6468,7 +6468,7 @@ static int nl80211_testmode_dump(struct
+@@ -6442,7 +6442,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6547,7 +6547,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6521,7 +6521,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6907,7 +6907,7 @@ static int nl80211_remain_on_channel(str
+@@ -6887,7 +6887,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7126,7 +7126,7 @@ static int nl80211_register_mgmt(struct
+@@ -7106,7 +7106,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7196,7 +7196,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7176,7 +7176,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7311,7 +7311,7 @@ static int nl80211_get_power_save(struct
+@@ -7291,7 +7291,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7605,7 +7605,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7586,7 +7586,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8029,7 +8029,7 @@ static int nl80211_register_unexpected_f
+@@ -8012,7 +8012,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8059,7 +8059,7 @@ static int nl80211_probe_client(struct s
+@@ -8042,7 +8042,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8103,13 +8103,13 @@ static int nl80211_register_beacons(stru
+@@ -8086,13 +8086,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8184,7 +8184,7 @@ static int nl80211_get_protocol_features
+@@ -8159,7 +8159,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8259,7 +8259,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8234,7 +8234,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10665,12 +10665,12 @@ static int nl80211_netlink_notify(struct
+@@ -10633,12 +10633,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index fa73e2a..c3150fb 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1611,6 +1611,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1572,6 +1572,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 &cb->args[2],
  						 &cb->args[3]);
  			if (ret < 0) {
@@ -36,8 +36,8 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1631,6 +1632,7 @@ static int nl80211_dump_wiphy(struct sk_
- 					mutex_unlock(&cfg80211_mutex);
+@@ -1591,6 +1592,7 @@ static int nl80211_dump_wiphy(struct sk_
+ 					cb->min_dump_alloc = 4096;
  					return 1;
  				}
 +#endif
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 9e9a8d0..9159fd6 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2577,6 +2577,9 @@ struct wiphy_wowlan_support {
+@@ -2607,6 +2607,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
index db7ad0b..4f7b302 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -314,6 +314,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -275,6 +275,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 80a75a4..17220f2 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -371,10 +371,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -324,10 +324,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,9 +11,9 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -944,6 +940,15 @@ static int cfg80211_netdev_notifier_call
+@@ -829,6 +825,15 @@ static int cfg80211_netdev_notifier_call
+ 		wdev->netdev = dev;
  		wdev->sme_state = CFG80211_SME_IDLE;
- 		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
 +#ifdef CONFIG_WIRELESS_EXT
 +		if (!dev->wireless_handlers)
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 6ab1566..803a461 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -349,6 +349,9 @@ static int iwl_pci_resume(struct device
+@@ -393,6 +393,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -364,7 +367,12 @@ static struct pci_driver iwl_pci_driver
+@@ -408,7 +411,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 7a4404d..c2aa04d 100644
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
@@ -30,4 +30,4 @@
 +#endif
  
  static int netdev_notify(struct notifier_block *nb,
- 			 unsigned long state,
+ 			 unsigned long state, void *ptr)
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 84337c7..b9bc0fe 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2647,14 +2647,24 @@ struct ieee80211_ops {
+@@ -2657,14 +2657,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index b21841d..f9b7a1c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -910,7 +910,12 @@ struct ieee80211_local {
+@@ -925,7 +925,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
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
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 434b59c..8f66c74 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2309,7 +2309,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2257,7 +2257,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index 1b69dd1..7edc774 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -815,7 +815,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -834,7 +834,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
index 9f25775..e68fab0 100644
--- a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
+++ b/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
@@ -1,8 +1,8 @@
 --- a/net/wireless/sysfs.c
 +++ b/net/wireless/sysfs.c
-@@ -133,12 +133,14 @@ static int wiphy_resume(struct device *d
- 	return ret;
+@@ -135,12 +135,14 @@ static int wiphy_resume(struct device *d
  }
+ #endif
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  static const void *wiphy_namespace(struct device *d)
@@ -15,10 +15,10 @@
  
  struct class ieee80211_class = {
  	.name = "ieee80211",
-@@ -148,8 +150,10 @@ struct class ieee80211_class = {
- 	.dev_uevent = wiphy_uevent,
+@@ -152,8 +154,10 @@ struct class ieee80211_class = {
  	.suspend = wiphy_suspend,
  	.resume = wiphy_resume,
+ #endif
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	.ns_type = &net_ns_type_operations,
  	.namespace = wiphy_namespace,
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 5da8151..5c0b100 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5685,7 +5685,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5650,7 +5650,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
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
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index b3b8a09..38f6340 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7748,7 +7748,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7730,7 +7730,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
-- 
1.7.10.4

