Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35254 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbaLTVjw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/14] backport: add pci_device_is_present()
Date: Sat, 20 Dec 2014 22:39:30 +0100
Message-Id: <1419111577-22174-8-git-send-email-hauke@hauke-m.de> (sfid-20141220_223956_692437_5DE6BEAE)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by igb driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h |  5 ++++
 backport/compat/backport-3.13.c       | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 3dd2c7e..f168bde 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -159,4 +159,9 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#define pci_device_is_present LINUX_BACKPORT(pci_device_is_present)
+bool pci_device_is_present(struct pci_dev *pdev);
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index fd562bb..553ed8f 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -12,6 +12,8 @@
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <net/genetlink.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 #ifdef CONFIG_REGULATOR
@@ -200,3 +202,53 @@ bool __net_get_random_once(void *buf, int nbytes, bool *done,
 }
 EXPORT_SYMBOL_GPL(__net_get_random_once);
 #endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
+
+#ifdef CONFIG_PCI
+#define pci_bus_read_dev_vendor_id LINUX_BACKPORT(pci_bus_read_dev_vendor_id)
+static bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int crs_timeout)
+{
+	int delay = 1;
+
+	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+		return false;
+
+	/* some broken boards return 0 or ~0 if a slot is empty: */
+	if (*l == 0xffffffff || *l == 0x00000000 ||
+	    *l == 0x0000ffff || *l == 0xffff0000)
+		return false;
+
+	/*
+	 * Configuration Request Retry Status.  Some root ports return the
+	 * actual device ID instead of the synthetic ID (0xFFFF) required
+	 * by the PCIe spec.  Ignore the device ID and only check for
+	 * (vendor id == 1).
+	 */
+	while ((*l & 0xffff) == 0x0001) {
+		if (!crs_timeout)
+			return false;
+
+		msleep(delay);
+		delay *= 2;
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+			return false;
+		/* Card hasn't responded in 60 seconds?  Must be stuck. */
+		if (delay > crs_timeout) {
+			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
+			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
+			       PCI_FUNC(devfn));
+			return false;
+		}
+	}
+
+	return true;
+}
+
+bool pci_device_is_present(struct pci_dev *pdev)
+{
+	u32 v;
+
+	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
+}
+EXPORT_SYMBOL_GPL(pci_device_is_present);
+#endif /* CONFIG_PCI */
-- 
1.9.1

