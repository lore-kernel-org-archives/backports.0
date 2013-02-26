Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 5/8] compat: include linux/compat-3.8.h
Date: Tue, 26 Feb 2013 22:05:42 +0100
Message-Id: <1361912745-29665-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This header file was not included in this branch.
This also fixes a compile problem in linux/compat-3.8.h.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.h |    1 +
 include/linux/compat-3.8.h |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index 7a8409f..34c49e6 100644
--- a/include/linux/compat-2.6.h
+++ b/include/linux/compat-2.6.h
@@ -68,6 +68,7 @@ void compat_dependency_symbol(void);
 #include <linux/compat-3.5.h>
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
+#include <linux/compat-3.8.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 1a3c320..60a08d2 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -10,4 +10,6 @@
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
 
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
+
 #endif /* LINUX_3_8_COMPAT_H */
-- 
1.7.10.4
