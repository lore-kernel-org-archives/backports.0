Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47120 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab3JZKNj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Oct 2013 06:13:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] backports: refresh patches on next-20131011
Date: Sat, 26 Oct 2013 12:13:09 +0200
Message-Id: <1382782389-4859-5-git-send-email-hauke@hauke-m.de> (sfid-20131026_121342_505403_BCAC9F92)
In-Reply-To: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
References: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
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
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  OK  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0001-netdev_ops/mac80211.patch         |    6 ++--
 .../mac80211.patch                                 |    4 +--
 .../network/0005-netlink-portid/nl80211.patch      |   32 ++++++++++----------
 .../include_net_cfg80211.patch                     |    2 +-
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      |    4 +--
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +--
 .../net_mac80211_tx.patch                          |    4 +--
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++--
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   18 +++++------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   14 ++++-----
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   18 +++++------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   18 +++++------
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_iface.patch                       |    4 +--
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 ++--
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_bluetooth_bfusb.patch                  |    2 +-
 .../drivers_bluetooth_bpa10x.patch                 |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 23 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
index f0f47c2..abb3856 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1108,7 +1108,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1112,7 +1112,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -9,7 +9,7 @@
  	dev->destructor = free_netdev;
  }
  
-@@ -1271,7 +1271,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1275,7 +1275,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -18,7 +18,7 @@
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1310,7 +1310,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1314,7 +1314,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 5cb4623..56c2fdb 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1615,6 +1615,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1619,6 +1619,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1623,6 +1624,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1627,6 +1628,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 8932897..622bedb 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5741,7 +5741,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5762,7 +5762,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5978,7 +5978,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5999,7 +5999,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6676,7 +6676,7 @@ static int nl80211_testmode_dump(struct
+@@ -6697,7 +6697,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6758,7 +6758,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6779,7 +6779,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -7126,7 +7126,7 @@ static int nl80211_remain_on_channel(str
+@@ -7147,7 +7147,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7344,7 +7344,7 @@ static int nl80211_register_mgmt(struct
+@@ -7365,7 +7365,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7425,7 +7425,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7446,7 +7446,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  		if (!hdr) {
  			err = -ENOBUFS;
-@@ -7539,7 +7539,7 @@ static int nl80211_get_power_save(struct
+@@ -7560,7 +7560,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7846,7 +7846,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7867,7 +7867,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8275,7 +8275,7 @@ static int nl80211_get_coalesce(struct s
+@@ -8296,7 +8296,7 @@ static int nl80211_get_coalesce(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -198,7 +198,7 @@
  			     NL80211_CMD_GET_COALESCE);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8528,7 +8528,7 @@ static int nl80211_register_unexpected_f
+@@ -8549,7 +8549,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -207,7 +207,7 @@
  	return 0;
  }
  
-@@ -8558,7 +8558,7 @@ static int nl80211_probe_client(struct s
+@@ -8579,7 +8579,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -216,7 +216,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -8601,13 +8601,13 @@ static int nl80211_register_beacons(stru
+@@ -8622,13 +8622,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -232,7 +232,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8674,7 +8674,7 @@ static int nl80211_get_protocol_features
+@@ -8695,7 +8695,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -241,7 +241,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8749,7 +8749,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8770,7 +8770,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -11150,12 +11150,12 @@ static int nl80211_netlink_notify(struct
+@@ -11172,12 +11172,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 7840152..6b81270 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2769,6 +2769,9 @@ struct wiphy_coalesce_support {
+@@ -2778,6 +2778,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
index 00790a6..430343b 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bcma/host_pci.c
 +++ b/drivers/bcma/host_pci.c
-@@ -257,6 +257,9 @@ static int bcma_host_pci_resume(struct d
+@@ -260,6 +260,9 @@ static int bcma_host_pci_resume(struct d
  	return bcma_bus_resume(bus);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(bcma_pm_ops, bcma_host_pci_suspend,
  			 bcma_host_pci_resume);
  #define BCMA_PM_OPS	(&bcma_pm_ops)
-@@ -286,7 +289,12 @@ static struct pci_driver bcma_pci_bridge
+@@ -290,7 +293,12 @@ static struct pci_driver bcma_pci_bridge
  	.id_table = bcma_pci_bridge_tbl,
  	.probe = bcma_host_pci_probe,
  	.remove = bcma_host_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index e580365..c9b871d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -404,6 +404,9 @@ static int iwl_pci_resume(struct device
+@@ -446,6 +446,9 @@ static int iwl_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -419,7 +422,12 @@ static struct pci_driver iwl_pci_driver
+@@ -461,7 +464,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 3108c1b..ff957c3 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1994,6 +1994,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1995,6 +1995,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2022,6 +2023,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2023,6 +2024,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
index 4167485..af53d75 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -1000,8 +1000,13 @@ drop:
+@@ -998,8 +998,13 @@ drop:
  	goto done;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1175,8 +1180,12 @@ static struct proto hci_sk_proto = {
+@@ -1173,8 +1178,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 572c4d9..0182caa 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -574,8 +574,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -575,8 +575,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1227,8 +1232,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1228,8 +1233,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1240,7 +1249,11 @@ static int l2cap_sock_create(struct net
+@@ -1241,7 +1250,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index fa5bb4b..a79b685 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1740,6 +1740,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1744,6 +1744,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1776,6 +1777,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1780,6 +1781,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 3649f7a..083644c 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1477,6 +1477,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1478,6 +1478,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
index dcaa69c..83be629 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
@@ -49,7 +49,7 @@
  
  	if (test_bit(XMIT_SENDING_READY, &(info->tx_state)))
  		bluecard_enable_activity_led(info);
-@@ -507,7 +524,11 @@ static irqreturn_t bluecard_interrupt(in
+@@ -506,7 +523,11 @@ static irqreturn_t bluecard_interrupt(in
  	if (!test_bit(CARD_READY, &(info->hw_state)))
  		return IRQ_HANDLED;
  
@@ -61,7 +61,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -629,7 +650,11 @@ static int bluecard_hci_open(struct hci_
+@@ -628,7 +649,11 @@ static int bluecard_hci_open(struct hci_
  		return 0;
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -73,7 +73,7 @@
  
  		/* Enable LED */
  		outb(0x08 | 0x20, iobase + 0x30);
-@@ -649,7 +674,11 @@ static int bluecard_hci_close(struct hci
+@@ -648,7 +673,11 @@ static int bluecard_hci_close(struct hci
  	bluecard_hci_flush(hdev);
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -85,7 +85,7 @@
  
  		/* Disable LED */
  		outb(0x00, iobase + 0x30);
-@@ -705,7 +734,11 @@ static int bluecard_hci_ioctl(struct hci
+@@ -698,7 +727,11 @@ static int bluecard_hci_send_frame(struc
  
  static int bluecard_open(bluecard_info_t *info)
  {
@@ -97,7 +97,7 @@
  	struct hci_dev *hdev;
  	unsigned char id;
  
-@@ -821,7 +854,11 @@ static int bluecard_open(bluecard_info_t
+@@ -813,7 +846,11 @@ static int bluecard_open(bluecard_info_t
  
  static int bluecard_close(bluecard_info_t *info)
  {
@@ -109,7 +109,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -856,7 +893,18 @@ static int bluecard_probe(struct pcmcia_
+@@ -848,7 +885,18 @@ static int bluecard_probe(struct pcmcia_
  	info->p_dev = link;
  	link->priv = info;
  
@@ -128,7 +128,7 @@
  
  	return bluecard_config(link);
  }
-@@ -873,15 +921,30 @@ static int bluecard_config(struct pcmcia
+@@ -865,15 +913,30 @@ static int bluecard_config(struct pcmcia
  	bluecard_info_t *info = link->priv;
  	int i, n;
  
@@ -159,7 +159,7 @@
  		if (i == 0)
  			break;
  	}
-@@ -889,9 +952,15 @@ static int bluecard_config(struct pcmcia
+@@ -881,9 +944,15 @@ static int bluecard_config(struct pcmcia
  	if (i != 0)
  		goto failed;
  
@@ -175,7 +175,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -929,7 +998,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
+@@ -921,7 +990,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
  
  static struct pcmcia_driver bluecard_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
index 6a8aa8e..7af65a3 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
@@ -24,7 +24,7 @@
  
  	avail = bt3c_read(iobase, 0x7006);
  	//printk("bt3c_cs: receiving %d bytes\n", avail);
-@@ -345,7 +353,11 @@ static irqreturn_t bt3c_interrupt(int ir
+@@ -344,7 +352,11 @@ static irqreturn_t bt3c_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -473,7 +485,11 @@ static int bt3c_load_firmware(bt3c_info_
+@@ -466,7 +478,11 @@ static int bt3c_load_firmware(bt3c_info_
  	unsigned int iobase, size, addr, fcs, tmp;
  	int i, err = 0;
  
@@ -48,7 +48,7 @@
  
  	/* Reset */
  	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -645,8 +661,27 @@ static int bt3c_probe(struct pcmcia_devi
+@@ -637,8 +653,27 @@ static int bt3c_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -76,7 +76,7 @@
  
  	return bt3c_config(link);
  }
-@@ -657,6 +692,7 @@ static void bt3c_detach(struct pcmcia_de
+@@ -649,6 +684,7 @@ static void bt3c_detach(struct pcmcia_de
  	bt3c_release(link);
  }
  
@@ -84,7 +84,7 @@
  static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -695,6 +731,63 @@ static int bt3c_check_config_notpicky(st
+@@ -687,6 +723,63 @@ static int bt3c_check_config_notpicky(st
  	}
  	return -ENODEV;
  }
@@ -148,7 +148,7 @@
  
  static int bt3c_config(struct pcmcia_device *link)
  {
-@@ -718,9 +811,15 @@ static int bt3c_config(struct pcmcia_dev
+@@ -710,9 +803,15 @@ static int bt3c_config(struct pcmcia_dev
  	goto failed;
  
  found_port:
@@ -164,7 +164,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -755,7 +854,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
+@@ -747,7 +846,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
  
  static struct pcmcia_driver bt3c_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
index d35eaad..0579688 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -295,7 +303,11 @@ static irqreturn_t btuart_interrupt(int
+@@ -294,7 +302,11 @@ static irqreturn_t btuart_interrupt(int
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -352,7 +364,11 @@ static void btuart_change_speed(btuart_i
+@@ -351,7 +363,11 @@ static void btuart_change_speed(btuart_i
  		return;
  	}
  
@@ -48,7 +48,7 @@
  
  	spin_lock_irqsave(&(info->lock), flags);
  
-@@ -471,7 +487,11 @@ static int btuart_hci_ioctl(struct hci_d
+@@ -464,7 +480,11 @@ static int btuart_hci_send_frame(struct
  static int btuart_open(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -60,7 +60,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -538,7 +558,11 @@ static int btuart_open(btuart_info_t *in
+@@ -530,7 +550,11 @@ static int btuart_open(btuart_info_t *in
  static int btuart_close(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -72,7 +72,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -574,8 +598,27 @@ static int btuart_probe(struct pcmcia_de
+@@ -566,8 +590,27 @@ static int btuart_probe(struct pcmcia_de
  	info->p_dev = link;
  	link->priv = info;
  
@@ -100,7 +100,7 @@
  
  	return btuart_config(link);
  }
-@@ -586,6 +629,7 @@ static void btuart_detach(struct pcmcia_
+@@ -578,6 +621,7 @@ static void btuart_detach(struct pcmcia_
  	btuart_release(link);
  }
  
@@ -108,7 +108,7 @@
  static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -624,6 +668,63 @@ static int btuart_check_config_notpicky(
+@@ -616,6 +660,63 @@ static int btuart_check_config_notpicky(
  	}
  	return -ENODEV;
  }
@@ -172,7 +172,7 @@
  
  static int btuart_config(struct pcmcia_device *link)
  {
-@@ -647,9 +748,15 @@ static int btuart_config(struct pcmcia_d
+@@ -639,9 +740,15 @@ static int btuart_config(struct pcmcia_d
  	goto failed;
  
  found_port:
@@ -188,7 +188,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -683,7 +790,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
+@@ -675,7 +782,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
  
  static struct pcmcia_driver btuart_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
index 1c14c79..39cb54b 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -296,7 +304,11 @@ static irqreturn_t dtl1_interrupt(int ir
+@@ -295,7 +303,11 @@ static irqreturn_t dtl1_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -451,7 +463,11 @@ static int dtl1_hci_ioctl(struct hci_dev
+@@ -444,7 +456,11 @@ static int dtl1_hci_send_frame(struct sk
  static int dtl1_open(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -48,7 +48,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -495,8 +511,13 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -487,8 +503,13 @@ static int dtl1_open(dtl1_info_t *info)
  	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
  	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
  
@@ -62,7 +62,7 @@
  
  	/* Turn on interrupts */
  	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -521,7 +542,11 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -513,7 +534,11 @@ static int dtl1_open(dtl1_info_t *info)
  static int dtl1_close(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -74,7 +74,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -557,7 +582,24 @@ static int dtl1_probe(struct pcmcia_devi
+@@ -549,7 +574,24 @@ static int dtl1_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -99,7 +99,7 @@
  
  	return dtl1_config(link);
  }
-@@ -571,6 +613,7 @@ static void dtl1_detach(struct pcmcia_de
+@@ -563,6 +605,7 @@ static void dtl1_detach(struct pcmcia_de
  	pcmcia_disable_device(link);
  }
  
@@ -107,7 +107,7 @@
  static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -581,6 +624,29 @@ static int dtl1_confcheck(struct pcmcia_
+@@ -573,6 +616,29 @@ static int dtl1_confcheck(struct pcmcia_
  
  	return pcmcia_request_io(p_dev);
  }
@@ -137,7 +137,7 @@
  
  static int dtl1_config(struct pcmcia_device *link)
  {
-@@ -588,14 +654,24 @@ static int dtl1_config(struct pcmcia_dev
+@@ -580,14 +646,24 @@ static int dtl1_config(struct pcmcia_dev
  	int ret;
  
  	/* Look for a generic full-sized window */
@@ -162,7 +162,7 @@
  
  	ret = pcmcia_enable_device(link);
  	if (ret)
-@@ -623,7 +699,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
+@@ -615,7 +691,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
  
  static struct pcmcia_driver dtl1_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index e6d4d46..64f1a9e 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2695,14 +2695,24 @@ struct ieee80211_ops {
+@@ -2715,14 +2715,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index d06607c..d196bca 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -803,8 +803,13 @@ static void ieee80211_do_stop(struct iee
+@@ -807,8 +807,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1018,10 +1023,20 @@ static void ieee80211_set_multicast_list
+@@ -1022,10 +1027,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
index 2f34c83..f7046b8 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btmrvl_sdio.c
 +++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1083,6 +1083,7 @@ static void btmrvl_sdio_remove(struct sd
+@@ -1081,6 +1081,7 @@ static void btmrvl_sdio_remove(struct sd
  	}
  }
  
@@ -8,7 +8,7 @@
  static int btmrvl_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1178,6 +1179,7 @@ static const struct dev_pm_ops btmrvl_sd
+@@ -1176,6 +1177,7 @@ static const struct dev_pm_ops btmrvl_sd
  	.suspend	= btmrvl_sdio_suspend,
  	.resume		= btmrvl_sdio_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct sdio_driver bt_mrvl_sdio = {
  	.name		= "btmrvl_sdio",
-@@ -1186,7 +1188,9 @@ static struct sdio_driver bt_mrvl_sdio =
+@@ -1184,7 +1186,9 @@ static struct sdio_driver bt_mrvl_sdio =
  	.remove		= btmrvl_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index 4615873..4bac3e2 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -840,7 +840,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -849,7 +849,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index c32eb76..28067ea 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5853,7 +5853,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5874,7 +5874,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
index 8eb2e3e..1fbcc45 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bfusb.c
 +++ b/drivers/bluetooth/bfusb.c
-@@ -745,7 +745,9 @@ static struct usb_driver bfusb_driver =
+@@ -738,7 +738,9 @@ static struct usb_driver bfusb_driver =
  	.probe		= bfusb_probe,
  	.disconnect	= bfusb_disconnect,
  	.id_table	= bfusb_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
index 180a54e..5006ab4 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bpa10x.c
 +++ b/drivers/bluetooth/bpa10x.c
-@@ -504,7 +504,9 @@ static struct usb_driver bpa10x_driver =
+@@ -502,7 +502,9 @@ static struct usb_driver bpa10x_driver =
  	.probe		= bpa10x_probe,
  	.disconnect	= bpa10x_disconnect,
  	.id_table	= bpa10x_table,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 22e6ac0..6c7c603 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7990,7 +7990,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8011,7 +8011,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
-- 
1.7.10.4

