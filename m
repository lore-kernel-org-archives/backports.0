Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44935 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbaHIOrq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] backports: add ktime_get_raw()
Date: Sat,  9 Aug 2014 16:47:34 +0200
Message-Id: <1407595659-10396-2-git-send-email-hauke@hauke-m.de> (sfid-20140809_164751_266688_44776432)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/ktime.h | 12 ++++++++++++
 backport/compat/backport-3.17.c         | 12 ++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 backport/backport-include/linux/ktime.h

diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
new file mode 100644
index 0000000..adefc27
--- /dev/null
+++ b/backport/backport-include/linux/ktime.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_KTIME_H
+#define __BACKPORT_LINUX_KTIME_H
+#include_next <linux/ktime.h>
+#include <linux/version.h>
+
+#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
+extern ktime_t ktime_get_raw(void);
+
+#endif /* < 3.17 */
+
+#endif /* __BACKPORT_LINUX_KTIME_H */
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
index 9cc0a82..567f0c3 100644
--- a/backport/compat/backport-3.17.c
+++ b/backport/compat/backport-3.17.c
@@ -10,6 +10,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/export.h>
+#include <linux/ktime.h>
 
 int bit_wait(void *word)
 {
@@ -25,3 +26,14 @@ int bit_wait_io(void *word)
 }
 EXPORT_SYMBOL_GPL(bit_wait_io);
 
+/**
+ * ktime_get_raw - Returns the raw monotonic time in ktime_t format
+ */
+ktime_t ktime_get_raw(void)
+{
+	struct timespec ts;
+
+	getrawmonotonic(&ts);
+	return timespec_to_ktime(ts);
+}
+EXPORT_SYMBOL_GPL(ktime_get_raw);
-- 
1.9.1

