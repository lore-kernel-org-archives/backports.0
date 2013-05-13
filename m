Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:45931 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3EMKYp (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 06:24:45 -0400
Received: by mail-da0-f45.google.com with SMTP id w3so46502dad.4
        for <backports@vger.kernel.org>; Mon, 13 May 2013 03:24:45 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: add support for regulator_map_voltage_ascend()
Date: Mon, 13 May 2013 03:24:33 -0700
Message-Id: <1368440675-23190-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_122448_760284_71C5E5B6)
In-Reply-To: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This is required by some drivers as of next-20130424.

commit fcf371ee5624cc87abac205cd0dad2432d7f0346
Author: Axel Lin <axel.lin@ingics.com>
Date:   Thu Apr 18 10:34:49 2013 +0800

    regulator: core: Add regulator_map_voltage_ascend() API

    A lot of regulator hardware has ascendant voltage list.
    This patch adds regulator_map_voltage_ascend() and export it.

    Drivers that have ascendant voltage list can use this as their map_voltage()
    operation, this is more efficient than default regulator_map_voltage_iterate()
    function.

    Signed-off-by: Axel Lin <axel.lin@ingics.com>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/regulator/driver.h |   26 ++++++++
 backport/compat/Makefile                           |    1 +
 backport/compat/backport-3.10.c                    |   62 ++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 backport/backport-include/linux/regulator/driver.h
 create mode 100644 backport/compat/backport-3.10.c

diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
new file mode 100644
index 0000000..fbd9845
--- /dev/null
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -0,0 +1,26 @@
+/*
+ * driver.h -- SoC Regulator driver support.
+ *
+ * Copyright (C) 2007, 2008 Wolfson Microelectronics PLC.
+ *
+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Regulator Driver Interface.
+ */
+
+#ifndef __BACKPORT_LINUX_REGULATOR_DRIVER_H_
+#define __BACKPORT_LINUX_REGULATOR_DRIVER_H_
+
+#include <linux/version.h>
+#include_next <linux/regulator/driver.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+int regulator_map_voltage_ascend(struct regulator_dev *rdev,
+				 int min_uV, int max_uV);
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+
+#endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 2ab3169..18df156 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -34,6 +34,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_6) += compat-3.6.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_7) += compat-3.7.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_8) += compat-3.8.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
new file mode 100644
index 0000000..69c3788
--- /dev/null
+++ b/backport/compat/backport-3.10.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * Linux backport symbols for kernels 3.10.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/async.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/suspend.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/module.h>
+
+/**
+ * regulator_map_voltage_ascend - map_voltage() for ascendant voltage list
+ *
+ * @rdev: Regulator to operate on
+ * @min_uV: Lower bound for voltage
+ * @max_uV: Upper bound for voltage
+ *
+ * Drivers that have ascendant voltage list can use this as their
+ * map_voltage() operation.
+ */
+int regulator_map_voltage_ascend(struct regulator_dev *rdev,
+				 int min_uV, int max_uV)
+{
+	int i, ret;
+
+	for (i = 0; i < rdev->desc->n_voltages; i++) {
+		ret = rdev->desc->ops->list_voltage(rdev, i);
+		if (ret < 0)
+			continue;
+
+		if (ret > max_uV)
+			break;
+
+		if (ret >= min_uV && ret <= max_uV)
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(regulator_map_voltage_ascend);
+
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
-- 
1.7.10.4

