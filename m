Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35020 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaBXAqi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 278107E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:37 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/12] backports: add pci_enable_msi_range()
Date: Mon, 24 Feb 2014 01:45:47 +0100
Message-Id: <1393202754-12919-6-git-send-email-hauke@hauke-m.de> (sfid-20140224_014639_357498_A6EAC9F6)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/net/wireless/ath/wil6210/pcie_bus.c

pci_enable_msi_block() was added in kernel 2.6.30, so this does not
work on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h |   12 ++++++++
 backport/compat/Makefile              |    1 +
 backport/compat/backport-3.14.c       |   51 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 backport/compat/backport-3.14.c

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 2d4822a..2190831 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -233,4 +233,16 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 #endif
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30))
+#define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
+#ifdef CONFIG_PCI_MSI
+int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
+#else
+static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
+				       int maxvec)
+{ return -ENOSYS; }
+#endif
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 3525f9d..ac2dc47 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -29,6 +29,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
diff --git a/backport/compat/backport-3.14.c b/backport/compat/backport-3.14.c
new file mode 100644
index 0000000..9e37c58
--- /dev/null
+++ b/backport/compat/backport-3.14.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.14.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+#ifdef CONFIG_PCI_MSI
+/**
+ * pci_enable_msi_range - configure device's MSI capability structure
+ * @dev: device to configure
+ * @minvec: minimal number of interrupts to configure
+ * @maxvec: maximum number of interrupts to configure
+ *
+ * This function tries to allocate a maximum possible number of interrupts in a
+ * range between @minvec and @maxvec. It returns a negative errno if an error
+ * occurs. If it succeeds, it returns the actual number of interrupts allocated
+ * and updates the @dev's irq member to the lowest new interrupt number;
+ * the other interrupt numbers allocated to this device are consecutive.
+ **/
+int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
+{
+	int nvec = maxvec;
+	int rc;
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	do {
+		rc = pci_enable_msi_block(dev, nvec);
+		if (rc < 0) {
+			return rc;
+		} else if (rc > 0) {
+			if (rc < minvec)
+				return -ENOSPC;
+			nvec = rc;
+		}
+	} while (rc);
+
+	return nvec;
+}
+EXPORT_SYMBOL(pci_enable_msi_range);
+#endif
+#endif
-- 
1.7.10.4

