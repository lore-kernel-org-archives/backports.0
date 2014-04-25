Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11855 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaDYHPE (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Apr 2014 03:15:04 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 1/3] backports: wrap dma_set_mask_and_coherent in LINUX_BACKPORT()
Date: Fri, 25 Apr 2014 09:14:28 +0200
Message-Id: <1398410070-30529-2-git-send-email-sassmann@kpanic.de> (sfid-20140425_091506_994863_5139D278)
In-Reply-To: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
References: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

To avoid conflicts with any distribution kernel wrap
dma_set_mask_and_coherent with LINUX_BACKPORT().

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/dma-mapping.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index 9b2bc90..fdc3331 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -22,6 +22,7 @@ static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
  * as the DMA API guarantees that the coherent DMA mask can be set to
  * the same or smaller than the streaming DMA mask.
  */
+#define dma_set_mask_and_coherent LINUX_BACKPORT(dma_set_mask_and_coherent)
 static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
 {
 	int rc = dma_set_mask(dev, mask);
-- 
1.9.0

