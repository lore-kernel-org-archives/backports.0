Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/24] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:38:06 +0100
Message-Id: <1361911096-29117-15-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Refresh patches on linux-next next-20130208

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0001-netdev_ops.patch  |   14 +++++++-------
 .../network/0003-netdev-needed_headroom_tailroom.patch   |    2 +-
 patches/collateral-evolutions/network/05-usb.patch       |    2 +-
 .../network/08-rename-config-options.patch               |    2 +-
 .../collateral-evolutions/network/11-dev-pm-ops.patch    |    4 ++--
 .../network/12-iw_handler-changes.patch                  |    2 +-
 .../network/12-mac80211-disable-tx-status.patch          |    2 +-
 .../collateral-evolutions/network/14-device-type.patch   |    2 +-
 patches/collateral-evolutions/network/16-bluetooth.patch |   12 ++++++------
 patches/collateral-evolutions/network/24-pcmcia.patch    |    2 +-
 .../network/25-multicast-list_head.patch                 |    4 ++--
 patches/collateral-evolutions/network/36-workqueue.patch |    2 +-
 .../network/40-netdev-hw-features.patch                  |   12 ++++++------
 .../network/47-no_trans_start_on_netdev_queue.patch      |    2 +-
 .../network/61-netdev-addr_assign_type.patch             |    2 +-
 .../network/62-usb_driver_lpm.patch                      |    8 ++++----
 .../network/64-b44-32bit-stats.patch                     |    4 ++--
 17 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index f96ed08..27a47e2 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1448,7 +1448,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1446,7 +1446,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
