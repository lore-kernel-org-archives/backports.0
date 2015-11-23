Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41641 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710AbbKWXLL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/14] header: move smp_mb__after_atomic definition to the correct file
Date: Tue, 24 Nov 2015 00:10:53 +0100
Message-Id: <1448320264-15070-4-git-send-email-hauke@hauke-m.de> (sfid-20151124_001114_570748_7D48F5A0)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The smp_mb__after_atomic definition is in barrier.h in the mainline,
but we currently include the backport in atomic.h.  This may cause
problems with certain include chain combinations.

Move it to the correct place.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/atomic.h  | 4 ----
 backport/backport-include/asm/barrier.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index 9f3543c..d5148f0 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -16,8 +16,4 @@
 #endif
 #endif
 
-#ifndef smp_mb__after_atomic
-#define smp_mb__after_atomic smp_mb__after_clear_bit
-#endif
-
 #endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 7ccf57c..423a581 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -10,4 +10,8 @@
 #define dma_rmb()	rmb()
 #endif
 
+#ifndef smp_mb__after_atomic
+#define smp_mb__after_atomic smp_mb__after_clear_bit
+#endif
+
 #endif /* __BACKPORT_ASM_BARRIER_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
