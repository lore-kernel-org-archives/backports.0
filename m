Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59546 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNz6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:58 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:59 +0200
Message-Id: <20180218132459.11011-11-luca@coelho.fi> (sfid-20180218_145559_401980_45C4214D)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 10/10] backport: implement alloc_percpu_gfp() for < 3.18.
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Sara Sharon <sara.sharon@intel.com>

mac80211 now uses the alloc_percpu_gfp() function, which doesn't exist
in kernels older than 3.18.  Backport it accordingly.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport-include/linux/percpu.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport-include/linux/percpu.h

diff --git a/backport-include/linux/percpu.h b/backport-include/linux/percpu.h
new file mode 100644
index 000000000000..10be03cba795
--- /dev/null
+++ b/backport-include/linux/percpu.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2018 Intel Corporation
+ */
+#ifndef __BACKPORT_PERCPU_H
+#define __BACKPORT_PERCPU_H
+#include_next <linux/percpu.h>
+
+#if LINUX_VERSION_IS_LESS(3,18,0)
+static inline void __percpu *__alloc_gfp_warn(void)
+{
+	WARN(1, "Cannot backport alloc_percpu_gfp");
+	return NULL;
+}
+
+#define alloc_percpu_gfp(type, gfp) \
+	({ (gfp == GFP_KERNEL) ? alloc_percpu(type) : __alloc_gfp_warn(); })
+#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
+
+#endif /* __BACKPORT_PERCPU_H */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
