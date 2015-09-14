Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35749 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbbINHtA (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] patches: make ACPI gpio configuration depend on kernel >= 3.19
Date: Mon, 14 Sep 2015 09:48:37 +0200
Message-Id: <1442216922-3318-6-git-send-email-hauke@hauke-m.de> (sfid-20150914_094904_723782_0F36CD59)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The GPIO configuration in the hci_bcm driver is now fetched from ACPI,
which only works in kernel version >= 3.19. In addition it used these
GPIO informations with the gpio consumer framework which was added in
3.13, deactivate these new features if the kernel does not support them.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch

diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
new file mode 100644
index 0000000..df1b165
--- /dev/null
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -0,0 +1,78 @@
+--- a/drivers/bluetooth/hci_bcm.c
++++ b/drivers/bluetooth/hci_bcm.c
+@@ -29,7 +29,9 @@
+ #include <linux/acpi.h>
+ #include <linux/platform_device.h>
+ #include <linux/clk.h>
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ #include <linux/gpio/consumer.h>
++#endif
+ #include <linux/tty.h>
+ 
+ #include <net/bluetooth/bluetooth.h>
+@@ -138,8 +140,10 @@ static int bcm_gpio_set_power(struct bcm
+ 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+ 		clk_enable(dev->clk);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	gpiod_set_value(dev->shutdown, powered);
+ 	gpiod_set_value(dev->device_wakeup, powered);
++#endif
+ 
+ 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
+ 		clk_disable(dev->clk);
+@@ -347,7 +351,9 @@ static int bcm_suspend(struct device *de
+ 
+ 	/* Suspend the device */
+ 	if (bdev->device_wakeup) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 		gpiod_set_value(bdev->device_wakeup, false);
++#endif
+ 		BT_DBG("suspend, delaying 15 ms");
+ 		mdelay(15);
+ 	}
+@@ -363,7 +369,9 @@ static int bcm_resume(struct device *dev
+ 	BT_DBG("resume (%p): is_suspended %d", bdev, bdev->is_suspended);
+ 
+ 	if (bdev->device_wakeup) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 		gpiod_set_value(bdev->device_wakeup, true);
++#endif
+ 		BT_DBG("resume, delaying 15 ms");
+ 		mdelay(15);
+ 	}
+@@ -379,6 +387,7 @@ static int bcm_resume(struct device *dev
+ }
+ #endif
+ 
++#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
+ static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
+ 
+@@ -388,7 +397,6 @@ static const struct acpi_gpio_mapping ac
+ 	{ },
+ };
+ 
+-#ifdef CONFIG_ACPI
+ static int bcm_resource(struct acpi_resource *ares, void *data)
+ {
+ 	struct bcm_device *dev = data;
+@@ -527,7 +535,7 @@ static const struct hci_uart_proto bcm_p
+ 	.dequeue	= bcm_dequeue,
+ };
+ 
+-#ifdef CONFIG_ACPI
++#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ static const struct acpi_device_id bcm_acpi_match[] = {
+ 	{ "BCM2E39", 0 },
+ 	{ "BCM2E67", 0 },
+@@ -544,7 +552,9 @@ static struct platform_driver bcm_driver
+ 	.remove = bcm_remove,
+ 	.driver = {
+ 		.name = "hci_bcm",
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
++#endif
+ 		.pm = &bcm_pm_ops,
+ 	},
+ };
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
