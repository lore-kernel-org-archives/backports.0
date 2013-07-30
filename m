Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60247 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab3G3J0b (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:31 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so6457208pad.9
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 06/14] backports: backport of_get_child_by_name() support
Date: Tue, 30 Jul 2013 02:25:51 -0700
Message-Id: <1375176359-1331-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112632_798634_90FAC740)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This was added via 9c19761a. While at it clean up the backported
header a bit to make backporting more OF stuff more manageable.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 9c19761a
v3.7-rc1~123^2~4

commit 9c19761a7ecdc86abb2fba0feb81e8952eccc1f1
Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Date:   Tue Sep 18 08:10:28 2012 +0100

    dt: introduce of_get_child_by_name to get child node by name

    This patch introduces of_get_child_by_name function to get a child node
    by its name in a given parent node.

    Without this patch each driver code has to iterate the parent and do
    a string compare, However having of_get_child_by_name libary function would
    avoid code duplication, errors and is more convenient.

    Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
    Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/of.h |   23 ++++++++++++++++++++---
 backport/compat/compat-3.7.c         |   29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index c5dc87c..93e91dd 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -4,13 +4,30 @@
 #include <linux/version.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-#include_next <linux/of.h>
-#else
+#define KERNEL_HAS_OF_SUPPORT 1
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
 
 #ifdef CONFIG_OF
+#define KERNEL_HAS_OF_SUPPORT 1
+#endif /* CONFIG_OF */
+
+#ifdef KERNEL_HAS_OF_SUPPORT
 #include_next <linux/of.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#ifdef CONFIG_OF
+extern struct device_node *of_get_child_by_name(const struct device_node *node,
+						const char *name);
+#else
+static inline struct device_node *of_get_child_by_name(
+					const struct device_node *node,
+					const char *name)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
+#endif /* KERNEL_HAS_OF_SUPPORT */
 
 #endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 0f2d332..8f5a56c 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -251,3 +251,32 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_dword);
+
+#ifdef KERNEL_HAS_OF_SUPPORT
+#ifdef CONFIG_OF
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+/**
+ *	of_get_child_by_name - Find the child node by name for a given parent
+ *	@node:	parent node
+ *	@name:	child name to look for.
+ *
+ *      This function looks for child node for given matching name
+ *
+ *	Returns a node pointer if found, with refcount incremented, use
+ *	of_node_put() on it when done.
+ *	Returns NULL if node is not found.
+ */
+struct device_node *of_get_child_by_name(const struct device_node *node,
+				const char *name)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(node, child)
+		if (child->name && (of_node_cmp(child->name, name) == 0))
+			break;
+	return child;
+}
+EXPORT_SYMBOL_GPL(of_get_child_by_name);
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
+#endif /* CONFIG_OF */
+#endif /* KERNEL_HAS_OF_SUPPORT */
-- 
1.7.10.4

