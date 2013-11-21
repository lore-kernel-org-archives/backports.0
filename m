Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37759 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab3KUWlu (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:41:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh on next-20131121
Date: Thu, 21 Nov 2013 23:41:29 +0100
Message-Id: <1385073689-10441-3-git-send-email-hauke@hauke-m.de> (sfid-20131121_234152_334113_4614C158)
In-Reply-To: <1385073689-10441-1-git-send-email-hauke@hauke-m.de>
References: <1385073689-10441-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.24              [  FAIL  ]
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
17  3.0.101             [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.17             [  OK  ]
20  3.11.6              [  OK  ]
21  3.12-rc7            [  OK  ]
22  3.2.52              [  OK  ]
23  3.3.8               [  OK  ]
24  3.4.67              [  OK  ]
25  3.5.7               [  OK  ]
26  3.6.11              [  OK  ]
27  3.7.10              [  OK  ]
28  3.8.13              [  OK  ]
29  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0006-disable-dump-adjust-on-old-kernels.patch      |    4 ++--
 .../drivers_net_ethernet_atheros_alx_main.patch        |    4 ++--
 .../drivers_net_wireless_mwifiex_pcie.patch            |    4 ++--
 .../drivers_net_wireless_ipw2x00_ipw2100.patch         |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch            |   10 +++++-----
 .../network/30-bridge-port/net_wireless_nl80211.patch  |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch        |   10 +++++-----
 ...drivers_net_ethernet_atheros_atl1c_atl1c_main.patch |   12 ++++++------
 ...drivers_net_ethernet_atheros_atl1e_atl1e_main.patch |   10 +++++-----
 .../drivers_net_ethernet_atheros_atlx_atl2.patch       |   16 ++++++++--------
 .../drivers_net_ethernet_atheros_atlx_atlx.patch       |    4 ++--
 .../drivers_net_wireless_ath_ath6kl_main.patch         |    4 ++--
 .../drivers_net_wireless_ath_wil6210_netdev.patch      |    2 +-
 .../network/42-netlink_seq/net_wireless_nl80211.patch  |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch        |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch        |    2 +-
 ...drivers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../network/61-netdev-addr_assign_type/usbnet.patch    |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_btusb.patch    |    2 +-
 .../drivers_net_wireless_rndis_wlan.patch              |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch            |    2 +-
 .../drivers_net_wireless_libertas_main.patch           |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch     |    2 +-
 .../network/78-usb-sg/usbnet.patch                     |   12 ++++++------
 24 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index ecb3c91..e5901f0 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1644,6 +1644,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1663,6 +1663,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1664,6 +1665,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1683,6 +1684,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index b4fbfac..41502dd 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1395,6 +1395,9 @@ static int alx_resume(struct device *dev
+@@ -1398,6 +1398,9 @@ static int alx_resume(struct device *dev
  	return __alx_open(alx, true);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1497,7 +1500,12 @@ static struct pci_driver alx_driver = {
+@@ -1500,7 +1503,12 @@ static struct pci_driver alx_driver = {
  	.probe       = alx_probe,
  	.remove      = alx_remove,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
index 4b76db3..2c4ac40 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/pcie.c
 +++ b/drivers/net/wireless/mwifiex/pcie.c
-@@ -260,6 +260,9 @@ static DEFINE_PCI_DEVICE_TABLE(mwifiex_i
+@@ -259,6 +259,9 @@ static DEFINE_PCI_DEVICE_TABLE(mwifiex_i
  MODULE_DEVICE_TABLE(pci, mwifiex_ids);
  
  #ifdef CONFIG_PM_SLEEP
@@ -10,7 +10,7 @@
  /* Power Management Hooks */
  static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
  				mwifiex_pcie_resume);
-@@ -272,9 +275,14 @@ static struct pci_driver __refdata mwifi
+@@ -271,9 +274,14 @@ static struct pci_driver __refdata mwifi
  	.probe    = mwifiex_pcie_probe,
  	.remove   = mwifiex_pcie_remove,
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
index 1d515a7..8a3a80d 100644
--- a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ b/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
 @@ -6071,7 +6071,11 @@ static struct net_device *ipw2100_alloc_
- 	netdev_attach_ops(dev, &ipw2100_netdev_ops);
+ 	dev->netdev_ops = &ipw2100_netdev_ops;
  	dev->ethtool_ops = &ipw2100_ethtool_ops;
  	dev->wireless_handlers = &ipw2100_wx_handler_def;
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 3dc2888..11a3039 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -11,15 +11,15 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -201,6 +203,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
- 	kfree(card);
+@@ -200,6 +202,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+ 	mwifiex_remove_card(card->adapter, &add_remove_card_sem);
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
  /*
   * SDIO suspend.
   *
-@@ -255,6 +258,7 @@ static int mwifiex_sdio_suspend(struct d
+@@ -254,6 +257,7 @@ static int mwifiex_sdio_suspend(struct d
  
  	return ret;
  }
@@ -27,7 +27,7 @@
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -280,10 +284,12 @@ static const struct sdio_device_id mwifi
+@@ -279,10 +283,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +40,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -292,7 +298,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -291,7 +297,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index addbdc7..cd1090b 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2343,7 +2343,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2362,7 +2362,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 5360471..af38787 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -737,6 +737,7 @@ static int alx_init_sw(struct alx_priv *
+@@ -733,6 +733,7 @@ static int alx_init_sw(struct alx_priv *
  }
  
  
@@ -8,7 +8,7 @@
  static netdev_features_t alx_fix_features(struct net_device *netdev,
  					  netdev_features_t features)
  {
-@@ -745,6 +746,7 @@ static netdev_features_t alx_fix_feature
+@@ -741,6 +742,7 @@ static netdev_features_t alx_fix_feature
  
  	return features;
  }
@@ -16,7 +16,7 @@
  
  static void alx_netif_stop(struct alx_priv *alx)
  {
-@@ -821,7 +823,17 @@ static int alx_change_mtu(struct net_dev
+@@ -817,7 +819,17 @@ static int alx_change_mtu(struct net_dev
  	alx->hw.mtu = mtu;
  	alx->rxbuf_size = mtu > ALX_DEF_RXBUF_SIZE ?
  			   ALIGN(max_frame, 8) : ALX_DEF_RXBUF_SIZE;
@@ -34,7 +34,7 @@
  	if (netif_running(netdev))
  		alx_reinit(alx);
  	return 0;
-@@ -1180,7 +1192,9 @@ static const struct net_device_ops alx_n
+@@ -1176,7 +1188,9 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1298,7 +1312,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1294,7 +1308,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index 72d672b..c2a1f19 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -496,6 +496,7 @@ static void atl1c_set_rxbufsize(struct a
+@@ -492,6 +492,7 @@ static void atl1c_set_rxbufsize(struct a
  	adapter->rx_frag_size = roundup_pow_of_two(head_size);
  }
  
@@ -8,7 +8,7 @@
  static netdev_features_t atl1c_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -524,6 +525,7 @@ static int atl1c_set_features(struct net
+@@ -520,6 +521,7 @@ static int atl1c_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  /**
   * atl1c_change_mtu - Change the Maximum Transfer Unit
-@@ -556,8 +558,19 @@ static int atl1c_change_mtu(struct net_d
+@@ -552,8 +554,19 @@ static int atl1c_change_mtu(struct net_d
  		netdev->mtu = new_mtu;
  		adapter->hw.max_frame_size = new_mtu;
  		atl1c_set_rxbufsize(adapter, netdev);
@@ -36,7 +36,7 @@
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2497,8 +2510,10 @@ static const struct net_device_ops atl1c
+@@ -2493,8 +2506,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -47,7 +47,7 @@
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2516,6 +2531,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2512,6 +2527,7 @@ static int atl1c_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1c_set_ethtool_ops(netdev);
  
@@ -55,7 +55,7 @@
  	/* TODO: add when ready */
  	netdev->hw_features =	NETIF_F_SG		|
  				NETIF_F_HW_CSUM		|
-@@ -2524,6 +2540,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2520,6 +2536,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features	|
  				NETIF_F_HW_VLAN_CTAG_TX;
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index 71d8d65..6927a57 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -403,6 +403,7 @@ static int atl1e_set_mac_addr(struct net
+@@ -399,6 +399,7 @@ static int atl1e_set_mac_addr(struct net
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static netdev_features_t atl1e_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -432,6 +433,7 @@ static int atl1e_set_features(struct net
+@@ -428,6 +429,7 @@ static int atl1e_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1991,7 +1993,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1987,7 +1989,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -28,7 +28,7 @@
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2261,8 +2267,10 @@ static const struct net_device_ops atl1e
+@@ -2257,8 +2263,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -39,7 +39,7 @@
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2282,12 +2290,17 @@ static int atl1e_init_netdev(struct net_
+@@ -2278,12 +2286,17 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
index 95b77e1..f2f05c7 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl2.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl2.c
-@@ -365,6 +365,7 @@ static inline void atl2_irq_disable(stru
+@@ -361,6 +361,7 @@ static inline void atl2_irq_disable(stru
      synchronize_irq(adapter->pdev->irq);
  }
  
@@ -8,7 +8,7 @@
  static void __atl2_vlan_mode(netdev_features_t features, u32 *ctrl)
  {
  	if (features & NETIF_F_HW_VLAN_CTAG_RX) {
-@@ -390,12 +391,16 @@ static void atl2_vlan_mode(struct net_de
+@@ -386,12 +387,16 @@ static void atl2_vlan_mode(struct net_de
  
  	atl2_irq_enable(adapter);
  }
@@ -25,7 +25,7 @@
  static netdev_features_t atl2_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -421,6 +426,7 @@ static int atl2_set_features(struct net_
+@@ -417,6 +422,7 @@ static int atl2_set_features(struct net_
  
  	return 0;
  }
@@ -33,7 +33,7 @@
  
  static void atl2_intr_rx(struct atl2_adapter *adapter)
  {
-@@ -1154,7 +1160,9 @@ static void atl2_setup_mac_ctrl(struct a
+@@ -1150,7 +1156,9 @@ static void atl2_setup_mac_ctrl(struct a
  		MAC_CTRL_PRMLEN_SHIFT);
  
  	/* vlan */
@@ -43,7 +43,7 @@
  
  	/* filter mode */
  	value |= MAC_CTRL_BC_EN;
-@@ -1319,8 +1327,10 @@ static const struct net_device_ops atl2_
+@@ -1315,8 +1323,10 @@ static const struct net_device_ops atl2_
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl2_set_mac,
  	.ndo_change_mtu		= atl2_change_mtu,
@@ -54,7 +54,7 @@
  	.ndo_do_ioctl		= atl2_ioctl,
  	.ndo_tx_timeout		= atl2_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -1417,8 +1427,12 @@ static int atl2_probe(struct pci_dev *pd
+@@ -1413,8 +1423,12 @@ static int atl2_probe(struct pci_dev *pd
  
  	err = -EIO;
  
@@ -67,7 +67,7 @@
  
  	/* Init PHY as early as possible due to power saving issue  */
  	atl2_phy_init(&adapter->hw);
-@@ -2092,6 +2106,13 @@ static int atl2_nway_reset(struct net_de
+@@ -2088,6 +2102,13 @@ static int atl2_nway_reset(struct net_de
  	return 0;
  }
  
@@ -81,7 +81,7 @@
  static const struct ethtool_ops atl2_ethtool_ops = {
  	.get_settings		= atl2_get_settings,
  	.set_settings		= atl2_set_settings,
-@@ -2107,6 +2128,14 @@ static const struct ethtool_ops atl2_eth
+@@ -2103,6 +2124,14 @@ static const struct ethtool_ops atl2_eth
  	.get_eeprom_len		= atl2_get_eeprom_len,
  	.get_eeprom		= atl2_get_eeprom,
  	.set_eeprom		= atl2_set_eeprom,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
index 6dd8287..c315e36 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atlx.c
 +++ b/drivers/net/ethernet/atheros/atlx/atlx.c
-@@ -254,6 +254,7 @@ static void atlx_restore_vlan(struct atl
+@@ -250,6 +250,7 @@ static void atlx_restore_vlan(struct atl
  	atlx_vlan_mode(adapter->netdev, adapter->netdev->features);
  }
  
@@ -8,7 +8,7 @@
  static netdev_features_t atlx_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -279,5 +280,6 @@ static int atlx_set_features(struct net_
+@@ -275,5 +276,6 @@ static int atlx_set_features(struct net_
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
index 94e4c4a..f59f657 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
@@ -16,7 +16,7 @@
  
  static void ath6kl_set_multicast_list(struct net_device *ndev)
  {
-@@ -1298,7 +1300,9 @@ static const struct net_device_ops ath6k
+@@ -1286,7 +1288,9 @@ static const struct net_device_ops ath6k
  	.ndo_stop               = ath6kl_close,
  	.ndo_start_xmit         = ath6kl_data_tx,
  	.ndo_get_stats          = ath6kl_get_stats,
@@ -26,7 +26,7 @@
  	.ndo_set_rx_mode	= ath6kl_set_multicast_list,
  };
  
-@@ -1315,7 +1319,11 @@ void init_netdev(struct net_device *dev)
+@@ -1303,7 +1307,11 @@ void init_netdev(struct net_device *dev)
  					WMI_MAX_TX_META_SZ +
  					ATH6KL_HTC_ALIGN_BYTES, 4);
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
index 5f3e636..cdf75c5 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
@@ -2,7 +2,7 @@
 +++ b/drivers/net/wireless/ath/wil6210/netdev.c
 @@ -127,7 +127,9 @@ void *wil_if_alloc(struct device *dev, v
  
- 	netdev_attach_ops(ndev, &wil_netdev_ops);
+ 	ndev->netdev_ops = &wil_netdev_ops;
  	ndev->ieee80211_ptr = wdev;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index b34a124..17e0e02 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5920,7 +5920,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5939,7 +5939,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index 6118d59..5e2cfaa 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1029,7 +1029,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1026,7 +1026,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
index a492664..f3e25d8 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -499,8 +499,10 @@ static int alx_set_mac_address(struct ne
+@@ -495,8 +495,10 @@ static int alx_set_mac_address(struct ne
  	if (!is_valid_ether_addr(addr->sa_data))
  		return -EADDRNOTAVAIL;
  
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index 6494b84..6961c1a 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2660,7 +2660,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2656,7 +2656,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
index 0a5eba5..11338bd 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1675,9 +1675,11 @@ usbnet_probe (struct usb_interface *udev
+@@ -1672,9 +1672,11 @@ usbnet_probe (struct usb_interface *udev
  		dev->rx_urb_size = dev->hard_mtu;
  	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 9cc0340..73bea26 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1634,7 +1634,9 @@ static struct usb_driver btusb_driver =
+@@ -1637,7 +1637,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
index 7216a7b..e2951e3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3757,7 +3757,9 @@ static struct usb_driver rndis_wlan_driv
+@@ -3753,7 +3753,9 @@ static struct usb_driver rndis_wlan_driv
  	.disconnect =	usbnet_disconnect,
  	.suspend =	usbnet_suspend,
  	.resume =	usbnet_resume,
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
index bdda62c..bbb8c97 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
@@ -26,7 +26,7 @@
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2138,7 +2146,11 @@ static const struct net_device_ops b44_n
+@@ -2134,7 +2142,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
diff --git a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch b/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
index c255478..6cd74c5 100644
--- a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
+++ b/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/main.c
 +++ b/drivers/net/wireless/libertas/main.c
-@@ -590,7 +590,11 @@ static int lbs_thread(void *data)
+@@ -574,7 +574,11 @@ static int lbs_thread(void *data)
  
  			/* Reset card, but only when it isn't in the process
  			 * of being shutdown anyway. */
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 769e850..59d5aec 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8060,7 +8060,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8075,7 +8075,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index 08499d8..6e2cdfe 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1234,6 +1234,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1231,6 +1231,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1266,6 +1267,12 @@ static int build_dma_sg(const struct sk_
+@@ -1263,6 +1264,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1322,12 +1329,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1319,12 +1326,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1382,7 +1396,9 @@ not_drop:
+@@ -1379,7 +1393,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1435,7 +1451,9 @@ static void usbnet_bh (unsigned long par
+@@ -1432,7 +1448,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1790,7 +1808,9 @@ int usbnet_resume (struct usb_interface
+@@ -1787,7 +1805,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
-- 
1.7.10.4

