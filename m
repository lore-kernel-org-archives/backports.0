Return-path: <backports-owner@vger.kernel.org>
Received: from [192.19.211.62] ([192.19.211.62]:48747 "EHLO
        relay.smtp.broadcom.com" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S966898AbcKLUZg (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 12 Nov 2016 15:25:36 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/3] backports: empty define for __ro_after_init
Date: Sat, 12 Nov 2016 20:18:43 +0000
Message-Id: <1478981923-12298-3-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161112_212539_146779_9220B565)
In-Reply-To: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

nl80211 now uses section qualifier __ro_after_init. However, this
is not available in kernels before v4.6. Neither is the section
itself hence adding an empty define in backports.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/cache.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/backport-include/linux/cache.h

diff --git a/backport/backport-include/linux/cache.h b/backport/backport-include/linux/cache.h
new file mode 100644
index 0000000..9ea4a96
--- /dev/null
+++ b/backport/backport-include/linux/cache.h
@@ -0,0 +1,11 @@
+#ifndef _BACKPORT_CACHE_H
+#define _BACKPORT_CACHE_H
+
+#include_next <linux/cache.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
+#define __ro_after_init
+#endif
+
+#endif /* _BACKPORT_CACHE_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
