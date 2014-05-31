Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56015 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 09EC27E5C
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:52 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/13] backports: add devm_gpio_request{_one}()
Date: Sat, 31 May 2014 19:16:06 +0200
Message-Id: <1401556570-3363-10-git-send-email-hauke@hauke-m.de> (sfid-20140531_191654_682738_BAF1D095)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These two functions are used by some drivers, but not available in all
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/gpio.h | 29 +++++++++++++
 backport/compat/compat-3.5.c           | 77 ++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 backport/backport-include/linux/gpio.h

diff --git a/backport/backport-include/linux/gpio.h b/backport/backport-include/linux/gpio.h
new file mode 100644
index 0000000..8fb7211
--- /dev/null
+++ b/backport/backport-include/linux/gpio.h
@@ -0,0 +1,29 @@
+#ifndef __BACKPORT_LINUX_GPIO_H
+#define __BACKPORT_LINUX_GPIO_H
+#include_next <linux/gpio.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#define devm_gpio_request_one LINUX_BACKPORT(devm_gpio_request_one)
+#define devm_gpio_request LINUX_BACKPORT(devm_gpio_request)
+#ifdef CONFIG_GPIOLIB
+int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
+int devm_gpio_request_one(struct device *dev, unsigned gpio,
+			  unsigned long flags, const char *label);
+#else
+static inline int devm_gpio_request(struct device *dev, unsigned gpio,
+				    const char *label)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
+
+static inline int devm_gpio_request_one(struct device *dev, unsigned gpio,
+					unsigned long flags, const char *label)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
+#endif /* CONFIG_GPIOLIB */
+#endif
+
+#endif /* __BACKPORT_LINUX_GPIO_H */
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 2727eb3..487605f 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -12,6 +12,7 @@
 #include <linux/highuid.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
+#include <linux/gpio.h>
 #include <linux/ptp_clock_kernel.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
@@ -73,3 +74,79 @@ int ptp_clock_index(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_index);
 #endif /* CONFIG_PTP_1588_CLOCK */
+
+#ifdef CONFIG_GPIOLIB
+static void devm_gpio_release(struct device *dev, void *res)
+{
+	unsigned *gpio = res;
+
+	gpio_free(*gpio);
+}
+
+/**
+ *      devm_gpio_request - request a GPIO for a managed device
+ *      @dev: device to request the GPIO for
+ *      @gpio: GPIO to allocate
+ *      @label: the name of the requested GPIO
+ *
+ *      Except for the extra @dev argument, this function takes the
+ *      same arguments and performs the same function as
+ *      gpio_request().  GPIOs requested with this function will be
+ *      automatically freed on driver detach.
+ *
+ *      If an GPIO allocated with this function needs to be freed
+ *      separately, devm_gpio_free() must be used.
+ */
+
+int devm_gpio_request(struct device *dev, unsigned gpio, const char *label)
+{
+	unsigned *dr;
+	int rc;
+
+	dr = devres_alloc(devm_gpio_release, sizeof(unsigned), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = gpio_request(gpio, label);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	*dr = gpio;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_gpio_request);
+
+/**
+ *	devm_gpio_request_one - request a single GPIO with initial setup
+ *	@dev:   device to request for
+ *	@gpio:	the GPIO number
+ *	@flags:	GPIO configuration as specified by GPIOF_*
+ *	@label:	a literal description string of this GPIO
+ */
+int devm_gpio_request_one(struct device *dev, unsigned gpio,
+			  unsigned long flags, const char *label)
+{
+	unsigned *dr;
+	int rc;
+
+	dr = devres_alloc(devm_gpio_release, sizeof(unsigned), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = gpio_request_one(gpio, flags, label);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	*dr = gpio;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_gpio_request_one);
+#endif /* CONFIG_GPIOLIB */
-- 
1.9.1

