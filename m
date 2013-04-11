Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37180 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXm7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:42:59 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC/WIP 02/24] backports: move br_port_exists
Date: Fri, 12 Apr 2013 01:42:29 +0200
Message-Id: <1365723771-10660-3-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014301_757703_77027FF0)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Hauke Mehrtens <hauke@hauke-m.de>

---
 backport/backport-include/linux/compat-2.6.36.h | 15 -------------
 backport/backport-include/linux/if.h            | 28 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 backport/backport-include/linux/if.h

diff --git a/backport/backport-include/linux/compat-2.6.36.h b/backport/backport-include/linux/compat-2.6.36.h
index ff6a53f..ae3ffa6 100644
--- a/backport/backport-include/linux/compat-2.6.36.h
+++ b/backport/backport-include/linux/compat-2.6.36.h
@@ -187,8 +187,6 @@ enum {
 #define work_busy LINUX_BACKPORT(work_busy)
 extern unsigned int work_busy(struct work_struct *work);
 
-#define br_port_exists(dev)	(dev->br_port)
-
 #else
 
 static inline void backport_system_workqueue_create(void)
@@ -199,19 +197,6 @@ static inline void backport_system_workqueue_destroy(void)
 {
 }
 
-/*
- * This is not part of The 2.6.37 kernel yet but we
- * we use it to optimize the backport code we
- * need to implement. Instead of using ifdefs
- * to check what version of the check we use
- * we just replace all checks on current code
- * with this. I'll submit this upstream too, that
- * way all we'd have to do is to implement this
- * for older kernels, then we would not have to
- * edit the upstrema code for backport efforts.
- */
-#define br_port_exists(dev)	(dev->priv_flags & IFF_BRIDGE_PORT)
-
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)) */
 
 #endif /* LINUX_26_36_COMPAT_H */
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
new file mode 100644
index 0000000..63fef8a
--- /dev/null
+++ b/backport/backport-include/linux/if.h
@@ -0,0 +1,28 @@
+#ifndef _BACKPORT_LINUX_IF_H
+#define _BACKPORT_LINUX_IF_H
+
+#include_next <linux/if.h>
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
+
+#define br_port_exists(dev)	(dev->br_port)
+
+#else
+
+/*
+ * This is not part of The 2.6.37 kernel yet but we
+ * we use it to optimize the backport code we
+ * need to implement. Instead of using ifdefs
+ * to check what version of the check we use
+ * we just replace all checks on current code
+ * with this. I'll submit this upstream too, that
+ * way all we'd have to do is to implement this
+ * for older kernels, then we would not have to
+ * edit the upstrema code for backport efforts.
+ */
+#define br_port_exists(dev)	(dev->priv_flags & IFF_BRIDGE_PORT)
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)) */
+#endif	/* _BACKPORT_LINUX_IF_H */
-- 
1.8.0

