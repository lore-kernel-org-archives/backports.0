Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56160 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeIRDA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] header: Add ktime_get_raw_ts64()
Date: Mon, 17 Sep 2018 23:31:42 +0200
Message-Id: <20180917213142.7875-7-hauke@hauke-m.de> (sfid-20180917_233152_740529_FF5E28E3)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ktime_get_raw_ts64() uses the old function which was renmaed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timekeeping.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 56c3deec..73ce9f17 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -58,4 +58,12 @@ static inline void ktime_get_ts64(struct timespec64 *ts)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,18,0)
+#define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
+static inline void ktime_get_raw_ts64(struct timespec64 *ts)
+{
+	return getrawmonotonic64(ts);
+}
+#endif
+
 #endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
