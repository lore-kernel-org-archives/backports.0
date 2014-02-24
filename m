Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35024 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaBXAqm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id C4A567E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:41 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/12] backports: add pci_enable_msix_range()
Date: Mon, 24 Feb 2014 01:45:48 +0100
Message-Id: <1393202754-12919-7-git-send-email-hauke@hauke-m.de> (sfid-20140224_014643_680611_2BBEA1C3)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/net/ethernet/intel/igb/igb_main.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h |   12 ++++++++++
 backport/compat/backport-3.14.c       |   41 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 2190831..9eeb09b 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -245,4 +245,16 @@ static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#define pci_enable_msix_range LINUX_BACKPORT(pci_enable_msix_range)
+#ifdef CONFIG_PCI_MSI
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			  int minvec, int maxvec);
+#else
+static inline int pci_enable_msix_range(struct pci_dev *dev,
+		      struct msix_entry *entries, int minvec, int maxvec)
+{ return -ENOSYS; }
+#endif
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/backport-3.14.c b/backport/compat/backport-3.14.c
index 9e37c58..bce50dc 100644
--- a/backport/compat/backport-3.14.c
+++ b/backport/compat/backport-3.14.c
@@ -49,3 +49,44 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 EXPORT_SYMBOL(pci_enable_msi_range);
 #endif
 #endif
+
+#ifdef CONFIG_PCI_MSI
+/**
+ * pci_enable_msix_range - configure device's MSI-X capability structure
+ * @dev: pointer to the pci_dev data structure of MSI-X device function
+ * @entries: pointer to an array of MSI-X entries
+ * @minvec: minimum number of MSI-X irqs requested
+ * @maxvec: maximum number of MSI-X irqs requested
+ *
+ * Setup the MSI-X capability structure of device function with a maximum
+ * possible number of interrupts in the range between @minvec and @maxvec
+ * upon its software driver call to request for MSI-X mode enabled on its
+ * hardware device function. It returns a negative errno if an error occurs.
+ * If it succeeds, it returns the actual number of interrupts allocated and
+ * indicates the successful configuration of MSI-X capability structure
+ * with new allocated MSI-X interrupts.
+ **/
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			       int minvec, int maxvec)
+{
+	int nvec = maxvec;
+	int rc;
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	do {
+		rc = pci_enable_msix(dev, entries, nvec);
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
+EXPORT_SYMBOL(pci_enable_msix_range);
+#endif
-- 
1.7.10.4

