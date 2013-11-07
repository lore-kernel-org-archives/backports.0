Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55832 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773Ab3KGU2T (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:19 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] backports: add of_property_read_u8_array()
Date: Thu,  7 Nov 2013 21:27:51 +0100
Message-Id: <1383856078-19823-5-git-send-email-hauke@hauke-m.de> (sfid-20131107_212834_885638_F21E6A4B)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/bluetooth/btmrvl_main.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h |   13 +++++++
 backport/compat/compat-3.8.c         |   63 ++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 8b24311..a4189bb 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -33,4 +33,17 @@ static inline struct device_node *of_find_node_by_name(struct device_node *from,
 #endif /* CONFIG_OF */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#ifdef CONFIG_OF
+extern int of_property_read_u8_array(const struct device_node *np,
+			const char *propname, u8 *out_values, size_t sz);
+#else
+static inline int of_property_read_u8_array(const struct device_node *np,
+			const char *propname, u8 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
 #endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index b63382d..d43d386 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -418,3 +418,66 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
 	return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
 }
 EXPORT_SYMBOL_GPL(vm_iomap_memory);
+
+#ifdef CONFIG_OF
+/**
+ * of_find_property_value_of_size
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @len:	requested length of property value
+ *
+ * Search for a property in a device node and valid the requested size.
+ * Returns the property value on success, -EINVAL if the property does not
+ *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ */
+static void *of_find_property_value_of_size(const struct device_node *np,
+			const char *propname, u32 len)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	if (!prop)
+		return ERR_PTR(-EINVAL);
+	if (!prop->value)
+		return ERR_PTR(-ENODATA);
+	if (len > prop->length)
+		return ERR_PTR(-EOVERFLOW);
+
+	return prop->value;
+}
+
+/**
+ * of_property_read_u8_array - Find and read an array of u8 from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 8-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * dts entry of array should be like:
+ *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *
+ * The out_values is modified only if a valid u8 value can be decoded.
+ */
+int of_property_read_u8_array(const struct device_node *np,
+			const char *propname, u8 *out_values, size_t sz)
+{
+	const u8 *val = of_find_property_value_of_size(np, propname,
+						(sz * sizeof(*out_values)));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	while (sz--)
+		*out_values++ = *val++;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u8_array);
+#endif /* CONFIG_OF */
-- 
1.7.10.4

