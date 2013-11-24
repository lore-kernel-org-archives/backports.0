Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48272 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3KXVXn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/15] backports: remove atomic_inc_not_zero_hint()
Date: Sun, 24 Nov 2013 22:23:07 +0100
Message-Id: <1385328198-28520-5-git-send-email-hauke@hauke-m.de> (sfid-20131124_222345_330736_FA5486CF)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

atomic_inc_not_zero_hint() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/atomic.h |   34 ------------------------------
 1 file changed, 34 deletions(-)

diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
index 378b748..41b769b 100644
--- a/backport/backport-include/linux/atomic.h
+++ b/backport/backport-include/linux/atomic.h
@@ -6,41 +6,7 @@
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36))
 #include_next <linux/atomic.h>
 #else
-
 #include <asm/atomic.h>
-
-/**
- * atomic_inc_not_zero_hint - increment if not null
- * @v: pointer of type atomic_t
- * @hint: probable value of the atomic before the increment
- *
- * This version of atomic_inc_not_zero() gives a hint of probable
- * value of the atomic. This helps processor to not read the memory
- * before doing the atomic read/modify/write cycle, lowering
- * number of bus transactions on some arches.
- *
- * Returns: 0 if increment was not done, 1 otherwise.
- */
-#ifndef atomic_inc_not_zero_hint
-static inline int atomic_inc_not_zero_hint(atomic_t *v, int hint)
-{
-	int val, c = hint;
-
-	/* sanity test, should be removed by compiler if hint is a constant */
-	if (!hint)
-		return atomic_inc_not_zero(v);
-
-	do {
-		val = atomic_cmpxchg(v, c, c + 1);
-		if (val == c)
-			return 1;
-		c = val;
-	} while (c);
-
-	return 0;
-}
-#endif
-
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36)) */
 
 #endif	/* _COMPAT_LINUX_ATOMIC_H */
-- 
1.7.10.4

