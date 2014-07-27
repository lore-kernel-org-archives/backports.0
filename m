Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34005 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbaG0WKz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/9] backports: add some more dev_*_ratelimited() functions
Date: Mon, 28 Jul 2014 00:10:35 +0200
Message-Id: <1406499039-16212-6-git-send-email-hauke@hauke-m.de> (sfid-20140728_001100_309698_343D61E5)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Some drivers now also call the other dev_*_ratelimited() functions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index e574d47..9ed7398 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -70,6 +70,16 @@ do {									\
 	dev_level_ratelimited(dev_emerg, dev, fmt, ##__VA_ARGS__)
 #define dev_alert_ratelimited(dev, fmt, ...)				\
 	dev_level_ratelimited(dev_alert, dev, fmt, ##__VA_ARGS__)
+#define dev_crit_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_crit, dev, fmt, ##__VA_ARGS__)
+#define dev_err_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
+#define dev_warn_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
+#define dev_notice_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
+#define dev_info_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
-- 
1.9.1

