Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43458 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932346AbdCINFi (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 9 Mar 2017 08:05:38 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/4] backports: introduce new definition for DECLARE_EWMA macro
Date: Thu,  9 Mar 2017 12:57:32 +0000
Message-Id: <1489064253-3652-4-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140611_189597_39E350D6)
In-Reply-To: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit eb1e011a1474 ("average: change to declare precision,
not factor") the definition of DECLARE_EWMA has changed so we
need a backport for the new macro as it differs. Changing the
strategy by checking the kernel version and #undef the macro to
be sure we do not run into macro redefinition issue.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/average.h | 65 +++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/backport/backport-include/linux/average.h b/backport/backport-include/linux/average.h
index 5d80041..51702fb 100644
--- a/backport/backport-include/linux/average.h
+++ b/backport/backport-include/linux/average.h
@@ -2,45 +2,68 @@
 #define __BACKPORT_AVERAGE
 #include_next <linux/average.h>
 
-#ifndef DECLARE_EWMA
-#define DECLARE_EWMA(name, _factor, _weight)				\
+/*
+ * Exponentially weighted moving average (EWMA)
+ *
+ * This implements a fixed-precision EWMA algorithm, with both the
+ * precision and fall-off coefficient determined at compile-time
+ * and built into the generated helper funtions.
+ *
+ * The first argument to the macro is the name that will be used
+ * for the struct and helper functions.
+ *
+ * The second argument, the precision, expresses how many bits are
+ * used for the fractional part of the fixed-precision values.
+ *
+ * The third argument, the weight reciprocal, determines how the
+ * new values will be weighed vs. the old state, new values will
+ * get weight 1/weight_rcp and old values 1-1/weight_rcp. Note
+ * that this parameter must be a power of two for efficiency.
+ */
+#if LINUX_VERSION_IS_LESS(4, 11, 0)
+#undef DECLARE_EWMA
+#define DECLARE_EWMA(name, _precision, _weight_rcp)			\
 	struct ewma_##name {						\
 		unsigned long internal;					\
 	};								\
 	static inline void ewma_##name##_init(struct ewma_##name *e)	\
 	{								\
-		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
+		/*							\
+		 * Even if you want to feed it just 0/1 you should have	\
+		 * some bits for the non-fractional part...		\
+		 */							\
+		BUILD_BUG_ON((_precision) > 30);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
 		e->internal = 0;					\
 	}								\
 	static inline unsigned long					\
 	ewma_##name##_read(struct ewma_##name *e)			\
 	{								\
-		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
-		return e->internal >> ilog2(_factor);			\
+		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
+		BUILD_BUG_ON((_precision) > 30);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
+		return e->internal >> (_precision);			\
 	}								\
 	static inline void ewma_##name##_add(struct ewma_##name *e,	\
 					     unsigned long val)		\
 	{								\
 		unsigned long internal = ACCESS_ONCE(e->internal);	\
-		unsigned long weight = ilog2(_weight);			\
-		unsigned long factor = ilog2(_factor);			\
+		unsigned long weight_rcp = ilog2(_weight_rcp);		\
+		unsigned long precision = _precision;			\
 									\
-		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
+		BUILD_BUG_ON((_precision) > 30);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
 									\
 		ACCESS_ONCE(e->internal) = internal ?			\
-			(((internal << weight) - internal) +		\
-				(val << factor)) >> weight :		\
-			(val << factor);				\
+			(((internal << weight_rcp) - internal) +	\
+				(val << precision)) >> weight_rcp :	\
+			(val << precision);				\
 	}
-#endif /* DECLARE_EWMA */
+#endif /* LINUX_VERSION_IS_LESS(4, 11, 0) */
 
 #endif /* __BACKPORT_AVERAGE */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
