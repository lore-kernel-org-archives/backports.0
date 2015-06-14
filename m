Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41044 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/21] header: add dev_dbg_once() and others
Date: Sun, 14 Jun 2015 16:29:17 +0200
Message-Id: <1434292162-2261-17-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_798423_CC6BFB68)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mt7601u driver makes use of some of these functions and they are
not available on kernel version < 3.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 03ca1f1..539fd50 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -199,5 +199,42 @@ static inline void *devm_kmemdup(struct device *dev, const void *src,
 }
 #endif
 
+#ifndef dev_level_once
+#ifdef CONFIG_PRINTK
+#define dev_level_once(dev_level, dev, fmt, ...)			\
+do {									\
+	static bool __print_once __read_mostly;				\
+									\
+	if (!__print_once) {						\
+		__print_once = true;					\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+	}								\
+} while (0)
+#else
+#define dev_level_once(dev_level, dev, fmt, ...)			\
+do {									\
+	if (0)								\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+} while (0)
+#endif
+
+#define dev_emerg_once(dev, fmt, ...)					\
+	dev_level_once(dev_emerg, dev, fmt, ##__VA_ARGS__)
+#define dev_alert_once(dev, fmt, ...)					\
+	dev_level_once(dev_alert, dev, fmt, ##__VA_ARGS__)
+#define dev_crit_once(dev, fmt, ...)					\
+	dev_level_once(dev_crit, dev, fmt, ##__VA_ARGS__)
+#define dev_err_once(dev, fmt, ...)					\
+	dev_level_once(dev_err, dev, fmt, ##__VA_ARGS__)
+#define dev_warn_once(dev, fmt, ...)					\
+	dev_level_once(dev_warn, dev, fmt, ##__VA_ARGS__)
+#define dev_notice_once(dev, fmt, ...)					\
+	dev_level_once(dev_notice, dev, fmt, ##__VA_ARGS__)
+#define dev_info_once(dev, fmt, ...)					\
+	dev_level_once(dev_info, dev, fmt, ##__VA_ARGS__)
+#define dev_dbg_once(dev, fmt, ...)					\
+	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
+#endif /* dev_level_once */
+
 
 #endif /* __BACKPORT_DEVICE_H */
-- 
2.1.4

