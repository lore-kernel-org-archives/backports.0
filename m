Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41274 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3JXTsL (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 15:48:11 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: add devm_regulator_register()
Date: Thu, 24 Oct 2013 21:48:00 +0200
Message-Id: <1382644082-14032-2-git-send-email-hauke@hauke-m.de> (sfid-20131024_214814_064944_DF0C9DA2)
In-Reply-To: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
References: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports the following commit from mainline:
commit b33e46bcdc4e598d738ed12a5a7906be4e11d786
Author: Mark Brown <broonie@linaro.org>
Date:   Sat Aug 31 11:58:26 2013 +0100

regulator: core: Provide managed regulator registration

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/regulator/driver.h |   10 +++
 backport/compat/Makefile                           |    1 +
 backport/compat/backport-3.13.c                    |   83 ++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 backport/compat/backport-3.13.c

diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
index fbd9845..f56990b 100644
--- a/backport/backport-include/linux/regulator/driver.h
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -23,4 +23,14 @@ int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 				 int min_uV, int max_uV);
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+struct regulator_dev *
+devm_regulator_register(struct device *dev,
+			const struct regulator_desc *regulator_desc,
+			const struct regulator_config *config);
+void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) &&
+	  (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
+
 #endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 4485552..dbf2bff 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -35,6 +35,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_8) += compat-3.8.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
new file mode 100644
index 0000000..c99625f
--- /dev/null
+++ b/backport/compat/backport-3.13.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.13.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/driver.h>
+#include <linux/device.h>
+
+static void devm_rdev_release(struct device *dev, void *res)
+{
+	regulator_unregister(*(struct regulator_dev **)res);
+}
+
+/**
+ * devm_regulator_register - Resource managed regulator_register()
+ * @regulator_desc: regulator to register
+ * @config: runtime configuration for regulator
+ *
+ * Called by regulator drivers to register a regulator.  Returns a
+ * valid pointer to struct regulator_dev on success or an ERR_PTR() on
+ * error.  The regulator will automatically be released when the device
+ * is unbound.
+ */
+struct regulator_dev *devm_regulator_register(struct device *dev,
+				  const struct regulator_desc *regulator_desc,
+				  const struct regulator_config *config)
+{
+	struct regulator_dev **ptr, *rdev;
+
+	ptr = devres_alloc(devm_rdev_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	rdev = regulator_register(regulator_desc, config);
+	if (!IS_ERR(rdev)) {
+		*ptr = rdev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_register);
+
+static int devm_rdev_match(struct device *dev, void *res, void *data)
+{
+	struct regulator_dev **r = res;
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+	return *r == data;
+}
+
+/**
+ * devm_regulator_unregister - Resource managed regulator_unregister()
+ * @regulator: regulator to free
+ *
+ * Unregister a regulator registered with devm_regulator_register().
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_rdev_release, devm_rdev_match, rdev);
+	if (rc != 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_unregister);
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
-- 
1.7.10.4

