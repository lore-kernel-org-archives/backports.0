Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38230 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161302Ab3DGCW1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:27 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so2623342pdd.17
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 5/9] compat: backport devm_regmap_init()
Date: Sat,  6 Apr 2013 19:21:58 -0700
Message-Id: <1365301322-19327-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042228_677693_8BC7BC67)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Backport devm_regmap_init() for I2C and SPI.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains c0eb4676
v3.4-rc1~126^2~4^2

commit c0eb46766d395da8d62148bda2e59bad5e6ee2f2
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Jan 30 19:56:52 2012 +0000

    regmap: Implement managed regmap_init()

    Save error handling and unwinding code in drivers by providing managed
    versions of the regmap init functions, simplifying usage.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.4.c        |   95 +++++++++++++++++++++++++++++++++++
 backport/include/linux/compat-3.4.h |   15 ++++++
 2 files changed, 110 insertions(+)

diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index f8512e4..1f3f8ec 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -12,6 +12,101 @@
 #include <linux/module.h>
 #include <linux/wait.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if defined(CONFIG_REGMAP)
+static void devm_regmap_release(struct device *dev, void *res)
+{
+	regmap_exit(*(struct regmap **)res);
+}
+
+/**
+ * devm_regmap_init(): Initialise managed register map
+ *
+ * @dev: Device that will be interacted with
+ * @bus: Bus-specific callbacks to use with device
+ * @bus_context: Data passed to bus-specific callbacks
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  This function should generally not be called
+ * directly, it should be called by bus-specific init functions.  The
+ * map will be automatically freed by the device management code.
+ */
+struct regmap *devm_regmap_init(struct device *dev,
+				const struct regmap_bus *bus,
+				void *bus_context,
+				const struct regmap_config *config)
+{
+	struct regmap **ptr, *regmap;
+
+	ptr = devres_alloc(devm_regmap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	regmap = regmap_init(dev,
+			     bus,
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+			     bus_context,
+#endif /* see commit 0135bbcc */
+			     config);
+	if (!IS_ERR(regmap)) {
+		*ptr = regmap;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init);
+
+#if defined(CONFIG_REGMAP_I2C)
+/**
+ * devm_regmap_init_i2c(): Initialise managed register map
+ *
+ * @i2c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
+				    const struct regmap_config *config)
+{
+	return devm_regmap_init(&i2c->dev, &regmap_i2c, config);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
+#endif /* defined(CONFIG_REGMAP_I2C) */
+
+#if defined(CONFIG_REGMAP_I2C)
+/**
+ * devm_regmap_init_spi(): Initialise register map
+ *
+ * @spi: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The map will be automatically freed by the
+ * device management code.
+ */
+struct regmap *devm_regmap_init_spi(struct spi_device *spi,
+				    const struct regmap_config *config)
+{
+	return devm_regmap_init(&spi->dev, &regmap_spi, config);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_spi);
+#endif /* defined(CONFIG_REGMAP_SPI) */
+
+#endif /* defined(CONFIG_REGMAP) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+
 /* __wake_up_common was declared as part of the wait.h until
  * 2.6.31 in which they made it private to the scheduler. Prefix it with
  * compat to avoid double declaration issues.
diff --git a/backport/include/linux/compat-3.4.h b/backport/include/linux/compat-3.4.h
index 2a53cef..0636499 100644
--- a/backport/include/linux/compat-3.4.h
+++ b/backport/include/linux/compat-3.4.h
@@ -13,6 +13,21 @@
 
 #define EPROBE_DEFER   517     /* Driver requests probe retry */
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/regmap.h>
+#define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
+struct regmap *devm_regmap_init(struct device *dev,
+				const struct regmap_bus *bus,
+				void *bus_context,
+				const struct regmap_config *config);
+#define devm_regmap_init_i2c LINUX_BACKPORT(devm_regmap_init_i2c)
+struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
+				    const struct regmap_config *config);
+#define devm_regmap_init_spi LINUX_BACKPORT(devm_regmap_init_spi)
+struct regmap *devm_regmap_init_spi(struct spi_device *dev,
+				    const struct regmap_config *config);
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+
 /*
  * defined here to allow things to compile but technically
  * using this for memory regions will yield in a no-op on newer
-- 
1.7.10.4

