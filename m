Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:62021 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaDEMlN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:13 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so4528758pdj.3
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/27] backports: fix compilation with CONFIG_OF
Date: Sat,  5 Apr 2014 05:40:35 -0700
Message-Id: <1396701662-15165-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144120_269414_B7B61909)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There are two users of of_find_property_value_of_size() which is
originally static in the kernel, but we need it exposed (but not
exported) so that multiple backport files can use it; do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/of.h |  3 +++
 backport/compat/backport-3.10.c      | 28 ++++++++++++++++++++++++++++
 backport/compat/compat-3.8.c         | 28 ----------------------------
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index e600055..e7f7ea7 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -52,6 +52,9 @@ static inline int of_property_read_u8_array(const struct device_node *np,
 extern int of_property_read_u32_index(const struct device_node *np,
 				       const char *propname,
 				       u32 index, u32 *out_value);
+/* This is static in the kernel, but we need it in multiple places */
+void *of_find_property_value_of_size(const struct device_node *np,
+				     const char *propname, u32 len);
 #else
 static inline int of_property_read_u32_index(const struct device_node *np,
 			const char *propname, u32 index, u32 *out_value)
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 2e64228..c7a1c18 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -178,6 +178,34 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
 
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
  * of_property_read_u32_index - Find and read a u32 from a multi-value property.
  *
  * @np:		device node from which the property value is to be read.
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index d39e8d6..49dc44b 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -457,34 +457,6 @@ EXPORT_SYMBOL_GPL(prandom_bytes);
 
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
-static void *of_find_property_value_of_size(const struct device_node *np,
-			const char *propname, u32 len)
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
  * of_property_read_u8_array - Find and read an array of u8 from a property.
  *
  * @np:		device node from which the property value is to be read.
-- 
1.8.5.3

