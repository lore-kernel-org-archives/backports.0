Return-path: <backports-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:44490 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbAYRqO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 25 Jan 2015 12:46:14 -0500
From: Mathieu Olivari <mathieu@qca.qualcomm.com>
To: <mcgrof@kernel.org>, <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>, <kvalo@qca.qualcomm.com>,
	Mathieu Olivari <mathieu@qca.qualcomm.com>
Subject: [PATCH v2 2/2] backport: add hwmon group registration functions
Date: Sun, 25 Jan 2015 09:46:02 -0800
Message-ID: <1422207962-23988-2-git-send-email-mathieu@qca.qualcomm.com> (sfid-20150125_184615_933441_6ED1D4B8)
In-Reply-To: <1422207962-23988-1-git-send-email-mathieu@qca.qualcomm.com>
References: <1422207962-23988-1-git-send-email-mathieu@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

hwmon group registration functions have been added in 3.13 kernel.
Latest ath10k patches make use of this mechanism, therefore the
need for the backport.

Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>

---
 backport/backport-include/linux/hwmon.h |   34 ++++++++++++++++++++
 backport/compat/backport-3.13.c         |   52 +++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 backport/backport-include/linux/hwmon.h

Notes:
    v2: address the comments reported by Hauke
    *make devm_hwmon_release() static and moved it above
     devm_hwmon_device_register_with_group()
    *moved new includes at the top of the file
    *set dev->groups and drvdata in hwmon_device_register_with_groups()

diff --git a/backport/backport-include/linux/hwmon.h b/backport/backport-include/linux/hwmon.h
new file mode 100644
index 0000000..c0185f1
--- /dev/null
+++ b/backport/backport-include/linux/hwmon.h
@@ -0,0 +1,34 @@
+#ifndef __BACKPORT_LINUX_HWMON_H
+#define __BACKPORT_LINUX_HWMON_H
+#include_next <linux/hwmon.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+/*
+ * Backports
+ *
+ * commit bab2243ce1897865e31ea6d59b0478391f51812b
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ * Date:   Sat Jul 6 13:57:23 2013 -0700
+ *
+ *     hwmon: Introduce hwmon_device_register_with_groups
+ *
+ *     hwmon_device_register_with_groups() lets callers register a hwmon device
+ *     together with all sysfs attributes in a single call.
+ *
+ *     When using hwmon_device_register_with_groups(), hwmon attributes are attached
+ *     to the hwmon device directly and no longer with its parent device.
+ *
+ * Signed-off-by: Guenter Roeck <linux@roeck-us.net>
+ */
+struct device *
+hwmon_device_register_with_groups(struct device *dev, const char *name,
+				  void *drvdata,
+				  const struct attribute_group **groups);
+struct device *
+devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
+				       void *drvdata,
+				       const struct attribute_group **groups);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
+#endif /* __BACKPORT_LINUX_HWMON_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 553ed8f..f06269b 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -14,6 +14,8 @@
 #include <net/genetlink.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 #ifdef CONFIG_REGULATOR
@@ -252,3 +254,53 @@ bool pci_device_is_present(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
 #endif /* CONFIG_PCI */
+
+#ifdef CONFIG_HWMON
+struct device*
+hwmon_device_register_with_groups(struct device *dev, const char *name,
+				  void *drvdata,
+				  const struct attribute_group **groups)
+{
+	struct device *hwdev;
+
+	hwdev = hwmon_device_register(dev);
+	hwdev->groups = groups;
+	dev_set_drvdata(&hwdev, drvdata);
+	return hwdev;
+}
+
+static void devm_hwmon_release(struct device *dev, void *res)
+{
+	struct device *hwdev = *(struct device **)res;
+
+	hwmon_device_unregister(hwdev);
+}
+
+struct device *
+devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
+				       void *drvdata,
+				       const struct attribute_group **groups)
+{
+	struct device **ptr, *hwdev;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hwdev = hwmon_device_register_with_groups(dev, name, drvdata, groups);
+	if (IS_ERR(hwdev))
+		goto error;
+
+	*ptr = hwdev;
+	devres_add(dev, ptr);
+	return hwdev;
+
+error:
+	devres_free(ptr);
+	return hwdev;
+}
+EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
+#endif
-- 
1.7.10.4

