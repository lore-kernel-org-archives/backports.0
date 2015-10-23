Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36781 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbbJWHXQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Oct 2015 03:23:16 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add ktime_get_seconds()
Date: Fri, 23 Oct 2015 09:23:11 +0200
Message-Id: <1445584991-11249-1-git-send-email-johannes@sipsolutions.net> (sfid-20151023_092322_558450_86167259)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/ktime.h       |  1 +
 backport/backport-include/linux/timekeeping.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 backport/backport-include/linux/timekeeping.h

diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
index 6fbc6c6eb26c..33ed31caf01a 100644
--- a/backport/backport-include/linux/ktime.h
+++ b/backport/backport-include/linux/ktime.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_LINUX_KTIME_H
 #define __BACKPORT_LINUX_KTIME_H
 #include_next <linux/ktime.h>
+#include <linux/timekeeping.h>
 #include <linux/version.h>
 
 #if  LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
new file mode 100644
index 000000000000..25ca76b5f802
--- /dev/null
+++ b/backport/backport-include/linux/timekeeping.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_TIMKEEPING_H
+#define __BACKPORT_TIMKEEPING_H
+#include <linux/version.h>
+#include <linux/types.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+#include_next <linux/timekeeping.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+static inline time_t ktime_get_seconds(void)
+{
+	struct timespec t;
+
+	ktime_get_ts(&t);
+
+	return t.tv_sec;
+}
+#endif
+
+#endif /* __BACKPORT_TIMKEEPING_H */
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
