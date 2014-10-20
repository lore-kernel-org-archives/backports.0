Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58017 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbaJTVeQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add S8_MIN
Date: Mon, 20 Oct 2014 23:33:43 +0200
Message-Id: <1413840827-9142-2-git-send-email-hauke@hauke-m.de> (sfid-20141020_233420_337498_B527672F)
In-Reply-To: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
References: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by the iwlwifi river.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 160689a..9d31d0f 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -45,6 +45,18 @@
 #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
 #endif
 
+#ifndef U8_MAX
+#define U8_MAX		((u8)~0U)
+#endif
+
+#ifndef S8_MAX
+#define S8_MAX		((s8)(U8_MAX>>1))
+#endif
+
+#ifndef S8_MIN
+#define S8_MIN		((s8)(-S8_MAX - 1))
+#endif
+
 #ifndef U16_MAX
 #define U16_MAX		((u16)~0U)
 #endif
-- 
1.9.1

