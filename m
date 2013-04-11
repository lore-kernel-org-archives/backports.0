Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37190 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3DKXnB (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:01 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 06/24] backports: move module_pci_driver
Date: Fri, 12 Apr 2013 01:42:33 +0200
Message-Id: <1365723771-10660-7-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014306_520609_4C44617D)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.4.h | 13 -------------
 backport/backport-include/linux/pci.h        | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
index 6f655bd..45aef72 100644
--- a/backport/backport-include/linux/compat-3.4.h
+++ b/backport/backport-include/linux/compat-3.4.h
@@ -160,19 +160,6 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)) */
 
-/* source include/linux/pci.h */
-/**
- * module_pci_driver() - Helper macro for registering a PCI driver
- * @__pci_driver: pci_driver struct
- *
- * Helper macro for PCI drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_pci_driver(__pci_driver) \
-	module_driver(__pci_driver, pci_register_driver, \
-		       pci_unregister_driver)
-
 /*
  * Getting something that works in C and CPP for an arg that may or may
  * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 2600376..1cecd98 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -72,4 +72,18 @@
 #define compat_pci_resume(fn)
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+/**
+ * module_pci_driver() - Helper macro for registering a PCI driver
+ * @__pci_driver: pci_driver struct
+ *
+ * Helper macro for PCI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pci_driver(__pci_driver) \
+	module_driver(__pci_driver, pci_register_driver, \
+		       pci_unregister_driver)
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
1.8.0

