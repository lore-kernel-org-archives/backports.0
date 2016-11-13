Return-path: <backports-owner@vger.kernel.org>
Received: from [192.19.211.62] ([192.19.211.62]:50685 "EHLO
        relay.smtp.broadcom.com" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S934302AbcKMTnP (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 13 Nov 2016 14:43:15 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V2] backports: empty define for __ro_after_init
Date: Sun, 13 Nov 2016 19:43:07 +0000
Message-Id: <1479066187-26861-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161113_204317_871666_964C0C8E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

nl80211 now uses section qualifier __ro_after_init. However, this
is not available in kernels before v4.6. Neither is the section
itself hence adding an empty define in backports.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
v2:
- use ifndef instead of version check
- consequently dropped inclusion of version.h
---
 backport/backport-include/linux/cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/cache.h

diff --git a/backport/backport-include/linux/cache.h b/backport/backport-include/linux/cache.h
new file mode 100644
index 0000000..bd7cdcf
--- /dev/null
+++ b/backport/backport-include/linux/cache.h
@@ -0,0 +1,10 @@
+#ifndef _BACKPORT_CACHE_H
+#define _BACKPORT_CACHE_H
+
+#include_next <linux/cache.h>
+
+#ifndef __ro_after_init
+#define __ro_after_init
+#endif
+
+#endif /* _BACKPORT_CACHE_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
