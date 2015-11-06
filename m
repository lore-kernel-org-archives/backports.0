Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:44322 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757234AbbKFIED (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 Nov 2015 03:04:03 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backport: backport debugfs_create_bool()
Date: Fri,  6 Nov 2015 09:04:00 +0100
Message-Id: <1446797040-23973-1-git-send-email-johannes@sipsolutions.net> (sfid-20151106_090405_966576_523D2864)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The prototype for this function is changing upstream, so backport
a copy of the new one that has a bool * argument instead of u32 *.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/debugfs.h | 15 ++++++++
 backport/compat/Makefile                  |  1 +
 backport/compat/backport-4.4.c            | 64 +++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 backport/compat/backport-4.4.c

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index a68435322b4b..5ea4bfbe928e 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -24,4 +24,19 @@ static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
 #endif /* CONFIG_DEBUG_FS */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#define debugfs_create_bool LINUX_BACKPORT(debugfs_create_bool)
+#ifdef CONFIG_DEBUG_FS
+struct dentry *debugfs_create_bool(const char *name, umode_t mode,
+				   struct dentry *parent, bool *value);
+#else
+static inline struct dentry *
+debugfs_create_bool(const char *name, umode_t mode,
+		    struct dentry *parent, bool *value)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) */
+
 #endif /* __BACKPORT_DEBUGFS_H_ */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 666ef9111ace..fa992e780ec1 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -29,6 +29,7 @@ compat-$(CPTCFG_KERNEL_4_0) += backport-4.0.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
+compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
new file mode 100644
index 000000000000..d91d100af906
--- /dev/null
+++ b/backport/compat/backport-4.4.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright(c) 2015 Intel Deutschland GmbH
+ *
+ * Backport functionality introduced in Linux 4.4.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
+
+#ifdef CONFIG_DEBUG_FS
+static ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	char buf[3];
+	bool *val = file->private_data;
+
+	if (*val)
+		buf[0] = 'Y';
+	else
+		buf[0] = 'N';
+	buf[1] = '\n';
+	buf[2] = 0x00;
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t debugfs_write_file_bool(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	char buf[32];
+	size_t buf_size;
+	bool bv;
+	bool *val = file->private_data;
+
+	buf_size = min(count, (sizeof(buf)-1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &bv) == 0)
+		*val = bv;
+
+	return count;
+}
+
+static const struct file_operations fops_bool = {
+	.read =		debugfs_read_file_bool,
+	.write =	debugfs_write_file_bool,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+struct dentry *debugfs_create_bool(const char *name, umode_t mode,
+				   struct dentry *parent, bool *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_bool);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_bool);
+#endif /* CONFIG_DEBUG_FS */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
