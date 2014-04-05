Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63322 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaDEMlY (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:24 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so4658219pbc.34
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:24 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Eliad Peller <eliad@wizery.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/27] backports: ifdef some pci functions
Date: Sat,  5 Apr 2014 05:40:37 -0700
Message-Id: <1396701662-15165-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144125_927872_5F960D34)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
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
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
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
1.8.5.3

