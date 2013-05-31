Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59698 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab3EaTPk (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 May 2013 15:15:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: add backport for netdev_notifier_info_to_dev()
Date: Fri, 31 May 2013 21:15:22 +0200
Message-Id: <1370027724-22627-1-git-send-email-hauke@hauke-m.de> (sfid-20130531_211541_141983_96272DED)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds a backport for the following commit in mainline:
commit 351638e7deeed2ec8ce451b53d33921b3da68f83
Author: Jiri Pirko <jiri@resnulli.us>
Date:   Tue May 28 01:30:21 2013 +0000

    net: pass info struct via netdevice notifier

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 815c8b4..e405c6c 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -467,4 +467,8 @@ struct net *dev_net(const struct net_device *dev)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#define netdev_notifier_info_to_dev(ndev) ndev
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.7.10.4

