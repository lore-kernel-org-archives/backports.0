Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59538 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNzz (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:55 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:56 +0200
Message-Id: <20180218132459.11011-8-luca@coelho.fi> (sfid-20180218_145557_190400_B1447278)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 07/10] backports: fix typo "TIMKEEPING" and fix gfp.h
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

There is a typo in the timekeeping.h backport, fix that.
Additionally, fix the gfp.h file tha has a copy/paste issue where
__BACKPORT_TIMKEEPING_H is used instead of __BACKPORT_LINUX_GFP_H.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/gfp.h         | 2 +-
 backport/backport-include/linux/timekeeping.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
index b4db7bb9066e..42f818f1fee3 100644
--- a/backport/backport-include/linux/gfp.h
+++ b/backport/backport-include/linux/gfp.h
@@ -10,4 +10,4 @@
 #define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
 #endif
 
-#endif /* __BACKPORT_TIMKEEPING_H */
+#endif /* __BACKPORT_LINUX_GFP_H */
diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index b683d1298336..0b9c649a3395 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -1,5 +1,5 @@
-#ifndef __BACKPORT_TIMKEEPING_H
-#define __BACKPORT_TIMKEEPING_H
+#ifndef __BACKPORT_TIMEKEEPING_H
+#define __BACKPORT_TIMEKEEPING_H
 #include <linux/version.h>
 #include <linux/types.h>
 
@@ -35,4 +35,4 @@ static inline time64_t ktime_get_seconds(void)
 }
 #endif
 
-#endif /* __BACKPORT_TIMKEEPING_H */
+#endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
