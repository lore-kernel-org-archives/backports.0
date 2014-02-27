Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35254 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaB0Qgu (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 27 Feb 2014 11:36:50 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix compilation with CONFIG_OF
Date: Thu, 27 Feb 2014 17:36:43 +0100
Message-Id: <1393519003-15535-1-git-send-email-johannes@sipsolutions.net> (sfid-20140227_173652_664179_E5A8755E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There are two users of of_find_property_value_of_size() which is
originally static in the kernel, but we need it exposed (but not
exported) so that multiple backport files can use it; do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/of.h |  3 +++
 backport/compat/compat-3.10.c        | 44 ++++++++++++++++++++++++++++++++++++
 backport/compat/compat-3.8.c         | 28 -----------------------
 3 files changed, 47 insertions(+), 28 deletions(-)
 create mode 100644 backport/compat/compat-3.10.c

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index e60005540e12..e7f7ea741b93 100644
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
diff --git a/backport/compat/compat-3.10.c b/backport/compat/compat-3.10.c
new file mode 100644
index 000000000000..affc85f32445
--- /dev/null
+++ b/backport/compat/compat-3.10.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 1999 Andreas Gal
+ * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ * Copyright (c) 2006-2012 Jiri Kosina
+ * Copyright (c) 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * Backport functionality introduced in Linux 3.10.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/of.h>
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
+#endif /* CONFIG_OF */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index d39e8d6728c9..49dc44bd4664 100644
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

