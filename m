Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37186 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3DKXm7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:42:59 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 04/24] backports: move compat_pci_{suspend,resume}
Date: Fri, 12 Apr 2013 01:42:31 +0200
Message-Id: <1365723771-10660-5-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014303_764970_1E1B6333)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.29.h | 67 ----------------------
 backport/backport-include/linux/pci.h           | 75 +++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 67 deletions(-)
 create mode 100644 backport/backport-include/linux/pci.h

diff --git a/backport/backport-include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
index c8cf898..949874e 100644
--- a/backport/backport-include/linux/compat-2.6.29.h
+++ b/backport/backport-include/linux/compat-2.6.29.h
@@ -358,73 +358,6 @@ static inline int ndo_do_ioctl(struct net_device *dev,
 
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-#define compat_pci_suspend(fn)						\
-	int fn##_compat(struct pci_dev *pdev, pm_message_t state) 	\
-	{								\
-		int r;							\
-									\
-		r = fn(&pdev->dev);					\
-		if (r)							\
-			return r;					\
-									\
-		pci_save_state(pdev);					\
-		pci_disable_device(pdev);				\
-		pci_set_power_state(pdev, PCI_D3hot);			\
-									\
-		return 0;						\
-	}
-
-#define compat_pci_resume(fn)						\
-	int fn##_compat(struct pci_dev *pdev)				\
-	{								\
-		int r;							\
-									\
-		pci_set_power_state(pdev, PCI_D0);			\
-		r = pci_enable_device(pdev);				\
-		if (r)							\
-			return r;					\
-		pci_restore_state(pdev);				\
-									\
-		return fn(&pdev->dev);					\
-	}
-#elif LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
-#define compat_pci_suspend(fn)						\
-	int fn##_compat(struct device *dev)			 	\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int r;							\
-									\
-		r = fn(&pdev->dev);					\
-		if (r)							\
-			return r;					\
-									\
-		pci_save_state(pdev);					\
-		pci_disable_device(pdev);				\
-		pci_set_power_state(pdev, PCI_D3hot);			\
-									\
-		return 0;						\
-	}
-
-#define compat_pci_resume(fn)						\
-	int fn##_compat(struct device *dev)				\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int r;							\
-									\
-		pci_set_power_state(pdev, PCI_D0);			\
-		r = pci_enable_device(pdev);				\
-		if (r)							\
-			return r;					\
-		pci_restore_state(pdev);				\
-									\
-		return fn(&pdev->dev);					\
-	}
-#else
-#define compat_pci_suspend(fn)
-#define compat_pci_resume(fn)
-#endif
-
 #define  PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
 
 #endif /*  LINUX_26_29_COMPAT_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
new file mode 100644
index 0000000..2600376
--- /dev/null
+++ b/backport/backport-include/linux/pci.h
@@ -0,0 +1,75 @@
+#ifndef _BACKPORT_LINUX_PCI_H
+#define _BACKPORT_LINUX_PCI_H
+
+#include_next <linux/pci.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#define compat_pci_suspend(fn)						\
+	int fn##_compat(struct pci_dev *pdev, pm_message_t state) 	\
+	{								\
+		int r;							\
+									\
+		r = fn(&pdev->dev);					\
+		if (r)							\
+			return r;					\
+									\
+		pci_save_state(pdev);					\
+		pci_disable_device(pdev);				\
+		pci_set_power_state(pdev, PCI_D3hot);			\
+									\
+		return 0;						\
+	}
+
+#define compat_pci_resume(fn)						\
+	int fn##_compat(struct pci_dev *pdev)				\
+	{								\
+		int r;							\
+									\
+		pci_set_power_state(pdev, PCI_D0);			\
+		r = pci_enable_device(pdev);				\
+		if (r)							\
+			return r;					\
+		pci_restore_state(pdev);				\
+									\
+		return fn(&pdev->dev);					\
+	}
+#elif LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
+#define compat_pci_suspend(fn)						\
+	int fn##_compat(struct device *dev)			 	\
+	{								\
+		struct pci_dev *pdev = to_pci_dev(dev);			\
+		int r;							\
+									\
+		r = fn(&pdev->dev);					\
+		if (r)							\
+			return r;					\
+									\
+		pci_save_state(pdev);					\
+		pci_disable_device(pdev);				\
+		pci_set_power_state(pdev, PCI_D3hot);			\
+									\
+		return 0;						\
+	}
+
+#define compat_pci_resume(fn)						\
+	int fn##_compat(struct device *dev)				\
+	{								\
+		struct pci_dev *pdev = to_pci_dev(dev);			\
+		int r;							\
+									\
+		pci_set_power_state(pdev, PCI_D0);			\
+		r = pci_enable_device(pdev);				\
+		if (r)							\
+			return r;					\
+		pci_restore_state(pdev);				\
+									\
+		return fn(&pdev->dev);					\
+	}
+#else
+#define compat_pci_suspend(fn)
+#define compat_pci_resume(fn)
+#endif
+
+#endif /* _BACKPORT_LINUX_PCI_H */
-- 
1.8.0

