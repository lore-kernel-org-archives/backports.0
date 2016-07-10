Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56159 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757310AbcGJVPB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/19] header: add thermal_notify_framework()
Date: Sun, 10 Jul 2016 23:14:36 +0200
Message-Id: <1468185285-28265-11-git-send-email-hauke@hauke-m.de> (sfid-20160711_013912_430874_58ABA457)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

thermal_notify_framework() was renamed in kernel 3.10 and added in
kernel 3.8. Instead of calling the update only on the specified trip,
we call it on all in kernel < 3.8.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/thermal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index c06dee6..595f5c5 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -14,4 +14,14 @@
 	thermal_zone_device_register(type, trips, mask, devdata, ops, passive_delay, polling_delay)
 #endif /* < 3.8 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#define thermal_notify_framework LINUX_BACKPORT(thermal_notify_framework)
+static inline void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
+{
+       thermal_zone_device_update(tz);
+}
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define thermal_notify_framework(tz, trip) notify_thermal_framework(tz, trip)
+#endif /* < 3.10 */
+
 #endif /* __BACKPORT_THERMAL_H__ */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
