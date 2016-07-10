Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56153 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273AbcGJVPA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/19] header: add missing S16_MIN and S16_MAX
Date: Sun, 10 Jul 2016 23:14:33 +0200
Message-Id: <1468185285-28265-8-git-send-email-hauke@hauke-m.de> (sfid-20160710_231505_190952_7D2A15C8)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are now needed by the iwlwifi driver and were added in commit
89a0714106a "kernel.h: define u8, s8, u32, etc. limits"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index f47b21f..fd7aa2b 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -61,6 +61,14 @@
 #define U16_MAX		((u16)~0U)
 #endif
 
+#ifndef S16_MAX
+#define S16_MAX		((s16)(U16_MAX>>1))
+#endif
+
+#ifndef S16_MIN
+#define S16_MIN		((s16)(-S16_MAX - 1))
+#endif
+
 #ifndef U32_MAX
 #define U32_MAX		((u32)~0U)
 #endif
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
