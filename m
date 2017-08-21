Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42959 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754429AbdHUW2u (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/21] header: add dma_wmb()
Date: Tue, 22 Aug 2017 00:28:16 +0200
Message-Id: <20170821222817.17376-21-hauke@hauke-m.de> (sfid-20170822_002852_814455_30FA11B9)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the qtnfmac driver.
This was added in commit 1077fa36f23e259 ("arch: Add lightweight memory
barriers dma_rmb() and dma_wmb()")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/barrier.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 9147fb05..9e1e1f11 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -11,6 +11,10 @@
 #define dma_rmb()	rmb()
 #endif
 
+#ifndef dma_wmb
+#define dma_wmb()	wmb()
+#endif
+
 #ifndef smp_mb__after_atomic
 #define smp_mb__after_atomic smp_mb__after_clear_bit
 #endif
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
