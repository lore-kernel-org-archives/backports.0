Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51184 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728547AbeITWKo (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 18:10:44 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 19:26:22 +0300
Message-Id: <20180920162622.30203-1-luca@coelho.fi> (sfid-20180920_182843_962911_C83B0485)
Subject: [PATCH] backport: add ktime_get_raw_ts64() backport for < 3.19
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The getrawmonotonic64() function that is used by the
ktime_get_raw_ts64() backport was only introduced in 3.19.  To fix
compilation with earlier kernels, do the convertion from
getrawmonotonic() manually if the kernel is < 3.19.

Additionally, add timespec_to_timespec64() that we need for this
conversion (and which was only introduced in 4.15).

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index aebb00ca366b..56fca5759b8e 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -55,11 +55,40 @@ static inline void ktime_get_ts64(struct timespec64 *ts)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(3,19,0)
+/* This was introduced in 4.15, but we only need it in the
+ * ktime_get_raw_ts64 backport() for < 3.19.
+ */
+#if __BITS_PER_LONG == 64
+static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
+{
+	return *(const struct timespec64 *)&ts;
+}
+
+#else
+static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
+{
+	struct timespec64 ret;
+
+	ret.tv_sec = ts.tv_sec;
+	ret.tv_nsec = ts.tv_nsec;
+	return ret;
+}
+#endif
+#endif /* < 3.19 */
+
 #if LINUX_VERSION_IS_LESS(4,18,0)
 #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
 static inline void ktime_get_raw_ts64(struct timespec64 *ts)
 {
+#if LINUX_VERSION_IS_LESS(3,19,0)
+	struct timespec64 ts64;
+
+	getrawmonotonic(&ts64);
+	*ts = timespec_to_timespec64(ts64);
+#else
 	return getrawmonotonic64(ts);
+#endif /* < 3.19 */
 }
 #endif
 
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
