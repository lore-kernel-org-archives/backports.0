Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] compat: fix warning of missing struct netdev_queue
Date: Wed,  9 Jan 2013 17:34:19 +0100
Message-Id: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Fix a warning on kernel version <= 2.6.26:
include/linux/compat-3.3.h:44:49: warning: ‘struct netdev_queue’ declared inside parameter list [enabled by default]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.3.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compat-3.3.h b/include/linux/compat-3.3.h
index a8a1d7e..5d07c1a 100644
--- a/include/linux/compat-3.3.h
+++ b/include/linux/compat-3.3.h
@@ -22,28 +22,34 @@
  * inlines if it was defined
  */
 #ifndef CONFIG_BQL
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 					unsigned int bytes)
 {
 }
+#endif
 
 static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
 {
 }
 
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
 					     unsigned pkts, unsigned bytes)
 {
 }
+#endif
 
 static inline void netdev_completed_queue(struct net_device *dev,
 					  unsigned pkts, unsigned bytes)
 {
 }
 
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 {
 }
+#endif
 
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-- 
1.7.10.4
