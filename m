Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48212 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbeIFLbw (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:52 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 4/6] backport-include: backport ktime_get_boottime_seconds
Date: Thu,  6 Sep 2018 08:57:48 +0200
Message-Id: <20180906065750.89673-4-nbd@nbd.name> (sfid-20180906_085756_468881_D5848AB5)
In-Reply-To: <20180906065750.89673-1-nbd@nbd.name>
References: <20180906065750.89673-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/timekeeping.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 30f9b7a9..56c3deec 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -24,6 +24,13 @@ static inline u64 ktime_get_boot_ns(void)
 }
 #endif /* < 3.17 */
 
+#if LINUX_VERSION_IS_LESS(4,18,0)
+static inline time64_t ktime_get_boottime_seconds(void)
+{
+	return ktime_divns(ktime_get_boottime(), NSEC_PER_SEC);
+}
+#endif /* < 4.18 */
+
 #if LINUX_VERSION_IS_LESS(3,19,0)
 static inline time64_t ktime_get_seconds(void)
 {
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
