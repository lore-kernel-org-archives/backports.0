Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33281 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2IFTuG (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Sep 2012 15:50:06 -0400
Received: by wgbfm10 with SMTP id fm10so5036708wgb.1
        for <backports@vger.kernel.org>; Thu, 06 Sep 2012 12:50:04 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/2] compat-drivers: Sync with linux-next 20120906
Date: Thu,  6 Sep 2012 22:49:54 +0300
Message-Id: <1346960995-13363-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Refresh patches for next-20120906

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 patches/network/04-netns.patch           |  2 +-
 patches/network/29-sdio_no_suspend.patch |  2 +-
 patches/network/62-usb_driver_lpm.patch  | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/patches/network/04-netns.patch b/patches/network/04-netns.patch
index 70b6f41..07d059e 100644
--- a/patches/network/04-netns.patch
+++ b/patches/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5712,7 +5712,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -5714,7 +5714,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
diff --git a/patches/network/29-sdio_no_suspend.patch b/patches/network/29-sdio_no_suspend.patch
index 247cd1b..5f4c82f 100644
--- a/patches/network/29-sdio_no_suspend.patch
+++ b/patches/network/29-sdio_no_suspend.patch
@@ -60,7 +60,7 @@ suspend and resume that are not backported.
  static int if_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1373,15 +1374,18 @@ static const struct dev_pm_ops if_sdio_p
+@@ -1378,15 +1379,18 @@ static const struct dev_pm_ops if_sdio_p
  	.suspend	= if_sdio_suspend,
  	.resume		= if_sdio_resume,
  };
diff --git a/patches/network/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
index 2ca1fd6..9aeba44 100644
--- a/patches/network/62-usb_driver_lpm.patch
+++ b/patches/network/62-usb_driver_lpm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -450,7 +450,9 @@ static struct usb_driver ath3k_driver =
+@@ -452,7 +452,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
@@ -48,7 +48,7 @@
  module_usb_driver(bpa10x_driver);
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1219,7 +1219,9 @@ static struct usb_driver btusb_driver =
+@@ -1221,7 +1221,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
@@ -204,7 +204,7 @@
  module_usb_driver(rndis_wlan_driver);
 --- a/drivers/net/wireless/rt2x00/rt2500usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2500usb.c
-@@ -1980,7 +1980,9 @@ static struct usb_driver rt2500usb_drive
+@@ -1989,7 +1989,9 @@ static struct usb_driver rt2500usb_drive
  	.disconnect	= rt2x00usb_disconnect,
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
@@ -216,7 +216,7 @@
  module_usb_driver(rt2500usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1304,7 +1304,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1322,7 +1322,9 @@ static struct usb_driver rt2800usb_drive
  	.disconnect	= rt2x00usb_disconnect,
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
@@ -228,7 +228,7 @@
  module_usb_driver(rt2800usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt73usb.c
 +++ b/drivers/net/wireless/rt2x00/rt73usb.c
-@@ -2527,7 +2527,9 @@ static struct usb_driver rt73usb_driver
+@@ -2536,7 +2536,9 @@ static struct usb_driver rt73usb_driver
  	.disconnect	= rt2x00usb_disconnect,
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
-- 
1.7.11.4

