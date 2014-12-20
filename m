Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35252 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbaLTVjw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/14] backport: add debugfs_create_devm_seqfile()
Date: Sat, 20 Dec 2014 22:39:29 +0100
Message-Id: <1419111577-22174-7-git-send-email-hauke@hauke-m.de> (sfid-20141220_223957_266395_482D35B6)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This new functions is used by ath9k.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/debugfs.h | 23 +++++++++++++
 backport/compat/backport-3.19.c           | 56 +++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 backport/backport-include/linux/debugfs.h

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
new file mode 100644
index 0000000..77b2e64
--- /dev/null
+++ b/backport/backport-include/linux/debugfs.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT_DEBUGFS_H_
+#define __BACKPORT_DEBUGFS_H_
+#include_next <linux/debugfs.h>
+#include <linux/version.h>
+#include <generated/utsrelease.h>
+
+#if defined(CONFIG_DEBUG_FS)
+struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
+					   struct dentry *parent,
+					   int (*read_fn)(struct seq_file *s,
+							  void *data));
+#else
+static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
+							 const char *name,
+							 struct dentry *parent,
+					   int (*read_fn)(struct seq_file *s,
+							  void *data))
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* __BACKPORT_DEBUGFS_H_ */
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index fd13400..c633f38 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
+#include <linux/debugfs.h>
 
 static inline bool is_kthread_should_stop(void)
 {
@@ -90,3 +91,58 @@ void netdev_rss_key_fill(void *buffer, size_t len)
 }
 EXPORT_SYMBOL_GPL(netdev_rss_key_fill);
 #endif /* __BACKPORT_NETDEV_RSS_KEY_FILL */
+
+#if defined(CONFIG_DEBUG_FS)
+struct debugfs_devm_entry {
+	int (*read)(struct seq_file *seq, void *data);
+	struct device *dev;
+};
+
+static int debugfs_devm_entry_open(struct inode *inode, struct file *f)
+{
+	struct debugfs_devm_entry *entry = inode->i_private;
+
+	return single_open(f, entry->read, entry->dev);
+}
+
+static const struct file_operations debugfs_devm_entry_ops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_devm_entry_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+/**
+ * debugfs_create_devm_seqfile - create a debugfs file that is bound to device.
+ *
+ * @dev: device related to this debugfs file.
+ * @name: name of the debugfs file.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *	directory dentry if set.  If this parameter is %NULL, then the
+ *	file will be created in the root of the debugfs filesystem.
+ * @read_fn: function pointer called to print the seq_file content.
+ */
+struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
+					   struct dentry *parent,
+					   int (*read_fn)(struct seq_file *s,
+							  void *data))
+{
+	struct debugfs_devm_entry *entry;
+
+	if (IS_ERR(parent))
+		return ERR_PTR(-ENOENT);
+
+	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->read = read_fn;
+	entry->dev = dev;
+
+	return debugfs_create_file(name, S_IRUGO, parent, entry,
+				   &debugfs_devm_entry_ops);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
+
+#endif /* CONFIG_DEBUG_FS */
-- 
1.9.1

