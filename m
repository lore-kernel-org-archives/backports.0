Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46034 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364Ab3JYV6u (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:58:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] backports: refresh patches on next-20131004
Date: Fri, 25 Oct 2013 23:58:27 +0200
Message-Id: <1382738307-16123-5-git-send-email-hauke@hauke-m.de> (sfid-20131025_235852_913632_89AAF8B8)
In-Reply-To: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
References: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Manual fixes where needed in:
patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch

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
 .../network/0001-netdev_ops/atl1e.patch               |    2 +-
 .../network/0001-netdev_ops/b44.patch                 |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch             |    2 +-
 .../network/0001-netdev_ops/qmi_wwan.patch            |    2 +-
 .../network/0001-netdev_ops/usbnet.patch              |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch         |   17 ++++++++++-------
 .../net_wireless_core.patch                           |    2 +-
 .../drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch   |    4 ++--
 .../drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch   |    4 ++--
 .../drivers_net_wireless_rtlwifi_rtl8192de_sw.patch   |    4 ++--
 .../drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch   |    4 ++--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch       |    6 +++---
 .../drivers_net_ethernet_broadcom_b44.patch           |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch         |    4 ++--
 ...net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    8 ++++----
 ...rivers_net_ethernet_atheros_atl1e_atl1e_main.patch |   14 ++++++++------
 .../network/61-netdev-addr_assign_type/usbnet.patch   |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch  |    2 +-
 .../drivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch       |    2 +-
 .../drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch   |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch           |    4 ++--
 22 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
