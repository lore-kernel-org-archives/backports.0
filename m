Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39343 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3FOPiU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:20 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: move netif_set_real_num_rx_queues() to compat-2.6.37.c
Date: Sat, 15 Jun 2013 17:37:51 +0200
Message-Id: <1371310678-26491-2-git-send-email-hauke@hauke-m.de> (sfid-20130615_173822_950820_916C704B)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

netif_set_real_num_rx_queues() was added to kernel version 2.6.37 and
not to kernel 2.6.35 therefore it should also be added to the
corresponding compat-*.c file.

This also adds a missing EXPORT_SYMBOL, documentation and a check.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat-2.6.35.c |   15 ---------------
 backport/compat/compat-2.6.37.c |   27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/backport/compat/compat-2.6.35.c b/backport/compat/compat-2.6.35.c
index 86ea557..e59cdc1 100644
--- a/backport/compat/compat-2.6.35.c
+++ b/backport/compat/compat-2.6.35.c
@@ -17,21 +17,6 @@
 #include <linux/uaccess.h>
 #include <net/sch_generic.h>
 
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-#ifdef CONFIG_RPS
-int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
-{
-	int rc;
-
-	/* we can't update the sysfs object for older kernels */
-	if (dev->reg_state == NETREG_REGISTERED)
-		return -EINVAL;
-	dev->num_rx_queues = rxq;
-	return 0;
-}
-#endif
-#endif
-
 /*
  * Routine to help set real_num_tx_queues. To avoid skbs mapped to queues
  * greater then real_num_tx_queues stale skbs on the qdisc must be flushed.
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index 5c6cc7b..cc85b15 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -357,3 +357,30 @@ void *vzalloc(unsigned long size)
 	return buf;
 }
 EXPORT_SYMBOL_GPL(vzalloc);
+
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
+#ifdef CONFIG_RPS
+/**
+ *	netif_set_real_num_rx_queues - set actual number of RX queues used
+ *	@dev: Network device
+ *	@rxq: Actual number of RX queues
+ *
+ *	This must be called either with the rtnl_lock held or before
+ *	registration of the net device.  Returns 0 on success, or a
+ *	negative error code.  If called before registration, it always
+ *	succeeds.
+ */
+int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
+{
+	if (rxq < 1 || rxq > dev->num_rx_queues)
+		return -EINVAL;
+
+	/* we can't update the sysfs object for older kernels */
+	if (dev->reg_state == NETREG_REGISTERED)
+		return -EINVAL;
+	dev->num_rx_queues = rxq;
+	return 0;
+}
+EXPORT_SYMBOL(netif_set_real_num_rx_queues);
+#endif
+#endif
-- 
1.7.10.4

