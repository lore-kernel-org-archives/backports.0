Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46006 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab3JYV6g (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:58:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] backports: add dma_set_mask_and_coherent()
Date: Fri, 25 Oct 2013 23:58:24 +0200
Message-Id: <1382738307-16123-2-git-send-email-hauke@hauke-m.de> (sfid-20131025_235838_029484_08BB3CE7)
In-Reply-To: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
References: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dma_set_mask_and_coherent() is used by some Broadcom drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de
---
 backport/backport-include/linux/dma-mapping.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index eb786cf..6c4973a 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -90,4 +90,20 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 #endif /* arm */
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+/*
+ * Set both the DMA mask and the coherent DMA mask to the same thing.
+ * Note that we don't check the return value from dma_set_coherent_mask()
+ * as the DMA API guarantees that the coherent DMA mask can be set to
+ * the same or smaller than the streaming DMA mask.
+ */
+static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
+{
+	int rc = dma_set_mask(dev, mask);
+	if (rc == 0)
+		dma_set_coherent_mask(dev, mask);
+	return rc;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
 #endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
-- 
1.7.10.4

