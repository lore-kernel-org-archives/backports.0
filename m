Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36598 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbaLURgn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 08/16] backport: add of_property_read_u32()
Date: Sun, 21 Dec 2014 18:36:22 +0100
Message-Id: <1419183390-22169-9-git-send-email-hauke@hauke-m.de> (sfid-20141221_184348_395798_1767A52E)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 27 ++++++++++++++++++++++++++-
 backport/compat/compat-3.1.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 32ccf19..b289bcb 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -29,6 +29,7 @@ static inline struct device_node *of_find_node_by_name(struct device_node *from,
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#define of_property_read_u8_array LINUX_BACKPORT(of_property_read_u8_array)
 #ifdef CONFIG_OF
 extern int of_property_read_u8_array(const struct device_node *np,
 			const char *propname, u8 *out_values, size_t sz);
@@ -39,7 +40,31 @@ static inline int of_property_read_u8_array(const struct device_node *np,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define of_property_read_u32_array LINUX_BACKPORT(of_property_read_u32_array)
+#ifdef CONFIG_OF
+extern int of_property_read_u32_array(const struct device_node *np,
+				      const char *propname,
+				      u32 *out_values,
+				      size_t sz);
+#else
+static inline int of_property_read_u32_array(const struct device_node *np,
+					     const char *propname,
+					     u32 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+#define of_property_read_u32 LINUX_BACKPORT(of_property_read_u32)
+static inline int of_property_read_u32(const struct device_node *np,
+				       const char *propname,
+				       u32 *out_value)
+{
+	return of_property_read_u32_array(np, propname, out_value, 1);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 #define of_property_read_u32_index LINUX_BACKPORT(of_property_read_u32_index)
diff --git a/backport/compat/compat-3.1.c b/backport/compat/compat-3.1.c
index 0d9c3a2..2618780 100644
--- a/backport/compat/compat-3.1.c
+++ b/backport/compat/compat-3.1.c
@@ -10,6 +10,7 @@
 
 #include <linux/idr.h>
 #include <linux/cpufreq.h>
+#include <linux/of.h>
 
 static DEFINE_SPINLOCK(compat_simple_ida_lock);
 
@@ -82,3 +83,36 @@ void ida_simple_remove(struct ida *ida, unsigned int id)
 EXPORT_SYMBOL_GPL(ida_simple_remove);
 /* source lib/idr.c */
 
+#ifdef CONFIG_OF
+/**
+ * of_property_read_u32_array - Find and read an array of 32 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u32 value can be decoded.
+ */
+int of_property_read_u32_array(const struct device_node *np,
+			       const char *propname, u32 *out_values,
+			       size_t sz)
+{
+	const __be32 *val = of_find_property_value_of_size(np, propname,
+						(sz * sizeof(*out_values)));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	while (sz--)
+		*out_values++ = be32_to_cpup(val++);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u32_array);
+#endif
-- 
1.9.1

