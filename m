Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58340 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsK (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/16] backports: add linux/irqdomain.h
Date: Sun, 19 Jan 2014 17:47:27 +0100
Message-Id: <1390150057-11652-7-git-send-email-hauke@hauke-m.de> (sfid-20140119_174811_590751_AB1DA1AD)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ssb uses this header file, but does not use any of the functions in
there in the default config, because that is only used when
SSB_DRIVER_GPIO and SSB_EMBEDDED are activated.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/irqdomain.h |    9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/irqdomain.h

diff --git a/backport/backport-include/linux/irqdomain.h b/backport/backport-include/linux/irqdomain.h
new file mode 100644
index 0000000..a889a29
--- /dev/null
+++ b/backport/backport-include/linux/irqdomain.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_LINUX_IRQDOMAIN_H
+#define __BACKPORT_LINUX_IRQDOMAIN_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
+#include_next <linux/irqdomain.h>
+#endif
+
+#endif /* __BACKPORT_LINUX_IRQDOMAIN_H */
-- 
1.7.10.4

