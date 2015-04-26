Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50098 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbbDZVEc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] header: add IS_REACHABLE()
Date: Sun, 26 Apr 2015 23:04:18 +0200
Message-Id: <1430082264-11808-2-git-send-email-hauke@hauke-m.de> (sfid-20150426_230435_251058_CE509BBD)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was introduced in commit 9b174527e and is used by the media
drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kconfig.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index ee938e3..4fe2a10 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -24,4 +24,15 @@
 #undef IS_BUILTIN
 #define IS_BUILTIN(option) config_enabled(option)
 
+#ifndef IS_REACHABLE
+/*
+ * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
+ * code can call a function defined in code compiled based on CONFIG_FOO.
+ * This is similar to IS_ENABLED(), but returns false when invoked from
+ * built-in code when CONFIG_FOO is set to 'm'.
+ */
+#define IS_REACHABLE(option) (config_enabled(option) || \
+		 (config_enabled(option##_MODULE) && config_enabled(MODULE)))
+#endif
+
 #endif
-- 
1.9.1

