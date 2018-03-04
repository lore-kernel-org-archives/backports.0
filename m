Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34286 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932507AbeCDW5v (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/14] header: timekeeping.h: Add ktime_get_ts64()
Date: Sun,  4 Mar 2018 23:57:13 +0100
Message-Id: <20180304225717.20890-11-hauke@hauke-m.de> (sfid-20180304_235756_708468_5F4F6AC8)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in commit d6d29896c665d ("timekeeping: Provide
timespec64 based interfaces"). We can just use the 32 bit version
instated as the rest was already backported in backports commit
ea8b7cd797ca0c ("backports: deal with struct timespec64 changes)".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timekeeping.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index c108645f..30f9b7a9 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -44,4 +44,11 @@ static inline time64_t ktime_get_real_seconds(void)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(3,17,0)
+static inline void ktime_get_ts64(struct timespec64 *ts)
+{
+	ktime_get_ts(ts);
+}
+#endif
+
 #endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
