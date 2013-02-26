Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 6/8] compat: add compat/compat-3.8.c
Date: Tue, 26 Feb 2013 22:05:43 +0100
Message-Id: <1361912745-29665-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

compat/compat-3.8.c was never build and had a compile error which is
fixed now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/Makefile     |    1 +
 compat/compat-3.8.c |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/Makefile b/compat/Makefile
index e9c6e1f..3adb3a0 100644
--- a/compat/Makefile
+++ b/compat/Makefile
@@ -49,6 +49,7 @@ compat-$(CONFIG_COMPAT_KERNEL_3_5) += \
 	compat-3.5.o \
 	user_namespace.o
 compat-$(CONFIG_COMPAT_KERNEL_3_7) += compat-3.7.o
+compat-$(CONFIG_COMPAT_KERNEL_3_8) += compat-3.8.o
 
 compat-$(CONFIG_COMPAT_CORDIC) += cordic.o
 compat-$(CONFIG_COMPAT_CRC8) += crc8.o
diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 8c1ea6f..91518f2 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -17,4 +17,3 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 		dev->ethtool_ops = ops;
 }
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5) */
-- 
1.7.10.4
