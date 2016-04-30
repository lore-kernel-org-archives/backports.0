Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49593 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbcD3VBF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/16] backport: add memzero_explicit()
Date: Sat, 30 Apr 2016 23:00:36 +0200
Message-Id: <1462050048-8953-5-git-send-email-hauke@hauke-m.de> (sfid-20160430_230110_462652_6491742A)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

memzero_explicit() was added in Linux commit d4c5efdb9 "random: add and
use memzero_explicit() for clearing data" and is used by skcipher.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/string.h | 17 ++++++++++++++++
 backport/compat/backport-3.18.c          | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index f585862..e8c5cb0 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,4 +8,21 @@
 extern void *memdup_user_nul(const void __user *, size_t);
 #endif
 
+/* this was added in v3.2.65, v3.4.106, v3.10.60, v3.12.33, v3.14.24,
+ * v3.17.3 and v3.18 */
+#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,3) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,24) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,33) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,60) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,106) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,65) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)))
+#define memzero_explicit LINUX_BACKPORT(memzero_explicit)
+void memzero_explicit(void *s, size_t count);
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index f0f7fd8..5c3e751 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -16,6 +16,7 @@
 #include <linux/errqueue.h>
 #include <linux/wait.h>
 #include <linux/of.h>
+#include <linux/string.h>
 
 /**
  * eth_get_headlen - determine the the length of header for an ethernet frame
@@ -286,3 +287,36 @@ int of_property_read_u64_array(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_property_read_u64_array);
 #endif /* CONFIG_OF */
+
+#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,3) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,24) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,33) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,60) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,106) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) || \
+      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,65) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)))
+/**
+ * memzero_explicit - Fill a region of memory (e.g. sensitive
+ *		      keying data) with 0s.
+ * @s: Pointer to the start of the area.
+ * @count: The size of the area.
+ *
+ * Note: usually using memset() is just fine (!), but in cases
+ * where clearing out _local_ data at the end of a scope is
+ * necessary, memzero_explicit() should be used instead in
+ * order to prevent the compiler from optimising away zeroing.
+ *
+ * memzero_explicit() doesn't need an arch-specific version as
+ * it just invokes the one of memset() implicitly.
+ */
+void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
+EXPORT_SYMBOL_GPL(memzero_explicit);
+#endif
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
