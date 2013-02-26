Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 22/23] compat: deactivate netdev_set_default_ethtool_ops() for some 3.7 kernels
Date: Tue, 26 Feb 2013 21:59:13 +0100
Message-Id: <1361912354-29498-23-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

netdev_set_default_ethtool_ops() was backported in 3.7.8 and compat
should not ship it on any more recent versions any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c        |    2 ++
 include/linux/compat-3.8.h |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index b3d399c..8134323 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -18,6 +18,7 @@
 #include "hid-ids.h"
 #include <linux/netdevice.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
@@ -25,6 +26,7 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 		dev->ethtool_ops = ops;
 }
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
+#endif
 
 /* a list of devices that shouldn't be handled by HID core at all */
 static const struct hid_device_id hid_ignore_list[] = {
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 545e9f0..4aeffdb 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -9,8 +9,10 @@
 #include <linux/netdevice.h>
 #include <linux/efi.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
+#endif
 
 #define HID_BUS_ANY                            0xffff
 #define HID_GROUP_ANY                          0x0000
-- 
1.7.10.4
