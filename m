Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49609 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/16] backports: add kstrtobool() and kstrtobool_from_user()
Date: Sat, 30 Apr 2016 23:00:42 +0200
Message-Id: <1462050048-8953-11-git-send-email-hauke@hauke-m.de> (sfid-20160430_230721_595418_57E719FC)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kstrtobool was added in Linux commit a21d167dc "lib: move strtobool()
to kstrtobool()".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h |  7 +++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-4.6.c           | 77 ++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 backport/compat/backport-4.6.c

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 54050aa..f47b21f 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -153,6 +153,13 @@ int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
 #endif /* < 3.18 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#define kstrtobool LINUX_BACKPORT(kstrtobool)
+int __must_check kstrtobool(const char *s, bool *res);
+#define kstrtobool_from_user LINUX_BACKPORT(kstrtobool_from_user)
+int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
 
 #undef abs
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 76d71e7..7651f83 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -31,6 +31,7 @@ compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
+compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
diff --git a/backport/compat/backport-4.6.c b/backport/compat/backport-4.6.c
new file mode 100644
index 0000000..54ff669
--- /dev/null
+++ b/backport/compat/backport-4.6.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright(c) 2016 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.6.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/export.h>
+
+/**
+ * kstrtobool - convert common user inputs into boolean values
+ * @s: input string
+ * @res: result
+ *
+ * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
+ * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
+ * pointed to by res is updated upon finding a match.
+ */
+int kstrtobool(const char *s, bool *res)
+{
+	if (!s)
+		return -EINVAL;
+
+	switch (s[0]) {
+	case 'y':
+	case 'Y':
+	case '1':
+		*res = true;
+		return 0;
+	case 'n':
+	case 'N':
+	case '0':
+		*res = false;
+		return 0;
+	case 'o':
+	case 'O':
+		switch (s[1]) {
+		case 'n':
+		case 'N':
+			*res = true;
+			return 0;
+		case 'f':
+		case 'F':
+			*res = false;
+			return 0;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(kstrtobool);
+
+/*
+ * Since "base" would be a nonsense argument, this open-codes the
+ * _from_user helper instead of using the helper macro below.
+ */
+int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
+{
+	/* Longest string needed to differentiate, newline, terminator */
+	char buf[4];
+
+	count = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, s, count))
+		return -EFAULT;
+	buf[count] = '\0';
+	return kstrtobool(buf, res);
+}
+EXPORT_SYMBOL_GPL(kstrtobool_from_user);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
