Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37208 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3DKXnI (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:08 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 12/24] backports: move module_driver()
Date: Fri, 12 Apr 2013 01:42:39 +0200
Message-Id: <1365723771-10660-13-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014341_164022_B9296D29)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.3.h | 22 --------------------
 backport/backport-include/linux/device.h     | 31 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 22 deletions(-)
 create mode 100644 backport/backport-include/linux/device.h

diff --git a/backport/backport-include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
index 7b2ec47..eded1bb 100644
--- a/backport/backport-include/linux/compat-3.3.h
+++ b/backport/backport-include/linux/compat-3.3.h
@@ -307,28 +307,6 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 
 #define NL80211_FEATURE_SK_TX_STATUS 0
 
-/* source include/linux/device.h */
-/**
- * module_driver() - Helper macro for drivers that don't do anything
- * special in module init/exit. This eliminates a lot of boilerplate.
- * Each module may only use this macro once, and calling it replaces
- * module_init() and module_exit().
- *
- * Use this macro to construct bus specific macros for registering
- * drivers, and do not use it on its own.
- */
-#define module_driver(__driver, __register, __unregister) \
-static int __init __driver##_init(void) \
-{ \
-	return __register(&(__driver)); \
-} \
-module_init(__driver##_init); \
-static void __exit __driver##_exit(void) \
-{ \
-	__unregister(&(__driver)); \
-} \
-module_exit(__driver##_exit);
-
 /* source include/linux/usb.h */
 /**
  * module_usb_driver() - Helper macro for registering a USB driver
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
new file mode 100644
index 0000000..b46731a
--- /dev/null
+++ b/backport/backport-include/linux/device.h
@@ -0,0 +1,31 @@
+#ifndef __BACKPORT_DEVICE_H
+#define __BACKPORT_DEVICE_H
+#include <linux/export.h>
+#include_next <linux/device.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+/**
+ * module_driver() - Helper macro for drivers that don't do anything
+ * special in module init/exit. This eliminates a lot of boilerplate.
+ * Each module may only use this macro once, and calling it replaces
+ * module_init() and module_exit().
+ *
+ * Use this macro to construct bus specific macros for registering
+ * drivers, and do not use it on its own.
+ */
+#define module_driver(__driver, __register, __unregister) \
+static int __init __driver##_init(void) \
+{ \
+	return __register(&(__driver)); \
+} \
+module_init(__driver##_init); \
+static void __exit __driver##_exit(void) \
+{ \
+	__unregister(&(__driver)); \
+} \
+module_exit(__driver##_exit);
+#endif
+
+#endif /* __BACKPORT_DEVICE_H */
-- 
1.8.0

