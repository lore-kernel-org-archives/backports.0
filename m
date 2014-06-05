Return-path: <backports-owner@vger.kernel.org>
Received: from merlin1991.at ([188.40.39.11]:33956 "EHLO merlin1991.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbaFEXLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 5 Jun 2014 19:11:34 -0400
Received: from chris-laptop3.wien.local (chello084114178111.5.15.vie.surfer.at [84.114.178.111])
	by merlin1991.at (Postfix) with ESMTPSA id CE60D23C00C3
	for <backports@vger.kernel.org>; Fri,  6 Jun 2014 01:02:35 +0200 (CEST)
From: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
To: backports@vger.kernel.org
Subject: [PATCH linux-3.15.y] backports: wrap dma_set_mask_and_coherent in LINUX_BACKPORT()
Date: Fri,  6 Jun 2014 01:02:42 +0200
Message-Id: <1402009362-25432-1-git-send-email-christian.ratzenhofer@cdnm.at> (sfid-20140606_011136_655225_7AC2EF29)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Stefan Assmann <sassmann@kpanic.de>

Upstream commit: 3443187edd32767c838e5d4f654df474e77fb7ce

To avoid conflicts with any distribution kernel wrap
dma_set_mask_and_coherent with LINUX_BACKPORT().

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
---
 backport/backport-include/linux/dma-mapping.h |    1 +
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
1.7.10.4

