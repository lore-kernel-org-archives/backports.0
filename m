Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46829 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3KXN2J (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 08:28:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: add current_user_ns()
Date: Sun, 24 Nov 2013 14:27:45 +0100
Message-Id: <1385299666-18712-2-git-send-email-hauke@hauke-m.de> (sfid-20131124_142811_772630_2AE577BF)
In-Reply-To: <1385299666-18712-1-git-send-email-hauke@hauke-m.de>
References: <1385299666-18712-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

current_user_ns() is used by seq_user_ns() if CONFIG_USER_NS is set and
kernel version <= 2.6.38.
This was added to the kernel in version 2.6.29.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/cred.h |   10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/cred.h

diff --git a/backport/backport-include/linux/cred.h b/backport/backport-include/linux/cred.h
new file mode 100644
index 0000000..2fbcf01
--- /dev/null
+++ b/backport/backport-include/linux/cred.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_CRED_H
+#define __BACKPORT_LINUX_CRED_H
+#include_next <linux/cred.h>
+#include <linux/version.h>
+
+#ifndef current_user_ns
+#define current_user_ns()	(current->nsproxy->user_ns)
+#endif
+
+#endif /* __BACKPORT_LINUX_CRED_H */
-- 
1.7.10.4

