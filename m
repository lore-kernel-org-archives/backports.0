Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40565 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbbAWXUr (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Jan 2015 18:20:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] header: add linux/timecounter.h
Date: Sat, 24 Jan 2015 00:20:38 +0100
Message-Id: <1422055240-4753-2-git-send-email-hauke@hauke-m.de> (sfid-20150124_002049_720713_05341FFF)
In-Reply-To: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
References: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was newly added to the kernel. It was extracted from
linux/clocksource.h.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timecounter.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/timecounter.h

diff --git a/backport/backport-include/linux/timecounter.h b/backport/backport-include/linux/timecounter.h
new file mode 100644
index 0000000..92fafb9
--- /dev/null
+++ b/backport/backport-include/linux/timecounter.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_TIMECOUNTER_H
+#define __BACKPORT_LINUX_TIMECOUNTER_H
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,20,0)
+#include_next <linux/timecounter.h>
+#else
+#include <linux/clocksource.h>
+
+/**
+ * timecounter_adjtime - Shifts the time of the clock.
+ * @delta:	Desired change in nanoseconds.
+ */
+#define timecounter_adjtime LINUX_BACKPORT(timecounter_adjtime)
+static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
+{
+	tc->nsec += delta;
+}
+#endif
+
+#ifndef CYCLECOUNTER_MASK
+/* simplify initialization of mask field */
+#define CYCLECOUNTER_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
+#endif
+
+#endif /* __BACKPORT_LINUX_TIMECOUNTER_H */
-- 
1.9.1

