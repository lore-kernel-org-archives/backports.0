Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37685 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaKPUtj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/20] headers: delete the list in unregister_netdevice_many()
Date: Sun, 16 Nov 2014 21:49:05 +0100
Message-Id: <1416170960-12868-6-git-send-email-hauke@hauke-m.de> (sfid-20141116_214945_171282_ABA4C848)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

unregister_netdevice_many() now deletes the list after running, in the
earlier days mac80211 and so on, did this on their own. We extended the
old unregister_netdevice_many() function for all kernel versions that
do not have a fixed unregister_netdevice_many().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 8826771..4eec6c0 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -176,4 +176,27 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 			 count)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) */
 
+/*
+ * This backports this commit from upstream:
+ * commit 87757a917b0b3c0787e0563c679762152be81312
+ * net: force a list_del() in unregister_netdevice_many()
+ */
+#if (!(LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,45) && \
+       LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) && \
+     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,23) && \
+       LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
+     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,9) && \
+       LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) && \
+     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,2) && \
+       LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)) && \
+     (LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)))
+static inline void backport_unregister_netdevice_many(struct list_head *head)
+{
+	unregister_netdevice_many(head);
+
+	list_del(head);
+}
+#define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

