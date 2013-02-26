Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/23] compat: backport BUILD_BUG_ON from recent kernel
Date: Tue, 26 Feb 2013 21:59:01 +0100
Message-Id: <1361912354-29498-11-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This version of BUILD_BUG_ON does not have the following error on an
old kernel version (2.6.32 - 2.6.37):

drivers/net/wireless/iwlwifi/mvm/quota.c:145:24: error: bit-field
'<anonymous>' width not an integer constant

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.38.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/compat-2.6.38.h b/include/linux/compat-2.6.38.h
index 0aa5d9b..8dfeed6 100644
--- a/include/linux/compat-2.6.38.h
+++ b/include/linux/compat-2.6.38.h
@@ -139,6 +139,41 @@ static inline int is_unicast_ether_addr(const u8 *addr)
 	return !is_multicast_ether_addr(addr);
 }
 
+/* Backport of:
+ *
+ * commit 7ef88ad561457c0346355dfd1f53e503ddfde719
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * Date:   Mon Jan 24 14:45:10 2011 -0600
+ *
+ *     BUILD_BUG_ON: make it handle more cases
+ */
+#undef BUILD_BUG_ON
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ *
+ * The implementation uses gcc's reluctance to create a negative array, but
+ * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
+ * to inline functions).  So as a fallback we use the optimizer; if it can't
+ * prove the condition is false, it will cause a link error on the undefined
+ * "__build_bug_on_failed".  This error message can be harder to track down
+ * though, hence the two different methods.
+ */
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+#else
+extern int __build_bug_on_failed;
+#define BUILD_BUG_ON(condition)					\
+	do {							\
+		((void)sizeof(char[1 - 2*!!(condition)]));	\
+		if (condition) __build_bug_on_failed = 1;	\
+	} while(0)
+#endif
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)) */
 
 #endif /* LINUX_26_38_COMPAT_H */
-- 
1.7.10.4
