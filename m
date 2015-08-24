Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59917 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932884AbbHXJTR (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 24 Aug 2015 05:19:17 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: remove AVERAGE, backport DECLARE_EWMA
Date: Mon, 24 Aug 2015 11:19:14 +0200
Message-Id: <1440407954-9633-1-git-send-email-johannes@sipsolutions.net> (sfid-20150824_111922_949412_99752BD1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

My patches to remove the out-of-line EWMA implemenation (under
Kconfig symbol AVERAGE) went into net-next, so now we only need
to backport DECLARE_EWMA as the only necessary macro.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/average.h | 46 +++++++++++++++++++++++++++++++
 backport/compat/Kconfig                   | 11 --------
 2 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 backport/backport-include/linux/average.h

diff --git a/backport/backport-include/linux/average.h b/backport/backport-include/linux/average.h
new file mode 100644
index 000000000000..5d80041fe5e8
--- /dev/null
+++ b/backport/backport-include/linux/average.h
@@ -0,0 +1,46 @@
+#ifndef __BACKPORT_AVERAGE
+#define __BACKPORT_AVERAGE
+#include_next <linux/average.h>
+
+#ifndef DECLARE_EWMA
+#define DECLARE_EWMA(name, _factor, _weight)				\
+	struct ewma_##name {						\
+		unsigned long internal;					\
+	};								\
+	static inline void ewma_##name##_init(struct ewma_##name *e)	\
+	{								\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		e->internal = 0;					\
+	}								\
+	static inline unsigned long					\
+	ewma_##name##_read(struct ewma_##name *e)			\
+	{								\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		return e->internal >> ilog2(_factor);			\
+	}								\
+	static inline void ewma_##name##_add(struct ewma_##name *e,	\
+					     unsigned long val)		\
+	{								\
+		unsigned long internal = ACCESS_ONCE(e->internal);	\
+		unsigned long weight = ilog2(_weight);			\
+		unsigned long factor = ilog2(_factor);			\
+									\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+									\
+		ACCESS_ONCE(e->internal) = internal ?			\
+			(((internal << weight) - internal) +		\
+				(val << factor)) >> weight :		\
+			(val << factor);				\
+	}
+#endif /* DECLARE_EWMA */
+
+#endif /* __BACKPORT_AVERAGE */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index ed600a3e53bb..7c88729c3ec2 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -73,17 +73,6 @@ config BPAUTO_BUILD_CORDIC
 config BPAUTO_CORDIC
 	bool
 
-config BPAUTO_BUILD_AVERAGE
-	bool
-	depends on !AVERAGE
-	default y if BPAUTO_USERSEL_BUILD_ALL
-	default y if BPAUTO_AVERAGE
-	#h-file linux/average.h
-	#c-file lib/average.c
-
-config BPAUTO_AVERAGE
-	bool
-
 config BPAUTO_MII
 	bool
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
