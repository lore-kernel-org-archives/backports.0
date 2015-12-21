Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51825 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbLUAGJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] backport: add no_seek_end_llseek()
Date: Mon, 21 Dec 2015 01:05:56 +0100
Message-Id: <1450656361-21259-2-git-send-email-hauke@hauke-m.de> (sfid-20151221_010618_275833_501D33B5)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

no_seek_end_llseek() was added with kernel 4.5 in commit fb1d259e4 "new
helpers: no_seek_end_llseek{,_size}()". This is used by wlcore.
generic_file_llseek_size() is only available in kernel >= 3.2.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/fs.h |  6 ++++++
 backport/compat/backport-4.5.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 2790db6..42fb1e9 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -43,4 +43,10 @@ static inline struct inode *file_inode(struct file *f)
 	} while(0)
 #endif /* replace_fops */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) && \
+     LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#define no_seek_end_llseek LINUX_BACKPORT(no_seek_end_llseek)
+extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+#endif /* < 4.5 && >= 3.2 */
+
 #endif	/* _COMPAT_LINUX_FS_H */
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index e8f9b12..13c0a71 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -11,6 +11,7 @@
 #include <linux/leds.h>
 #include <linux/export.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
 int led_set_brightness_sync(struct led_classdev *led_cdev,
@@ -31,3 +32,29 @@ int led_set_brightness_sync(struct led_classdev *led_cdev,
 }
 EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 #endif /* >= 3.19 */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+/**
+ * no_seek_end_llseek - llseek implementation for fixed-sized devices
+ * @file:	file structure to seek on
+ * @offset:	file offset to seek to
+ * @whence:	type of seek
+ *
+ */
+loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
+{
+	switch (whence) {
+	case SEEK_SET: case SEEK_CUR:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+		return generic_file_llseek_size(file, offset, whence,
+						~0ULL, 0);
+#else
+		return generic_file_llseek_size(file, offset, whence,
+						~0ULL);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(no_seek_end_llseek);
+#endif /* >= 3.2 */
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
