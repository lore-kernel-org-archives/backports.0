Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46684 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAex (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:34:53 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/17] backports: add netdev_notify_peers()
Date: Wed,  8 Jan 2014 01:34:19 +0100
Message-Id: <1389141274-2002-3-git-send-email-hauke@hauke-m.de> (sfid-20140108_013454_469269_C731C813)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

netif_notify_peers() was renamed to netdev_notify_peers() in kernel
3.7. Replace the calls to netdev_notify_peers() with
netif_notify_peers().

Some older kernel versions do not even have netif_notify_peers(), there
we just remove the call, currently it is only used in the 6lowpan code
and I assume it will still work, but not so good.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 3d6b7b3..f99ea02 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -475,4 +475,12 @@ struct net *dev_net(const struct net_device *dev)
 #define netdev_notifier_info_to_dev(ndev) ndev
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34) && \
+    LINUX_VERSION_CODE != KERNEL_VERSION(2,6,32)
+/* there is no equivalent function to update arp table */
+#define netdev_notify_peers(dev)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define netdev_notify_peers(dev) netif_notify_peers(dev)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.7.10.4

