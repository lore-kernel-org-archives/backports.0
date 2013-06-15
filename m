Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39379 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPik (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: add module_spi_driver
Date: Sat, 15 Jun 2013 17:37:56 +0200
Message-Id: <1371310678-26491-7-git-send-email-hauke@hauke-m.de> (sfid-20130615_173842_156192_A5EDED9D)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

module_spi_driver was added in the following commit to mainline:
commit 3acbb0142d48713a8f65cde678a54f419801c189
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Wed Nov 16 10:13:37 2011 +0100

    SPI: Add helper macro for spi_driver boilerplate

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/spi/spi.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/linux/spi/spi.h

diff --git a/backport/backport-include/linux/spi/spi.h b/backport/backport-include/linux/spi/spi.h
new file mode 100644
index 0000000..672cf5b
--- /dev/null
+++ b/backport/backport-include/linux/spi/spi.h
@@ -0,0 +1,20 @@
+#ifndef _BACKPORTS_LINUX_SPI_H
+#define _BACKPORTS_LINUX_SPI_H 1
+
+#include_next <linux/spi/spi.h>
+
+#ifndef module_spi_driver
+/**
+ * module_spi_driver() - Helper macro for registering a SPI driver
+ * @__spi_driver: spi_driver struct
+ *
+ * Helper macro for SPI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_spi_driver(__spi_driver) \
+	module_driver(__spi_driver, spi_register_driver, \
+			spi_unregister_driver)
+#endif
+
+#endif /* _BACKPORTS_LINUX_SPI_H */
-- 
1.7.10.4

