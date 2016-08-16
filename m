Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39198 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750928AbcHPJUw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 16 Aug 2016 05:20:52 -0400
From: Luca Coelho <luca@coelho.fi>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org
Date: Tue, 16 Aug 2016 12:20:44 +0300
Message-Id: <1471339244-12868-1-git-send-email-luca@coelho.fi> (sfid-20160816_112212_902465_AB789047)
Subject: [PATCH] backports: genetlink: define GENL_UNS_ADMIN_PERM as GENL_ADMIN_PERM
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Older kernels don't have support for GENL_UNS_ADMIN_PERM.  So, if it
is not defined, use the previous GENL_ADMIN_PERM permission instead.

Change-Id: I4c845de0d5b326aff8400df22a23595ef9cd12aa
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/uapi/linux/genetlink.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/uapi/linux/genetlink.h

diff --git a/backport/backport-include/uapi/linux/genetlink.h b/backport/backport-include/uapi/linux/genetlink.h
new file mode 100644
index 0000000..5292892
--- /dev/null
+++ b/backport/backport-include/uapi/linux/genetlink.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_UAPI_LINUX_GENETLINK_H
+#define __BACKPORT_UAPI_LINUX_GENETLINK_H
+#include_next <uapi/linux/genetlink.h>
+
+#ifndef GENL_UNS_ADMIN_PERM
+#define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM
+#endif
+
+#endif /* __BACKPORT_UAPI_LINUX_GENETLINK_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
