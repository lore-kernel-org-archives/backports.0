Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60685 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbbLGMvz (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Dec 2015 07:51:55 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3] backports: add ktime_get_boot_ns()
Date: Mon,  7 Dec 2015 13:51:52 +0100
Message-Id: <1449492712-1584-1-git-send-email-johannes@sipsolutions.net> (sfid-20151207_135156_666267_55DC9B0A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This small helper inline was added in 3.17, we want to use it now
so need to backport it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index fe42e7170680..db90a0a139b5 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -15,6 +15,12 @@ static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
+
+extern ktime_t ktime_get_boottime(void);
+static inline u64 ktime_get_boot_ns(void)
+{
+	return ktime_to_ns(ktime_get_boottime());
+}
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
