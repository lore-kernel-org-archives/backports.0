Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60916 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab3HRXky (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:40:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 18/19] backports: refresh patches on next-20130802
Date: Mon, 19 Aug 2013 01:38:03 +0200
Message-Id: <1376869084-16513-19-git-send-email-hauke@hauke-m.de> (sfid-20130819_020908_886853_EE683DA5)
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
 .../network/0001-netdev_ops/atl1c.patch            |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../network/0005-netlink-portid/nl80211.patch      |   52 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../net_wireless_core.patch                        |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    4 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../25-multicast-list_head/net_mac80211_main.patch |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   12 ++---
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   14 +++---
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 29 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
index 5e0fb04..4ac2c5e 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2470,7 +2470,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2508,7 +2508,7 @@ static int atl1c_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 16e6051..2acfc59 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -759,7 +759,7 @@ static const struct net_device_ops mwifi
+@@ -806,7 +806,7 @@ static const struct net_device_ops mwifi
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
  
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 478c4e4..dc8b9b1 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1593,7 +1593,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1628,7 +1628,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
@@ -9,7 +9,7 @@
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
-@@ -1646,7 +1646,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1681,7 +1681,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -18,7 +18,7 @@
  			       &state) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2221,7 +2221,7 @@ static int nl80211_dump_interface(struct
+@@ -2256,7 +2256,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				goto out;
-@@ -2250,7 +2250,7 @@ static int nl80211_get_interface(struct
+@@ -2285,7 +2285,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2483,7 +2483,7 @@ static int nl80211_new_interface(struct
+@@ -2518,7 +2518,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2618,7 +2618,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2653,7 +2653,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3587,7 +3587,7 @@ static int nl80211_dump_station(struct s
+@@ -3622,7 +3622,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3633,7 +3633,7 @@ static int nl80211_get_station(struct sk
+@@ -3668,7 +3668,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4241,7 +4241,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4276,7 +4276,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4290,7 +4290,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4325,7 +4325,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4554,7 +4554,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4589,7 +4589,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4913,7 +4913,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4948,7 +4948,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5592,7 +5592,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5627,7 +5627,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5828,7 +5828,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5864,7 +5864,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6500,7 +6500,7 @@ static int nl80211_testmode_dump(struct
+@@ -6551,7 +6551,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6579,7 +6579,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6630,7 +6630,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6947,7 +6947,7 @@ static int nl80211_remain_on_channel(str
+@@ -6998,7 +6998,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7166,7 +7166,7 @@ static int nl80211_register_mgmt(struct
+@@ -7217,7 +7217,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7247,7 +7247,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7298,7 +7298,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7362,7 +7362,7 @@ static int nl80211_get_power_save(struct
+@@ -7413,7 +7413,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7673,7 +7673,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7723,7 +7723,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  	return 0;
  }
  
-@@ -8128,7 +8128,7 @@ static int nl80211_probe_client(struct s
+@@ -8435,7 +8435,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -216,7 +216,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8172,13 +8172,13 @@ static int nl80211_register_beacons(stru
+@@ -8479,13 +8479,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -232,7 +232,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8245,7 +8245,7 @@ static int nl80211_get_protocol_features
+@@ -8552,7 +8552,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -241,7 +241,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8320,7 +8320,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8627,7 +8627,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -10696,12 +10696,12 @@ static int nl80211_netlink_notify(struct
+@@ -11018,12 +11018,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 7b48d3d..5141592 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1597,6 +1597,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1632,6 +1632,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1617,6 +1618,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1652,6 +1653,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index b4e56c1..6bbfedf 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2645,6 +2645,9 @@ struct wiphy_wowlan_support {
+@@ -2735,6 +2735,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 86e99ff..8468d96 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -788,12 +788,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -793,12 +793,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1582,9 +1591,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1587,9 +1596,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 48074d7..7b3aa4e 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -828,6 +824,15 @@ static int cfg80211_netdev_notifier_call
+@@ -837,6 +833,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index fa2385a..86b356c 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2743,6 +2743,9 @@ static const struct pci_error_handlers a
+@@ -2781,6 +2781,9 @@ static const struct pci_error_handlers a
  	.resume = atl1c_io_resume,
  };
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(atl1c_pm_ops, atl1c_suspend, atl1c_resume);
  
  static struct pci_driver atl1c_driver = {
-@@ -2752,7 +2755,12 @@ static struct pci_driver atl1c_driver =
+@@ -2790,7 +2793,12 @@ static struct pci_driver atl1c_driver =
  	.remove   = atl1c_remove,
  	.shutdown = atl1c_shutdown,
  	.err_handler = &atl1c_err_handler,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index ca69e3d..0eebc4b 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6819,7 +6819,12 @@ static struct pci_driver il4965_driver =
+@@ -6825,7 +6825,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 0d38b88..8d83bbe 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -397,6 +397,9 @@ static int iwl_pci_resume(struct device
+@@ -398,6 +398,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -412,7 +415,12 @@ static struct pci_driver iwl_pci_driver
+@@ -413,7 +416,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index e8339e7..c4ab559 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1972,6 +1972,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1991,6 +1991,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2000,6 +2001,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2019,6 +2020,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 8ff53fc..bd50a7a 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1455,6 +1455,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1474,6 +1474,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index fb22de2..fc1af33 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2662,14 +2662,24 @@ struct ieee80211_ops {
+@@ -2666,14 +2666,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 40c37f1..204d0b4 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -926,7 +926,12 @@ struct ieee80211_local {
+@@ -957,7 +957,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
index 38a8540..b1df3b7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
@@ -12,7 +12,7 @@
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -599,9 +603,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -590,9 +594,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
index ab9b14a..d46f5ee 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -76,7 +76,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
+@@ -73,7 +73,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
  
  	card->func = func;
  
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 8d2d67d..3dc2888 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -141,8 +141,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -183,8 +183,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	wait_for_completion(&adapter->fw_load);
  
  	if (user_rmmod) {
@@ -11,7 +11,7 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -159,6 +161,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -201,6 +203,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	kfree(card);
  }
  
@@ -19,15 +19,15 @@
  /*
   * SDIO suspend.
   *
-@@ -258,6 +261,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -255,6 +258,7 @@ static int mwifiex_sdio_suspend(struct d
  
- 	return 0;
+ 	return ret;
  }
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -283,10 +287,12 @@ static const struct sdio_device_id mwifi
+@@ -280,10 +284,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +40,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -295,7 +301,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -292,7 +298,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 886cde4..b4fa41b 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2296,7 +2296,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2331,7 +2331,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index 7edc774..4615873 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -834,7 +834,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -840,7 +840,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index 04e1cac..e0c2c04 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1151,6 +1151,10 @@ static void __exit ieee80211_exit(void)
+@@ -1142,6 +1142,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index f673667..72d672b 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,14 +1,14 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -491,6 +491,7 @@ static void atl1c_set_rxbufsize(struct a
- 		roundup(mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN, 8) : AT_RX_BUF_SIZE;
+@@ -496,6 +496,7 @@ static void atl1c_set_rxbufsize(struct a
+ 	adapter->rx_frag_size = roundup_pow_of_two(head_size);
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  static netdev_features_t atl1c_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -519,6 +520,7 @@ static int atl1c_set_features(struct net
+@@ -524,6 +525,7 @@ static int atl1c_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  /**
   * atl1c_change_mtu - Change the Maximum Transfer Unit
-@@ -551,8 +553,19 @@ static int atl1c_change_mtu(struct net_d
+@@ -556,8 +558,19 @@ static int atl1c_change_mtu(struct net_d
  		netdev->mtu = new_mtu;
  		adapter->hw.max_frame_size = new_mtu;
  		atl1c_set_rxbufsize(adapter, netdev);
@@ -36,7 +36,7 @@
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2459,8 +2472,10 @@ static const struct net_device_ops atl1c
+@@ -2497,8 +2510,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -47,7 +47,7 @@
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2478,6 +2493,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2516,6 +2531,7 @@ static int atl1c_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1c_set_ethtool_ops(netdev);
  
@@ -55,7 +55,7 @@
  	/* TODO: add when ready */
  	netdev->hw_features =	NETIF_F_SG		|
  				NETIF_F_HW_CSUM		|
-@@ -2486,6 +2502,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2524,6 +2540,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features	|
  				NETIF_F_HW_VLAN_CTAG_TX;
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 3b6ef8a..0ae1e69 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5703,7 +5703,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5739,7 +5739,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
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
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index 103d8f5..6494b84 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2622,7 +2622,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2660,7 +2660,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
index ce5b6d7..6a25832 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -473,7 +473,9 @@ static struct usb_driver ath3k_driver =
+@@ -501,7 +501,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 9a2c9e3..ad7942f 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1623,7 +1623,9 @@ static struct usb_driver btusb_driver =
+@@ -1627,7 +1627,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index fb20e84..f8f9809 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7817,7 +7817,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7867,7 +7867,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index 0688cea..c72b054 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1209,7 +1209,11 @@ static const struct file_operations fops
+@@ -1328,7 +1328,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

