Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55234 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab3K3Tyw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Nov 2013 14:54:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add backport_ prefix in front of BQL functions
Date: Sat, 30 Nov 2013 20:54:40 +0100
Message-Id: <1385841283-10277-2-git-send-email-hauke@hauke-m.de> (sfid-20131130_205500_699503_C84D8DFC)
In-Reply-To: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
References: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Sometimes these functions are backported in the kernel, add the
backports_ prefix to prevent the names from colliding.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f97e9e1..3d6b7b3 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -157,34 +157,40 @@ static inline int ndo_do_ioctl(struct net_device *dev,
  */
 #ifndef CONFIG_BQL
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+#define netdev_tx_sent_queue LINUX_BACKPORT(netdev_tx_sent_queue)
 static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 					unsigned int bytes)
 {
 }
 #endif
 
+#define netdev_sent_queue LINUX_BACKPORT(netdev_sent_queue)
 static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
 {
 }
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+#define netdev_tx_completed_queue LINUX_BACKPORT(netdev_tx_completed_queue)
 static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
 					     unsigned pkts, unsigned bytes)
 {
 }
 #endif
 
+#define netdev_completed_queue LINUX_BACKPORT(netdev_completed_queue)
 static inline void netdev_completed_queue(struct net_device *dev,
 					  unsigned pkts, unsigned bytes)
 {
 }
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+#define netdev_tx_reset_queue LINUX_BACKPORT(netdev_tx_reset_queue)
 static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 {
 }
 #endif
 
+#define netdev_reset_queue LINUX_BACKPORT(netdev_reset_queue)
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
 }
-- 
1.7.10.4

