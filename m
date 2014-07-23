Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55526 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933729AbaGWWLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: add U16_MAX
Date: Thu, 24 Jul 2014 00:11:19 +0200
Message-Id: <1406153488-23896-3-git-send-email-hauke@hauke-m.de> (sfid-20140724_001138_045002_73C4D1BB)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 933686f..160689a 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -45,6 +45,10 @@
 #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
 #endif
 
+#ifndef U16_MAX
+#define U16_MAX		((u16)~0U)
+#endif
+
 #ifndef U32_MAX
 #define U32_MAX		((u32)~0U)
 #endif
-- 
1.9.1

