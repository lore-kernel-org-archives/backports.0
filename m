Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] t compat: add file_inode()
Date: Thu, 28 Feb 2013 00:54:58 +0100
Message-Id: <1362009298-20174-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This adds a backport for file_inode().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.9.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compat-3.9.h b/include/linux/compat-3.9.h
index ff1b386..26e6f57 100644
--- a/include/linux/compat-3.9.h
+++ b/include/linux/compat-3.9.h
@@ -121,6 +121,20 @@ static inline void idr_preload_end(void)
 #define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
 #define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
 
+/**
+ * backport of:
+ *
+ * commit 496ad9aa8ef448058e36ca7a787c61f2e63f0f54
+ * Author: Al Viro <viro@zeniv.linux.org.uk>
+ * Date:   Wed Jan 23 17:07:38 2013 -0500
+ *
+ *     new helper: file_inode(file)
+ */
+static inline struct inode *file_inode(struct file *f)
+{
+	return f->f_path.dentry->d_inode;
+}
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
 
 #endif /* LINUX_3_9_COMPAT_H */
-- 
1.7.10.4
