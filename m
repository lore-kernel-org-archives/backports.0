Return-path: <backports-owner@vger.kernel.org>
Received: from sabertooth02.qualcomm.com ([65.197.215.38]:3337 "EHLO
	sabertooth02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbbAMCSc (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 12 Jan 2015 21:18:32 -0500
From: Mathieu Olivari <mathieu@qca.qualcomm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>,
	Mathieu Olivari <mathieu@qca.qualcomm.com>
Subject: [PATCH 2/2] backport: add hwmon group registration functions
Date: Mon, 12 Jan 2015 18:17:56 -0800
Message-ID: <1421115476-11855-2-git-send-email-mathieu@qca.qualcomm.com> (sfid-20150113_031834_987465_2795DB4E)
In-Reply-To: <1421115476-11855-1-git-send-email-mathieu@qca.qualcomm.com>
References: <1421115476-11855-1-git-send-email-mathieu@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

hwmon group registration functions have been added in 3.13 kernel.
Latest ath10k patches make use of this mechanism, therefore the
need for the backport.

Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>
---
 backport/backport-include/linux/hwmon.h |   36 +++++++++++++++++++++++
 backport/compat/backport-3.13.c         |   47 +++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 backport/backport-include/linux/hwmon.h

diff --git a/backport/backport-include/linux/hwmon.h b/backport/backport-include/linux/hwmon.h
new file mode 100644
index 0000000..961e979
--- /dev/null
+++ b/backport/backport-include/linux/hwmon.h
@@ -0,0 +1,36 @@
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
+void devm_hwmon_release(struct device *dev, void *res);
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
+#endif /* __BACKPORT_LINUX_HWMON_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 553ed8f..89100a2 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -252,3 +252,50 @@ bool pci_device_is_present(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
 #endif /* CONFIG_PCI */
+
+#ifdef CONFIG_HWMON
+#include <linux/device.h>
+#include <linux/hwmon.h>
+struct device*
+hwmon_device_register_with_groups(struct device *dev, const char *name,
+				  void *drvdata,
+				  const struct attribute_group **groups)
+{
+	return hwmon_device_register(dev);
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
+
+void devm_hwmon_release(struct device *dev, void *res)
+{
+	struct device *hwdev = *(struct device **)res;
+
+	hwmon_device_unregister(hwdev);
+}
+#endif
-- 
1.7.10.4

