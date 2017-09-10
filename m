Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58428 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdIJWKs (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] header: add pm_system_wakeup()
Date: Mon, 11 Sep 2017 00:10:18 +0200
Message-Id: <20170910221020.13067-7-hauke@hauke-m.de> (sfid-20170911_001052_010594_5AEDB503)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in kernel 3.18 in commit 068765ba7987e ("PM /
sleep: Mechanism for aborting system suspends unconditionally") In our
implementation we only call pm_system_wakeup(() and do not handle the
abortion of the current suspend process.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/suspend.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/suspend.h

diff --git a/backport/backport-include/linux/suspend.h b/backport/backport-include/linux/suspend.h
new file mode 100644
index 00000000..394b164b
--- /dev/null
+++ b/backport/backport-include/linux/suspend.h
@@ -0,0 +1,12 @@
+#ifndef __BP_LINUX_SUSPEND_H
+#define __BP_LINUX_SUSPEND_H
+#include_next <linux/suspend.h>
+
+#if LINUX_VERSION_IS_LESS(3,18,0)
+static inline void pm_system_wakeup(void)
+{
+	freeze_wake();
+}
+#endif
+
+#endif /* __BP_LINUX_SUSPEND_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
