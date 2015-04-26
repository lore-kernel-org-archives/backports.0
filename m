Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50096 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbDZVEc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] header: add TRACE_DEFINE_ENUM define for v4l2
Date: Sun, 26 Apr 2015 23:04:19 +0200
Message-Id: <1430082264-11808-3-git-send-email-hauke@hauke-m.de> (sfid-20150426_230435_826344_2C503497)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

v4l2 makes use of TRACE_DEFINE_ENUM. This was introduced in 0c564a538
and is not supported in older kernel versions, implement it empty.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tracepoint.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/tracepoint.h

diff --git a/backport/backport-include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
new file mode 100644
index 0000000..a695c6f
--- /dev/null
+++ b/backport/backport-include/linux/tracepoint.h
@@ -0,0 +1,10 @@
+#include_next <linux/tracepoint.h>
+
+#ifndef __BACKPORT_LINUX_TRACEPOINT_H
+#define __BACKPORT_LINUX_TRACEPOINT_H
+
+#ifndef TRACE_DEFINE_ENUM
+#define TRACE_DEFINE_ENUM(a)
+#endif
+
+#endif /* __BACKPORT_LINUX_TRACEPOINT_H */
-- 
1.9.1

