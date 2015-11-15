Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35543 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbbKOPxe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:53:34 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: eliad@wizery.com, emmanuel.grumbach@intel.com
Cc: backports@vger.kernel.org, eliadx.peller@intel.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] backports: add of_find_property_value_of_size()
Date: Sun, 15 Nov 2015 16:53:19 +0100
Message-Id: <1447602799-11759-1-git-send-email-hauke@hauke-m.de> (sfid-20151115_165340_574318_8058BDE7)
In-Reply-To: <1447588042-27281-1-git-send-email-emmanuel.grumbach@intel.com>
References: <1447588042-27281-1-git-send-email-emmanuel.grumbach@intel.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Eliad Peller <eliad@wizery.com>

commit 2e98a32a274274fca0e6e ("backport: add
of_property_read_u64_array()") added a call
to of_find_property_value_of_size(), which is a
static function, causing compilation error.

Implement it locally as well.

Signed-off-by: Eliad Peller <eliadx.peller@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
[remove of_find_property_value_of_size() from backport-3.10.c]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

I did some changes to this patch, I hope they are ok.

 backport/backport-include/linux/of.h |  6 +++---
 backport/compat/backport-3.10.c      | 28 ----------------------------
 backport/compat/backport-3.18.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index bc0d7fd..ab98061 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -82,9 +82,6 @@ static inline const void *of_get_property(const struct device_node *node,
 extern int of_property_read_u32_index(const struct device_node *np,
 				       const char *propname,
 				       u32 index, u32 *out_value);
-/* This is static in the kernel, but we need it in multiple places */
-void *of_find_property_value_of_size(const struct device_node *np,
-				     const char *propname, u32 len);
 #else
 static inline int of_property_read_u32_index(const struct device_node *np,
 			const char *propname, u32 index, u32 *out_value)
@@ -170,6 +167,9 @@ static inline struct device_node *of_find_compatible_node(
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
 #define of_property_read_u64_array LINUX_BACKPORT(of_property_read_u64_array)
 #ifdef CONFIG_OF
+/* This is static in the kernel, but we need it in multiple places */
+void *of_find_property_value_of_size(const struct device_node *np,
+				     const char *propname, u32 len);
 extern int of_property_read_u64_array(const struct device_node *np,
 				      const char *propname,
 				      u64 *out_values,
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 53123fb..5cab709 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -123,34 +123,6 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
 
 #ifdef CONFIG_OF
 /**
- * of_find_property_value_of_size
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @len:	requested length of property value
- *
- * Search for a property in a device node and valid the requested size.
- * Returns the property value on success, -EINVAL if the property does not
- *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- */
-void *of_find_property_value_of_size(const struct device_node *np,
-				     const char *propname, u32 len)
-{
-	struct property *prop = of_find_property(np, propname, NULL);
-
-	if (!prop)
-		return ERR_PTR(-EINVAL);
-	if (!prop->value)
-		return ERR_PTR(-ENODATA);
-	if (len > prop->length)
-		return ERR_PTR(-EOVERFLOW);
-
-	return prop->value;
-}
-
-/**
  * of_property_read_u32_index - Find and read a u32 from a multi-value property.
  *
  * @np:		device node from which the property value is to be read.
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index bed5d96..f0f7fd8 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -225,6 +225,34 @@ EXPORT_SYMBOL_GPL(bit_wait_timeout);
 
 #ifdef CONFIG_OF
 /**
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
+void *of_find_property_value_of_size(const struct device_node *np,
+				     const char *propname, u32 len)
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
  * of_property_read_u64_array - Find and read an array of 64 bit integers
  * from a property.
  *
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
