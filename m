Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49626 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbDYNvV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/9] header: add module_pnp_driver()
Date: Sat, 25 Apr 2015 15:51:00 +0200
Message-Id: <1429969864-16831-6-git-send-email-hauke@hauke-m.de> (sfid-20150425_155126_211563_04247480)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This macro is used by some media drivers and was added to the kernel in
commit 95c0fd457.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pnp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/pnp.h

diff --git a/backport/backport-include/linux/pnp.h b/backport/backport-include/linux/pnp.h
new file mode 100644
index 0000000..0a88455
--- /dev/null
+++ b/backport/backport-include/linux/pnp.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_LINUX_PNP_H
+#define __BACKPORT_LINUX_PNP_H
+#include_next <linux/pnp.h>
+
+#ifndef module_pnp_driver
+/**
+ * module_pnp_driver() - Helper macro for registering a PnP driver
+ * @__pnp_driver: pnp_driver struct
+ *
+ * Helper macro for PnP drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pnp_driver(__pnp_driver) \
+	module_driver(__pnp_driver, pnp_register_driver, \
+				    pnp_unregister_driver)
+#endif
+
+#endif /* __BACKPORT_LINUX_PNP_H */
-- 
1.9.1

