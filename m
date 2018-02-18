Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeBRNzr (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:47 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:51 +0200
Message-Id: <20180218132459.11011-3-luca@coelho.fi> (sfid-20180218_145548_308755_D53692BB)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 02/10] backport: add pcie_find_root_port()
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

This function was introduced in v4.9 and added to 3.12.69, 4.4.37 and
4.8.13.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/pci.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 81c2d57a3454..67ac40fcbf58 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -184,4 +184,25 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 #endif
 #endif /* CONFIG_PCI */
 
+#if LINUX_VERSION_IS_LESS(4,9,0) &&			\
+	!LINUX_VERSION_IN_RANGE(3,12,69, 3,13,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,4,37, 4,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
+
+static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
+{
+	while (1) {
+		if (!pci_is_pcie(dev))
+			break;
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+			return dev;
+		if (!dev->bus->self)
+			break;
+		dev = dev->bus->self;
+	}
+	return NULL;
+}
+
+#endif/* <4.9.0 but not >= 3.12.69, 4.4.37, 4.8.13 */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
