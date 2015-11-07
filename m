Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52919 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGQzW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:22 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] backport: add of_property_read_u64_array()
Date: Sat,  7 Nov 2015 17:55:08 +0100
Message-Id: <1446915310-8278-9-git-send-email-hauke@hauke-m.de> (sfid-20151107_175527_704800_311C2FBE)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in commit b31384fa5 "Driver core: Unified
device properties interface for platform firmware".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 17 +++++++++++++++++
 backport/compat/backport-3.18.c      | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index ef9c6aa..bc0d7fd 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -167,4 +167,21 @@ static inline struct device_node *of_find_compatible_node(
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#define of_property_read_u64_array LINUX_BACKPORT(of_property_read_u64_array)
+#ifdef CONFIG_OF
+extern int of_property_read_u64_array(const struct device_node *np,
+				      const char *propname,
+				      u64 *out_values,
+				      size_t sz);
+#else
+static inline int of_property_read_u64_array(const struct device_node *np,
+					     const char *propname,
+					     u64 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+
 #endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index 9e1a026..bed5d96 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -15,6 +15,7 @@
 #include <linux/skbuff.h>
 #include <linux/errqueue.h>
 #include <linux/wait.h>
+#include <linux/of.h>
 
 /**
  * eth_get_headlen - determine the the length of header for an ethernet frame
@@ -221,3 +222,39 @@ __sched int bit_wait_timeout(struct wait_bit_key *word)
 }
 EXPORT_SYMBOL_GPL(bit_wait_timeout);
 #endif
+
+#ifdef CONFIG_OF
+/**
+ * of_property_read_u64_array - Find and read an array of 64 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u64 value can be decoded.
+ */
+int of_property_read_u64_array(const struct device_node *np,
+			       const char *propname, u64 *out_values,
+			       size_t sz)
+{
+	const __be32 *val = of_find_property_value_of_size(np, propname,
+						(sz * sizeof(*out_values)));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	while (sz--) {
+		*out_values++ = of_read_number(val, 2);
+		val += 2;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u64_array);
+#endif /* CONFIG_OF */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
