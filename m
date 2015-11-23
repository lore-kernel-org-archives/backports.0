Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41646 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbbKWXLN (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/14] header: add netif_tx_napi_add()
Date: Tue, 24 Nov 2015 00:11:00 +0100
Message-Id: <1448320264-15070-11-git-send-email-hauke@hauke-m.de> (sfid-20151124_001118_164473_3915A142)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Older kernel versions do not support to only set NAPI for TX queues, so
call the normal NAPI function and do it also for the used RX part.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 86d5ea7..bbe17a1 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -300,4 +300,26 @@ static inline void napi_complete_done(struct napi_struct *n, int work_done)
 }
 #endif /* < 3.19 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
+/**
+ *	netif_tx_napi_add - initialize a napi context
+ *	@dev:  network device
+ *	@napi: napi context
+ *	@poll: polling function
+ *	@weight: default weight
+ *
+ * This variant of netif_napi_add() should be used from drivers using NAPI
+ * to exclusively poll a TX queue.
+ * This will avoid we add it into napi_hash[], thus polluting this hash table.
+ */
+static inline void netif_tx_napi_add(struct net_device *dev,
+				     struct napi_struct *napi,
+				     int (*poll)(struct napi_struct *, int),
+				     int weight)
+{
+	netif_napi_add(dev, napi, poll, weight);
+}
+#endif /* < 4.4 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
