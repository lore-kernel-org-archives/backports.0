Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35036 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaBXArB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:47:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 2E5AF7E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:47:00 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/12] backports: add of_property_read_u32_index()
Date: Mon, 24 Feb 2014 01:45:51 +0100
Message-Id: <1393202754-12919-10-git-send-email-hauke@hauke-m.de> (sfid-20140224_014703_219563_530F4332)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/regulator/gpio-regulator.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h |   15 +++++++++++++++
 backport/compat/backport-3.10.c      |   34 +++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 10a3d11..e600055 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -46,6 +46,21 @@ static inline int of_property_read_u8_array(const struct device_node *np,
 #endif /* CONFIG_OF */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define of_property_read_u32_index LINUX_BACKPORT(of_property_read_u32_index)
+#ifdef CONFIG_OF
+extern int of_property_read_u32_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u32 *out_value);
+#else
+static inline int of_property_read_u32_index(const struct device_node *np,
+			const char *propname, u32 index, u32 *out_value)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
 #define of_property_count_elems_of_size LINUX_BACKPORT(of_property_count_elems_of_size)
 #ifdef CONFIG_OF
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index a9f74ed..2e64228 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
+#include <linux/of.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/init.h>
@@ -27,7 +28,6 @@
 #include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
@@ -175,3 +175,35 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
 #endif /* CONFIG_PCI_IOV */
 
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
+
+#ifdef CONFIG_OF
+/**
+ * of_property_read_u32_index - Find and read a u32 from a multi-value property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @out_value:	pointer to return value, modified only if no error.
+ *
+ * Search for a property in a device node and read nth 32-bit value from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_value is modified only if a valid u32 value can be decoded.
+ */
+int of_property_read_u32_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u32 *out_value)
+{
+	const u32 *val = of_find_property_value_of_size(np, propname,
+					((index + 1) * sizeof(*out_value)));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	*out_value = be32_to_cpup(((__be32 *)val) + index);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u32_index);
+#endif /* CONFIG_OF */
-- 
1.7.10.4