@@ -82,7 +82,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	wdev->netdev = ndev;
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3442,7 +3442,7 @@ static int rndis_wlan_bind(struct usbnet
+@@ -3439,7 +3439,7 @@ static int rndis_wlan_bind(struct usbnet
  	 * rndis_host wants to avoid all OID as much as possible
  	 * so do promisc/multicast handling in rndis_wlan.
  	 */
@@ -93,7 +93,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	retval = rndis_set_oid(usbdev,
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -2173,7 +2173,7 @@ static int b44_init_one(struct ssb_devic
+@@ -2171,7 +2171,7 @@ static int b44_init_one(struct ssb_devic
  	bp->rx_pending = B44_DEF_RX_RING_PENDING;
  	bp->tx_pending = B44_DEF_TX_RING_PENDING;
  
@@ -104,7 +104,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->irq = sdev->irq;
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6103,7 +6103,7 @@ static struct net_device *ipw2100_alloc_
+@@ -6100,7 +6100,7 @@ static struct net_device *ipw2100_alloc_
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
@@ -190,7 +190,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  }
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2211,7 +2211,7 @@ static int atl1e_init_netdev(struct net_
+@@ -2209,7 +2209,7 @@ static int atl1e_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
@@ -201,7 +201,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	atl1e_set_ethtool_ops(netdev);
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2415,7 +2415,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2413,7 +2413,7 @@ static int atl1c_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
@@ -263,7 +263,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		break;
 --- a/drivers/net/wireless/orinoco/main.c
 +++ b/drivers/net/wireless/orinoco/main.c
-@@ -2278,9 +2278,9 @@ int orinoco_if_add(struct orinoco_privat
+@@ -2272,9 +2272,9 @@ int orinoco_if_add(struct orinoco_privat
  #endif
  	/* Default to standard ops if not set */
  	if (ops)
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
index 2dfab43..c832799 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
@@ -22,7 +22,7 @@ could be used.
  		if (ret < 0) {
 --- a/drivers/net/wireless/orinoco/main.c
 +++ b/drivers/net/wireless/orinoco/main.c
-@@ -2285,7 +2285,11 @@ int orinoco_if_add(struct orinoco_privat
+@@ -2279,7 +2279,11 @@ int orinoco_if_add(struct orinoco_privat
  	/* we use the default eth_mac_addr for setting the MAC addr */
  
  	/* Reserve space in skb for the SNAP header */
diff --git a/patches/collateral-evolutions/network/05-usb.patch b/patches/collateral-evolutions/network/05-usb.patch
index 16d7d8a..4303b56 100644
--- a/patches/collateral-evolutions/network/05-usb.patch
+++ b/patches/collateral-evolutions/network/05-usb.patch
@@ -2,7 +2,7 @@ USB opt soft_unbid was added as of 2.6.27.
 
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1143,7 +1143,9 @@ static struct usb_driver p54u_driver = {
+@@ -1137,7 +1137,9 @@ static struct usb_driver p54u_driver = {
  	.resume = p54u_resume,
  	.reset_resume = p54u_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/08-rename-config-options.patch b/patches/collateral-evolutions/network/08-rename-config-options.patch
index 125109d..7692746 100644
--- a/patches/collateral-evolutions/network/08-rename-config-options.patch
+++ b/patches/collateral-evolutions/network/08-rename-config-options.patch
@@ -170,7 +170,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  #else
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
-@@ -862,7 +862,7 @@ static int rfcomm_sock_ioctl(struct sock
+@@ -860,7 +860,7 @@ static int rfcomm_sock_ioctl(struct sock
  	err = bt_sock_ioctl(sock, cmd, arg);
  
  	if (err == -ENOIOCTLCMD) {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index 600943d..f0d3f42 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -34,7 +34,7 @@ calls on compat code with only slight modifications.
  int __init bcma_host_pci_init(void)
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2688,6 +2688,9 @@ static const struct pci_error_handlers a
+@@ -2686,6 +2686,9 @@ static const struct pci_error_handlers a
  	.resume = atl1c_io_resume,
  };
  
@@ -44,7 +44,7 @@ calls on compat code with only slight modifications.
  static SIMPLE_DEV_PM_OPS(atl1c_pm_ops, atl1c_suspend, atl1c_resume);
  
  static struct pci_driver atl1c_driver = {
-@@ -2697,7 +2700,12 @@ static struct pci_driver atl1c_driver =
+@@ -2695,7 +2698,12 @@ static struct pci_driver atl1c_driver =
  	.remove   = atl1c_remove,
  	.shutdown = atl1c_shutdown,
  	.err_handler = &atl1c_err_handler,
diff --git a/patches/collateral-evolutions/network/12-iw_handler-changes.patch b/patches/collateral-evolutions/network/12-iw_handler-changes.patch
index 5b22ef8..7d89ac0 100644
--- a/patches/collateral-evolutions/network/12-iw_handler-changes.patch
+++ b/patches/collateral-evolutions/network/12-iw_handler-changes.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6106,7 +6106,11 @@ static struct net_device *ipw2100_alloc_
+@@ -6103,7 +6103,11 @@ static struct net_device *ipw2100_alloc_
  	netdev_attach_ops(dev, &ipw2100_netdev_ops);
  	dev->ethtool_ops = &ipw2100_ethtool_ops;
  	dev->wireless_handlers = &ipw2100_wx_handler_def;
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
index 6b639b7..2bc6d3b 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
@@ -14,7 +14,7 @@ So we need to just ifdef this part out.
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2030,6 +2031,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2020,6 +2021,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index df2d2c9..d95f317 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1365,13 +1365,17 @@ static const struct net_device_ops usbne
+@@ -1363,13 +1363,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth.patch
index 22db06b..567c4b4 100644
--- a/patches/collateral-evolutions/network/16-bluetooth.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth.patch
@@ -84,7 +84,7 @@ here still, but for now we keep this here.
  	wake_up_process(session->task);
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -884,8 +884,13 @@ drop:
+@@ -879,8 +879,13 @@ drop:
  	goto done;
  }
  
@@ -98,7 +98,7 @@ here still, but for now we keep this here.
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1059,8 +1064,12 @@ static struct proto hci_sk_proto = {
+@@ -1054,8 +1059,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
@@ -371,7 +371,7 @@ here still, but for now we keep this here.
  }
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
-@@ -306,8 +306,13 @@ static struct sock *rfcomm_sock_alloc(st
+@@ -304,8 +304,13 @@ static struct sock *rfcomm_sock_alloc(st
  	return sk;
  }
  
@@ -385,7 +385,7 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -662,7 +667,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -660,7 +665,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
@@ -462,7 +462,7 @@ here still, but for now we keep this here.
  	struct rfcomm_dlc *dlc = dev->dlc;
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -424,8 +424,12 @@ static struct sock *sco_sock_alloc(struc
+@@ -422,8 +422,12 @@ static struct sock *sco_sock_alloc(struc
  	return sk;
  }
  
@@ -475,7 +475,7 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -676,7 +680,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -674,7 +678,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
diff --git a/patches/collateral-evolutions/network/24-pcmcia.patch b/patches/collateral-evolutions/network/24-pcmcia.patch
index 56c0dfe..3538eb7 100644
--- a/patches/collateral-evolutions/network/24-pcmcia.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia.patch
@@ -1400,7 +1400,7 @@
  	.suspend	= spectrum_cs_suspend,
 --- a/drivers/ssb/main.c
 +++ b/drivers/ssb/main.c
-@@ -510,7 +510,11 @@ static int ssb_devices_register(struct s
+@@ -519,7 +519,11 @@ static int ssb_devices_register(struct s
  			break;
  		case SSB_BUSTYPE_PCMCIA:
  #ifdef CONFIG_SSB_PCMCIAHOST
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index dcbeb6c..6c3dfc5 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -69,7 +69,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -1696,7 +1696,11 @@ static int __b44_load_mcast(struct b44 *
+@@ -1694,7 +1694,11 @@ static int __b44_load_mcast(struct b44 *
  	netdev_for_each_mc_addr(ha, dev) {
  		if (i == num_ents)
  			break;
@@ -480,7 +480,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	return 1; /* update */
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -1632,7 +1632,11 @@ static void set_multicast_list(struct us
+@@ -1629,7 +1629,11 @@ static void set_multicast_list(struct us
  
  		netdev_for_each_mc_addr(ha, usbdev->net)
  			memcpy(mc_addrs + i++ * ETH_ALEN,
diff --git a/patches/collateral-evolutions/network/36-workqueue.patch b/patches/collateral-evolutions/network/36-workqueue.patch
index 60f8804..93246c2 100644
--- a/patches/collateral-evolutions/network/36-workqueue.patch
+++ b/patches/collateral-evolutions/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1173,6 +1173,10 @@ static void __exit ieee80211_exit(void)
+@@ -1171,6 +1171,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features.patch b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
index 475c305..b266f68 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
@@ -84,7 +84,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2404,8 +2417,10 @@ static const struct net_device_ops atl1c
+@@ -2402,8 +2415,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -95,7 +95,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2424,6 +2439,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2422,6 +2437,7 @@ static int atl1c_init_netdev(struct net_
  	atl1c_set_ethtool_ops(netdev);
  
  	/* TODO: add when ready */
@@ -103,7 +103,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	netdev->hw_features =	NETIF_F_SG	   |
  				NETIF_F_HW_CSUM	   |
  				NETIF_F_HW_VLAN_RX |
-@@ -2431,6 +2447,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2429,6 +2445,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features |
  				NETIF_F_HW_VLAN_TX;
@@ -150,7 +150,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1929,7 +1931,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1927,7 +1929,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -162,7 +162,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2199,8 +2205,10 @@ static const struct net_device_ops atl1e
+@@ -2197,8 +2203,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -173,7 +173,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2220,10 +2228,15 @@ static int atl1e_init_netdev(struct net_
+@@ -2218,10 +2226,15 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
index 2c46b9a..573b579 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
@@ -4,7 +4,7 @@ on older kernels.
 
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -374,8 +374,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -371,8 +371,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
index fc3b169..5a1486b 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
@@ -7,7 +7,7 @@ v2.6.36-rc1~571^2~104
 
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2567,7 +2567,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2565,7 +2565,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index 6dfd1f5..787ab07 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -84,7 +84,7 @@
  module_usb_driver(rndis_driver);
 --- a/drivers/net/wireless/at76c50x-usb.c
 +++ b/drivers/net/wireless/at76c50x-usb.c
-@@ -2453,7 +2453,9 @@ static struct usb_driver at76_driver = {
+@@ -2451,7 +2451,9 @@ static struct usb_driver at76_driver = {
  	.probe = at76_probe,
  	.disconnect = at76_disconnect,
  	.id_table = dev_table,
@@ -180,7 +180,7 @@
  module_usb_driver(orinoco_driver);
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1146,7 +1146,9 @@ static struct usb_driver p54u_driver = {
+@@ -1140,7 +1140,9 @@ static struct usb_driver p54u_driver = {
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
@@ -192,7 +192,7 @@
  module_usb_driver(p54u_driver);
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3761,7 +3761,9 @@ static struct usb_driver rndis_wlan_driv
+@@ -3758,7 +3758,9 @@ static struct usb_driver rndis_wlan_driv
  	.disconnect =	usbnet_disconnect,
  	.suspend =	usbnet_suspend,
  	.resume =	usbnet_resume,
@@ -264,7 +264,7 @@
  module_usb_driver(rtl8192cu_driver);
 --- a/drivers/net/wireless/zd1211rw/zd_usb.c
 +++ b/drivers/net/wireless/zd1211rw/zd_usb.c
-@@ -1541,7 +1541,9 @@ static struct usb_driver driver = {
+@@ -1540,7 +1540,9 @@ static struct usb_driver driver = {
  	.disconnect	= disconnect,
  	.pre_reset	= pre_reset,
  	.post_reset	= post_reset,
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
index e5c620c..10f4a79 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
@@ -22,7 +22,7 @@ Date:   Tue Jul 17 17:46:01 2012 +0000
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1641,10 +1642,17 @@ static int b44_close(struct net_device *
+@@ -1639,10 +1640,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -40,7 +40,7 @@ Date:   Tue Jul 17 17:46:01 2012 +0000
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2133,7 +2141,11 @@ static const struct net_device_ops b44_n
+@@ -2131,7 +2139,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
-- 
1.7.10.4
