Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44919 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933035Ab3FQNV0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] backports: add PCI_DEVICE_SUB
Date: Mon, 17 Jun 2013 15:21:04 +0200
Message-Id: <1371475267-27179-4-git-send-email-hauke@hauke-m.de> (sfid-20130617_152133_073478_C2261FE7)
In-Reply-To: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
References: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index b223879..08783e5 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -178,4 +178,20 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 #endif
 
+#ifndef PCI_DEVICE_SUB
+/**
+ * PCI_DEVICE_SUB - macro used to describe a specific pci device with subsystem
+ * @vend: the 16 bit PCI Vendor ID
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific device with subsystem information.
+ */
+#define PCI_DEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev)
+#endif /* PCI_DEVICE_SUB */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
1.7.10.4

