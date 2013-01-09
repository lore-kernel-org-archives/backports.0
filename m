Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] compat: add missing return value to netif_set_real_num_tx_queues
Date: Wed,  9 Jan 2013 17:34:20 +0100
Message-Id: <1357749263-4596-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
References: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

compat/compat-2.6.35.o
compat/compat-2.6.35.c: In function ‘netif_set_real_num_tx_queues’:
compat/compat-2.6.35.c:45:1: warning: control reaches end of non-void function [-Wreturn-type]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-2.6.35.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/compat-2.6.35.c b/compat/compat-2.6.35.c
index d33db46..0fc0db2 100644
--- a/compat/compat-2.6.35.c
+++ b/compat/compat-2.6.35.c
@@ -42,12 +42,14 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		dev->real_num_tx_queues = txq;
 		qdisc_reset_all_tx_gt(dev, txq);
 	}
+	return 0;
 }
 #else
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
 	dev->egress_subqueue_count = txq;
 	/* XXX: consider qdisc reset for older kernels */
+	return 0;
 }
 #endif
 EXPORT_SYMBOL_GPL(netif_set_real_num_tx_queues);
-- 
1.7.10.4
