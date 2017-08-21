Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48955 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754388AbdHUW2r (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/21] header: add offsetofend()
Date: Tue, 22 Aug 2017 00:28:10 +0200
Message-Id: <20170821222817.17376-15-hauke@hauke-m.de> (sfid-20170822_002849_814745_D2369F95)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

offsetofend() was moved from vfio.h to stddef.h in commit
3876488444e7123 ("include/stddef.h: Move offsetofend() from vfio.h to a
generic kernel header") for kernel 4.1. Add it again to stddef.h so it
is available in more include paths.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/stddef.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/linux/stddef.h

diff --git a/backport/backport-include/linux/stddef.h b/backport/backport-include/linux/stddef.h
new file mode 100644
index 00000000..2c836b00
--- /dev/null
+++ b/backport/backport-include/linux/stddef.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_LINUX_STDDEF_H
+#define __BACKPORT_LINUX_STDDEF_H
+#include_next <linux/stddef.h>
+
+#ifndef offsetofend
+/**
+ * offsetofend(TYPE, MEMBER)
+ *
+ * @TYPE: The type of the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
+#endif
+
+#endif /* __BACKPORT_LINUX_STDDEF_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
