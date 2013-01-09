Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] compat: add simple_write_to_buffer
Date: Wed,  9 Jan 2013 17:34:21 +0100
Message-Id: <1357749263-4596-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
References: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This was copied from fs/libfs.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-2.6.35.c        |   34 ++++++++++++++++++++++++++++++++++
 include/linux/compat-2.6.35.h |    3 +++
 2 files changed, 37 insertions(+)

diff --git a/compat/compat-2.6.35.c b/compat/compat-2.6.35.c
index 0fc0db2..422487c 100644
--- a/compat/compat-2.6.35.c
+++ b/compat/compat-2.6.35.c
@@ -89,3 +89,37 @@ loff_t noop_llseek(struct file *file, loff_t offset, int origin)
 }
 EXPORT_SYMBOL_GPL(noop_llseek);
 
+/**
+ * simple_write_to_buffer - copy data from user space to the buffer
+ * @to: the buffer to write to
+ * @available: the size of the buffer
+ * @ppos: the current position in the buffer
+ * @from: the user space buffer to read from
+ * @count: the maximum number of bytes to read
+ *
+ * The simple_write_to_buffer() function reads up to @count bytes from the user
+ * space address starting at @from into the buffer @to at offset @ppos.
+ *
+ * On success, the number of bytes written is returned and the offset @ppos is
+ * advanced by this number, or negative value is returned on error.
+ **/
+ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
+		const void __user *from, size_t count)
+{
+	loff_t pos = *ppos;
+	size_t res;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	res = copy_from_user(to + pos, from, count);
+	if (res == count)
+		return -EFAULT;
+	count -= res;
+	*ppos = pos + count;
+	return count;
+}
+EXPORT_SYMBOL(simple_write_to_buffer);
diff --git a/include/linux/compat-2.6.35.h b/include/linux/compat-2.6.35.h
index b06638a..82b4dea 100644
--- a/include/linux/compat-2.6.35.h
+++ b/include/linux/compat-2.6.35.h
@@ -88,6 +88,9 @@ usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
 	return eps[usb_pipeendpoint(pipe)];
 }
 
+extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
+		const void __user *from, size_t count);
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)) */
 
 #endif /* LINUX_26_35_COMPAT_H */
-- 
1.7.10.4
