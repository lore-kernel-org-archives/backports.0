Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:59183 "EHLO
	sipsolutions.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750938Ab3LTUrx (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 20 Dec 2013 15:47:53 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: backport hex2bin()
Date: Fri, 20 Dec 2013 21:47:26 +0100
Message-Id: <1387572446-4446-1-git-send-email-johannes@sipsolutions.net> (sfid-20131220_214806_107038_C7784BEF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This changed from not having a return value to having one,
so backport the version that has it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kernel.h |  6 ++++++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-3.2.c           | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 backport/compat/backport-3.2.c

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 01e2e9a..0224a69 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -249,6 +249,12 @@ int hex_to_bin(char ch);
 )
 #endif /* rounddown */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+/* kernels before 3.2 didn't have error checking for the function */
+#define hex2bin LINUX_BACKPORT(hex2bin)
+int __must_check hex2bin(u8 *dst, const char *src, size_t count);
+#endif /* < 3.2 */
+
 #endif /* __BACKPORT_KERNEL_H */
 
 /*
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index dbf2bff..69f91e6 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -26,6 +26,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_2_6_37) += compat-2.6.37.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_39) += compat-2.6.39.o kstrtox.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_0) += compat-3.0.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_1) += compat-3.1.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_2) += backport-3.2.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_3) += compat-3.3.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_4) += compat-3.4.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_5) += compat-3.5.o user_namespace.o
diff --git a/backport/compat/backport-3.2.c b/backport/compat/backport-3.2.c
new file mode 100644
index 0000000..601a168
--- /dev/null
+++ b/backport/compat/backport-3.2.c
@@ -0,0 +1,25 @@
+/*
+ * Linux backport symbols for kernels 3.2.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+
+int hex2bin(u8 *dst, const char *src, size_t count)
+{
+	while (count--) {
+		int hi = hex_to_bin(*src++);
+		int lo = hex_to_bin(*src++);
+
+		if ((hi < 0) || (lo < 0))
+			return -1;
+
+		*dst++ = (hi << 4) | lo;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hex2bin);
-- 
1.8.5.1

