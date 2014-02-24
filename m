Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35048 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBXAri (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:47:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 7B6B07E58
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:47:37 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/12] backports: refresh patches on next-20140221
Date: Mon, 24 Feb 2014 01:45:54 +0100
Message-Id: <1393202754-12919-13-git-send-email-hauke@hauke-m.de> (sfid-20140224_014742_410530_740A13DA)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

manual changes were needed on these files:
 * patches/backport-adjustments/flow_dissector.patch
 * patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
 * patches/collateral-evolutions/network/83-select_queue/mac80211.patch
 * patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
 * patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch

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
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/dma-buf.patch         |    2 +-
 patches/backport-adjustments/flow_dissector.patch  |   22 +--
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 .../drivers_net_wireless_ti_wlcore_wlcore.patch    |    2 +-
 .../drivers_net_wireless_mwifiex_pcie.patch        |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |  169 --------------------
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 +-
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |    4 +-
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |    6 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_iwlwifi.patch             |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    4 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_wcn36xx_main.patch    |    6 +-
 .../drivers_net_wireless_ti_wl12xx_main.patch      |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 .../61-netdev-addr_assign_type/usbnet.patch        |    2 +-
 .../63-tty-termios/net_bluetooth_rfcomm_tty.patch  |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../76-sysfs-api/net_ieee802154_wpan-class.patch   |    6 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/78-usb-sg/usbnet.patch                 |   12 +-
 .../network/81-genl-const/hwsim.patch              |    2 +-
 .../network/81-genl-const/ieee802154.patch         |    2 +-
 .../network/81-genl-const/nl80211.patch            |    6 +-
 .../82-struct_property_missing/mwifiex.patch       |    4 +-
 .../network/83-select_queue/mac80211.patch         |   24 ++-
 .../network/83-select_queue/mwifiex.patch          |   12 +-
 .../84-ethernet/0001-igb_net_device_ops.patch      |    6 +-
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |    8 +-
 .../network/84-ethernet/0008-igb_no_fcs.patch      |    2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch |    6 +-
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch |    8 +-
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |   36 ++---
 50 files changed, 125 insertions(+), 302 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index cfd78be..ed70b69 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -726,17 +752,15 @@ static inline void dma_buf_uninit_debugf
+@@ -727,17 +753,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/backport-adjustments/flow_dissector.patch b/patches/backport-adjustments/flow_dissector.patch
index 6a6fc16..a4278f4 100644
--- a/patches/backport-adjustments/flow_dissector.patch
+++ b/patches/backport-adjustments/flow_dissector.patch
@@ -1,6 +1,6 @@
 --- a/compat/net-core-flow_dissector.c
 +++ b/compat/net-core-flow_dissector.c
-@@ -177,241 +177,10 @@ ipv6:
+@@ -177,229 +177,10 @@ ipv6:
  
  	flow->ip_proto = ip_proto;
  	flow->ports = skb_flow_get_ports(skb, nhoff, ip_proto);
@@ -152,17 +152,6 @@
 -	return poff;
 -}
 -
--static inline u16 dev_cap_txqueue(struct net_device *dev, u16 queue_index)
--{
--	if (unlikely(queue_index >= dev->real_num_tx_queues)) {
--		net_warn_ratelimited("%s selects TX queue %d, but real number of TX queues is %d\n",
--				     dev->name, queue_index,
--				     dev->real_num_tx_queues);
--		return 0;
--	}
--	return queue_index;
--}
--
 -static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 -{
 -#ifdef CONFIG_XPS
@@ -201,7 +190,7 @@
 -#endif
 -}
 -
--u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
+-static u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
 -{
 -	struct sock *sk = skb->sk;
 -	int queue_index = sk_tx_queue_get(sk);
@@ -221,7 +210,6 @@
 -
 -	return queue_index;
 -}
--EXPORT_SYMBOL(__netdev_pick_tx);
 -
 -struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 -				    struct sk_buff *skb,
