Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:43715 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3LFSaI (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 13:30:08 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so1061167wes.15
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 10:30:07 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 3/3] backports: refresh patches for next-20131206
Date: Fri,  6 Dec 2013 19:29:30 +0100
Message-Id: <1386354570-23940-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20131206_193011_938952_C0D3CDBC)
In-Reply-To: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Run time of generation of release:

real    5m28.543s
user    3m4.536s
sys     2m2.940s

spatch version 1.0.0-rc17 with Python support and with PCRE support

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
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.52              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.70              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.20             [  OK  ]
27  3.11.9              [  OK  ]
28  3.12.1              [  OK  ]
29  3.13-rc1            [  OK  ]

real    37m43.297s
user    1030m36.392s
sys     138m31.368s

Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/0003-netdev-needed_headroom_tailroom/mac80211.patch     | 4 ++--
 .../network/0006-disable-dump-adjust-on-old-kernels.patch           | 4 ++--
 .../network/09-cfg80211-wext-padding/include_net_cfg80211.patch     | 2 +-
 .../09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch   | 4 ++--
 .../09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch       | 6 +++---
 .../network/10-add-wext-handlers-to-netdev/net_wireless_core.patch  | 2 +-
 .../network/11-dev-pm-ops/drivers_bcma_host_pci.patch               | 4 ++--
 .../network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch  | 4 ++--
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch      | 2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch       | 4 ++--
 .../11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch        | 6 +++---
 .../network/12-mac80211-disable-tx-status/net_mac80211_tx.patch     | 4 ++--
 .../network/16-bluetooth/net_bluetooth_l2cap_sock.patch             | 6 +++---
 .../network/17-netdev-queue/net_mac80211_iface.patch                | 4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch                     | 2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch                       | 4 ++--
 .../network/25-multicast-list_head/include_net_mac80211.patch       | 2 +-
 .../network/25-multicast-list_head/net_mac80211_ieee80211_i.patch   | 2 +-
 .../network/25-multicast-list_head/net_mac80211_iface.patch         | 4 ++--
 .../drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch      | 4 ++--
 .../network/30-bridge-port/net_wireless_nl80211.patch               | 2 +-
 .../network/36-workqueue/net_mac80211_main.patch                    | 2 +-
 .../network/42-netlink_seq/net_wireless_nl80211.patch               | 2 +-
 .../drivers_net_wireless_ath_wcn36xx_main.patch                     | 6 +++---
 .../drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch                 | 2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch          | 2 +-
 .../collateral-evolutions/network/77-led-blink-api/mac80211.patch   | 2 +-
 patches/collateral-evolutions/network/81-genl-const/hwsim.patch     | 2 +-
 patches/collateral-evolutions/network/81-genl-const/nl80211.patch   | 6 +++---
 29 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index a5a814a..ab1ed2b 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1621,6 +1621,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1623,6 +1623,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1629,6 +1630,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1631,6 +1632,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index e5901f0..41dd968 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1663,6 +1663,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1664,6 +1664,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1683,6 +1684,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1684,6 +1685,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index df6d643..7b86184 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2790,6 +2790,9 @@ struct wiphy_coalesce_support {
+@@ -2792,6 +2792,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 9679bdf..9b1a6f6 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -912,12 +912,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -909,12 +909,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1612,9 +1621,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1609,9 +1618,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 106b730..9d4cb79 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6065,15 +6065,27 @@ static void wlcore_nvs_cb(const struct f
+@@ -6064,15 +6064,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -28,7 +28,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6119,7 +6131,11 @@ out_unreg:
+@@ -6118,7 +6130,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -40,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6165,7 +6181,12 @@ int wlcore_remove(struct platform_device
+@@ -6164,7 +6180,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index d2c580b..5c933d6 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -846,6 +842,15 @@ static int cfg80211_netdev_notifier_call
+@@ -852,6 +848,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
index 430343b..dbc8ae5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bcma/host_pci.c
 +++ b/drivers/bcma/host_pci.c
-@@ -260,6 +260,9 @@ static int bcma_host_pci_resume(struct d
+@@ -259,6 +259,9 @@ static int bcma_host_pci_resume(struct d
  	return bcma_bus_resume(bus);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(bcma_pm_ops, bcma_host_pci_suspend,
  			 bcma_host_pci_resume);
  #define BCMA_PM_OPS	(&bcma_pm_ops)
-@@ -290,7 +293,12 @@ static struct pci_driver bcma_pci_bridge
+@@ -289,7 +292,12 @@ static struct pci_driver bcma_pci_bridge
  	.id_table = bcma_pci_bridge_tbl,
  	.probe = bcma_host_pci_probe,
  	.remove = bcma_host_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index 4356f2e..5229345 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -838,6 +838,9 @@ static int ath_pci_resume(struct device
+@@ -883,6 +883,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -856,7 +859,12 @@ static struct pci_driver ath_pci_driver
+@@ -901,7 +904,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
index e86b61a..b0cc1d5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3908,7 +3908,12 @@ static struct pci_driver il3945_driver =
+@@ -3907,7 +3907,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index c9b871d..3cadd02 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -446,6 +446,9 @@ static int iwl_pci_resume(struct device
+@@ -467,6 +467,9 @@ static int iwl_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -461,7 +464,12 @@ static struct pci_driver iwl_pci_driver
+@@ -482,7 +485,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
index 07149e2..ac630ed 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_spi.c
 +++ b/drivers/net/wireless/libertas/if_spi.c
-@@ -1245,6 +1245,7 @@ static int libertas_spi_remove(struct sp
+@@ -1244,6 +1244,7 @@ static int libertas_spi_remove(struct sp
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int if_spi_suspend(struct device *dev)
  {
  	struct spi_device *spi = to_spi_device(dev);
-@@ -1278,6 +1279,7 @@ static const struct dev_pm_ops if_spi_pm
+@@ -1277,6 +1278,7 @@ static const struct dev_pm_ops if_spi_pm
  	.suspend	= if_spi_suspend,
  	.resume		= if_spi_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct spi_driver libertas_spi_driver = {
  	.probe	= if_spi_probe,
-@@ -1285,7 +1287,9 @@ static struct spi_driver libertas_spi_dr
+@@ -1284,7 +1286,9 @@ static struct spi_driver libertas_spi_dr
  	.driver = {
  		.name	= "libertas_spi",
  		.owner	= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 2dbe945..ebfbf16 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2024,6 +2024,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2049,6 +2049,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2052,6 +2053,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2077,6 +2078,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 5a9823a..fb4e8cb 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -639,8 +639,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -723,8 +723,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1379,8 +1384,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1521,8 +1526,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1392,7 +1401,11 @@ static int l2cap_sock_create(struct net
+@@ -1534,7 +1543,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 95c1e42..bbdee9c 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1746,6 +1746,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1750,6 +1750,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1782,6 +1783,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1786,6 +1787,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 2dab885..23e3c9b 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1507,6 +1507,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1510,6 +1510,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
index 762bda0..296aa49 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -3039,11 +3039,20 @@ struct wl1271_filter_params {
+@@ -3038,11 +3038,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -21,7 +21,7 @@
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -3052,16 +3061,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -3051,16 +3060,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 1635cd0..6fefdf7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2719,14 +2719,24 @@ struct ieee80211_ops {
+@@ -2759,14 +2759,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 4605cfa..22300b9 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -980,7 +980,12 @@ struct ieee80211_local {
+@@ -1003,7 +1003,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index d196bca..93014c9 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -807,8 +807,13 @@ static void ieee80211_do_stop(struct iee
+@@ -810,8 +810,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1022,10 +1027,20 @@ static void ieee80211_set_multicast_list
+@@ -1027,10 +1032,20 @@ static void ieee80211_set_multicast_list
  	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
  	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
  	    sdata->vif.type != NL80211_IFTYPE_AP)
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
index ee1eb72..5b358f9 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
@@ -18,7 +18,7 @@
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -417,7 +417,7 @@ static void brcmf_ops_sdio_remove(struct
+@@ -432,7 +432,7 @@ static void brcmf_ops_sdio_remove(struct
  	brcmf_dbg(SDIO, "Exit\n");
  }
  
@@ -27,7 +27,7 @@
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -467,7 +467,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -482,7 +482,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
  	.name = BRCMFMAC_SDIO_PDATA_NAME,
  	.id_table = brcmf_sdmmc_ids,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index cd1090b..072db59 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2362,7 +2362,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2363,7 +2363,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index e0c2c04..741dcf6 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1142,6 +1142,10 @@ static void __exit ieee80211_exit(void)
+@@ -1199,6 +1199,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 850c1fb..106783e 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5943,7 +5943,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5959,7 +5959,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
index a6f0c6b..d0c20eb 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/wcn36xx/main.c
 +++ b/drivers/net/wireless/ath/wcn36xx/main.c
-@@ -999,6 +999,7 @@ static int wcn36xx_remove(struct platfor
+@@ -1000,6 +1000,7 @@ static int wcn36xx_remove(struct platfor
  
  	return 0;
  }
@@ -8,7 +8,7 @@
  static const struct platform_device_id wcn36xx_platform_id_table[] = {
  	{
  		.name = "wcn36xx",
-@@ -1007,6 +1008,7 @@ static const struct platform_device_id w
+@@ -1008,6 +1009,7 @@ static const struct platform_device_id w
  	{}
  };
  MODULE_DEVICE_TABLE(platform, wcn36xx_platform_id_table);
@@ -16,7 +16,7 @@
  
  static struct platform_driver wcn36xx_driver = {
  	.probe      = wcn36xx_probe,
-@@ -1015,7 +1017,9 @@ static struct platform_driver wcn36xx_dr
+@@ -1016,7 +1018,9 @@ static struct platform_driver wcn36xx_dr
  		.name   = "wcn36xx",
  		.owner  = THIS_MODULE,
  	},
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
index c5233f4..7db0494 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -387,7 +387,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -397,7 +397,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 694bc4c..1ed8f4d 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8079,7 +8079,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8095,7 +8095,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index 05910bd..efb823c 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1122,6 +1122,9 @@ struct ieee80211_local {
+@@ -1150,6 +1150,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
index 60190bf..4a31f4f 100644
--- a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2105,7 +2105,7 @@ out:
+@@ -2112,7 +2112,7 @@ out:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 6aa8d19..6e50898 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -8874,7 +8874,7 @@ static int nl80211_crit_protocol_stop(st
+@@ -8890,7 +8890,7 @@ static int nl80211_crit_protocol_stop(st
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -8943,7 +8943,7 @@ static int nl80211_pre_doit(const struct
+@@ -8959,7 +8959,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -8960,7 +8960,7 @@ static void nl80211_post_doit(const stru
+@@ -8976,7 +8976,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
-- 
1.8.4.3

