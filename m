Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 4/8] compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
Date: Tue, 26 Feb 2013 22:05:41 +0100
Message-Id: <1361912745-29665-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 726d9b2ca3f75cba9f1d03e519c2b2e8bf6523a7

netdev_set_default_ethtool_ops() should be added to compat for every
3.7.X series kernel as it is also not in 3.7.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c        |    2 --
 include/linux/compat-3.8.h |    2 --
 2 files changed, 4 deletions(-)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 2ea3184..8c1ea6f 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -10,13 +10,11 @@
 
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
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5) */
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 1397161..1a3c320 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -7,9 +7,7 @@
 
 #include <linux/netdevice.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5))
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
-#endif
 
 #endif /* LINUX_3_8_COMPAT_H */
-- 
1.7.10.4
