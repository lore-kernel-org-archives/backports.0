Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 7/8] compat: deactivate netdev_set_default_ethtool_ops() for some 3.7 kernels
Date: Tue, 26 Feb 2013 22:05:44 +0100
Message-Id: <1361912745-29665-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 4971ae5e2075a284ff36a68cab7c3f407a852801

netdev_set_default_ethtool_ops() was backported in 3.7.8 and compat
should not ship it on any more recent versions any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c        |    2 ++
 include/linux/compat-3.8.h |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 91518f2..82730f2 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -10,6 +10,7 @@
 
 #include <linux/netdevice.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
@@ -17,3 +18,4 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 		dev->ethtool_ops = ops;
 }
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
+#endif
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 60a08d2..0879101 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -7,8 +7,10 @@
 
 #include <linux/netdevice.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
+#endif
 
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
 
-- 
1.7.10.4
