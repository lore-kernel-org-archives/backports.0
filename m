Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48075 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbaIFToh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: remove regulator drivers
Date: Sat,  6 Sep 2014 21:44:18 +0200
Message-Id: <1410032659-30404-5-git-send-email-hauke@hauke-m.de> (sfid-20140906_214441_428652_148C50AD)
In-Reply-To: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
References: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It looks like no one is using the regulator drivers and maintaining
them costs some time because they often break. When someone needs
a specific driver please send a patch adding this one specific driver,
maintaining a small subset is not a problem, but maintaining all is a
big task.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig                                   |  1 -
 backport/Makefile.kernel                           |  1 -
 backport/backport-include/linux/regulator/driver.h | 16 -----
 backport/compat/backport-3.10.c                    | 53 --------------
 backport/defconfigs/regulator                      | 66 -----------------
 copy-list                                          | 31 --------
 dependencies                                       | 82 ----------------------
 7 files changed, 250 deletions(-)
 delete mode 100644 backport/defconfigs/regulator

diff --git a/backport/Kconfig b/backport/Kconfig
index 64e9cb9..b14a268 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -38,7 +38,6 @@ source drivers/bcma/Kconfig
 
 source net/nfc/Kconfig
 
-source drivers/regulator/Kconfig
 source drivers/media/Kconfig
 
 source net/ieee802154/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index ada6dec..dcb2ba7 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -31,7 +31,6 @@ obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
 obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
-obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
 obj-$(CPTCFG_IEEE802154) += net/ieee802154/
diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
index 532eba0..ce5bbdf 100644
--- a/backport/backport-include/linux/regulator/driver.h
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -18,11 +18,6 @@
 #include <linux/version.h>
 #include_next <linux/regulator/driver.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
