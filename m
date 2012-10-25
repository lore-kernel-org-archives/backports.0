Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50848 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab2JYWRV (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 25 Oct 2012 18:17:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] compat-drivers: make patches apply again
Date: Fri, 26 Oct 2012 00:17:09 +0200
Message-Id: <1351203430-6865-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/network/21-capi-proc_fops.patch   |    2 +-
 patches/network/62-usb_driver_lpm.patch   |   18 +++++++++---------
 patches/network/99-change-makefiles.patch |    7 ++++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/patches/network/21-capi-proc_fops.patch b/patches/network/21-capi-proc_fops.patch
index 9cd9f4c..7dc92f4 100644
--- a/patches/network/21-capi-proc_fops.patch
+++ b/patches/network/21-capi-proc_fops.patch
@@ -6,7 +6,7 @@ proc_fops: convert drivers/isdn/ to seq_file
 @@ -21,8 +21,10 @@
  */
  
- #include <linux/module.h>
+ #include <linux/export.h>
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
  #include <linux/proc_fs.h>
  #include <linux/seq_file.h>
diff --git a/patches/network/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
index 5f56886..f1073ce 100644
--- a/patches/network/62-usb_driver_lpm.patch
+++ b/patches/network/62-usb_driver_lpm.patch
@@ -108,7 +108,7 @@
  static int ath6kl_usb_init(void)
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1372,7 +1372,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1373,7 +1373,9 @@ static struct usb_driver ath9k_hif_usb_d
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
@@ -120,7 +120,7 @@
  int ath9k_hif_usb_init(void)
 --- a/drivers/net/wireless/ath/carl9170/usb.c
 +++ b/drivers/net/wireless/ath/carl9170/usb.c
-@@ -1159,7 +1159,9 @@ static struct usb_driver carl9170_driver
+@@ -1166,7 +1166,9 @@ static struct usb_driver carl9170_driver
  	.resume = carl9170_usb_resume,
  	.reset_resume = carl9170_usb_resume,
  #endif /* CONFIG_PM */
@@ -168,7 +168,7 @@
  module_usb_driver(if_usb_driver);
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1752,7 +1752,9 @@ static struct usb_driver orinoco_driver
+@@ -1751,7 +1751,9 @@ static struct usb_driver orinoco_driver
  	.probe = ezusb_probe,
  	.disconnect = ezusb_disconnect,
  	.id_table = ezusb_table,
@@ -204,10 +204,10 @@
  module_usb_driver(rndis_wlan_driver);
 --- a/drivers/net/wireless/rt2x00/rt2500usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2500usb.c
-@@ -1988,7 +1988,9 @@ static struct usb_driver rt2500usb_drive
- 	.disconnect	= rt2x00usb_disconnect,
+@@ -1989,7 +1989,9 @@ static struct usb_driver rt2500usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
+ 	.reset_resume	= rt2x00usb_resume,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
  	.disable_hub_initiated_lpm = 1,
 +#endif
@@ -216,10 +216,10 @@
  module_usb_driver(rt2500usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1282,7 +1282,9 @@ static struct usb_driver rt2800usb_drive
- 	.disconnect	= rt2x00usb_disconnect,
+@@ -1283,7 +1283,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
+ 	.reset_resume	= rt2x00usb_resume,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
  	.disable_hub_initiated_lpm = 1,
 +#endif
@@ -228,10 +228,10 @@
  module_usb_driver(rt2800usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt73usb.c
 +++ b/drivers/net/wireless/rt2x00/rt73usb.c
-@@ -2535,7 +2535,9 @@ static struct usb_driver rt73usb_driver
- 	.disconnect	= rt2x00usb_disconnect,
+@@ -2536,7 +2536,9 @@ static struct usb_driver rt73usb_driver
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
+ 	.reset_resume	= rt2x00usb_resume,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
  	.disable_hub_initiated_lpm = 1,
 +#endif
diff --git a/patches/network/99-change-makefiles.patch b/patches/network/99-change-makefiles.patch
index 293add9..1da3353 100644
--- a/patches/network/99-change-makefiles.patch
+++ b/patches/network/99-change-makefiles.patch
@@ -15,7 +15,7 @@ only the wireless stuff.
 -obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
 --- a/drivers/net/usb/Makefile
 +++ b/drivers/net/usb/Makefile
-@@ -2,33 +2,6 @@
+@@ -2,34 +2,7 @@
  # Makefile for USB Network drivers
  #
  
@@ -48,7 +48,8 @@ only the wireless stuff.
 -obj-$(CONFIG_USB_NET_CDC_NCM)	+= cdc_ncm.o
 -obj-$(CONFIG_USB_VL600)		+= lg-vl600.o
 -obj-$(CONFIG_USB_NET_QMI_WWAN)	+= qmi_wwan.o
--
+-obj-$(CONFIG_USB_NET_CDC_MBIM)	+= cdc_mbim.o
+ 
 --- a/drivers/net/wireless/Makefile
 +++ b/drivers/net/wireless/Makefile
 @@ -7,18 +7,8 @@ obj-$(CONFIG_IPW2200) += ipw2x00/
@@ -96,5 +97,5 @@ only the wireless stuff.
 -obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 -
  cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
- cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o
+ cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o
  cfg80211-$(CONFIG_CFG80211_DEBUGFS) += debugfs.o
-- 
1.7.9.5

