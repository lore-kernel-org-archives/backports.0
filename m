Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:33994 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbaG0WKy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/9] backports: backport argument change in alloc_netdev_mqs()
Date: Mon, 28 Jul 2014 00:10:33 +0200
Message-Id: <1406499039-16212-4-git-send-email-hauke@hauke-m.de> (sfid-20140728_001102_231943_98722BEB)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

alloc_netdev_mqs() got a new parameter  in kernel 3.17, this patch
removed it from the calls if an older kernel is used. This is safe,
because older kernel versions do not need it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index e2161b7..8826771 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -162,4 +162,18 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define __QUEUE_STATE_STACK_XOFF __QUEUE_STATE_XOFF
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, txqs, rxqs) \
+	alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs)
+
+#undef alloc_netdev
+#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
+	alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
+
+#undef alloc_netdev_mq
+#define alloc_netdev_mq(sizeof_priv, name, name_assign_type, setup, count) \
+	alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, count, \
+			 count)
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

