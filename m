Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24554 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935419Ab3DHK0e (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:34 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 4/8] backport module_i2c_driver helper macro
Date: Mon,  8 Apr 2013 12:26:09 +0200
Message-Id: <1365416773-12836-5-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122644_799462_F2694913)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.3.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/backport/include/linux/compat-3.3.h b/backport/include/linux/compat-3.3.h
index 2af4a52..ce7e776 100644
--- a/backport/include/linux/compat-3.3.h
+++ b/backport/include/linux/compat-3.3.h
@@ -371,6 +371,27 @@ module_exit(__driver##_exit);
 #undef PCI_EXP_TYPE_RC_EC
 #define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
 
+
+/* This backports:
+ *
+ * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ * Date:   Wed Nov 16 10:13:36 2011 +0100
+ *
+ *     I2C: Add helper macro for i2c_driver boilerplate
+ */
+/**
+ * module_i2c_driver() - Helper macro for registering a I2C driver
+ * @__i2c_driver: i2c_driver struct
+ *
+ * Helper macro for I2C drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_i2c_driver(__i2c_driver) \
+	module_driver(__i2c_driver, i2c_add_driver, \
+			i2c_del_driver)
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) */
 
 #endif /* LINUX_3_3_COMPAT_H */
-- 
1.7.10.4