-int regulator_map_voltage_ascend(struct regulator_dev *rdev,
-				 int min_uV, int max_uV);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
     (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 #define devm_regulator_register LINUX_BACKPORT(devm_regulator_register)
@@ -35,15 +30,4 @@ void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) &&
 	  (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
 
-#ifndef REGULATOR_LINEAR_RANGE
-/* Initialize struct regulator_linear_range */
-#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
-{									\
-	.min_uV		= _min_uV,					\
-	.min_sel	= _min_sel,					\
-	.max_sel	= _max_sel,					\
-	.uV_step	= _step_uV,					\
-}
-#endif
-
 #endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index e75e52e..53123fb 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -19,59 +19,6 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
-#include <linux/init.h>
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/async.h>
-#include <linux/mutex.h>
-#include <linux/suspend.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/regmap.h>
-#include <linux/regulator/of_regulator.h>
-#include <linux/regulator/consumer.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
-#ifdef CONFIG_REGULATOR
-/**
- * regulator_map_voltage_ascend - map_voltage() for ascendant voltage list
- *
- * @rdev: Regulator to operate on
- * @min_uV: Lower bound for voltage
- * @max_uV: Upper bound for voltage
- *
- * Drivers that have ascendant voltage list can use this as their
- * map_voltage() operation.
- */
-int regulator_map_voltage_ascend(struct regulator_dev *rdev,
-				 int min_uV, int max_uV)
-{
-	int i, ret;
-
-	for (i = 0; i < rdev->desc->n_voltages; i++) {
-		ret = rdev->desc->ops->list_voltage(rdev, i);
-		if (ret < 0)
-			continue;
-
-		if (ret > max_uV)
-			break;
-
-		if (ret >= min_uV && ret <= max_uV)
-			return i;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(regulator_map_voltage_ascend);
-
-#endif /* CONFIG_REGULATOR */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
-
 void proc_set_size(struct proc_dir_entry *de, loff_t size)
 {
 	de->size = size;
diff --git a/backport/defconfigs/regulator b/backport/defconfigs/regulator
deleted file mode 100644
index 0b1bc27..0000000
--- a/backport/defconfigs/regulator
+++ /dev/null
@@ -1,66 +0,0 @@
-CPTCFG_REGULATOR=y
-CPTCFG_REGULATOR_88PM800=y
-CPTCFG_REGULATOR_88PM8607=y
-CPTCFG_REGULATOR_AAT2870=y
-CPTCFG_REGULATOR_AB3100=y
-CPTCFG_REGULATOR_AB8500=y
-CPTCFG_REGULATOR_AD5398=y
-CPTCFG_REGULATOR_ANATOP=y
-CPTCFG_REGULATOR_ARIZONA=y
-CPTCFG_REGULATOR_AS3711=y
-CPTCFG_REGULATOR_DA903X=y
-CPTCFG_REGULATOR_DA9052=y
-CPTCFG_REGULATOR_DA9055=y
-CPTCFG_REGULATOR_DB8500_PRCMU=y
-CPTCFG_REGULATOR_DBX500_PRCMU=y
-CPTCFG_REGULATOR_DEBUG=y
-CPTCFG_REGULATOR_FAN53555=y
-CPTCFG_REGULATOR_FIXED_VOLTAGE=y
-CPTCFG_REGULATOR_GPIO=y
-CPTCFG_REGULATOR_ISL6271A=y
-CPTCFG_REGULATOR_LP3971=y
-CPTCFG_REGULATOR_LP3972=y
-CPTCFG_REGULATOR_LP872X=y
-CPTCFG_REGULATOR_LP8755=y
-CPTCFG_REGULATOR_LP8788=y
-CPTCFG_REGULATOR_MAX1586=y
-CPTCFG_REGULATOR_MAX77686=y
-CPTCFG_REGULATOR_MAX77693=y
-CPTCFG_REGULATOR_MAX8649=y
-CPTCFG_REGULATOR_MAX8660=y
-CPTCFG_REGULATOR_MAX8907=y
-CPTCFG_REGULATOR_MAX8925=y
-CPTCFG_REGULATOR_MAX8952=y
-CPTCFG_REGULATOR_MAX8973=y
-CPTCFG_REGULATOR_MAX8997=y
-CPTCFG_REGULATOR_MAX8998=y
-CPTCFG_REGULATOR_MC13783=y
-CPTCFG_REGULATOR_MC13892=y
-CPTCFG_REGULATOR_MC13XXX_CORE=y
-CPTCFG_REGULATOR_PALMAS=y
-CPTCFG_REGULATOR_PCAP=y
-CPTCFG_REGULATOR_PCF50633=y
-CPTCFG_REGULATOR_PFUZE100=y
-CPTCFG_REGULATOR_RC5T583=y
-CPTCFG_REGULATOR_S2MPS11=y
-CPTCFG_REGULATOR_S5M8767=y
-CPTCFG_REGULATOR_TPS51632=y
-CPTCFG_REGULATOR_TPS6105X=y
-CPTCFG_REGULATOR_TPS62360=y
-CPTCFG_REGULATOR_TPS65023=y
-CPTCFG_REGULATOR_TPS6507X=y
-CPTCFG_REGULATOR_TPS65090=y
-CPTCFG_REGULATOR_TPS65217=y
-CPTCFG_REGULATOR_TPS6524X=y
-CPTCFG_REGULATOR_TPS6586X=y
-CPTCFG_REGULATOR_TPS65910=y
-CPTCFG_REGULATOR_TPS65912=y
-CPTCFG_REGULATOR_TPS80031=y
-CPTCFG_REGULATOR_TWL4030=y
-CPTCFG_REGULATOR_USERSPACE_CONSUMER=y
-CPTCFG_REGULATOR_VEXPRESS=y
-CPTCFG_REGULATOR_VIRTUAL_CONSUMER=y
-CPTCFG_REGULATOR_WM831X=y
-CPTCFG_REGULATOR_WM8350=y
-CPTCFG_REGULATOR_WM8400=y
-CPTCFG_REGULATOR_WM8994=y
diff --git a/copy-list b/copy-list
index fdf02c4..b821718 100644
--- a/copy-list
+++ b/copy-list
@@ -132,37 +132,6 @@ include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
 include/linux/platform_data/st21nfcb.h
 
-# Regulator
-# we don't include the whole directory as we need
-# rely on your core regulator implementation given that
-# it relies on late_initcall() and core_initcall() and
-# these can't be backported, as such we need to rely
-# on your base kernel regulator implementatin and can
-# only extend it with further exports. Your core
-# regulator routines are defined via the header file
-# include/linux/regulator/consumer.h and dummy.h
-include/linux/regulator/ab8500.h
-include/linux/regulator/act8865.h
-include/linux/regulator/db8500-prcmu.h
-include/linux/regulator/fan53555.h
-include/linux/regulator/gpio-regulator.h
-include/linux/regulator/lp3971.h
-include/linux/regulator/lp3972.h
-include/linux/regulator/lp872x.h
-include/linux/regulator/max1586.h
-include/linux/regulator/max8649.h
-include/linux/regulator/max8660.h
-include/linux/regulator/max8952.h
-include/linux/regulator/max8973-regulator.h
-include/linux/regulator/pfuze100.h
-include/linux/regulator/tps51632-regulator.h
-include/linux/regulator/tps62360.h
-include/linux/regulator/tps6507x.h
-include/linux/regulator/userspace-consumer.h
-include/linux/platform_data/lp8755.h
-
-drivers/regulator/
-
 # Media
 include/media/
 
diff --git a/dependencies b/dependencies
index 13bf625..a6a9700 100644
--- a/dependencies
+++ b/dependencies
@@ -9,82 +9,6 @@ WL1251_SPI 3.5
 WL1251_SDIO 3.15
 WLCORE_SDIO 3.15
 
-# Regulator
-# Because of -EPROBE_DEFER see commit d1c3414c and note that
-# we can't backport the core regulator as its part of the core
-# vmlinux.
-REGULATOR 3.4
-# requires some work
-REGULATOR_88PM800 3.12
-REGULATOR_88PM8607 3.10
-REGULATOR_AAT2870 3.6
-REGULATOR_ACT8865 3.12
-REGULATOR_AD5398 3.5
-REGULATOR_ARIZONA 3.16
-REGULATOR_AS3711 3.12
-REGULATOR_BCM590XX 3.16
-REGULATOR_DA903X 3.12
-REGULATOR_DA9052 3.9
-REGULATOR_DA9055 3.8
-REGULATOR_DA9210 3.5
-REGULATOR_DA9211 3.17
-REGULATOR_FAN53555 3.5
-REGULATOR_FIXED_VOLTAGE 3.13
-REGULATOR_GPIO 3.6
-REGULATOR_ISL6271A 3.5
-REGULATOR_LP3971 3.6
-REGULATOR_LP3972 3.6
-REGULATOR_LP872X 3.6
-REGULATOR_LP8755 3.6
-REGULATOR_LTC3589 3.13
-REGULATOR_MAX1586 3.6
-REGULATOR_MAX77686 3.7
-REGULATOR_MAX77693 3.11
-REGULATOR_MAX8649 3.10
-REGULATOR_MAX8660 3.5
-REGULATOR_MAX8925 3.5
-REGULATOR_MAX8952 3.6
-REGULATOR_MAX8973 3.6
-REGULATOR_MAX8997 3.8
-REGULATOR_MAX8998 3.11
-REGULATOR_MAX14577 3.16
-REGULATOR_MC13783 3.6
-REGULATOR_MC13892 3.6
-REGULATOR_MC13XXX_CORE 3.6
-REGULATOR_PALMAS 3.17
-REGULATOR_PCAP 3.6
-REGULATOR_PCF50633 3.8
-REGULATOR_PFUZE100 3.6
-REGULATOR_RC5T583 3.6
-
-# These depend on include/linux/mfd/samsung/s2mps14.h which
-# other mfd drivers / platform code can depend on, skip
-# unless we backport all the dependencies which we don't
-# right now.
-REGULATOR_S2MPS11 3.17
-REGULATOR_S2MPA01 3.15
-
-REGULATOR_S5M8767 3.15
-REGULATOR_TPS51632 3.8
-REGULATOR_TPS6105X 3.6
-REGULATOR_TPS62360 3.6
-REGULATOR_TPS62360 3.6
-REGULATOR_TPS65023 3.9
-REGULATOR_TPS6507X 3.6
-REGULATOR_TPS65090 3.16
-# depnds on include/linux/mfd/samsung/s2mps14.h which
-# other mfd drivers / platform code can depend on, skip
-REGULATOR_TPS65217 3.15
-REGULATOR_TPS6524X 3.6
-REGULATOR_TPS6586X 3.16
-REGULATOR_TPS65910 3.14
-REGULATOR_TPS65912 3.12
-REGULATOR_TWL4030 3.11
-REGULATOR_WM831X 3.12
-REGULATOR_WM8350 3.12
-REGULATOR_WM8400 3.12
-REGULATOR_WM8994 3.8
-
 # Media
 MEDIA_SUPPORT 3.2
 USB_GSPCA_OV534 3.5
@@ -132,12 +56,6 @@ SSB_DRIVER_MIPS 3.3
 # BCMA_HOST_SOC are set.
 BCMA_HOST_SOC 3.7
 
-# drivers/regulator/ab3100.c and drivers/mfd/ab3100-core.c
-# both depend on include/linux/mfd/ab3100.h and we should
-# only backport REGULATOR_AB3100 if the mfd driver is
-# backported as well.
-REGULATOR_AB3100 3.9
-
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
-- 
1.9.1

