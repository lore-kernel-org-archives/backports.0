Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10476 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbaCCLg1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 3 Mar 2014 06:36:27 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Eliad Peller <eliad@wizery.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: ifdef some pci functions
Date: Mon,  3 Mar 2014 13:34:21 +0200
Message-Id: <1393846461-21087-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140303_123630_223090_E78F3CC2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Eliad Peller <eliad@wizery.com>

struct msix_entry entry is defined only when CONFIG_PCI
is defined, resulting in warnings like:

backport-include/linux/pci.h:256:16: warning: 'struct msix_entry' declared inside parameter list [enabled by default]
backport-include/linux/pci.h:256:16: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

wrap (also the mock function) with appropriate ifdef CONFIG_PCI.

Signed-off-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 9eeb09b..e438f14 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -245,6 +245,7 @@ static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
 #endif
 #endif
 
+#ifdef CONFIG_PCI
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
 #define pci_enable_msix_range LINUX_BACKPORT(pci_enable_msix_range)
 #ifdef CONFIG_PCI_MSI
@@ -256,5 +257,6 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 { return -ENOSYS; }
 #endif
 #endif
+#endif
 
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
1.8.3.2

