Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/23] compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
Date: Tue, 26 Feb 2013 21:59:02 +0100
Message-Id: <1361912354-29498-12-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

netdev_set_default_ethtool_ops() should be added to compat for every
3.7.X series kernel as it is also not in 3.7.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c        |    3 ---
 include/linux/compat-3.8.h |    2 --
 2 files changed, 5 deletions(-)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index be77767..b3d399c 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -18,16 +18,13 @@
 #include "hid-ids.h"
 #include <linux/netdevice.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
 	if (!dev->ethtool_ops)
 		dev->ethtool_ops = ops;
 }
-
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5) */
 
 /* a list of devices that shouldn't be handled by HID core at all */
 static const struct hid_device_id hid_ignore_list[] = {
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 3af253b..b55a46d 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -9,10 +9,8 @@
 #include <linux/netdevice.h>
 #include <linux/efi.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5))
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
-#endif
 
 #define HID_BUS_ANY                            0xffff
 #define HID_GROUP_ANY                          0x0000
-- 
1.7.10.4
