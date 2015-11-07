Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52911 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbbKGQzV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:21 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/10] header: add ktime_get_ns()
Date: Sat,  7 Nov 2015 17:55:04 +0100
Message-Id: <1446915310-8278-5-git-send-email-hauke@hauke-m.de> (sfid-20151107_175525_215515_2F8EF9A1)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We also have to add the prototype of ktime_t ktime_get(), because
including linux/hrtimer.h caused some strange build errors.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timekeeping.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 4fb39b2..fe42e71 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -7,6 +7,16 @@
 #include_next <linux/timekeeping.h>
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
+extern ktime_t ktime_get(void);
+#define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
+static inline u64 ktime_get_ns(void)
+{
+	return ktime_to_ns(ktime_get());
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 static inline time64_t ktime_get_seconds(void)
 {
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
