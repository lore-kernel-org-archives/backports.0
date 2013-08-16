Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54790 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755027Ab3HPR1X (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/13] backports: add hid_alloc_report_buf()
Date: Fri, 16 Aug 2013 19:26:36 +0200
Message-Id: <1376674003-5801-6-git-send-email-hauke@hauke-m.de> (sfid-20130816_192738_901971_CE0FFD3D)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hid.h |    5 +++++
 backport/compat/Makefile              |    1 +
 backport/compat/backport-3.12.c       |   28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 backport/compat/backport-3.12.c

diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index 2cae9b7..91d3de6 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -79,4 +79,9 @@ extern bool hid_ignore(struct hid_device *);
 	dev_dbg(&(hid)->dev, fmt, ##arg)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#define hid_alloc_report_buf LINUX_BACKPORT(hid_alloc_report_buf)
+u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
+#endif
+
 #endif /* __BACKPORT_HID_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 80c0294..efdeebd 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -36,6 +36,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_8) += compat-3.8.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_11) += backport-3.11.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
diff --git a/backport/compat/backport-3.12.c b/backport/compat/backport-3.12.c
new file mode 100644
index 0000000..8ca9a8e
--- /dev/null
+++ b/backport/compat/backport-3.12.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.12.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/export.h>
+#include <linux/hid.h>
+
+/*
+ * Allocator for buffer that is going to be passed to hid_output_report()
+ */
+u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
+{
+	/*
+	 * 7 extra bytes are necessary to achieve proper functionality
+	 * of implement() working on 8 byte chunks
+	 */
+
+	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0) + 7;
+
+	return kmalloc(len, flags);
+}
+EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
-- 
1.7.10.4

