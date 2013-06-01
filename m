Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33245 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab3FAQAn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] backports: do not backport netif_set_real_num_rx_queues() on RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:11 +0200
Message-Id: <1370102417-6711-6-git-send-email-hauke@hauke-m.de> (sfid-20130601_181040_175043_0E4963E3)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The in kernel version of netif_set_real_num_rx_queues() on RHEL 6.4
accesses some other struct members than our backported version. We
should use that version instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |    2 ++
 backport/compat/compat-2.6.35.c             |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index e405c6c..aa1dcd6 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -233,6 +233,7 @@ static inline int register_netdevice_name(struct net_device *dev)
 #define net_ns_type_operations LINUX_BACKPORT(net_ns_type_operations)
 extern struct kobj_ns_type_operations net_ns_type_operations;
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #ifdef CONFIG_RPS
 extern int netif_set_real_num_rx_queues(struct net_device *dev,
 					unsigned int rxq);
@@ -243,6 +244,7 @@ static inline int netif_set_real_num_rx_queues(struct net_device *dev,
 	return 0;
 }
 #endif
+#endif
 #endif /* < 2.6.37 */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
diff --git a/backport/compat/compat-2.6.35.c b/backport/compat/compat-2.6.35.c
index cd556d3..f6e2672 100644
--- a/backport/compat/compat-2.6.35.c
+++ b/backport/compat/compat-2.6.35.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <net/sch_generic.h>
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #ifdef CONFIG_RPS
 int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 {
@@ -29,6 +30,7 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 	return 0;
 }
 #endif
+#endif
 
 /*
  * Routine to help set real_num_tx_queues. To avoid skbs mapped to queues
-- 
1.7.10.4

