Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49148 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab3JaWD3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:03:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: add reinit_completion()
Date: Thu, 31 Oct 2013 23:03:17 +0100
Message-Id: <1383256998-32371-2-git-send-email-hauke@hauke-m.de> (sfid-20131031_230331_460113_98CE3491)
In-Reply-To: <1383256998-32371-1-git-send-email-hauke@hauke-m.de>
References: <1383256998-32371-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/completion.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/linux/completion.h

diff --git a/backport/backport-include/linux/completion.h b/backport/backport-include/linux/completion.h
new file mode 100644
index 0000000..399430d
--- /dev/null
+++ b/backport/backport-include/linux/completion.h
@@ -0,0 +1,20 @@
+#ifndef __BACKPORT_COMPLETION_H
+#define __BACKPORT_COMPLETION_H
+#include_next <linux/completion.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+/**
+ * reinit_completion - reinitialize a completion structure
+ * @x:  pointer to completion structure that is to be reinitialized
+ *
+ * This inline function should be used to reinitialize a completion structure so it can
+ * be reused. This is especially important after complete_all() is used.
+ */
+static inline void reinit_completion(struct completion *x)
+{
+	x->done = 0;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
+#endif /* __BACKPORT_COMPLETION_H */
-- 
1.7.10.4

