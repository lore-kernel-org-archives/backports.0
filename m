Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51090 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936572Ab3DJLfx (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:35:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so215602pde.23
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:35:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/18] compat: backport devm_regmap_init()
Date: Wed, 10 Apr 2013 04:35:14 -0700
Message-Id: <1365593728-5720-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133558_979546_F1AA003A)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Backport devm_regmap_init() for I2C and SPI.
Asynchronous I/O support was added as of 3.9 and
since the regmap is part the core we don't want
to deal with trying a full backport replacement
yet. Given that no one as of next-20130328 uses
regmap asynchronous we simply warn if its ever
used for now. The regmap callbacks were made
bus agnostic as of commit 0135bbcc added on on
3.5 and becuase of this we we just remove all
that from our port given that we do this port
for kernels < 3.4.

This works with the old core regmap implementation
added as of 3.1 given that static inlines were
used as wrapper for calls and the bus context
was only used by the internal code.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains c0eb4676
v3.4-rc1~126^2~4^2

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 0d509f2b
v3.9-rc2~19^2~6^2~5

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 0135bbcc
v3.5-rc1~117^2~7^3~6

commit c0eb46766d395da8d62148bda2e59bad5e6ee2f2
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Jan 30 19:56:52 2012 +0000

    regmap: Implement managed regmap_init()

    Save error handling and unwinding code in drivers by providing managed
    versions of the regmap init functions, simplifying usage.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

commit 0d509f2b112b21411712f0bf789b372987967e49
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Sun Jan 27 22:07:38 2013 +0800

    regmap: Add asynchronous I/O support

    Some use cases like firmware download can transfer a lot of data in quick
    succession. With high speed buses these use cases can benefit from having
    multiple transfers scheduled at once since this allows the bus to minimise
    the delay between transfers.

    Support this by adding regmap_raw_write_async(), allowing raw transfers to
    be scheduled, and regmap_async_complete() to wait for them to finish.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

commit 0135bbcc7a0cc056f0203ff839466236b8e3dc19
Author: Stephen Warren <swarren@nvidia.com>
Date:   Wed Apr 4 15:48:30 2012 -0600

    regmap: introduce explicit bus_context for bus callbacks

    The only context needed by I2C and SPI bus definitions is the device
    itself; this can be converted to an i2c_client or spi_device in order
    to perform IO on the device. However, other bus types may need more
    context in order to perform IO. Enable this by having regmap_init accept
    a bus_context parameter, and pass this to all bus callbacks. The
    existing callbacks simply pass the struct device here. Future bus types
    may pass something else.

    Signed-off-by: Stephen Warren <swarren@nvidia.com>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.4.c        |  232 +++++++++++++++++++++++++++++++++++
 backport/include/linux/compat-3.4.h |   40 ++++++
 2 files changed, 272 insertions(+)

diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index f8512e4..eec311a 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -12,6 +12,238 @@
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
+#if defined(CONFIG_REGMAP_I2C)
+static int regmap_i2c_write(
+			    struct device *dev,
+			    const void *data,
+			    size_t count)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_master_send(i2c, data, count);
+	if (ret == count)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int regmap_i2c_gather_write(
+				   struct device *dev,
+				   const void *reg, size_t reg_size,
+				   const void *val, size_t val_size)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg xfer[2];
+	int ret;
+
+	/* If the I2C controller can't do a gather tell the core, it
+	 * will substitute in a linear write for us.
+	 */
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
+		return -ENOTSUPP;
+
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = reg_size;
+	xfer[0].buf = (void *)reg;
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_NOSTART;
+	xfer[1].len = val_size;
+	xfer[1].buf = (void *)val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (ret == 2)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int regmap_i2c_read(
+			   struct device *dev,
+			   const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg xfer[2];
+	int ret;
+
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = reg_size;
+	xfer[0].buf = (void *)reg;
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = val_size;
+	xfer[1].buf = val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (ret == 2)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static struct regmap_bus regmap_i2c = {
+	.write = regmap_i2c_write,
+	.gather_write = regmap_i2c_gather_write,
+	.read = regmap_i2c_read,
+};
+#endif /* defined(CONFIG_REGMAP_I2C) */
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
+#if defined(CONFIG_REGMAP_SPI)
+static int regmap_spi_write(
+			    struct device *dev,
+			    const void *data, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return spi_write(spi, data, count);
+}
+
+static int regmap_spi_gather_write(
+				   struct device *dev,
+				   const void *reg, size_t reg_len,
+				   const void *val, size_t val_len)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_message m;
+	struct spi_transfer t[2] = { { .tx_buf = reg, .len = reg_len, },
+				     { .tx_buf = val, .len = val_len, }, };
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+
+	return spi_sync(spi, &m);
+}
+
+static int regmap_spi_read(
+			   struct device *dev,
+			   const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return spi_write_then_read(spi, reg, reg_size, val, val_size);
+}
+
+static struct regmap_bus regmap_spi = {
+	.write = regmap_spi_write,
+	.gather_write = regmap_spi_gather_write,
+/*
+ * See commit 0d509f2b112b
+ * only 3.9 kernels have this we'll ignore it
+ * given I have not seen drivers use these we
+ * are backporting. We'll -EINVAL these.
+ */
+#if 0
+	.async_write = regmap_spi_async_write,
+	.async_alloc = regmap_spi_async_alloc,
+#endif
+	.read = regmap_spi_read,
+	.read_flag_mask = 0x80,
+
+};
+
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
index 01a72b7..a152d51 100644
--- a/backport/include/linux/compat-3.4.h
+++ b/backport/include/linux/compat-3.4.h
@@ -11,6 +11,46 @@
 #include <linux/kconfig.h>
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if defined(CONFIG_REGMAP)
+#include <linux/regmap.h>
+#define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
+struct regmap *devm_regmap_init(struct device *dev,
+				const struct regmap_bus *bus,
+				const struct regmap_config *config);
+#if defined(CONFIG_REGMAP_I2C)
+#define devm_regmap_init_i2c LINUX_BACKPORT(devm_regmap_init_i2c)
+struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
+				    const struct regmap_config *config);
+#endif /* defined(CONFIG_REGMAP_I2C) */
+#if defined(CONFIG_REGMAP_SPI)
+#define devm_regmap_init_spi LINUX_BACKPORT(devm_regmap_init_spi)
+struct regmap *devm_regmap_init_spi(struct spi_device *dev,
+				    const struct regmap_config *config);
+#endif /* defined(CONFIG_REGMAP_SPI) */
+
+/*
+ * We can't backport these unless we try to backport
+ * the full regmap into core so warn if used.
+ * No drivers are using this yet anyway.
+ */
+#define regmap_raw_write_async LINUX_BACKPORT(regmap_raw_write_async)
+static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
+					 const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+#define regmap_async_complete LINUX_BACKPORT(regmap_async_complete)
+static inline void regmap_async_complete(struct regmap *map)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+}
+
+#endif /* defined(CONFIG_REGMAP) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+
 /*
  * defined here to allow things to compile but technically
  * using this for memory regions will yield in a no-op on newer
-- 
1.7.10.4

