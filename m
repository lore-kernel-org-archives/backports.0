Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48919 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbdHUW2n (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/21] patches: adapt the stat64 usage for usbnet
Date: Tue, 22 Aug 2017 00:28:02 +0200
Message-Id: <20170821222817.17376-7-hauke@hauke-m.de> (sfid-20170822_002845_035104_C626BAE7)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The usbnet driver shares the stat64 implementation over multiple drivers
and file, the spatch is not able to handle this, add a manual patch to
work around this problem.

The spatch is still modifying all usbnet drivers, but the function gets
exported by the usbnet main driver now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0075-ndo-stats-64.cocci        |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 patches/0075-ndo-stats-64/usbnet.patch

diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-64.cocci
index 756be958..86131824 100644
--- a/patches/0075-ndo-stats-64.cocci
+++ b/patches/0075-ndo-stats-64.cocci
@@ -18,7 +18,7 @@ identifier r.stats64_fn;
 @@
 void stats64_fn(...) {...}
 +#if LINUX_VERSION_IS_LESS(4,11,0)
-+static struct rtnl_link_stats64 *
++struct rtnl_link_stats64 *
 +stats64_fn_wrap(struct net_device *dev,
 +		 struct rtnl_link_stats64 *stats)
 +{
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
new file mode 100644
index 00000000..09de2784
--- /dev/null
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -0,0 +1,26 @@
+diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
+index 095bcfd..6305c41 100644
+--- a/drivers/net/usb/usbnet.c
++++ b/drivers/net/usb/usbnet.c
+@@ -1014,6 +1014,7 @@
+ 	}
+ }
+ EXPORT_SYMBOL_GPL(usbnet_get_stats64);
++EXPORT_SYMBOL_GPL(bp_usbnet_get_stats64);
+ 
+ u32 usbnet_get_link (struct net_device *net)
+ {
+diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
+index 9711637..363f6b9 100644
+--- a/include/linux/usb/usbnet.h
++++ b/include/linux/usb/usbnet.h
+@@ -283,5 +283,9 @@ extern void usbnet_status_stop(struct usbnet *dev);
+ extern void usbnet_update_max_qlen(struct usbnet *dev);
+ extern void usbnet_get_stats64(struct net_device *dev,
+ 			       struct rtnl_link_stats64 *stats);
++#if LINUX_VERSION_IS_LESS(4,11,0)
++struct rtnl_link_stats64 *
++bp_usbnet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
++#endif
+ 
+ #endif /* __LINUX_USB_USBNET_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
