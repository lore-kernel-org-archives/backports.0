Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56910 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761464Ab3LIS14 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 13:27:56 -0500
Received: by mail-we0-f174.google.com with SMTP id q58so3844824wes.19
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 10:27:54 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: peter.senna@gmail.com, julia.lawall@lip6.fr, Gilles.Muller@lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: convert the 62-usb_driver_lpm patch series to SmPL
Date: Mon,  9 Dec 2013 19:27:43 +0100
Message-Id: <1386613665-11656-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20131209_192800_083965_BD70A433)
In-Reply-To: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is easily expressed instead as an SmPL patch for
interpretation with Coccinelle. This replaces 336 lines
patch code with 9 lines of SmPL.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/network/62-usb_driver_lpm.cocci    |  9 +++++++++
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch  | 12 ------------
 .../62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch        | 12 ------------
 .../network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch  | 12 ------------
 .../network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch | 12 ------------
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch  | 12 ------------
 .../62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch        | 12 ------------
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch | 12 ------------
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch  | 12 ------------
 .../network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch | 12 ------------
 .../62-usb_driver_lpm/drivers_net_usb_rndis_host.patch       | 12 ------------
 .../62-usb_driver_lpm/drivers_net_usb_sierra_net.patch       | 12 ------------
 .../drivers_net_wireless_at76c50x-usb.patch                  | 12 ------------
 .../drivers_net_wireless_ath_ath6kl_usb.patch                | 12 ------------
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch             | 12 ------------
 .../drivers_net_wireless_ath_carl9170_usb.patch              | 12 ------------
 .../drivers_net_wireless_brcm80211_brcmfmac_usb.patch        | 12 ------------
 .../drivers_net_wireless_libertas_if_usb.patch               | 12 ------------
 .../drivers_net_wireless_libertas_tf_if_usb.patch            | 12 ------------
 .../drivers_net_wireless_orinoco_orinoco_usb.patch           | 12 ------------
 .../62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch  | 12 ------------
 .../62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch  | 12 ------------
 .../drivers_net_wireless_rt2x00_rt2500usb.patch              | 12 ------------
 .../drivers_net_wireless_rt2x00_rt2800usb.patch              | 12 ------------
 .../drivers_net_wireless_rt2x00_rt73usb.patch                | 12 ------------
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch           | 12 ------------
 .../drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch          | 12 ------------
 .../drivers_net_wireless_zd1211rw_zd_usb.patch               | 12 ------------
 .../62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch        | 12 ------------
 29 files changed, 9 insertions(+), 336 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_at76c50x-usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_zd1211rw_zd_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch

diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci b/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
new file mode 100644
index 0000000..60712dc
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
@@ -0,0 +1,9 @@
+@@
+identifier backport_driver;
+@@
+struct usb_driver backport_driver = {
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+	.disable_hub_initiated_lpm = 1,
++#endif
+...
+};
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
deleted file mode 100644
index cbe44c2..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/bluetooth/ath3k.c
-+++ b/drivers/bluetooth/ath3k.c
-@@ -507,7 +507,9 @@ static struct usb_driver ath3k_driver =
- 	.probe		= ath3k_probe,
- 	.disconnect	= ath3k_disconnect,
- 	.id_table	= ath3k_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(ath3k_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch
deleted file mode 100644
index 46466aa..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/bluetooth/bcm203x.c
-+++ b/drivers/bluetooth/bcm203x.c
-@@ -273,7 +273,9 @@ static struct usb_driver bcm203x_driver
- 	.probe		= bcm203x_probe,
- 	.disconnect	= bcm203x_disconnect,
- 	.id_table	= bcm203x_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(bcm203x_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
deleted file mode 100644
index 8e4518d..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/bluetooth/bfusb.c
-+++ b/drivers/bluetooth/bfusb.c
-@@ -730,7 +730,9 @@ static struct usb_driver bfusb_driver =
- 	.probe		= bfusb_probe,
- 	.disconnect	= bfusb_disconnect,
- 	.id_table	= bfusb_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(bfusb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
deleted file mode 100644
index 88253a1..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/bluetooth/bpa10x.c
-+++ b/drivers/bluetooth/bpa10x.c
-@@ -503,7 +503,9 @@ static struct usb_driver bpa10x_driver =
- 	.probe		= bpa10x_probe,
- 	.disconnect	= bpa10x_disconnect,
- 	.id_table	= bpa10x_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(bpa10x_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
deleted file mode 100644
index 73bea26..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/bluetooth/btusb.c
-+++ b/drivers/bluetooth/btusb.c
-@@ -1637,7 +1637,9 @@ static struct usb_driver btusb_driver =
- #endif
- 	.id_table	= btusb_table,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(btusb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
deleted file mode 100644
index 467d4c6..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/cdc_ether.c
-+++ b/drivers/net/usb/cdc_ether.c
-@@ -726,7 +726,9 @@ static struct usb_driver cdc_driver = {
- 	.resume =	usbnet_resume,
- 	.reset_resume =	usbnet_resume,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(cdc_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
deleted file mode 100644
index b58c9bf..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/cdc_mbim.c
-+++ b/drivers/net/usb/cdc_mbim.c
-@@ -481,7 +481,9 @@ static struct usb_driver cdc_mbim_driver
- 	.resume = cdc_mbim_resume,
- 	.reset_resume =	cdc_mbim_resume,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- module_usb_driver(cdc_mbim_driver);
- 
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
deleted file mode 100644
index 27c1ae9..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/cdc_ncm.c
-+++ b/drivers/net/usb/cdc_ncm.c
-@@ -1212,7 +1212,9 @@ static struct usb_driver cdc_ncm_driver
- 	.resume = usbnet_resume,
- 	.reset_resume =	usbnet_resume,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(cdc_ncm_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
deleted file mode 100644
index 4b1511f..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/qmi_wwan.c
-+++ b/drivers/net/usb/qmi_wwan.c
-@@ -818,7 +818,9 @@ static struct usb_driver qmi_wwan_driver
- 	.resume		      =	qmi_wwan_resume,
- 	.reset_resume         = qmi_wwan_resume,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(qmi_wwan_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
deleted file mode 100644
index ff18d42..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/rndis_host.c
-+++ b/drivers/net/usb/rndis_host.c
-@@ -637,7 +637,9 @@ static struct usb_driver rndis_driver =
- 	.disconnect =	usbnet_disconnect,
- 	.suspend =	usbnet_suspend,
- 	.resume =	usbnet_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rndis_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
deleted file mode 100644
index c9060b4..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/sierra_net.c
-+++ b/drivers/net/usb/sierra_net.c
-@@ -959,7 +959,9 @@ static struct usb_driver sierra_net_driv
- 	.suspend = usbnet_suspend,
- 	.resume = usbnet_resume,
- 	.no_dynamic_id = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(sierra_net_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_at76c50x-usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_at76c50x-usb.patch
deleted file mode 100644
index e306366..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_at76c50x-usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/at76c50x-usb.c
-+++ b/drivers/net/wireless/at76c50x-usb.c
-@@ -2451,7 +2451,9 @@ static struct usb_driver at76_driver = {
- 	.probe = at76_probe,
- 	.disconnect = at76_disconnect,
- 	.id_table = dev_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- static int __init at76_mod_init(void)
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
deleted file mode 100644
index f57befe..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/usb.c
-+++ b/drivers/net/wireless/ath/ath6kl/usb.c
-@@ -1225,7 +1225,9 @@ static struct usb_driver ath6kl_usb_driv
- 	.disconnect = ath6kl_usb_remove,
- 	.id_table = ath6kl_usb_ids,
- 	.supports_autosuspend = true,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- static int ath6kl_usb_init(void)
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
deleted file mode 100644
index a25d021..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/hif_usb.c
-+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1368,7 +1368,9 @@ static struct usb_driver ath9k_hif_usb_d
- #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
- 	.soft_unbind = 1,
- #endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- int ath9k_hif_usb_init(void)
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
deleted file mode 100644
index cbd0ee5..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/carl9170/usb.c
-+++ b/drivers/net/wireless/ath/carl9170/usb.c
-@@ -1166,7 +1166,9 @@ static struct usb_driver carl9170_driver
- 	.resume = carl9170_usb_resume,
- 	.reset_resume = carl9170_usb_resume,
- #endif /* CONFIG_PM */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(carl9170_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
deleted file mode 100644
index 68a7c6d..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-+++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1502,7 +1502,9 @@ static struct usb_driver brcmf_usbdrvr =
- 	.resume = brcmf_usb_resume,
- 	.reset_resume = brcmf_usb_reset_resume,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- static void brcmf_release_fw(struct list_head *q)
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
deleted file mode 100644
index b930c58..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/libertas/if_usb.c
-+++ b/drivers/net/wireless/libertas/if_usb.c
-@@ -1010,7 +1010,9 @@ static struct usb_driver if_usb_driver =
- 	.suspend = if_usb_suspend,
- 	.resume = if_usb_resume,
- 	.reset_resume = if_usb_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(if_usb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
deleted file mode 100644
index fdc9253..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/libertas_tf/if_usb.c
-+++ b/drivers/net/wireless/libertas_tf/if_usb.c
-@@ -920,7 +920,9 @@ static struct usb_driver if_usb_driver =
- 	.id_table = if_usb_table,
- 	.suspend = if_usb_suspend,
- 	.resume = if_usb_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(if_usb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
deleted file mode 100644
index d9b1d71..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/orinoco/orinoco_usb.c
-+++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1759,7 +1759,9 @@ static struct usb_driver orinoco_driver
- 	.probe = ezusb_probe,
- 	.disconnect = ezusb_disconnect,
- 	.id_table = ezusb_table,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(orinoco_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
deleted file mode 100644
index 1ec4a59..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/p54/p54usb.c
-+++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1142,7 +1142,9 @@ static struct usb_driver p54u_driver = {
- #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
- 	.soft_unbind = 1,
- #endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(p54u_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
deleted file mode 100644
index e2951e3..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rndis_wlan.c
-+++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3753,7 +3753,9 @@ static struct usb_driver rndis_wlan_driv
- 	.disconnect =	usbnet_disconnect,
- 	.suspend =	usbnet_suspend,
- 	.resume =	usbnet_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rndis_wlan_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
deleted file mode 100644
index d9b1dcc..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rt2x00/rt2500usb.c
-+++ b/drivers/net/wireless/rt2x00/rt2500usb.c
-@@ -1998,7 +1998,9 @@ static struct usb_driver rt2500usb_drive
- 	.suspend	= rt2x00usb_suspend,
- 	.resume		= rt2x00usb_resume,
- 	.reset_resume	= rt2x00usb_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rt2500usb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
deleted file mode 100644
index 328aa57..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rt2x00/rt2800usb.c
-+++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1398,7 +1398,9 @@ static struct usb_driver rt2800usb_drive
- 	.suspend	= rt2x00usb_suspend,
- 	.resume		= rt2x00usb_resume,
- 	.reset_resume	= rt2x00usb_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rt2800usb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
deleted file mode 100644
index 3f1c4b8..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rt2x00/rt73usb.c
-+++ b/drivers/net/wireless/rt2x00/rt73usb.c
-@@ -2548,7 +2548,9 @@ static struct usb_driver rt73usb_driver
- 	.suspend	= rt2x00usb_suspend,
- 	.resume		= rt2x00usb_resume,
- 	.reset_resume	= rt2x00usb_resume,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rt73usb_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
deleted file mode 100644
index 3823436..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
-+++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
-@@ -1678,7 +1678,9 @@ static struct usb_driver rtl8187_driver
- 	.id_table	= rtl8187_table,
- 	.probe		= rtl8187_probe,
- 	.disconnect	= rtl8187_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rtl8187_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
deleted file mode 100644
index 7db0494..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -397,7 +397,9 @@ static struct usb_driver rtl8192cu_drive
- #ifdef CONFIG_AUTOSUSPEND
- 	.supports_autosuspend = 1,
- #endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(rtl8192cu_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_zd1211rw_zd_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_zd1211rw_zd_usb.patch
deleted file mode 100644
index 83f4e42..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_zd1211rw_zd_usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/zd1211rw/zd_usb.c
-+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
-@@ -1540,7 +1540,9 @@ static struct usb_driver driver = {
- 	.disconnect	= disconnect,
- 	.pre_reset	= pre_reset,
- 	.post_reset	= post_reset,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- struct workqueue_struct *zd_workqueue;
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
deleted file mode 100644
index f0ca2a9..0000000
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/usb/class/cdc-wdm.c
-+++ b/drivers/usb/class/cdc-wdm.c
-@@ -1099,7 +1099,9 @@ static struct usb_driver wdm_driver = {
- 	.post_reset =	wdm_post_reset,
- 	.id_table =	wdm_ids,
- 	.supports_autosuspend = 1,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.disable_hub_initiated_lpm = 1,
-+#endif
- };
- 
- module_usb_driver(wdm_driver);
-- 
1.8.4.3

