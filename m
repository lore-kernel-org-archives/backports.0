Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12496 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbcA1NXm (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Jan 2016 08:23:42 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: change abs() macro so it uses consistent return type
Date: Thu, 28 Jan 2016 15:23:24 +0200
Message-Id: <1453987404-18557-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20160128_142344_289593_33D27ED1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Backport:

commit 8f57e4d930d48217268315898212518d4d3e0773
Author: Michal Nazarewicz <mina86@mina86.com>
Date:   Fri Jan 15 16:57:58 2016 -0800

    include/linux/kernel.h: change abs() macro so it uses consistent return type

Change-Id: I224dc4b3898d7dc402632090b93d7f69866d1e48
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/kernel.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index c0eec2d..7d56f02 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -165,3 +165,31 @@ int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 #ifndef pr_fmt
 #define pr_fmt(msg) msg
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+
+#undef abs
+/**
+ * abs - return absolute value of an argument
+ * @x: the value.  If it is unsigned type, it is converted to signed type first.
+ *     char is treated as if it was signed (regardless of whether it really is)
+ *     but the macro's return type is preserved as char.
+ *
+ * Return: an absolute value of x.
+ */
+#define abs(x)	__abs_choose_expr(x, long long,				\
+		__abs_choose_expr(x, long,				\
+		__abs_choose_expr(x, int,				\
+		__abs_choose_expr(x, short,				\
+		__abs_choose_expr(x, char,				\
+		__builtin_choose_expr(					\
+			__builtin_types_compatible_p(typeof(x), char),	\
+			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
+			((void)0)))))))
+
+#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
+	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
+	__builtin_types_compatible_p(typeof(x), unsigned type),		\
+	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
+
+#endif
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
