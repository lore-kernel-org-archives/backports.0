Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39118 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbbHBWh6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] header: add of_platform_populate()
Date: Mon,  3 Aug 2015 00:37:44 +0200
Message-Id: <1438555067-15301-6-git-send-email-hauke@hauke-m.de> (sfid-20150803_003810_437223_5AB0A83D)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

of_platform_populate() is not added when CONFIG_OF_DEVICE is not set on
kernel < 3.4.
The same is true for of_default_bus_match_table on kernel < 3.11. we do
not need to provide a real implementation of of_default_bus_match_table
because it will be accessed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of_platform.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 backport/backport-include/linux/of_platform.h

diff --git a/backport/backport-include/linux/of_platform.h b/backport/backport-include/linux/of_platform.h
new file mode 100644
index 0000000..7b0e906
--- /dev/null
+++ b/backport/backport-include/linux/of_platform.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT_LINUX_OF_PLATFORM_H
+#define __BACKPORT_LINUX_OF_PLATFORM_H
+#include_next <linux/of_platform.h>
+#include <linux/version.h>
+#include <linux/of.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && !defined(CONFIG_OF_DEVICE)
+struct of_dev_auxdata;
+#define of_platform_populate LINUX_BACKPORT(of_platform_populate)
+static inline int of_platform_populate(struct device_node *root,
+					const struct of_device_id *matches,
+					const struct of_dev_auxdata *lookup,
+					struct device *parent)
+{
+	return -ENODEV;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) && !defined(CONFIG_OF_DEVICE)
+extern const struct of_device_id of_default_bus_match_table[];
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) */
+
+#endif /* __BACKPORT_LINUX_OF_PLATFORM_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
