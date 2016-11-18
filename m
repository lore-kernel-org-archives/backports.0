Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:40784 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753093AbcKRMoL (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 18 Nov 2016 07:44:11 -0500
Received: from [192.40.95.5] (helo=dubbel.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <luca@coelho.fi>)
        id 1c7iWW-0000Pp-J5
        for backports@vger.kernel.org; Fri, 18 Nov 2016 14:44:09 +0200
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Date: Fri, 18 Nov 2016 14:44:02 +0200
Message-Id: <20161118124402.17319-1-luca@coelho.fi> (sfid-20161118_134413_093871_C90578DD)
Subject: [PATCH] backports: only backport kconfig.h macros for < v3.4
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

In kernel v4.9-rc3, config_enabled() was removed, so we can't use it
anymore.  The IS_BUILTIN macro is undefined then redefined using
config_enabled(), which doesn't work anymore.  Additionally, it's not
necessary to include all these macros if the kernel is >= v3.4.  To
fix the config_enabled() problem and to avoid backporting
unnecessarily, simply gate the backports on < v3.4.

Change-Id: I7682ca0cef166e00dd37529da113ab949dfc5c0a
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/kconfig.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index 4fe2a10..4899c7e 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -5,6 +5,7 @@
 #include_next <linux/kconfig.h>
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 #ifndef __ARG_PLACEHOLDER_1
 #define __ARG_PLACEHOLDER_1 0,
 #define config_enabled(cfg) _config_enabled(cfg)
@@ -36,3 +37,4 @@
 #endif
 
 #endif
+#endif
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
