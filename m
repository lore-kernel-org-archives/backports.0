Return-path: <backports-owner@vger.kernel.org>
Received: from merlin1991.at ([188.40.39.11]:41003 "EHLO merlin1991.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbaFEX22 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 5 Jun 2014 19:28:28 -0400
Received: from chris-laptop3.wien.local (chello084114178111.5.15.vie.surfer.at [84.114.178.111])
	by merlin1991.at (Postfix) with ESMTPSA id 3433B23C00C3
	for <backports@vger.kernel.org>; Fri,  6 Jun 2014 01:28:27 +0200 (CEST)
From: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
To: backports@vger.kernel.org
Subject: [PATCH linux-3.14.y] backports: wrap dma_set_mask_and_coherent in LINUX_BACKPORT()
Date: Fri,  6 Jun 2014 01:28:33 +0200
Message-Id: <1402010913-27202-1-git-send-email-christian.ratzenhofer@cdnm.at> (sfid-20140606_012831_159952_2C596F1A)
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
index 6c4973a..62834d3 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -97,6 +97,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
  * as the DMA API guarantees that the coherent DMA mask can be set to
  * the same or smaller than the streaming DMA mask.
  */
+#define dma_set_mask_and_coherent LINUX_BACKPORT(dma_set_mask_and_coherent)
 static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
 {
 	int rc = dma_set_mask(dev, mask);
-- 
1.7.10.4

