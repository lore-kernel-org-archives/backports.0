Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37220 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3DKXns (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:48 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 13/24] backports: move module_usb_driver()
Date: Fri, 12 Apr 2013 01:42:40 +0200
Message-Id: <1365723771-10660-14-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014409_363156_0AE6A3D7)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.3.h | 14 --------------
 backport/backport-include/linux/usb.h        | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)
 create mode 100644 backport/backport-include/linux/usb.h

diff --git a/backport/backport-include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
index eded1bb..5950e2b 100644
--- a/backport/backport-include/linux/compat-3.3.h
+++ b/backport/backport-include/linux/compat-3.3.h
@@ -307,20 +307,6 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 
 #define NL80211_FEATURE_SK_TX_STATUS 0
 
-/* source include/linux/usb.h */
-/**
- * module_usb_driver() - Helper macro for registering a USB driver
- * @__usb_driver: usb_driver struct
- *
- * Helper macro for USB drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_usb_driver(__usb_driver) \
-	module_driver(__usb_driver, usb_register, \
-		       usb_deregister)
-
-
 /*
  * PCI_EXP_TYPE_RC_EC was added via 1b6b8ce2 on v2.6.30-rc4~20 :
  *
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
new file mode 100644
index 0000000..2c81e48
--- /dev/null
+++ b/backport/backport-include/linux/usb.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_USB_H
+#define __BACKPORT_USB_H
+
+#include_next <linux/usb.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+/**
+ * module_usb_driver() - Helper macro for registering a USB driver
+ * @__usb_driver: usb_driver struct
+ *
+ * Helper macro for USB drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_usb_driver(__usb_driver) \
+	module_driver(__usb_driver, usb_register, \
+		       usb_deregister)
+#endif
+
+#endif /* __BACKPORT_USB_H */
-- 
1.8.0

