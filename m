Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:37322 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753420AbcDSTNS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Apr 2016 15:13:18 -0400
Received: from [192.40.95.4] (helo=dubbel.ger.corp.intel.com)
	by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.87)
	(envelope-from <luca@coelho.fi>)
	id 1asb5H-00050a-KN
	for backports@vger.kernel.org; Tue, 19 Apr 2016 22:13:16 +0300
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Date: Tue, 19 Apr 2016 22:13:11 +0300
Message-Id: <1461093191-461-1-git-send-email-luca@coelho.fi> (sfid-20160419_211320_138154_42F79845)
Subject: [PATCH] backport: add pm_runtime_active() implementation for < 3.9 kernels
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The pm_runtime_active() helper function was introduced in kernel 3.9.
In order to use it in earlier kernels, we need to add its
implementation to the backports.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/pm_runtime.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/pm_runtime.h

diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
new file mode 100644
index 0000000..bc0b109
--- /dev/null
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_PM_RUNTIME_H
+#define __BACKPORT_PM_RUNTIME_H
+#include_next <linux/pm_runtime.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+
+#ifdef CONFIG_PM
+static inline bool pm_runtime_active(struct device *dev)
+{
+	return dev->power.runtime_status == RPM_ACTIVE
+		|| dev->power.disable_depth;
+}
+#else
+static inline bool pm_runtime_active(struct device *dev) { return true; }
+#endif /* CONFIG_PM */
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
+#endif /* __BACKPORT_PM_RUNTIME_H */
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
