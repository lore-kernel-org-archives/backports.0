Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:38450 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753230AbdBGLPj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 7 Feb 2017 06:15:39 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: restore config_enabled() macro
Date: Tue,  7 Feb 2017 11:15:24 +0000
Message-Id: <1486466124-31640-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170207_121541_911512_C145DFDA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Attempted a backport to FC25 4.9.5 kernel and hit issue with IS_BUILTIN()
using config_enabled() macro in backport-include/linux/kconfig.h. Fix this
by using #ifndef.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/kconfig.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index 4fe2a10..e284dca 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -21,6 +21,13 @@
         (config_enabled(option) || config_enabled(option##_MODULE))
 #endif
 
+/*
+ * Since 4.9 config_enabled has been removed in favor of __is_defined.
+ */
+#ifndef config_enabled
+#define config_enabled(cfg)	__is_defined(cfg)
+#endif
+
 #undef IS_BUILTIN
 #define IS_BUILTIN(option) config_enabled(option)
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
