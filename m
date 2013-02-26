Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/23] compat: do not access default_ethtool_ops
Date: Tue, 26 Feb 2013 21:58:53 +0100
Message-Id: <1361912354-29498-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

&default_ethtool_ops is not exported in kernel 3.7.4 and earlier and it
should be be accessed from compat.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 36f3c50..be77767 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -19,22 +19,12 @@
 #include <linux/netdevice.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5))
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
 	if (!dev->ethtool_ops)
 		dev->ethtool_ops = ops;
 }
-#else /* kernel is between 3.7.0 and 3.7.4 */
-void netdev_set_default_ethtool_ops(struct net_device *dev,
-				    const struct ethtool_ops *ops)
-{
-	if (dev->ethtool_ops == &default_ethtool_ops)
-		dev->ethtool_ops = ops;
-}
-#endif
 
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5) */
-- 
1.7.10.4
