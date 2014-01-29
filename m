Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbaA2JTk (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:19:40 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 05/12] backports: igb fixes for linux-3.7
Date: Wed, 29 Jan 2014 10:19:02 +0100
Message-Id: <1390987149-11171-6-git-send-email-sassmann@kpanic.de> (sfid-20140129_101943_268273_A91C5A79)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add pci_sriov_set_totalvfs()
- add patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch

Several ifdefs in igb_main.c to avoid compiler warnings.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/pci.h              |    6 ++-
 backport/compat/compat-3.8.c                       |   34 ++++++++++++
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |   57 ++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index f36384e..5201f1b 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -178,6 +178,11 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 	.subvendor = (subvend), .subdevice = (subdev)
 #endif /* PCI_DEVICE_SUB */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#define pci_sriov_set_totalvfs LINUX_BACKPORT(pci_sriov_set_totalvfs)
+int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 /* Taken from drivers/pci/pci.h */
 struct pci_sriov {
@@ -211,5 +216,4 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 #endif
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
-
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index 6741989..d39e8d6 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -19,6 +19,8 @@
 #include <linux/random.h>
 #include <linux/of.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
@@ -515,3 +517,35 @@ int of_property_read_u8_array(const struct device_node *np,
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
diff --git a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
new file mode 100644
index 0000000..47722cc
--- /dev/null
+++ b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
@@ -0,0 +1,57 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index f2a5abf..dd878b6 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -207,7 +207,9 @@ static const struct dev_pm_ops igb_pm_ops = {
+ };
+ #endif
+ static void igb_shutdown(struct pci_dev *);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ #ifdef CONFIG_IGB_DCA
+ static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
+ static struct notifier_block dca_notifier = {
+@@ -249,7 +251,9 @@ static struct pci_driver igb_driver = {
+ 	.driver.pm = &igb_pm_ops,
+ #endif
+ 	.shutdown = igb_shutdown,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 	.sriov_configure = igb_pci_sriov_configure,
++#endif
+ 	.err_handler = &igb_err_handler
+ };
+ 
+@@ -7310,6 +7314,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_disable_sriov(struct pci_dev *dev)
+ {
+ 	int err = igb_disable_sriov(dev);
+@@ -7319,6 +7324,7 @@ static int igb_pci_disable_sriov(struct pci_dev *dev)
+ 
+ 	return err;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ 
+ static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
+ {
+@@ -7336,6 +7342,8 @@ out:
+ }
+ 
+ #endif
++
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+ {
+ #ifdef CONFIG_PCI_IOV
+@@ -7346,6 +7354,7 @@ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+ #endif
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ 
+ #ifdef CONFIG_NET_POLL_CONTROLLER
+ /* Polling 'interrupt' - used by things like netconsole to send skbs
-- 
1.7.1

