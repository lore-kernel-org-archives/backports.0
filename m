Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51552 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbcBOPZK (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/12] backports: add devm_kasprintf()
Date: Mon, 15 Feb 2016 16:24:53 +0100
Message-Id: <1455549899-14564-7-git-send-email-hauke@hauke-m.de> (sfid-20160215_184440_377547_A4C50D6A)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the devm_kasprintf() function added in mainline Linux kernel
commit 75f2a4ead "devres: Add devm_kasprintf and devm_kvasprintf API"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |  8 +++++
 backport/compat/backport-3.17.c          | 56 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index f03e7c1..079b00d 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -243,5 +243,13 @@ do {									\
 	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
 #endif /* dev_level_once */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define devm_kvasprintf LINUX_BACKPORT(devm_kvasprintf)
+extern char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
+			     va_list ap);
+#define devm_kasprintf LINUX_BACKPORT(devm_kasprintf)
+extern char *devm_kasprintf(struct device *dev, gfp_t gfp,
+			    const char *fmt, ...);
+#endif /* < 3.17 */
 
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
index 485f2dc..de99fba 100644
--- a/backport/compat/backport-3.17.c
+++ b/backport/compat/backport-3.17.c
@@ -9,6 +9,7 @@
  */
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/ktime.h>
 #include <linux/jiffies.h>
@@ -88,3 +89,58 @@ unsigned long nsecs_to_jiffies(u64 n)
 	return (unsigned long)backport_nsecs_to_jiffies64(n);
 }
 EXPORT_SYMBOL_GPL(nsecs_to_jiffies);
+
+/**
+ * devm_kvasprintf - Allocate resource managed space
+ *			for the formatted string.
+ * @dev: Device to allocate memory for
+ * @gfp: the GFP mask used in the devm_kmalloc() call when
+ *       allocating memory
+ * @fmt: the formatted string to duplicate
+ * @ap: the list of tokens to be placed in the formatted string
+ * RETURNS:
+ * Pointer to allocated string on success, NULL on failure.
+ */
+char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
+		      va_list ap)
+{
+	unsigned int len;
+	char *p;
+	va_list aq;
+
+	va_copy(aq, ap);
+	len = vsnprintf(NULL, 0, fmt, aq);
+	va_end(aq);
+
+	p = devm_kmalloc(dev, len+1, gfp);
+	if (!p)
+		return NULL;
+
+	vsnprintf(p, len+1, fmt, ap);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(devm_kvasprintf);
+
+/**
+ * devm_kasprintf - Allocate resource managed space
+ *		and copy an existing formatted string into that
+ * @dev: Device to allocate memory for
+ * @gfp: the GFP mask used in the devm_kmalloc() call when
+ *       allocating memory
+ * @fmt: the string to duplicate
+ * RETURNS:
+ * Pointer to allocated string on success, NULL on failure.
+ */
+char *devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...)
+{
+	va_list ap;
+	char *p;
+
+	va_start(ap, fmt);
+	p = devm_kvasprintf(dev, gfp, fmt, ap);
+	va_end(ap);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(devm_kasprintf);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
