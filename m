Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50914 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab3JEWo6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 11/15] backports: remove devm_regmap_init_spi()
Date: Sun,  6 Oct 2013 00:44:00 +0200
Message-Id: <1381013044-7724-12-git-send-email-hauke@hauke-m.de> (sfid-20131006_010806_969172_421F6EC0)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is not used by any code in backports, not even a DRM driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/regmap.h |    5 --
 backport/compat/compat-3.4.c             |   73 ------------------------------
 2 files changed, 78 deletions(-)

diff --git a/backport/backport-include/linux/regmap.h b/backport/backport-include/linux/regmap.h
index ac6a3f2..870ea2c 100644
--- a/backport/backport-include/linux/regmap.h
+++ b/backport/backport-include/linux/regmap.h
@@ -25,11 +25,6 @@ struct regmap *devm_regmap_init(struct device *dev,
 struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
 				    const struct regmap_config *config);
 #endif /* defined(CONFIG_REGMAP_I2C) */
-#if defined(CONFIG_REGMAP_SPI)
-#define devm_regmap_init_spi LINUX_BACKPORT(devm_regmap_init_spi)
-struct regmap *devm_regmap_init_spi(struct spi_device *dev,
-				    const struct regmap_config *config);
-#endif /* defined(CONFIG_REGMAP_SPI) */
 
 /*
  * We can't backport these unless we try to backport
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index 99dfb0c..f6b826d 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -260,79 +260,6 @@ struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
 EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
 #endif /* defined(CONFIG_REGMAP_I2C) */
 
-#if defined(CONFIG_REGMAP_SPI)
-static int regmap_spi_write(
-			    struct device *dev,
-			    const void *data, size_t count)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return spi_write(spi, data, count);
-}
-
-static int regmap_spi_gather_write(
-				   struct device *dev,
-				   const void *reg, size_t reg_len,
-				   const void *val, size_t val_len)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct spi_message m;
-	struct spi_transfer t[2] = { { .tx_buf = reg, .len = reg_len, },
-				     { .tx_buf = val, .len = val_len, }, };
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t[0], &m);
-	spi_message_add_tail(&t[1], &m);
-
-	return spi_sync(spi, &m);
-}
-
-static int regmap_spi_read(
-			   struct device *dev,
-			   const void *reg, size_t reg_size,
-			   void *val, size_t val_size)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return spi_write_then_read(spi, reg, reg_size, val, val_size);
-}
-
-static struct regmap_bus regmap_spi = {
-	.write = regmap_spi_write,
-	.gather_write = regmap_spi_gather_write,
-/*
- * See commit 0d509f2b112b
- * only 3.9 kernels have this we'll ignore it
- * given I have not seen drivers use these we
- * are backporting. We'll -EINVAL these.
- */
-#if 0
-	.async_write = regmap_spi_async_write,
-	.async_alloc = regmap_spi_async_alloc,
-#endif
-	.read = regmap_spi_read,
-	.read_flag_mask = 0x80,
-
-};
-
-/**
- * devm_regmap_init_spi(): Initialise register map
- *
- * @spi: Device that will be interacted with
- * @config: Configuration for register map
- *
- * The return value will be an ERR_PTR() on error or a valid pointer
- * to a struct regmap.  The map will be automatically freed by the
- * device management code.
- */
-struct regmap *devm_regmap_init_spi(struct spi_device *spi,
-				    const struct regmap_config *config)
-{
-	return devm_regmap_init(&spi->dev, &regmap_spi, config);
-}
-EXPORT_SYMBOL_GPL(devm_regmap_init_spi);
-#endif /* defined(CONFIG_REGMAP_SPI) */
-
 #endif /* defined(CONFIG_REGMAP) */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
-- 
1.7.10.4

