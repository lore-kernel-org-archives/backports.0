Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:58844 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933452AbdBVWTA (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Feb 2017 17:19:00 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: add definitions S32_MAX and S32_MIN
Date: Wed, 22 Feb 2017 22:18:45 +0000
Message-Id: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170222_232123_578777_C8CEDBF9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 20e32810bcf4 ("cfg80211: Accept multiple RSSI thresholds
for CQM") the backports need to have S32_MAX and S32_MIN which were
introduced in kernel.h since v3.14.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/kernel.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 4ad000c..ea55d7d 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -73,6 +73,14 @@
 #define U32_MAX		((u32)~0U)
 #endif
 
+#ifndef S32_MAX
+#define S32_MAX		((s32)(U32_MAX>>1))
+#endif
+
+#ifndef S32_MIN
+#define S32_MIN		((s32)(-S32_MAX - 1))
+#endif
+
 #ifndef __round_mask
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
