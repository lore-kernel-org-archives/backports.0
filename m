Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50912 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab3JEWo4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 10/15] backports: remove ktime_get_monotonic_offset()
Date: Sun,  6 Oct 2013 00:43:59 +0200
Message-Id: <1381013044-7724-11-git-send-email-hauke@hauke-m.de> (sfid-20131006_004457_677220_BE8071FF)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hrtimer.h |   11 -----------
 backport/compat/compat-3.5.c              |   14 --------------
 2 files changed, 25 deletions(-)
 delete mode 100644 backport/backport-include/linux/hrtimer.h

diff --git a/backport/backport-include/linux/hrtimer.h b/backport/backport-include/linux/hrtimer.h
deleted file mode 100644
index c099dd4..0000000
--- a/backport/backport-include/linux/hrtimer.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_LINUX_HRTIMER_H
-#define __BACKPORT_LINUX_HRTIMER_H
-#include_next <linux/hrtimer.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
-#define ktime_get_monotonic_offset LINUX_BACKPORT(ktime_get_monotonic_offset)
-extern ktime_t ktime_get_monotonic_offset(void);
-#endif
-
-#endif /* __BACKPORT_LINUX_HRTIMER_H */
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 7068cfb..95f52b9 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -64,17 +64,3 @@ int overflowgid = DEFAULT_OVERFLOWGID;
 EXPORT_SYMBOL_GPL(overflowuid);
 EXPORT_SYMBOL_GPL(overflowgid);
 #endif
-
-/*
- * We can't access the timekeeper static variable
- * on older kernels so we're shit out of luck and
- * have to rely on time that might jump. Upgrade
- * if you want timestamps that don't jump, this
- * important for DRM vblank and page flip event
- * timestamps.
- */
-ktime_t ktime_get_monotonic_offset(void)
-{
-	return ktime_get();
-}
-EXPORT_SYMBOL_GPL(ktime_get_monotonic_offset);
-- 
1.7.10.4

