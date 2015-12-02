Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51772 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbbLBIxO (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 2 Dec 2015 03:53:14 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add ktime_get_boot_ns()
Date: Wed,  2 Dec 2015 09:53:07 +0100
Message-Id: <1449046387-5531-1-git-send-email-johannes@sipsolutions.net> (sfid-20151202_095315_994633_30AB6F68)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This small helper inline was added in 3.17, we want to use it now
so need to backport it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index fe42e7170680..0eaee836015d 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -15,6 +15,11 @@ static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
+
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
