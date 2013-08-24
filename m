Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52975 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495Ab3HXO3M (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 24 Aug 2013 10:29:12 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: do not depend on PCI functions when PCI is disabled in the kernel
Date: Sat, 24 Aug 2013 16:28:59 +0200
Message-Id: <1377354539-9202-2-git-send-email-hauke@hauke-m.de> (sfid-20130824_162916_847990_71769AD8)
In-Reply-To: <1377354539-9202-1-git-send-email-hauke@hauke-m.de>
References: <1377354539-9202-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This should prevent some compile errors when backports is used with a
kernel without PCI support.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat-2.6.27.c |    2 ++
 backport/compat/compat-2.6.28.c |    4 ++++
 backport/compat/compat-3.7.c    |    2 ++
 3 files changed, 8 insertions(+)

diff --git a/backport/compat/compat-2.6.27.c b/backport/compat/compat-2.6.27.c
index cda98e8..7235c87 100644
--- a/backport/compat/compat-2.6.27.c
+++ b/backport/compat/compat-2.6.27.c
@@ -29,6 +29,7 @@
  * we have to call the PCI routines directly.
  */
 
+#ifdef CONFIG_PCI
 /**
  * pci_pme_capable - check the capability of PCI device to generate PME#
  * @dev: PCI device to handle.
@@ -65,6 +66,7 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
 	return !!(pme_support & (1 << state));
 }
 EXPORT_SYMBOL_GPL(pci_pme_capable);
+#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
 /**
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
index 2ff6b1e..e38004f 100644
--- a/backport/compat/compat-2.6.28.c
+++ b/backport/compat/compat-2.6.28.c
@@ -239,6 +239,7 @@ EXPORT_SYMBOL_GPL(usb_anchor_empty);
 #endif /* CONFIG_USB */
 #endif
 
+#ifdef CONFIG_PCI
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 {
 	/*
@@ -252,6 +253,7 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 				     pci_resource_len(pdev, bar));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
+#endif
 
 static unsigned long round_jiffies_common(unsigned long j, int cpu,
 		bool force_up)
@@ -442,6 +444,7 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 }
 EXPORT_SYMBOL_GPL(n_tty_ioctl_helper);
 
+#ifdef CONFIG_PCI
 /**
  * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
  * @dev: PCI device to prepare
@@ -463,4 +466,5 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 			pci_enable_wake(dev, PCI_D3hot, enable);
 }
 EXPORT_SYMBOL_GPL(pci_wake_from_d3);
+#endif
 
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 8f5a56c..675cf29 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -22,6 +22,7 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL_GPL(mod_delayed_work);
 
+#ifdef CONFIG_PCI
 /*
  * Kernels >= 3.7 get their PCI-E Capabilities Register cached
  * via the pci_dev->pcie_flags_reg so for older kernels we have
@@ -251,6 +252,7 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_dword);
+#endif
 
 #ifdef KERNEL_HAS_OF_SUPPORT
 #ifdef CONFIG_OF
-- 
1.7.10.4

