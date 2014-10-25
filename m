Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40651 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbaJYSpx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] backports: add freezable_schedule_hrtimeout_range()
Date: Sat, 25 Oct 2014 11:19:22 +0200
Message-Id: <1414228770-20047-4-git-send-email-hauke@hauke-m.de> (sfid-20141025_204556_210225_303982E2)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the pt3 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/freezer.h | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 backport/backport-include/linux/freezer.h

diff --git a/backport/backport-include/linux/freezer.h b/backport/backport-include/linux/freezer.h
new file mode 100644
index 0000000..6bd6985
--- /dev/null
+++ b/backport/backport-include/linux/freezer.h
@@ -0,0 +1,32 @@
+#ifndef __BACKPORT_FREEZER_H_INCLUDED
+#define __BACKPORT_FREEZER_H_INCLUDED
+#include_next <linux/freezer.h>
+
+#ifdef CONFIG_FREEZER
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+/*
+ * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
+ * call this with locks held.
+ */
+#define freezable_schedule_hrtimeout_range LINUX_BACKPORT(freezable_schedule_hrtimeout_range)
+static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
+		unsigned long delta, const enum hrtimer_mode mode)
+{
+	int __retval;
+	freezer_do_not_count();
+	__retval = schedule_hrtimeout_range(expires, delta, mode);
+	freezer_count();
+	return __retval;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) */
+
+#else /* !CONFIG_FREEZER */
+
+#ifndef freezable_schedule_hrtimeout_range
+#define freezable_schedule_hrtimeout_range(expires, delta, mode)	\
+	schedule_hrtimeout_range(expires, delta, mode)
+#endif
+
+#endif /* !CONFIG_FREEZER */
+
+#endif /* __BACKPORT_FREEZER_H_INCLUDED */
-- 
1.9.1

