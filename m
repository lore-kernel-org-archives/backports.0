Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60111 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNpm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:45:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] backports: add compat_put_timespec()
Date: Sat,  8 Feb 2014 14:44:27 +0100
Message-Id: <1391867070-20031-4-git-send-email-hauke@hauke-m.de> (sfid-20140208_144544_166895_595BBA23)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by v4l2-compat-ioctl32.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/compat.h |    5 +++++
 backport/compat/compat-3.4.c             |   20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/compat.h b/backport/backport-include/linux/compat.h
index 22db9b0..07accd2 100644
--- a/backport/backport-include/linux/compat.h
+++ b/backport/backport-include/linux/compat.h
@@ -13,4 +13,9 @@
 #endif
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#define compat_put_timespec LINUX_BACKPORT(compat_put_timespec)
+extern int compat_put_timespec(const struct timespec *, void __user *);
+#endif
+
 #endif /* __BACKPORT_COMPAT_H */
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index fafe0df..bc090b7 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -11,6 +11,8 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/wait.h>
+#include <linux/compat.h>
+#include <asm/uaccess.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/regmap.h>
@@ -179,3 +181,21 @@ int simple_open(struct inode *inode, struct file *file)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(simple_open);
+
+#ifdef CONFIG_COMPAT
+static int __compat_put_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
+{
+	return (!access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
+			__put_user(ts->tv_sec, &cts->tv_sec) ||
+			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+}
+
+int compat_put_timespec(const struct timespec *ts, void __user *uts)
+{
+	if (COMPAT_USE_64BIT_TIME)
+		return copy_to_user(uts, ts, sizeof *ts) ? -EFAULT : 0;
+	else
+		return __compat_put_timespec(ts, uts);
+}
+EXPORT_SYMBOL_GPL(compat_put_timespec);
+#endif
-- 
1.7.10.4

