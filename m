Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59518 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeBRNzp (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:45 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:55 +0200
Message-Id: <20180218132459.11011-7-luca@coelho.fi> (sfid-20180218_145546_843555_1736357B)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 06/10] backport: add new build_bug.h file
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Some of the code in bug.h was moved into a new build_bug.h file.  Add
a backport that includes bug.h in the case of older kernels.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/build_bug.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/build_bug.h

diff --git a/backport/backport-include/linux/build_bug.h b/backport/backport-include/linux/build_bug.h
new file mode 100644
index 000000000000..13ee5d6a277a
--- /dev/null
+++ b/backport/backport-include/linux/build_bug.h
@@ -0,0 +1,10 @@
+#ifndef __BP_BUILD_BUG_H
+#define __BP_BUILD_BUG_H
+
+#if LINUX_VERSION_IS_GEQ(4,13,0)
+#include_next <linux/build_bug.h>
+#else /* LINUX_VERSION_IS_GEQ(4,13,0) */
+#include <linux/bug.h>
+#endif /* LINUX_VERSION_IS_GEQ(4,13,0) */
+
+#endif /* __BP_BUILD_BUG_H */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
