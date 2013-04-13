Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44273 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXzv (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:51 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 36/42] backports: avoid pr_fmt warning from our export.h
Date: Sun, 14 Apr 2013 01:53:56 +0200
Message-Id: <1365897243-31214-37-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015640_771028_A85FB3EC)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On old kernels, linux/export.h didn't exist and we need
to include linux/module.h instead. That includes a lot
though and thus defines pr_fmt already. Avoid redefine
warnings by checking if it's defined before and if not
undefining it afterwards.

However, to then avoid issues with kernel.h/printk.h
not defining it again, we need to override there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/export.h |  7 +++++++
 backport/backport-include/linux/kernel.h | 11 +++++++++++
 backport/backport-include/linux/printk.h |  9 ++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
index f7842b7..3686197 100644
--- a/backport/backport-include/linux/export.h
+++ b/backport/backport-include/linux/export.h
@@ -6,7 +6,14 @@
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include_next <linux/export.h>
 #else
+#ifndef pr_fmt
+#define backport_undef_pr_fmt
+#endif
 #include <linux/module.h>
+#ifdef backport_undef_pr_fmt
+#undef pr_fmt
+#undef backport_undef_pr_fmt
+#endif
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
 #endif	/* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 24755b0..df344eb 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -242,3 +242,14 @@ int hex_to_bin(char ch);
 #endif
 
 #endif /* __BACKPORT_KERNEL_H */
+
+/*
+ * We have to do this outside the include guard, because
+ * out own header (linux/export.h) has to include kernel.h
+ * indirectly (through module.h) and then undef's pr_fmt.
+ * Then, when the real kernel.h gets included again, it's
+ * not defined and we get problems ...
+ */
+#ifndef pr_fmt
+#define pr_fmt(msg) msg
+#endif
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index 00d86f3..6bc9931 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -9,9 +9,7 @@
 #include <linux/kernel.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35)) */
 
-#ifndef pr_fmt
-#define pr_fmt(fmt) fmt
-#endif
+/* see pr_fmt at end of file */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 /* backports 7a555613 */
@@ -100,3 +98,8 @@ int no_printk(const char *s, ...) { return 0; }
 #endif
 
 #endif	/* _COMPAT_LINUX_PRINTK_H */
+
+/* This must be outside -- see also kernel.h */
+#ifndef pr_fmt
+#define pr_fmt(fmt) fmt
+#endif
-- 
1.8.0

