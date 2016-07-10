Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56157 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302AbcGJVPA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/19] header: adapt thermal_zone_device_register() signature changes
Date: Sun, 10 Jul 2016 23:14:35 +0200
Message-Id: <1468185285-28265-10-git-send-email-hauke@hauke-m.de> (sfid-20160710_231505_730405_A59BF966)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The signature of thermal_zone_device_register() changed for kernel <
3.10 multiple times, adapt the backports code to the old signature.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/thermal.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/linux/thermal.h

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
new file mode 100644
index 0000000..c06dee6
--- /dev/null
+++ b/backport/backport-include/linux/thermal.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_THERMAL_H__
+#define __BACKPORT_THERMAL_H__
+#include_next <linux/thermal.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
+	thermal_zone_device_register(type, trips, devdata, ops, 0, 0, passive_delay, polling_delay)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
+	thermal_zone_device_register(type, trips, mask, devdata, ops, 0, 0, passive_delay, polling_delay)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
+	thermal_zone_device_register(type, trips, mask, devdata, ops, passive_delay, polling_delay)
+#endif /* < 3.8 */
+
+#endif /* __BACKPORT_THERMAL_H__ */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
