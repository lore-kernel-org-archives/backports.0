Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59178 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbbDAPbr (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Apr 2015 11:31:47 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] backport: backport NULLS_MARKER
Date: Wed,  1 Apr 2015 17:31:38 +0200
Message-Id: <1427902299-24079-4-git-send-email-johannes@sipsolutions.net> (sfid-20150401_173150_596855_EE64EFED)
In-Reply-To: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
References: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This was added to list_nulls.h fairly recently in commit f89bd6f87a53.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/list_nulls.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/list_nulls.h

diff --git a/backport/backport-include/linux/list_nulls.h b/backport/backport-include/linux/list_nulls.h
new file mode 100644
index 000000000000..ba28834f7900
--- /dev/null
+++ b/backport/backport-include/linux/list_nulls.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_LIST_NULLS
+#define __BACKPORT_LIST_NULLS
+#include_next <linux/list_nulls.h>
+
+#ifndef NULLS_MARKER
+#define NULLS_MARKER(value) (1UL | (((long)value) << 1))
+#endif
+
+#endif /* __BACKPORT_LIST_NULLS */
-- 
2.1.4

