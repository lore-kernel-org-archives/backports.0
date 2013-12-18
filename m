Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60673 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab3LRQJX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 18 Dec 2013 11:09:23 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC v2 04/11] backports: igb fixes for linux-3.7
Date: Wed, 18 Dec 2013 17:08:18 +0100
Message-Id: <1387382905-14274-5-git-send-email-sassmann@kpanic.de> (sfid-20131218_170926_709880_F9DE780F)
In-Reply-To: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add pci_sriov_set_totalvfs()
- add patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch

Had to ifdef out igb_pci_sriov_configure in igb because the assignment would
have required changes to struct pci_driver.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/pci.h              |  5 +++-
 backport/compat/compat-3.8.c                       | 34 ++++++++++++++++++++++
 .../82-ethernet/0002-igb_pci_sriov_configure.patch | 14 +++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index b56761f..c3360f1 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -178,6 +178,10 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 	.subvendor = (subvend), .subdevice = (subdev)
 #endif /* PCI_DEVICE_SUB */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 /* Taken from drivers/pci/pci.h */
 struct pci_sriov {
@@ -202,5 +206,4 @@ struct pci_sriov {
 
 extern int pci_vfs_assigned(struct pci_dev *dev);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
-
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index c6824bf..9d96b36 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -18,6 +18,8 @@
 #include <linux/netdevice.h>
 #include <linux/random.h>
 #include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
@@ -514,3 +516,35 @@ int of_property_read_u8_array(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_property_read_u8_array);
 #endif /* CONFIG_OF */
+
+#ifdef CONFIG_PCI_IOV
+/**
+ * pci_sriov_set_totalvfs -- reduce the TotalVFs available
+ * @dev: the PCI PF device
+ * @numvfs: number that should be used for TotalVFs supported
+ *
+ * Should be called from PF driver's probe routine with
+ * device's mutex held.
+ *
+ * Returns 0 if PF is an SRIOV-capable device and
+ * value of numvfs valid. If not a PF return -ENOSYS;
+ * if numvfs is invalid return -EINVAL;
+ * if VFs already enabled, return -EBUSY.
+ */
+int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
+{
+	if (!dev->is_physfn)
+		return -ENOSYS;
+	if (numvfs > dev->sriov->total_VFs)
+		return -EINVAL;
+
+	/* Shouldn't change if VFs already enabled */
+	if (dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
+		return -EBUSY;
+	else
+		dev->sriov->driver_max_VFs = numvfs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
+#endif /* CONFIG_PCI_IOV */
diff --git a/patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch b/patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch
new file mode 100644
index 0000000..bd9b3dd
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch
@@ -0,0 +1,14 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index f2a5abf..433463d 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -249,7 +249,9 @@ static struct pci_driver igb_driver = {
+ 	.driver.pm = &igb_pm_ops,
+ #endif
+ 	.shutdown = igb_shutdown,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 	.sriov_configure = igb_pci_sriov_configure,
++#endif
+ 	.err_handler = &igb_err_handler
+ };
+ 
-- 
1.8.3.1

