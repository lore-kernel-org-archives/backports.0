Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:34745 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab3BZVDn (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Feb 2013 16:03:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 9/9] compat: deactivate netdev_set_default_ethtool_ops() for some 3.7 kernels
Date: Tue, 26 Feb 2013 22:03:12 +0100
Message-Id: <1361912592-29591-10-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
References: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
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
index c913188..4ca7ae4 100644
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

