Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51941 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbbIUWHb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/10] patches: remove usage of gpio/consumer.h from hci_intel.c
Date: Tue, 22 Sep 2015 00:07:17 +0200
Message-Id: <1442873243-15490-5-git-send-email-hauke@hauke-m.de> (sfid-20150922_000734_593085_EFD3EDBD)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

hci_intel.c now also uses gpio/consumer.h which is only available in
kernel >= 3.13. devm_gpiod_get_optional() with the current parameter
list is only available in kernel 3.17.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0062-acpi-gpio-remove/hci_intel.patch  | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch

diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
new file mode 100644
index 0000000..a6a7d0f
--- /dev/null
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
@@ -0,0 +1,67 @@
+--- a/drivers/bluetooth/hci_intel.c
++++ b/drivers/bluetooth/hci_intel.c
+@@ -29,7 +29,9 @@
+ #include <linux/wait.h>
+ #include <linux/tty.h>
+ #include <linux/platform_device.h>
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ #include <linux/gpio/consumer.h>
++#endif
+ #include <linux/acpi.h>
+ #include <linux/interrupt.h>
+ #include <linux/pm_runtime.h>
+@@ -374,7 +376,9 @@ static int intel_set_power(struct hci_ua
+ 		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
+ 			hu, dev_name(&idev->pdev->dev), powered);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 		gpiod_set_value(idev->reset, powered);
++#endif
+ 
+ 		/* Provide to idev a hu reference which is used to run LPM
+ 		 * transactions (lpm suspend/resume) from PM callbacks.
+@@ -1322,14 +1326,17 @@ static int intel_probe(struct platform_d
+ 		return -ENODEV;
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
+ 					      GPIOD_OUT_LOW);
+ 	if (IS_ERR(idev->reset)) {
+ 		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
+ 		return PTR_ERR(idev->reset);
+ 	}
++#endif
+ 
+ 	idev->irq = platform_get_irq(pdev, 0);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	if (idev->irq < 0) {
+ 		struct gpio_desc *host_wake;
+ 
+@@ -1348,12 +1355,15 @@ static int intel_probe(struct platform_d
+ 			goto no_irq;
+ 		}
+ 	}
++#endif
+ 
+ 	/* Only enable wake-up/irq when controller is powered */
+ 	device_set_wakeup_capable(&pdev->dev, true);
+ 	device_wakeup_disable(&pdev->dev);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ no_irq:
++#endif
+ 	platform_set_drvdata(pdev, idev);
+ 
+ 	/* Place this instance on the device list */
+@@ -1361,8 +1371,10 @@ no_irq:
+ 	list_add_tail(&idev->list, &intel_device_list);
+ 	mutex_unlock(&intel_device_list_lock);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
+ 		 desc_to_gpio(idev->reset), idev->irq);
++#endif
+ 
+ 	return 0;
+ }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
