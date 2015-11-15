Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35557 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbbKOP5N (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/15] header: add empty implementation of irq_of_parse_and_map()
Date: Sun, 15 Nov 2015 16:56:54 +0100
Message-Id: <1447603019-11862-11-git-send-email-hauke@hauke-m.de> (sfid-20151115_165717_229562_B705078D)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When CONFIG_OF is not set kernel < 3.5 does not provide an empty
implementation of this function, more recent kernels do so.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of_irq.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 backport/backport-include/linux/of_irq.h

diff --git a/backport/backport-include/linux/of_irq.h b/backport/backport-include/linux/of_irq.h
new file mode 100644
index 0000000..b5cb432
--- /dev/null
+++ b/backport/backport-include/linux/of_irq.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_OF_IRQ_H
+#define __BACKPORT_OF_IRQ_H
+#include_next <linux/of_irq.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) && !defined(CONFIG_OF)
+#define irq_of_parse_and_map LINUX_BACKPORT(irq_of_parse_and_map)
+static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
+						int index)
+{
+	return 0;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) */
+
+#endif /* __BACKPORT_OF_IRQ_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
