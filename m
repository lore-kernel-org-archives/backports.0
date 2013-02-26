Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:34838 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759801Ab3BZVF7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Feb 2013 16:05:59 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 3/8] compat: do not access default_ethtool_ops
Date: Tue, 26 Feb 2013 22:05:40 +0100
Message-Id: <1361912745-29665-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 670c4a3d46797a92fd15d201e5d9859393c7b2b6

&default_ethtool_ops is not exported in kernel 3.7.4 and earlier and it
should be be accessed from compat.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 02353a2..2ea3184 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -11,22 +11,12 @@
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

