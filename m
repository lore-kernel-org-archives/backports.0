Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49589 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbcD3VBF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/16] header: add pci_enable_msix_exact()
Date: Sat, 30 Apr 2016 23:00:34 +0200
Message-Id: <1462050048-8953-3-git-send-email-hauke@hauke-m.de> (sfid-20160430_230106_522730_49C83EDA)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in upstream commit f7fc32cb20 "PCI/MSI: Add
pci_enable_msi_exact() and pci_enable_msix_exact()" and is used by the
mwifiex driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index f168bde..081b4c7 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -164,4 +164,24 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 bool pci_device_is_present(struct pci_dev *pdev);
 #endif
 
+#ifdef CONFIG_PCI
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#define pci_enable_msix_exact LINUX_BACKPORT(pci_enable_msix_exact)
+#ifdef CONFIG_PCI_MSI
+static inline int pci_enable_msix_exact(struct pci_dev *dev,
+					struct msix_entry *entries, int nvec)
+{
+	int rc = pci_enable_msix_range(dev, entries, nvec, nvec);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+#else
+static inline int pci_enable_msix_exact(struct pci_dev *dev,
+		      struct msix_entry *entries, int nvec)
+{ return -ENOSYS; }
+#endif /* CONFIG_PCI_MSI */
+#endif
+#endif /* CONFIG_PCI */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
