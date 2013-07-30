Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:36945 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3G3L4J (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Jul 2013 07:56:09 -0400
Message-ID: <51F7A87A.3030902@fh-kl.de> (sfid-20130730_135611_395428_D98A4F59)
Date: Tue, 30 Jul 2013 13:50:18 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC 1/8] backports: disable PCI functions for kernels without PCI
 support
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/compat/compat-2.6.25.c | 2 ++
 backport/compat/compat-2.6.28.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
index b3597ea..37407a4 100644
--- a/backport/compat/compat-2.6.25.c
+++ b/backport/compat/compat-2.6.25.c
@@ -210,6 +210,7 @@ EXPORT_SYMBOL_GPL(sg_alloc_table);
  * to it. We implement a sloppy work around for backporting
  * this.
  */
+#ifdef CONFIG_PCI
 int pci_enable_device_mem(struct pci_dev *dev)
 {
 	int bars = pci_select_bars(dev, IORESOURCE_MEM);
@@ -217,6 +218,7 @@ int pci_enable_device_mem(struct pci_dev *dev)
 	return pci_enable_device_bars(dev, bars);
 }
 EXPORT_SYMBOL_GPL(pci_enable_device_mem);
+#endif
 
 /**
  * The following things are out of ./lib/vsprintf.c
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
index e47626b..9c21de8 100644
--- a/backport/compat/compat-2.6.28.c
+++ b/backport/compat/compat-2.6.28.c
@@ -238,6 +238,7 @@ EXPORT_SYMBOL_GPL(usb_anchor_empty);
 #endif /* CONFIG_USB */
 #endif
 
+#ifdef CONFIG_PCI
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 {
 	/*
@@ -251,6 +252,7 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 				     pci_resource_len(pdev, bar));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
+#endif
 
 static unsigned long round_jiffies_common(unsigned long j, int cpu,
 		bool force_up)
@@ -455,6 +457,7 @@ EXPORT_SYMBOL_GPL(n_tty_ioctl_helper);
  * generating PME# from both D3_hot and D3_cold, and the platform is unable to
  * enable wake-up power for it.
  */
+#ifdef CONFIG_PCI
 int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 {
 	return pci_pme_capable(dev, PCI_D3cold) ?
@@ -462,4 +465,5 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 			pci_enable_wake(dev, PCI_D3hot, enable);
 }
 EXPORT_SYMBOL_GPL(pci_wake_from_d3);
+#endif
 
-- 
1.8.1.2



-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
