Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13118 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbbKOLr0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 06:47:26 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Eliad Peller <eliad@wizery.com>,
	Eliad Peller <eliadx.peller@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: add of_find_property_value_of_size()
Date: Sun, 15 Nov 2015 13:47:22 +0200
Message-Id: <1447588042-27281-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20151115_124728_437539_79979956)
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
---
 backport/compat/backport-3.18.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index bed5d96..60cd3c4 100644
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
  * of_property_read_u64_array - Find and read an array of 64 bit integers
  * from a property.
  *
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