index 4f129c9..15a0180 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2236,7 +2236,7 @@ static int atl1e_init_netdev(struct net_
+@@ -2273,7 +2273,7 @@ static int atl1e_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch b/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
index 0747b24..3c1097c 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -2170,7 +2170,7 @@ static int b44_init_one(struct ssb_devic
+@@ -2180,7 +2180,7 @@ static int b44_init_one(struct ssb_devic
  	bp->rx_pending = B44_DEF_RX_RING_PENDING;
  	bp->tx_pending = B44_DEF_TX_RING_PENDING;
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 033ee2c..3b05f25 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -792,7 +792,7 @@ static const struct net_device_ops mwifi
+@@ -794,7 +794,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
index 17bafe5..26f419c 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -331,7 +331,7 @@ next_desc:
+@@ -345,7 +345,7 @@ next_desc:
  		dev->net->dev_addr[0] |= 0x02;	/* set local assignment bit */
  		dev->net->dev_addr[0] &= 0xbf;	/* clear "IP" bit */
  	}
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index e0d6bd4..9ccbc25 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1613,7 +1613,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1619,7 +1619,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 05f6111..a271e47 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,31 +1,34 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5932,13 +5932,24 @@ static void wlcore_nvs_cb(const struct f
+@@ -6036,15 +6036,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 +	irqflags = IRQF_TRIGGER_RISING;
++	hardirq_fn = wlcore_hardirq;
 +#else
- 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ)
+ 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ) {
  		irqflags = IRQF_TRIGGER_RISING;
- 	else
+ 		hardirq_fn = wlcore_hardirq;
+ 	} else {
  		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
+ 	}
 +#endif
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 +	ret = compat_request_threaded_irq(&wl->irq_compat, wl->irq,
-+					  NULL, wlcore_irq,
++					  hardirq_fn, wlcore_irq,
 +					  irqflags,
 +					  pdev->name, wl);
 +#else
- 	ret = request_threaded_irq(wl->irq, NULL, wlcore_irq,
+ 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
  				   irqflags, pdev->name, wl);
 +#endif
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -5984,7 +5995,11 @@ out_unreg:
+@@ -6090,7 +6102,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -37,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6030,7 +6045,12 @@ int wlcore_remove(struct platform_device
+@@ -6136,7 +6152,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index d89c441..c29b907 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -838,6 +834,15 @@ static int cfg80211_netdev_notifier_call
+@@ -843,6 +839,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
index 219654d..5c20431 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
-@@ -387,6 +387,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+@@ -388,6 +388,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
  MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
  MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
  
  static struct pci_driver rtl88ee_driver = {
-@@ -394,7 +397,12 @@ static struct pci_driver rtl88ee_driver
+@@ -395,7 +398,12 @@ static struct pci_driver rtl88ee_driver
  	.id_table = rtl88ee_pci_ids,
  	.probe = rtl_pci_probe,
  	.remove = rtl_pci_disconnect,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
index 6de2fe7..0b74057 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
-@@ -374,6 +374,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+@@ -375,6 +375,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
  MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
  MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
  
  static struct pci_driver rtl92ce_driver = {
-@@ -381,7 +384,12 @@ static struct pci_driver rtl92ce_driver
+@@ -382,7 +385,12 @@ static struct pci_driver rtl92ce_driver
  	.id_table = rtl92ce_pci_ids,
  	.probe = rtl_pci_probe,
  	.remove = rtl_pci_disconnect,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
index 1adbc2e..ddbef97 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192de/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192de/sw.c
-@@ -378,6 +378,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+@@ -379,6 +379,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
  MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
  MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
  
  static struct pci_driver rtl92de_driver = {
-@@ -385,7 +388,12 @@ static struct pci_driver rtl92de_driver
+@@ -386,7 +389,12 @@ static struct pci_driver rtl92de_driver
  	.id_table = rtl92de_pci_ids,
  	.probe = rtl_pci_probe,
  	.remove = rtl_pci_disconnect,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
index 32eca2d..cfecd3f 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
-@@ -367,6 +367,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+@@ -368,6 +368,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
  MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
  MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
  
  static struct pci_driver rtl8723ae_driver = {
-@@ -374,7 +377,12 @@ static struct pci_driver rtl8723ae_drive
+@@ -375,7 +378,12 @@ static struct pci_driver rtl8723ae_drive
  	.id_table = rtl8723ae_pci_ids,
  	.probe = rtl_pci_probe,
  	.remove = rtl_pci_disconnect,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index ff615f8..572c4d9 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -579,8 +579,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -574,8 +574,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1237,8 +1242,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1227,8 +1232,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1250,7 +1259,11 @@ static int l2cap_sock_create(struct net
+@@ -1240,7 +1249,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
index 2e12908..41a7edb 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -1693,7 +1693,11 @@ static int __b44_load_mcast(struct b44 *
+@@ -1703,7 +1703,11 @@ static int __b44_load_mcast(struct b44 *
  	netdev_for_each_mc_addr(ha, dev) {
  		if (i == num_ents)
  			break;
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
index 7ea5d15..71c1cce 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -2939,11 +2939,20 @@ struct wl1271_filter_params {
+@@ -3010,11 +3010,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -21,7 +21,7 @@
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -2952,16 +2961,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -3023,16 +3032,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
index 3ed5e0e..ee3fb0e 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
-@@ -70,7 +70,7 @@ bool
+@@ -65,7 +65,7 @@ bool
  brcmf_pm_resume_error(struct brcmf_sdio_dev *sdiodev)
  {
  	bool is_err = false;
@@ -9,7 +9,7 @@
  	is_err = atomic_read(&sdiodev->suspend);
  #endif
  	return is_err;
-@@ -79,7 +79,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
+@@ -74,7 +74,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
  void
  brcmf_pm_resume_wait(struct brcmf_sdio_dev *sdiodev, wait_queue_head_t *wq)
  {
@@ -18,7 +18,7 @@
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -405,7 +405,7 @@ static void brcmf_ops_sdio_remove(struct
+@@ -400,7 +400,7 @@ static void brcmf_ops_sdio_remove(struct
  	brcmf_dbg(SDIO, "Exit\n");
  }
  
@@ -27,7 +27,7 @@
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -455,7 +455,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -450,7 +450,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
  	.name = BRCMFMAC_SDIO_PDATA_NAME,
  	.id_table = brcmf_sdmmc_ids,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index e521eb3..71d8d65 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -375,6 +375,7 @@ static int atl1e_set_mac_addr(struct net
+@@ -403,6 +403,7 @@ static int atl1e_set_mac_addr(struct net
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static netdev_features_t atl1e_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -400,6 +401,7 @@ static int atl1e_set_features(struct net
+@@ -432,6 +433,7 @@ static int atl1e_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1954,7 +1956,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1991,7 +1993,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -28,7 +28,7 @@
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2224,8 +2230,10 @@ static const struct net_device_ops atl1e
+@@ -2261,8 +2267,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -39,7 +39,7 @@
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2245,10 +2253,15 @@ static int atl1e_init_netdev(struct net_
+@@ -2282,12 +2290,17 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
@@ -48,10 +48,12 @@
  			      NETIF_F_HW_VLAN_CTAG_RX;
  	netdev->features = netdev->hw_features | NETIF_F_LLTX |
  			   NETIF_F_HW_VLAN_CTAG_TX;
+ 	/* not enabled by default */
+ 	netdev->hw_features |= NETIF_F_RXALL | NETIF_F_RXFCS;
 +#else
 +	netdev->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
 +			   NETIF_F_HW_VLAN_RX | NETIF_F_LLTX | NETIF_F_HW_VLAN_TX;
 +#endif
- 
  	return 0;
  }
+ 
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
index a82c478..0a5eba5 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1669,9 +1669,11 @@ usbnet_probe (struct usb_interface *udev
+@@ -1675,9 +1675,11 @@ usbnet_probe (struct usb_interface *udev
  		dev->rx_urb_size = dev->hard_mtu;
  	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
index 2d65822..60cd6c1 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -802,7 +802,9 @@ static struct usb_driver qmi_wwan_driver
+@@ -819,7 +819,9 @@ static struct usb_driver qmi_wwan_driver
  	.resume		      =	qmi_wwan_resume,
  	.reset_resume         = qmi_wwan_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
index 5dcb5a3..68a7c6d 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1505,7 +1505,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1502,7 +1502,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
  	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index c0acdf4..e46c63a 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1379,7 +1379,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1394,7 +1394,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
index 23181a0..c5233f4 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -386,7 +386,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -387,7 +387,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
index 72e1f65..bdda62c 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
@@ -8,7 +8,7 @@
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1636,10 +1637,17 @@ static int b44_close(struct net_device *
+@@ -1646,10 +1647,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -26,7 +26,7 @@
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2128,7 +2136,11 @@ static const struct net_device_ops b44_n
+@@ -2138,7 +2146,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
-- 
1.7.10.4

