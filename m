Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:33792 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933769AbbKSLdF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 19 Nov 2015 06:33:05 -0500
Received: from a88-113-70-92.elisa-laajakaista.fi ([88.113.70.92] helo=dubbel.amr.corp.intel.com)
	by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.86)
	(envelope-from <luca@coelho.fi>)
	id 1ZzMlj-0005kB-6I
	for backports@vger.kernel.org; Thu, 19 Nov 2015 12:48:47 +0200
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Date: Thu, 19 Nov 2015 12:48:41 +0200
Message-Id: <1447930121-3213-1-git-send-email-luca@coelho.fi> (sfid-20151119_123308_149091_F8DF88BC)
Subject: [PATCH] header: move smp_mb__after_atomic definition to the correct file
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The smp_mb__after_atomic definition is in barrier.h in the mainline,
but we currently include the backport in atomic.h.  This may cause
problems with certain include chain combinations.

Move it to the correct place.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/asm/atomic.h  | 4 ----
 backport/backport-include/asm/barrier.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index c2a46d2..3f09822 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -15,8 +15,4 @@
 #endif
 #endif
 
-#ifndef smp_mb__after_atomic
-#define smp_mb__after_atomic smp_mb__after_clear_bit
-#endif
-
 #endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 3eb7372..537b1aa 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -6,4 +6,8 @@
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
