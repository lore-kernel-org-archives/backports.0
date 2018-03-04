Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52132 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932503AbeCDW5u (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/14] header: timekeeping.h: Add ktime_get_real_seconds()
Date: Sun,  4 Mar 2018 23:57:12 +0100
Message-Id: <20180304225717.20890-10-hauke@hauke-m.de> (sfid-20180304_235756_048172_582342FD)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in commit dbe7aa622db96b ("timekeeping: Provide
y2038 safe accessor to the seconds portion of CLOCK_REALTIME") and is
used by multiple realtek drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timekeeping.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 0b9c649a..c108645f 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -33,6 +33,15 @@ static inline time64_t ktime_get_seconds(void)
 
 	return t.tv_sec;
 }
+
+static inline time64_t ktime_get_real_seconds(void)
+{
+	struct timeval tv;
+
+	do_gettimeofday(&tv);
+
+	return tv.tv_sec;
+}
 #endif
 
 #endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
