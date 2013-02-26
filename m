Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:34225 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759012Ab3BZUnE (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Feb 2013 15:43:04 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 6/8] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:42:33 +0100
Message-Id: <1361911355-29256-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
References: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

refreshes patches based on linux 3.8-rc7.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/0001-netdev_ops.patch        |    2 +-
 patches/collateral-evolutions/network/11-dev-pm-ops.patch          |    2 +-
 .../network/12-mac80211-disable-tx-status.patch                    |    4 ++--
 patches/collateral-evolutions/network/14-device-type.patch         |    2 +-
 patches/collateral-evolutions/network/24-pcmcia.patch              |    2 +-
 patches/collateral-evolutions/network/54-get_ts_info.patch         |    2 +-
 patches/collateral-evolutions/network/62-usb_driver_lpm.patch      |    4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index 95f75ee..716bc82 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1423,7 +1423,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1446,7 +1446,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index 4afd308..6a7eb3e 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -164,7 +164,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4906,8 +4906,17 @@ il_pci_resume(struct device *device)
+@@ -4899,8 +4899,17 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
index de53051..6b639b7 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
@@ -6,7 +6,7 @@ So we need to just ifdef this part out.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1989,6 +1989,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1992,6 +1992,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -14,7 +14,7 @@ So we need to just ifdef this part out.
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2027,6 +2028,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2030,6 +2031,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index dff6e69..0ecc24a 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1340,13 +1340,17 @@ static const struct net_device_ops usbne
+@@ -1363,13 +1363,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
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
diff --git a/patches/collateral-evolutions/network/54-get_ts_info.patch b/patches/collateral-evolutions/network/54-get_ts_info.patch
index 7cec3d8..5e5764f 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info.patch
@@ -27,7 +27,7 @@ Date:   Tue Apr 3 22:59:17 2012 +0000
 
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -911,7 +911,9 @@ static const struct ethtool_ops usbnet_e
+@@ -933,7 +933,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index e0d9637..717931e 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -453,7 +453,9 @@ static struct usb_driver ath3k_driver =
+@@ -463,7 +463,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
@@ -48,7 +48,7 @@
  module_usb_driver(bpa10x_driver);
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1224,7 +1224,9 @@ static struct usb_driver btusb_driver =
+@@ -1229,7 +1229,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

