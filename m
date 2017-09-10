Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:45962 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdIJWKr (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] patches: export bp_usbnet_get_stats64() only if function is added
Date: Mon, 11 Sep 2017 00:10:13 +0200
Message-Id: <20170910221020.13067-2-hauke@hauke-m.de> (sfid-20170911_001050_600087_FCE143CE)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Export the bp_usbnet_get_stats64() function only on kernel < 4.11,
because this function is only available on such kernel versions.

Fixes: 5a00d8489c7 ("patches: adapt the stat64 usage for usbnet")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0075-ndo-stats-64/usbnet.patch | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index 09de2784..7b48bfeb 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,20 +1,18 @@
-diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
-index 095bcfd..6305c41 100644
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1014,6 +1014,7 @@
+@@ -1014,6 +1014,9 @@ void usbnet_get_stats64(struct net_devic
  	}
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
++#if LINUX_VERSION_IS_LESS(4,11,0)
 +EXPORT_SYMBOL_GPL(bp_usbnet_get_stats64);
++#endif
  
  u32 usbnet_get_link (struct net_device *net)
  {
-diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
-index 9711637..363f6b9 100644
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -283,5 +283,9 @@ extern void usbnet_status_stop(struct usbnet *dev);
+@@ -283,5 +283,9 @@ extern void usbnet_status_stop(struct us
  extern void usbnet_update_max_qlen(struct usbnet *dev);
  extern void usbnet_get_stats64(struct net_device *dev,
  			       struct rtnl_link_stats64 *stats);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
