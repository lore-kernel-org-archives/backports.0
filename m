Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49152 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757560AbdJMJmc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 02/11] backports: add mktime64()
Date: Fri, 13 Oct 2017 11:42:17 +0200
Message-Id: <20171013094226.10021-2-johannes@sipsolutions.net> (sfid-20171013_114234_796215_2A8F2D33)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/time64.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/backport/backport-include/linux/time64.h b/backport/backport-include/linux/time64.h
index 609b8904e40d..49805da9dfce 100644
--- a/backport/backport-include/linux/time64.h
+++ b/backport/backport-include/linux/time64.h
@@ -21,4 +21,26 @@
 #define timespec64			timespec
 #endif /* LINUX_VERSION_IS_LESS(3,17,0) */
 
+#if LINUX_VERSION_IS_LESS(3,19,0)
+static inline time64_t mktime64(const unsigned int year0, const unsigned int mon0,
+				const unsigned int day, const unsigned int hour,
+				const unsigned int min, const unsigned int sec)
+{
+	unsigned int mon = mon0, year = year0;
+
+	/* 1..12 -> 11,12,1..10 */
+	if (0 >= (int) (mon -= 2)) {
+		mon += 12;	/* Puts Feb last since it has leap day */
+		year -= 1;
+	}
+
+	return ((((time64_t)
+		  (year/4 - year/100 + year/400 + 367*mon/12 + day) +
+		  year*365 - 719499
+	    )*24 + hour /* now have hours - midnight tomorrow handled here */
+	  )*60 + min /* now have minutes */
+	)*60 + sec; /* finally seconds */
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_TIME64_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
