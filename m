Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49896 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbcBLN7v (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add memdup_user_nul()
Date: Fri, 12 Feb 2016 14:58:35 +0100
Message-Id: <1455285519-16163-2-git-send-email-hauke@hauke-m.de> (sfid-20160212_145954_267357_43315EF1)
In-Reply-To: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
References: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added to the mainline kernel in commit 3bc8f29b14 "new helper:
memdup_user_nul()" and is now used by multiple drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/string.h |  5 +++++
 backport/compat/backport-4.5.c           | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 819d141..878d033 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,4 +8,9 @@
 extern size_t memweight(const void *ptr, size_t bytes);
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#define memdup_user_nul LINUX_BACKPORT(memdup_user_nul)
+extern void *memdup_user_nul(const void __user *, size_t);
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index 13c0a71..b7e6da0 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -12,6 +12,9 @@
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/uaccess.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
 int led_set_brightness_sync(struct led_classdev *led_cdev,
@@ -58,3 +61,34 @@ loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
 }
 EXPORT_SYMBOL_GPL(no_seek_end_llseek);
 #endif /* >= 3.2 */
+
+/**
+ * memdup_user_nul - duplicate memory region from user space and NUL-terminate
+ *
+ * @src: source address in user space
+ * @len: number of bytes to copy
+ *
+ * Returns an ERR_PTR() on failure.
+ */
+void *memdup_user_nul(const void __user *src, size_t len)
+{
+	char *p;
+
+	/*
+	 * Always use GFP_KERNEL, since copy_from_user() can sleep and
+	 * cause pagefault, which makes it pointless to use GFP_NOFS
+	 * or GFP_ATOMIC.
+	 */
+	p = kmalloc(len + 1, GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(p, src, len)) {
+		kfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+	p[len] = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(memdup_user_nul);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
