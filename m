Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34298 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbeCDW5v (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/14] header: netdevice.h: Fix netdev_upper_dev_link on 4.14
Date: Sun,  4 Mar 2018 23:57:14 +0100
Message-Id: <20180304225717.20890-12-hauke@hauke-m.de> (sfid-20180304_235801_873038_B9A613C5)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 42ab19ee90292 ("net: Add extack to upper device linking") which
added an extra parameter to netdev_upper_dev_link() was added with
kernel 4.15 and was not backported to kernel 4.14, activate this
backport already for kernel 4.14.

Fixes: 8cdd85766293 ("backports: add netdev_upper_dev_link() extack argument")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d92c95ad..8723f8c5 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -334,7 +334,7 @@ static inline void netif_trans_update(struct net_device *dev)
 	(_dev)->needs_free_netdev = true;
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,14,0)
+#if LINUX_VERSION_IS_LESS(4,15,0)
 static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 					    struct net_device *upper_dev)
 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
