Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55827 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804Ab3KGU2P (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:15 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] backports: always activate the of.h backports
Date: Thu,  7 Nov 2013 21:27:50 +0100
Message-Id: <1383856078-19823-4-git-send-email-hauke@hauke-m.de> (sfid-20131107_212835_482197_5D7AB4DA)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removes the KERNEL_HAS_OF_SUPPORT option from backports.
We can not include linux/of.h on kernel < 2.6.34, because this depends
on some sparc and powerpc only headers. The backport code should still
be included in this header file for such kernel versions, because some
recent drivers are using these functions now on all platforms, but they
will use the empty implementations then.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h |   23 ++++++++---------------
 backport/compat/compat-3.7.c         |    2 --
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index ad852c1..8b24311 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -3,18 +3,13 @@
 
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-#define KERNEL_HAS_OF_SUPPORT 1
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
-
-#ifdef CONFIG_OF
-#define KERNEL_HAS_OF_SUPPORT 1
-#endif /* CONFIG_OF */
-
-#ifdef KERNEL_HAS_OF_SUPPORT
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34) || defined(CONFIG_OF)
 #include_next <linux/of.h>
+#else
+struct device_node;
+#endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #ifdef CONFIG_OF
 extern struct device_node *of_get_child_by_name(const struct device_node *node,
 						const char *name);
@@ -26,9 +21,9 @@ static inline struct device_node *of_get_child_by_name(
 	return NULL;
 }
 #endif /* CONFIG_OF */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #ifndef CONFIG_OF
 static inline struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -36,8 +31,6 @@ static inline struct device_node *of_find_node_by_name(struct device_node *from,
 	return NULL;
 }
 #endif /* CONFIG_OF */
-#endif
-
-#endif /* KERNEL_HAS_OF_SUPPORT */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
 #endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 675cf29..b21b8ac 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -254,7 +254,6 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_dword);
 #endif
 
-#ifdef KERNEL_HAS_OF_SUPPORT
 #ifdef CONFIG_OF
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
 /**
@@ -281,4 +280,3 @@ struct device_node *of_get_child_by_name(const struct device_node *node,
 EXPORT_SYMBOL_GPL(of_get_child_by_name);
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
 #endif /* CONFIG_OF */
-#endif /* KERNEL_HAS_OF_SUPPORT */
-- 
1.7.10.4