@@ -232,13 +220,13 @@
 -	if (dev->real_num_tx_queues != 1) {
 -		const struct net_device_ops *ops = dev->netdev_ops;
 -		if (ops->ndo_select_queue)
--			queue_index = ops->ndo_select_queue(dev, skb,
--							    accel_priv);
+-			queue_index = ops->ndo_select_queue(dev, skb, accel_priv,
+-							    __netdev_pick_tx);
 -		else
 -			queue_index = __netdev_pick_tx(dev, skb);
 -
 -		if (!accel_priv)
--			queue_index = dev_cap_txqueue(dev, queue_index);
+-			queue_index = netdev_cap_txqueue(dev, queue_index);
 -	}
 -
 -	skb_set_queue_mapping(skb, queue_index);
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 2e764c2..3911ada 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1609,6 +1609,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1613,6 +1613,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1617,6 +1618,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1621,6 +1622,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index a440aee..7a470cc 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1705,6 +1705,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1726,6 +1726,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1726,6 +1727,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1747,6 +1748,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
index 806b54d..1c7ad21 100644
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1365,7 +1365,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1367,7 +1367,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 8af7fa6..690f4f5 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2879,6 +2879,9 @@ struct wiphy_vendor_command {
+@@ -2896,6 +2896,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 8067684..4c697f2 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -900,12 +900,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -950,12 +950,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1606,9 +1615,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1655,9 +1664,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 9381b59..7f5137c 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6073,15 +6073,27 @@ static void wlcore_nvs_cb(const struct f
+@@ -6079,15 +6079,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -28,7 +28,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6127,7 +6139,11 @@ out_unreg:
+@@ -6133,7 +6145,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -40,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6173,7 +6189,12 @@ int wlcore_remove(struct platform_device
+@@ -6179,7 +6195,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
index 4c7b66e..29e1d1e 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/wlcore.h
 +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
-@@ -176,7 +176,9 @@ struct wl1271 {
+@@ -178,7 +178,9 @@ struct wl1271 {
  	bool initialized;
  	struct ieee80211_hw *hw;
  	bool mac80211_registered;
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
index 3cc0530..0ba50bf 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/pcie.c
 +++ b/drivers/net/wireless/mwifiex/pcie.c
-@@ -271,9 +271,14 @@ static struct pci_driver __refdata mwifi
+@@ -282,9 +282,14 @@ static struct pci_driver __refdata mwifi
  	.probe    = mwifiex_pcie_probe,
  	.remove   = mwifiex_pcie_remove,
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 1e10d38..e481d68 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2054,6 +2054,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2065,6 +2065,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2082,6 +2083,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2093,6 +2094,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
index 268f647..5798965 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -1002,8 +1002,13 @@ drop:
+@@ -1003,8 +1003,13 @@ drop:
  	goto done;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1177,8 +1182,12 @@ static struct proto hci_sk_proto = {
+@@ -1178,8 +1183,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
deleted file mode 100644
index 068243f..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ /dev/null
@@ -1,169 +0,0 @@
---- a/net/bluetooth/hidp/core.c
-+++ b/net/bluetooth/hidp/core.c
-@@ -268,6 +268,7 @@ static int hidp_hidinput_event(struct in
- 	return hidp_send_report(session, field->report);
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
- static int hidp_get_raw_report(struct hid_device *hid,
- 		unsigned char report_number,
- 		unsigned char *data, size_t count,
-@@ -352,6 +353,7 @@ err:
- 	mutex_unlock(&session->report_mutex);
- 	return ret;
- }
-+#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
- 
- static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
- 			       unsigned char *data, size_t count,
-@@ -418,6 +420,7 @@ err:
- 	return ret;
- }
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
- 		unsigned char report_type)
- {
-@@ -475,6 +478,16 @@ err:
- 	mutex_unlock(&session->report_mutex);
- 	return ret;
- }
-+#elif (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
-+static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count)
-+{
-+	if (hidp_send_ctrl_message(hid->driver_data,
-+			HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE,
-+			data, count))
-+		return -ENOMEM;
-+	return count;
-+}
-+#endif
- 
- static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
- 			    __u8 *buf, size_t len, unsigned char rtype,
-@@ -786,6 +799,87 @@ static void hidp_close(struct hid_device
- {
- }
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
-+static const struct {
-+	__u16 idVendor;
-+	__u16 idProduct;
-+	unsigned quirks;
-+} hidp_blacklist[] = {
-+	/* Apple wireless Mighty Mouse */
-+	{ 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
-+
-+	{ }	/* Terminating entry */
-+};
-+static void hidp_setup_quirks(struct hid_device *hid)
-+{
-+	unsigned int n;
-+
-+	for (n = 0; hidp_blacklist[n].idVendor; n++)
-+		if (hidp_blacklist[n].idVendor == le16_to_cpu(hid->vendor) &&
-+				hidp_blacklist[n].idProduct == le16_to_cpu(hid->product))
-+			hid->quirks = hidp_blacklist[n].quirks;
-+}
-+
-+static int hidp_setup_hid(struct hidp_session *session,
-+			  struct hidp_connadd_req *req)
-+{
-+	struct hid_device *hid;
-+	struct hid_report *report;
-+	bdaddr_t src, dst;
-+	unsigned char *buf;
-+
-+	buf = kmalloc(req->rd_size, GFP_KERNEL);
-+	if (!buf)
-+		return -ENOMEM;
-+
-+	if (copy_from_user(buf, req->rd_data, req->rd_size)) {
-+		kfree(buf);
-+		return -EFAULT;
-+	}
-+
-+	hid = hid_parse_report(buf, req->rd_size);
-+	kfree(buf);
-+	if (!session->hid)
-+		return -EINVAL;
-+
-+	session->hid = hid;
-+
-+	hid->driver_data = session;
-+
-+	baswap(&src, &bt_sk(session->ctrl_sock->sk)->src);
-+	baswap(&dst, &bt_sk(session->ctrl_sock->sk)->dst);
-+
-+	hid->bus     = BUS_BLUETOOTH;
-+	hid->vendor  = req->vendor;
-+	hid->product = req->product;
-+	hid->version = req->version;
-+	hid->country = req->country;
-+
-+	strlcpy(hid->name, req->name, 128);
-+	strlcpy(hid->phys, batostr(&src), 64);
-+	strlcpy(hid->uniq, batostr(&dst), 64);
-+
-+	hid->dev = hidp_get_device(session);
-+	hid->hid_open  = hidp_open;
-+	hid->hid_close = hidp_close;
-+
-+	hid->hidinput_input_event = hidp_hidinput_event;
-+
-+	hidp_setup_quirks(hid);
-+
-+	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].report_list, list)
-+		hidp_send_report(session, report);
-+
-+	list_for_each_entry(report, &hid->report_enum[HID_FEATURE_REPORT].report_list, list)
-+		hidp_send_report(session, report);
-+
-+	if (hidinput_connect(hid) == 0)
-+		hid->claimed |= HID_CLAIMED_INPUT;
-+
-+	return 0;
-+}
-+#else
-+
- static int hidp_parse(struct hid_device *hid)
- {
- 	struct hidp_session *session = hid->driver_data;
-@@ -865,7 +959,9 @@ static int hidp_setup_hid(struct hidp_se
- 	hid->dev.parent = &session->conn->hcon->dev;
- 	hid->ll_driver = &hidp_hid_driver;
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
- 	hid->hid_get_raw_report = hidp_get_raw_report;
-+#endif
- 	hid->hid_output_raw_report = hidp_output_raw_report;
- 
- 	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -883,6 +979,7 @@ fault:
- 
- 	return err;
- }
-+#endif
- 
- /* initialize session devices */
- static int hidp_session_dev_init(struct hidp_session *session,
-@@ -945,10 +1042,17 @@ static int hidp_session_dev_add(struct h
- /* remove HID/input devices from their bus systems */
- static void hidp_session_dev_del(struct hidp_session *session)
- {
--	if (session->hid)
-+	if (session->hid) {
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 		hid_destroy_device(session->hid);
--	else if (session->input)
-+#else
-+		if (session->hid->claimed & HID_CLAIMED_INPUT)
-+			hidinput_disconnect(session->hid);
-+		hid_free_device(session->hid);
-+#endif
-+	} else if (session->input) {
- 		input_unregister_device(session->input);
-+	}
- }
- 
- /*
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 2bd33d2..e5e7c75 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -749,8 +749,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -733,8 +733,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1553,8 +1558,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1527,8 +1532,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1566,7 +1575,11 @@ static int l2cap_sock_create(struct net
+@@ -1540,7 +1549,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index bbb4cf9..f6b84b5 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
-@@ -305,8 +305,13 @@ static struct sock *rfcomm_sock_alloc(st
+@@ -310,8 +310,13 @@ static struct sock *rfcomm_sock_alloc(st
  	return sk;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -675,7 +680,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -681,7 +686,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index 1013610..286e167 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -796,7 +796,11 @@ static int rfcomm_tty_write_room(struct
+@@ -822,7 +822,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
  
@@ -12,7 +12,7 @@
  {
  	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
  
-@@ -1045,7 +1049,11 @@ static void rfcomm_tty_hangup(struct tty
+@@ -1071,7 +1075,11 @@ static void rfcomm_tty_hangup(struct tty
  	tty_port_hangup(&dev->port);
  }
  
@@ -24,7 +24,7 @@
  {
  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
  
-@@ -1054,7 +1062,11 @@ static int rfcomm_tty_tiocmget(struct tt
+@@ -1080,7 +1088,11 @@ static int rfcomm_tty_tiocmget(struct tt
  	return dev->modem_status;
  }
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 47f75f0..abe38a3 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1733,6 +1733,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1737,6 +1737,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1769,6 +1770,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1773,6 +1774,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index cfb030b..3894a96 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1515,6 +1515,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1526,6 +1526,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
index 3404c11..9a111b9 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
-@@ -800,12 +800,21 @@ static void iwl_mvm_recalc_multicast(str
+@@ -948,12 +948,21 @@ static void iwl_mvm_recalc_multicast(str
  }
  
  static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
@@ -22,7 +22,7 @@
  	bool pass_all = false;
  	int len;
  
-@@ -824,11 +833,15 @@ static u64 iwl_mvm_prepare_multicast(str
+@@ -972,11 +981,15 @@ static u64 iwl_mvm_prepare_multicast(str
  		return (u64)(unsigned long)cmd;
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
index 296aa49..2c2a87f 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -3038,11 +3038,20 @@ struct wl1271_filter_params {
+@@ -3053,11 +3053,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -21,7 +21,7 @@
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -3051,16 +3060,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -3066,16 +3075,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 3f7a360..dae04b3 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2789,7 +2789,11 @@ struct ieee80211_ops {
+@@ -2792,7 +2792,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 290b720..1019fa2 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1013,7 +1013,12 @@ struct ieee80211_local {
+@@ -1017,7 +1017,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 4dbd96c..4814014 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1024,7 +1029,12 @@ static void ieee80211_set_multicast_list
+@@ -1026,7 +1031,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 307354e..e97b1af 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2380,7 +2380,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2403,7 +2403,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index aac67dd..5b95a39 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -865,7 +865,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -866,7 +866,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index 552d1c8..dca9153 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1195,6 +1195,10 @@ static void __exit ieee80211_exit(void)
+@@ -1200,6 +1200,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index e9a4a9e..46fef2d 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1344,7 +1358,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1345,7 +1359,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index da19d69..2aa916c 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5978,7 +5978,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6067,7 +6067,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
index d0c20eb..887162e 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/wcn36xx/main.c
 +++ b/drivers/net/wireless/ath/wcn36xx/main.c
-@@ -1000,6 +1000,7 @@ static int wcn36xx_remove(struct platfor
+@@ -1062,6 +1062,7 @@ static int wcn36xx_remove(struct platfor
  
  	return 0;
  }
@@ -8,7 +8,7 @@
  static const struct platform_device_id wcn36xx_platform_id_table[] = {
  	{
  		.name = "wcn36xx",
-@@ -1008,6 +1009,7 @@ static const struct platform_device_id w
+@@ -1070,6 +1071,7 @@ static const struct platform_device_id w
  	{}
  };
  MODULE_DEVICE_TABLE(platform, wcn36xx_platform_id_table);
@@ -16,7 +16,7 @@
  
  static struct platform_driver wcn36xx_driver = {
  	.probe      = wcn36xx_probe,
-@@ -1016,7 +1018,9 @@ static struct platform_driver wcn36xx_dr
+@@ -1078,7 +1080,9 @@ static struct platform_driver wcn36xx_dr
  		.name   = "wcn36xx",
  		.owner  = THIS_MODULE,
  	},
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
index dea351e..4a1662b 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wl12xx/main.c
 +++ b/drivers/net/wireless/ti/wl12xx/main.c
-@@ -1825,16 +1825,20 @@ out:
+@@ -1888,16 +1888,20 @@ out:
  	return wlcore_remove(pdev);
  }
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index 6c5aa7c..9d8ab2c 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -290,8 +290,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -294,8 +294,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index 788df56..5221573 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1025,7 +1025,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1020,7 +1020,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
index c8e72e7..fa27163 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1671,9 +1671,11 @@ usbnet_probe (struct usb_interface *udev
+@@ -1666,9 +1666,11 @@ usbnet_probe (struct usb_interface *udev
  		dev->rx_urb_size = dev->hard_mtu;
  	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
  
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
index 5905539..5993b92 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -847,7 +847,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -873,7 +873,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 0a3f6c5..c5b78d2 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8203,7 +8203,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8308,7 +8308,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
index db71155..8099fab 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/wpan-class.c
 +++ b/net/ieee802154/wpan-class.c
-@@ -77,7 +77,12 @@ static struct attribute *pmib_attrs[] =
+@@ -75,7 +75,12 @@ static struct attribute *pmib_attrs[] =
  	&dev_attr_cca_mode.attr,
  	NULL,
  };
@@ -13,7 +13,7 @@
  
  static void wpan_phy_release(struct device *d)
  {
-@@ -88,7 +93,11 @@ static void wpan_phy_release(struct devi
+@@ -86,7 +91,11 @@ static void wpan_phy_release(struct devi
  static struct class wpan_phy_class = {
  	.name = "ieee802154",
  	.dev_release = wpan_phy_release,
@@ -25,7 +25,7 @@
  };
  
  static DEFINE_MUTEX(wpan_phy_mutex);
-@@ -199,6 +208,7 @@ EXPORT_SYMBOL(wpan_phy_free);
+@@ -203,6 +212,7 @@ EXPORT_SYMBOL(wpan_phy_free);
  static int __init wpan_phy_class_init(void)
  {
  	int rc;
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index c8dcc3e..bddfd78 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1161,6 +1161,9 @@ struct ieee80211_local {
+@@ -1165,6 +1165,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index 7b1c4d9..9aaf581 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1230,6 +1230,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1225,6 +1225,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1262,6 +1263,12 @@ static int build_dma_sg(const struct sk_
+@@ -1257,6 +1258,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1318,12 +1325,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1313,12 +1320,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1378,7 +1392,9 @@ not_drop:
+@@ -1373,7 +1387,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1431,7 +1447,9 @@ static void usbnet_bh (unsigned long par
+@@ -1426,7 +1442,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1786,7 +1804,9 @@ int usbnet_resume (struct usb_interface
+@@ -1781,7 +1799,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
index ddb47de..c48b65b 100644
--- a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2449,7 +2449,7 @@ static int hwsim_destroy_radio_nl(struct
+@@ -2466,7 +2466,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
index 8e9b226..f6e20aa 100644
--- a/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
@@ -9,7 +9,7 @@
  	/* see nl-phy.c */
  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
  			ieee802154_dump_phy),
-@@ -125,7 +125,7 @@ static const struct genl_ops ieee8021154
+@@ -126,7 +126,7 @@ static const struct genl_ops ieee8021154
  			ieee802154_dump_iface),
  };
  
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 5f78eff..0e8d703 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9154,7 +9154,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9259,7 +9259,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9223,7 +9223,7 @@ static int nl80211_pre_doit(const struct
+@@ -9328,7 +9328,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9240,7 +9240,7 @@ static void nl80211_post_doit(const stru
+@@ -9345,7 +9345,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
index ac882e6..26fa949 100644
--- a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
+++ b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
@@ -8,7 +8,7 @@
  
  /*
   * This function prepares command to set/get RSSI information.
-@@ -1192,9 +1193,10 @@ static int mwifiex_cmd_cfg_data(struct m
+@@ -1430,9 +1431,10 @@ static int mwifiex_cmd_cfg_data(struct m
  	struct property *prop = data_buf;
  	u32 len;
  	u8 *data = (u8 *)cmd + S_DS_GEN;
@@ -20,7 +20,7 @@
  		len = prop->length;
  		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
  						data, len);
-@@ -1202,6 +1204,9 @@ static int mwifiex_cmd_cfg_data(struct m
+@@ -1440,6 +1442,9 @@ static int mwifiex_cmd_cfg_data(struct m
  			return ret;
  		dev_dbg(adapter->dev,
  			"download cfg_data from device tree: %s\n", prop->name);
diff --git a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
index eb90b42..ce087cc 100644
--- a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
@@ -1,15 +1,20 @@
 diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
-index 3dfd20a..0696aec 100644
+index 088111a..dcf149a 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1065,9 +1065,14 @@ static void ieee80211_uninit(struct net_
+@@ -1067,10 +1067,19 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
- 					 void *accel_priv)
+ 					 void *accel_priv,
+ 					 select_queue_fallback_t fallback)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++static u16 ieee80211_netdev_select_queue(struct net_device *dev,
++					 struct sk_buff *skb,
++					 void *accel_priv)
 +#else
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb)
@@ -17,14 +22,19 @@ index 3dfd20a..0696aec 100644
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1083,9 +1088,14 @@ static const struct net_device_ops ieee8
+@@ -1086,10 +1095,19 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
- 					  void *accel_priv)
+ 					  void *accel_priv,
+ 					  select_queue_fallback_t fallback)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++static u16 ieee80211_monitor_select_queue(struct net_device *dev,
++					  struct sk_buff *skb,
++					  void *accel_priv)
 +#else
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 +					  struct sk_buff *skb)
diff --git a/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
index 78292d2..db9ed6e 100644
--- a/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
@@ -1,15 +1,19 @@
 diff --git a/drivers/net/wireless/mwifiex/main.c b/drivers/net/wireless/mwifiex/main.c
-index 4d79761..8bd0316 100644
+index 9d3d275..f8b16f4 100644
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -746,9 +746,14 @@ static struct net_device_stats *mwifiex_
+@@ -746,9 +746,18 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
- 				void *accel_priv)
+ 				void *accel_priv, select_queue_fallback_t fallback)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++static u16
++mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
++				void *accel_priv)
 +#else
 +static u16
 +mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb)
diff --git a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
index e07ec86..f4f79cf 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
@@ -16,7 +16,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7168,8 +7173,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7169,8 +7174,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +29,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7186,8 +7195,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7187,8 +7196,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +42,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7213,7 +7226,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7214,7 +7227,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
index e818251..9046191 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
@@ -22,7 +22,7 @@ index f2a5abf..dd878b6 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7519,6 +7523,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7520,6 +7524,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7528,6 +7533,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7529,6 +7534,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -38,7 +38,7 @@ index f2a5abf..dd878b6 100644
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7545,6 +7551,8 @@ out:
+@@ -7546,6 +7552,8 @@ out:
  }
  
  #endif
@@ -47,7 +47,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7555,6 +7563,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7556,6 +7564,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
index 772b319..a47238e 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index fd6a103..a919cfa 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4691,9 +4691,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4692,9 +4692,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
index c6d977a..3c2d939 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
@@ -18,7 +18,7 @@ index 37e6062..6bf0a88 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7185,8 +7188,10 @@ static void igb_vlan_mode(struct net_dev
+@@ -7186,8 +7189,10 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
@@ -30,7 +30,7 @@ index 37e6062..6bf0a88 100644
  #endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7201,15 +7206,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7202,15 +7207,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@ index 37e6062..6bf0a88 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7225,7 +7234,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7226,7 +7235,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
index dec9a83..64dd97b 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
@@ -13,7 +13,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2056,7 +2058,9 @@ static const struct net_device_ops igb_n
+@@ -2057,7 +2059,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
@@ -23,7 +23,7 @@ index 35ac7d8..e609f71 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7854,6 +7858,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7855,6 +7859,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7880,6 +7885,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7881,6 +7886,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 35ac7d8..e609f71 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7892,7 +7898,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7893,7 +7899,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
index 81d742b..19b3b85 100644
--- a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
@@ -1,48 +1,38 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -355,6 +355,7 @@ err:
+@@ -223,6 +223,7 @@ static void hidp_input_report(struct hid
+ 	input_sync(dev);
  }
- #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
- static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
- 			       unsigned char *data, size_t count,
- 			       unsigned char report_type)
-@@ -419,6 +420,7 @@ err:
+ static int hidp_get_raw_report(struct hid_device *hid,
+ 		unsigned char report_number,
+ 		unsigned char *data, size_t count,
+@@ -307,6 +308,7 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
 +#endif
  
- #if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
-@@ -489,6 +491,7 @@ static int hidp_output_raw_report(struct
+ static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
+ 			       unsigned char *data, size_t count,
+@@ -394,6 +396,7 @@ static int hidp_output_raw_report(struct
+ 	return hidp_set_raw_report(hid, data[0], data, count, report_type);
  }
- #endif
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
  			    __u8 *buf, size_t len, unsigned char rtype,
  			    int reqtype)
-@@ -502,7 +505,9 @@ static int hidp_raw_request(struct hid_d
+@@ -407,6 +410,7 @@ static int hidp_raw_request(struct hid_d
  		return -EIO;
  	}
  }
 +#endif
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
- static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
- {
- 	struct hidp_session *session = hid->driver_data;
-@@ -511,6 +516,7 @@ static int hidp_output_report(struct hid
- 				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
- 				      data, count);
- }
-+#endif
- 
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -909,8 +915,10 @@ static struct hid_ll_driver hidp_hid_dri
+@@ -736,8 +740,10 @@ static struct hid_ll_driver hidp_hid_dri
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
@@ -50,6 +40,6 @@
  	.raw_request = hidp_raw_request,
  	.output_report = hidp_output_report,
 +#endif
- 	.hidinput_input_event = hidp_hidinput_event,
  };
  
+ /* This function sets up the hid device. It does not add it
-- 
1.7.10.4

