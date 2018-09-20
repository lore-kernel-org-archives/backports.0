Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50960 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRLx (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:53 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:31 +0300
Message-Id: <20180920112842.27198-4-luca@coelho.fi> (sfid-20180920_132854_071068_96F8394E)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 03/14] backport: introduce match_string() for kernels < 4.6
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

This function was introduced in v4.6 and now the iwlwifi driver uses
it.  Add the function for kernels older than v4.6.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/string.h |  4 ++++
 backport/compat/backport-4.6.c           | 26 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index b85d9c73dc27..df93bf79a691 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -29,4 +29,8 @@ void memzero_explicit(void *s, size_t count);
 ssize_t strscpy(char *dest, const char *src, size_t count);
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,6,0)
+int match_string(const char * const *array, size_t n, const char *string);
+#endif /* LINUX_VERSION_IS_LESS(4,5,0) */
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/backport-4.6.c b/backport/compat/backport-4.6.c
index 54ff669df192..8d0ecf56526d 100644
--- a/backport/compat/backport-4.6.c
+++ b/backport/compat/backport-4.6.c
@@ -75,3 +75,29 @@ int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
 	return kstrtobool(buf, res);
 }
 EXPORT_SYMBOL_GPL(kstrtobool_from_user);
+
+/**
+ * match_string - matches given string in an array
+ * @array:	array of strings
+ * @n:		number of strings in the array or -1 for NULL terminated arrays
+ * @string:	string to match with
+ *
+ * Return:
+ * index of a @string in the @array if matches, or %-EINVAL otherwise.
+ */
+int match_string(const char * const *array, size_t n, const char *string)
+{
+	int index;
+	const char *item;
+
+	for (index = 0; index < n; index++) {
+		item = array[index];
+		if (!item)
+			break;
+		if (!strcmp(item, string))
+			return index;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(match_string);
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
