Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41654 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbbKWXLO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/14] backports: add nsecs_to_jiffies()
Date: Tue, 24 Nov 2015 00:10:59 +0100
Message-Id: <1448320264-15070-10-git-send-email-hauke@hauke-m.de> (sfid-20151124_002251_651048_489D9C17)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This method is declared in the header sine a long time, but the
function is not exported since 3.17. Add it to backports, but rename it
so it will not collide with the original version if it gets exported.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/jiffies.h |  9 ++++++
 backport/compat/backport-3.17.c           | 51 +++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
index 9e74e6a..9cff5e9 100644
--- a/backport/backport-include/linux/jiffies.h
+++ b/backport/backport-include/linux/jiffies.h
@@ -18,4 +18,13 @@
 #define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
 #endif
 
+/*
+ * This function is available, but not exported in kernel < 3.17, add
+ * an own version.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define nsecs_to_jiffies LINUX_BACKPORT(nsecs_to_jiffies)
+extern unsigned long nsecs_to_jiffies(u64 n);
+#endif /* 3.17 */
+
 #endif /* __BACKPORT_LNIUX_JIFFIES_H */
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
index 567f0c3..485f2dc 100644
--- a/backport/compat/backport-3.17.c
+++ b/backport/compat/backport-3.17.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/ktime.h>
+#include <linux/jiffies.h>
 
 int bit_wait(void *word)
 {
@@ -37,3 +38,53 @@ ktime_t ktime_get_raw(void)
 	return timespec_to_ktime(ts);
 }
 EXPORT_SYMBOL_GPL(ktime_get_raw);
+
+
+/**
+ * nsecs_to_jiffies64 - Convert nsecs in u64 to jiffies64
+ *
+ * @n:	nsecs in u64
+ *
+ * Unlike {m,u}secs_to_jiffies, type of input is not unsigned int but u64.
+ * And this doesn't return MAX_JIFFY_OFFSET since this function is designed
+ * for scheduler, not for use in device drivers to calculate timeout value.
+ *
+ * note:
+ *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
+ *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
+ */
+static u64 backport_nsecs_to_jiffies64(u64 n)
+{
+#if (NSEC_PER_SEC % HZ) == 0
+	/* Common case, HZ = 100, 128, 200, 250, 256, 500, 512, 1000 etc. */
+	return div_u64(n, NSEC_PER_SEC / HZ);
+#elif (HZ % 512) == 0
+	/* overflow after 292 years if HZ = 1024 */
+	return div_u64(n * HZ / 512, NSEC_PER_SEC / 512);
+#else
+	/*
+	 * Generic case - optimized for cases where HZ is a multiple of 3.
+	 * overflow after 64.99 years, exact for HZ = 60, 72, 90, 120 etc.
+	 */
+	return div_u64(n * 9, (9ull * NSEC_PER_SEC + HZ / 2) / HZ);
+#endif
+}
+
+/**
+ * nsecs_to_jiffies - Convert nsecs in u64 to jiffies
+ *
+ * @n:	nsecs in u64
+ *
+ * Unlike {m,u}secs_to_jiffies, type of input is not unsigned int but u64.
+ * And this doesn't return MAX_JIFFY_OFFSET since this function is designed
+ * for scheduler, not for use in device drivers to calculate timeout value.
+ *
+ * note:
+ *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
+ *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
+ */
+unsigned long nsecs_to_jiffies(u64 n)
+{
+	return (unsigned long)backport_nsecs_to_jiffies64(n);
+}
+EXPORT_SYMBOL_GPL(nsecs_to_jiffies);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
