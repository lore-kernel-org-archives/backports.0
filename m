Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35032 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaBXAq4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 1AA947E58
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:55 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/12] backports: add of_property_count_u32_elems()
Date: Mon, 24 Feb 2014 01:45:50 +0100
Message-Id: <1393202754-12919-9-git-send-email-hauke@hauke-m.de> (sfid-20140224_014657_147244_B3B95A67)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/regulator/gpio-regulator.c

This also adds of_property_count_elems_of_size()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h |   35 ++++++++++++++++++++++++++++++++++
 backport/compat/backport-3.15.c      |   35 ++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index a4189bb..10a3d11 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -46,4 +46,39 @@ static inline int of_property_read_u8_array(const struct device_node *np,
 #endif /* CONFIG_OF */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#define of_property_count_elems_of_size LINUX_BACKPORT(of_property_count_elems_of_size)
+#ifdef CONFIG_OF
+extern int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size);
+#else
+static inline int of_property_count_elems_of_size(const struct device_node *np,
+			const char *propname, int elem_size)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+/**
+ * of_property_count_u32_elems - Count the number of u32 elements in a property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a property in a device node and count the number of u32 elements
+ * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * not exist or its length does not match a multiple of u32 and -ENODATA if the
+ * property does not have a value.
+ */
+#define of_property_count_u32_elems LINUX_BACKPORT(of_property_count_u32_elems)
+static inline int of_property_count_u32_elems(const struct device_node *np,
+				const char *propname)
+{
+	return of_property_count_elems_of_size(np, propname, sizeof(u32));
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+
 #endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 367ff9d..67d672b 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -10,6 +10,7 @@
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/of.h>
 
 /**
  * devm_kstrdup - Allocate resource managed space and
@@ -36,3 +37,37 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
 	return buf;
 }
 EXPORT_SYMBOL_GPL(devm_kstrdup);
+
+#ifdef CONFIG_OF
+/**
+ * of_property_count_elems_of_size - Count the number of elements in a property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @elem_size:	size of the individual element
+ *
+ * Search for a property in a device node and count the number of elements of
+ * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
+ * property does not exist or its length does not match a multiple of elem_size
+ * and -ENODATA if the property does not have a value.
+ */
+int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+
+	if (prop->length % elem_size != 0) {
+		pr_err("size of %s in node %s is not a multiple of %d\n",
+		       propname, np->full_name, elem_size);
+		return -EINVAL;
+	}
+
+	return prop->length / elem_size;
+}
+EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
+#endif
-- 
1.7.10.4

