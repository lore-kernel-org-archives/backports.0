Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37602 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWyB (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:54:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] backports: add hid log functions
Date: Thu,  8 Aug 2013 00:53:22 +0200
Message-Id: <1375916005-16411-8-git-send-email-hauke@hauke-m.de> (sfid-20130808_005402_610701_01B9AC7B)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds some hid log functions like hid_warn().

This backports the following commit:
commit 4291ee305e9bb0699504a66f0e2b7aefcf0512a5
Author: Joe Perches <joe@perches.com>
Date:   Thu Dec 9 19:29:03 2010 -0800

    HID: Add and use hid_<level>: dev_<level> equivalents

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hid.h |   45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index 22ff6f1..2cae9b7 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -34,4 +34,49 @@ extern bool hid_ignore(struct hid_device *);
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #endif
 
+#ifndef hid_printk
+#define hid_printk(level, hid, fmt, arg...)		\
+	dev_printk(level, &(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_emerg
+#define hid_emerg(hid, fmt, arg...)			\
+	dev_emerg(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_crit
+#define hid_crit(hid, fmt, arg...)			\
+	dev_crit(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_alert
+#define hid_alert(hid, fmt, arg...)			\
+	dev_alert(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_err
+#define hid_err(hid, fmt, arg...)			\
+	dev_err(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_notice
+#define hid_notice(hid, fmt, arg...)			\
+	dev_notice(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_warn
+#define hid_warn(hid, fmt, arg...)			\
+	dev_warn(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_info
+#define hid_info(hid, fmt, arg...)			\
+	dev_info(&(hid)->dev, fmt, ##arg)
+#endif
+
+#ifndef hid_dbg
+#define hid_dbg(hid, fmt, arg...)			\
+	dev_dbg(&(hid)->dev, fmt, ##arg)
+#endif
+
 #endif /* __BACKPORT_HID_H */
-- 
1.7.10.4

