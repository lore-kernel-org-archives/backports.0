Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56022 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQ4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 567547E5D
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:55 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/13] backports: add irq_get_trigger_type()
Date: Sat, 31 May 2014 19:16:07 +0200
Message-Id: <1401556570-3363-11-git-send-email-hauke@hauke-m.de> (sfid-20140531_191657_452951_85EEA827)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function is needed by some drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/irq.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/irq.h

diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
new file mode 100644
index 0000000..8b2804d
--- /dev/null
+++ b/backport/backport-include/linux/irq.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_IRQ_H
+#define __BACKPORT_LINUX_IRQ_H
+#include_next <linux/irq.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+static inline u32 irq_get_trigger_type(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+	return d ? irqd_get_trigger_type(d) : 0;
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_IRQ_H */
-- 
1.9.1

