Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35028 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaBXAqt (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id E2D347E58
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:48 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/12] backports: add devm_kstrdup()
Date: Mon, 24 Feb 2014 01:45:49 +0100
Message-Id: <1393202754-12919-8-git-send-email-hauke@hauke-m.de> (sfid-20140224_014651_048605_ED64D13C)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/regulator/fixed.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |    5 ++++
 backport/compat/Makefile                 |    1 +
 backport/compat/backport-3.15.c          |   38 ++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 backport/compat/backport-3.15.c

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index aa91c62..ebfc01a 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -247,4 +247,9 @@ static inline void *dev_get_platdata(const struct device *dev)
 #define devm_kmalloc(dev, size, flags) devm_kzalloc(dev, size, flags) 
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#define devm_kstrdup LINUX_BACKPORT(devm_kstrdup)
+extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index ac2dc47..e2da341 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -30,6 +30,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_15) += backport-3.15.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
new file mode 100644
index 0000000..367ff9d
--- /dev/null
+++ b/backport/compat/backport-3.15.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.15.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+/**
+ * devm_kstrdup - Allocate resource managed space and
+ *                copy an existing string into that.
+ * @dev: Device to allocate memory for
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the devm_kmalloc() call when
+ *       allocating memory
+ * RETURNS:
+ * Pointer to allocated string on success, NULL on failure.
+ */
+char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
+{
+	size_t size;
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	size = strlen(s) + 1;
+	buf = devm_kmalloc(dev, size, gfp);
+	if (buf)
+		memcpy(buf, s, size);
+	return buf;
+}
+EXPORT_SYMBOL_GPL(devm_kstrdup);
-- 
1.7.10.4

