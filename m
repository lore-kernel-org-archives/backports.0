Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49102 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbCBIsg (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 2 Mar 2015 03:48:36 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: backport recent wext change
Date: Mon,  2 Mar 2015 09:48:32 +0100
Message-Id: <1425286112-6369-1-git-send-email-johannes@sipsolutions.net> (sfid-20150302_094838_221884_52982544)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

backport the commit 36ef906ee8fefbfac3844206e66d8450e6221c69
("wext: add checked wrappers for adding events/points to streams")

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/iw_handler.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 backport/backport-include/net/iw_handler.h

diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
new file mode 100644
index 000000000000..11135c898b83
--- /dev/null
+++ b/backport/backport-include/net/iw_handler.h
@@ -0,0 +1,28 @@
+#ifndef __BACKPORT_IW_HANDLER_H
+#define __BACKPORT_IW_HANDLER_H
+#include_next <net/iw_handler.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+static inline char *
+iwe_stream_add_event_check(struct iw_request_info *info, char *stream,
+			   char *ends, struct iw_event *iwe, int event_len)
+{
+	char *res = iwe_stream_add_event(info, stream, ends, iwe, event_len);
+
+	if (res == stream)
+		return ERR_PTR(-E2BIG);
+	return res;
+}
+
+static inline char *
+iwe_stream_add_point_check(struct iw_request_info *info, char *stream,
+			   char *ends, struct iw_event *iwe, char *extra)
+{
+	char *res = iwe_stream_add_point(info, stream, ends, iwe, extra);
+
+	if (res == stream)
+		return ERR_PTR(-E2BIG);
+	return res;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#endif /* __BACKPORT_IW_HANDLER_H */
-- 
2.1.4

