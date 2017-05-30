Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59866 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751168AbdE3IJp (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 30 May 2017 04:09:45 -0400
From: Luca Coelho <luca@coelho.fi>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org
Date: Tue, 30 May 2017 11:09:34 +0300
Message-Id: <20170530080934.7214-1-luca@coelho.fi> (sfid-20170530_100950_656784_A39C9357)
Subject: [PATCH] backports: provide backport of devcoredump when disabled in kernels >= 3.18
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

When devcoredump is not enabled in a kernel that supports it, we would
only use stubs for the devcoredump in the backports.  Allow the
backport to compile when that's the case.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/Kconfig        | 1 -
 backport/compat/backport-4.7.c | 8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 335d9058072e..f66d5f74ba18 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -128,7 +128,6 @@ config BPAUTO_WANT_DEV_COREDUMP
 
 config BPAUTO_BUILD_WANT_DEV_COREDUMP
 	bool
-	depends on KERNEL_3_18
 	default n if DEV_COREDUMP
 	default n if DISABLE_DEV_COREDUMP
 	default y if BPAUTO_WANT_DEV_COREDUMP
diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
index 25a00235bce4..b064707767c6 100644
--- a/backport/compat/backport-4.7.c
+++ b/backport/compat/backport-4.7.c
@@ -116,8 +116,12 @@ int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
 }
 EXPORT_SYMBOL_GPL(nla_put_64bit);
 
-/* below 3.18 we copied the entire devcoredump */
-#if LINUX_VERSION_IS_GEQ(3,18,0)
+/*
+ * Below 3.18 or if the kernel has devcoredump disabled, we copied the
+ * entire devcoredump, so no need to define these functions.
+ */
+#if LINUX_VERSION_IS_GEQ(3,18,0) && \
+	!defined(CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP)
 #include <linux/devcoredump.h>
 #include <linux/scatterlist.h>
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
