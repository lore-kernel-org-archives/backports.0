Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:33606 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbeIYDqh (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 24 Sep 2018 23:46:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: Add 3. parameter to of_dma_configure()
Date: Mon, 24 Sep 2018 23:42:03 +0200
Message-Id: <20180924214203.26553-1-hauke@hauke-m.de> (sfid-20180924_234232_968572_712CE2B6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

With commit 3d6ce86ee794 ("drivers: remove force dma flag from buses")
in kernel 4.18 of_dma_configure() got the extra parameter force_dma.
This is backported by setting the force_dma member which was added in
commit d89e2378a97f ("drivers: flag buses which demand DMA
configuration") in kernel 4.15.
In older kernel versions we just ignore this parameter as the
of_dma_configure() function internally takes care of setting this
correctly.
Since commit 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with
deferred probing or error") in kernel 4.12 this function returns int and
not void any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of_device.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/of_device.h b/backport/backport-include/linux/of_device.h
index 951b2534..cdd366e3 100644
--- a/backport/backport-include/linux/of_device.h
+++ b/backport/backport-include/linux/of_device.h
@@ -3,9 +3,24 @@
 #include_next <linux/of_device.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
-static inline void of_dma_configure(struct device *dev, struct device_node *np)
-{}
-#endif /* < 4.1.0 */
+#if LINUX_VERSION_IS_LESS(4,18,0)
+static inline int backport_of_dma_configure(struct device *dev,
+					    struct device_node *np,
+					    bool force_dma)
+{
+#if LINUX_VERSION_IS_GEQ(4,15,0)
+	dev->bus->force_dma = force_dma;
+	return of_dma_configure(dev, np);
+#elif LINUX_VERSION_IS_GEQ(4,12,0)
+	return of_dma_configure(dev, np);
+#elif LINUX_VERSION_IS_GEQ(4,1,0)
+	of_dma_configure(dev, np);
+	return 0;
+#else
+	return 0;
+#endif
+}
+#define of_dma_configure LINUX_BACKPORT(of_dma_configure)
+#endif /* < 4.18 */
 
 #endif /* __BP_OF_DEVICE_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
