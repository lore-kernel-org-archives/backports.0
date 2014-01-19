Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58355 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:23 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/16] backports: add IS_BUILTIN()
Date: Sun, 19 Jan 2014 17:47:30 +0100
Message-Id: <1390150057-11652-10-git-send-email-hauke@hauke-m.de> (sfid-20140119_174824_578315_C9C6274F)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by bcma.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kconfig.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index d5c483d..ee938e3 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -21,4 +21,7 @@
         (config_enabled(option) || config_enabled(option##_MODULE))
 #endif
 
+#undef IS_BUILTIN
+#define IS_BUILTIN(option) config_enabled(option)
+
 #endif
-- 
1.7.10.4

