Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57501 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab3EKSy4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 May 2013 14:54:56 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so3693023pab.17
        for <backports@vger.kernel.org>; Sat, 11 May 2013 11:54:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 5/5] backports: refresh patches for next-20130423
Date: Sat, 11 May 2013 11:54:29 -0700
Message-Id: <1368298469-29143-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205458_976098_5C4B76C5)
In-Reply-To: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m53.044s
user    815m38.362s
sys     127m50.187s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   62 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_mwl8k.patch               |   10 ++--
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_rt2x00_rt2500usb.patch    |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 21 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index d8b4169..04c9132 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1068,7 +1068,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1069,7 +1069,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1231,7 +1231,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1232,7 +1232,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1269,7 +1269,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1270,7 +1270,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
index f23c3e4..6eb68e7 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1707,7 +1707,7 @@ static const struct net_device_ops hwsim
+@@ -1739,7 +1739,7 @@ static const struct net_device_ops hwsim
  
  static void hwsim_mon_setup(struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 0d48e3c..83749a5 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1564,6 +1564,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1565,6 +1565,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1572,6 +1573,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1573,6 +1574,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
index 3910fd8..e7b9e16 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2031,10 +2031,10 @@ static int hwsim_register_received_nl(st
+@@ -2063,10 +2063,10 @@ static int hwsim_register_received_nl(st
  	if (info == NULL)
  		goto out;
  
@@ -13,7 +13,7 @@
  
  	return 0;
  out:
-@@ -2071,7 +2071,7 @@ static int mac80211_hwsim_netlink_notify
+@@ -2103,7 +2103,7 @@ static int mac80211_hwsim_netlink_notify
  	if (state != NETLINK_URELEASE)
  		return NOTIFY_DONE;
  
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index bde418d..89c6213 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1593,7 +1593,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1604,7 +1604,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI,
  						 split, &cb->args[1],
-@@ -1642,7 +1642,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1653,7 +1653,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       false, NULL, NULL, NULL) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2222,7 +2222,7 @@ static int nl80211_dump_interface(struct
+@@ -2233,7 +2233,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -2253,7 +2253,7 @@ static int nl80211_get_interface(struct
+@@ -2264,7 +2264,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2478,7 +2478,7 @@ static int nl80211_new_interface(struct
+@@ -2489,7 +2489,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2613,7 +2613,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2624,7 +2624,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,16 +54,16 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3549,7 +3549,7 @@ static int nl80211_dump_station(struct s
+@@ -3565,7 +3565,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
 -				NETLINK_CB(cb->skb).portid,
 +				NETLINK_CB_PORTID(cb->skb),
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				dev, netdev, mac_addr,
+ 				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3595,7 +3595,7 @@ static int nl80211_get_station(struct sk
+@@ -3611,7 +3611,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,16 +72,16 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4195,7 +4195,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4211,7 +4211,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
 -		if (nl80211_send_mpath(skb, NETLINK_CB(cb->skb).portid,
 +		if (nl80211_send_mpath(skb, NETLINK_CB_PORTID(cb->skb),
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				       netdev, dst, next_hop,
+ 				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4244,7 +4244,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4260,7 +4260,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4508,7 +4508,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4524,7 +4524,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4858,7 +4858,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4874,7 +4874,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5558,7 +5558,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5574,7 +5574,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,16 +117,16 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5789,7 +5789,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5810,7 +5810,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
 -				NETLINK_CB(cb->skb).portid,
 +				NETLINK_CB_PORTID(cb->skb),
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				netdev,
- 				&survey) < 0)
-@@ -6448,7 +6448,7 @@ static int nl80211_testmode_dump(struct
+ 				wdev->netdev, &survey) < 0)
+ 			goto out;
+@@ -6468,7 +6468,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6527,7 +6527,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6547,7 +6547,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6887,7 +6887,7 @@ static int nl80211_remain_on_channel(str
+@@ -6907,7 +6907,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7106,7 +7106,7 @@ static int nl80211_register_mgmt(struct
+@@ -7126,7 +7126,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7176,7 +7176,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7196,7 +7196,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7291,7 +7291,7 @@ static int nl80211_get_power_save(struct
+@@ -7311,7 +7311,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7583,7 +7583,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7603,7 +7603,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8007,7 +8007,7 @@ static int nl80211_register_unexpected_f
+@@ -8027,7 +8027,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8037,7 +8037,7 @@ static int nl80211_probe_client(struct s
+@@ -8057,7 +8057,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8081,13 +8081,13 @@ static int nl80211_register_beacons(stru
+@@ -8101,13 +8101,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8160,7 +8160,7 @@ static int nl80211_get_protocol_features
+@@ -8182,7 +8182,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8261,7 +8261,7 @@ static int nl80211_crit_protocol_start(struct sk_buff *skb,
+@@ -8257,7 +8257,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10565,12 +10565,12 @@ static int nl80211_netlink_notify(struct
+@@ -10661,12 +10661,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index ff7abf7..fa73e2a 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1600,6 +1600,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1611,6 +1611,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 &cb->args[2],
  						 &cb->args[3]);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1620,6 +1621,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1631,6 +1632,7 @@ static int nl80211_dump_wiphy(struct sk_
  					mutex_unlock(&cfg80211_mutex);
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 8ac85f7..9e9a8d0 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2565,6 +2565,9 @@ struct wiphy_wowlan_support {
+@@ -2577,6 +2577,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index 9073d05..79805b0 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6803,7 +6803,12 @@ static struct pci_driver il4965_driver =
+@@ -6801,7 +6801,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 5e92069..11533d7 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2035,6 +2035,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1977,6 +1977,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2063,6 +2064,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2005,6 +2006,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index c38ea75..7a4404d 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1689,6 +1689,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1690,6 +1690,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1716,6 +1717,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1717,6 +1718,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index a1f32e1..01102c2 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1512,6 +1512,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1454,6 +1454,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
index 6f36d72..c1d11c3 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2656,15 +2656,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2654,15 +2654,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -22,7 +22,7 @@
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2685,13 +2691,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2683,13 +2689,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -50,7 +50,7 @@
  		}
  	}
  
-@@ -5026,7 +5046,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5024,7 +5044,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -62,7 +62,7 @@
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5037,7 +5061,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5035,7 +5059,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -74,7 +74,7 @@
  
  	return (unsigned long)cmd;
  }
-@@ -5159,7 +5187,11 @@ static void mwl8k_configure_filter(struc
+@@ -5157,7 +5185,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index e2393b4..84337c7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2612,14 +2612,24 @@ struct ieee80211_ops {
+@@ -2647,14 +2647,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 629007d..b21841d 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -907,7 +907,12 @@ struct ieee80211_local {
+@@ -910,7 +910,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index e08b4d0..895287e 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -978,10 +983,20 @@ static void ieee80211_set_multicast_list
+@@ -979,10 +984,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 6570273..434b59c 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2298,7 +2298,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2309,7 +2309,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index 04e1cac..d8759fe 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1151,6 +1151,10 @@ static void __exit ieee80211_exit(void)
+@@ -1152,6 +1152,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index 47dc6ae..e8e6108 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -11,7 +11,7 @@
  	.ndo_do_ioctl		= atlx_ioctl,
  	.ndo_tx_timeout		= atlx_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3020,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3023,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
  	netdev->features |= NETIF_F_SG;
  	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index be71278..5da8151 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5669,7 +5669,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5685,7 +5685,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
index f2a644e..af9ee0b 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2500usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2500usb.c
-@@ -1989,7 +1989,9 @@ static struct usb_driver rt2500usb_drive
+@@ -1990,7 +1990,9 @@ static struct usb_driver rt2500usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 2a6c740..608f2a2 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7726,7 +7726,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7746,7 +7746,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
-- 
1.7.10.4

