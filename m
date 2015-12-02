Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51784 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214AbbLBI4i (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 2 Dec 2015 03:56:38 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: add ktime_get_boot_ns()
Date: Wed,  2 Dec 2015 09:56:34 +0100
Message-Id: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net> (sfid-20151202_095640_670832_C3102C13)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This small helper inline was added in 3.17, we want to use it now
so need to backport it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index fe42e7170680..4d31580b8757 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_TIMKEEPING_H
 #include <linux/version.h>
 #include <linux/types.h>
+#include <linux/hrtimer.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
 #include_next <linux/timekeeping.h>
@@ -15,6 +16,11 @@ static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
+
+static inline u64 ktime_get_boot_ns(void)
+{
+	return ktime_to_ns(ktime_get_boottime());
+}
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
