Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41815 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbcEaOD5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 31 May 2016 10:03:57 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add page_ref backport
Date: Tue, 31 May 2016 16:03:53 +0200
Message-Id: <1464703433-6026-1-git-send-email-johannes@sipsolutions.net> (sfid-20160531_160359_234066_56C5D368)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Currently, only page_ref_inc() is needed, so backport only that.

Change-Id: I7b4d7eb4ccccf61d0921ef28a40b6628e8f2c1f8
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/mm.h       |  1 +
 backport/backport-include/linux/page_ref.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/page_ref.h

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index bac230364139..5b3cca6afb63 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_MM_H
 #define __BACKPORT_MM_H
 #include_next <linux/mm.h>
+#include <linux/page_ref.h>
 
 #ifndef VM_NODUMP
 /*
diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
new file mode 100644
index 000000000000..0b890e9be415
--- /dev/null
+++ b/backport/backport-include/linux/page_ref.h
@@ -0,0 +1,13 @@
+#ifndef __BP_PAGE_REF_H
+#define __BP_PAGE_REF_H
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+#include_next <linux/page_ref.h>
+#else
+static inline void page_ref_inc(struct page *page)
+{
+	atomic_inc(&page->_count);
+}
+#endif
+
+#endif /* __BP_PAGE_REF_H */
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
