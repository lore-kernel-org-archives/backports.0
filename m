Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34278 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932501AbeCDW5t (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/14] header: nospec.h: provide dummy header file
Date: Sun,  4 Mar 2018 23:57:11 +0100
Message-Id: <20180304225717.20890-9-hauke@hauke-m.de> (sfid-20180304_235754_828281_70C7C4AD)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Older kernel versions do not have the include linux/nospec.h with the
function array_index_nospec, provide a dummy implementation for these
kernel versions and forward the call the the real version for capable
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/nospec.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/nospec.h

diff --git a/backport/backport-include/linux/nospec.h b/backport/backport-include/linux/nospec.h
new file mode 100644
index 00000000..50cf4673
--- /dev/null
+++ b/backport/backport-include/linux/nospec.h
@@ -0,0 +1,12 @@
+#ifndef _BACKPORT_LINUX_NOSPEC_H
+#define _BACKPORT_LINUX_NOSPEC_H
+
+#if LINUX_VERSION_IS_GEQ(4,14,18) || \
+    LINUX_VERSION_IN_RANGE(4,9,81, 4,10,0) || \
+    LINUX_VERSION_IN_RANGE(4,4,118, 4,5,0)
+#include_next <linux/nospec.h>
+#else
+#define array_index_nospec(index, size)	(index)
+#endif
+
+#endif /* _BACKPORT_LINUX_NOSPEC_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
