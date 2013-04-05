Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3473 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162570Ab3DEVUv (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:51 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 4/8] backport module_i2c_driver helper macro
Date: Fri,  5 Apr 2013 23:20:38 +0200
Message-Id: <1365196842-12992-4-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232054_849178_BC2537E9)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.7.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/include/linux/compat-3.7.h b/backport/include/linux/compat-3.7.h
index 96662e3..3d35bed 100644
--- a/backport/include/linux/compat-3.7.h
+++ b/backport/include/linux/compat-3.7.h
@@ -207,6 +207,26 @@ static inline s64 nla_get_s64(struct nlattr *nla)
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-1)
 
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
 #else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-- 
1.7.10.4

