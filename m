Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 8/8] compat: add include/export.h in compat-3.8.c
Date: Tue, 26 Feb 2013 22:05:45 +0100
Message-Id: <1361912745-29665-9-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is not indirectly included on some kernel versions

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 82730f2..c4b8284 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/export.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
-- 
1.7.10.4
