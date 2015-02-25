Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbbBYOWC (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:02 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 04/10] backports: replace struct pci_driver sriov_configure changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:48 +0100
Message-Id: <1424874054-22956-5-git-send-email-sassmann@kpanic.de> (sfid-20150225_152216_702963_91F510D8)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There's still some manual patching done because igb_pci_disable_sriov()
will not be used on kernel older than 3.8, which would generate a
compile warning.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../0032-sriov_configure/igb_sriov_configure.patch | 40 ++--------------------
 .../0032-sriov_configure/sriov_configure.cocci     | 19 ++++++++++
 2 files changed, 21 insertions(+), 38 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/sriov_configure.cocci

diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index cd2b268..c6bcbd2 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,26 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -196,7 +196,9 @@ static const struct dev_pm_ops igb_pm_op
- };
- #endif
- static void igb_shutdown(struct pci_dev *);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- #ifdef CONFIG_IGB_DCA
- static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
- static struct notifier_block dca_notifier = {
-@@ -237,7 +239,9 @@ static struct pci_driver igb_driver = {
- 	.driver.pm = &igb_pm_ops,
- #endif
- 	.shutdown = igb_shutdown,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- 	.sriov_configure = igb_pci_sriov_configure,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- 	.err_handler = &igb_err_handler
- };
- 
-@@ -7567,6 +7571,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7572,6 +7572,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
  	return 0;
  }
  
@@ -28,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7576,6 +7581,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7581,6 +7582,7 @@ static int igb_pci_disable_sriov(struct pci_dev *dev)
  
  	return err;
  }
@@ -36,19 +16,3 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7593,6 +7599,7 @@ out:
- }
- 
- #endif
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
- {
- #ifdef CONFIG_PCI_IOV
-@@ -7603,6 +7610,7 @@ static int igb_pci_sriov_configure(struc
- #endif
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- 
- #ifdef CONFIG_NET_POLL_CONTROLLER
- /* Polling 'interrupt' - used by things like netconsole to send skbs
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/sriov_configure.cocci b/patches/collateral-evolutions/network/0032-sriov_configure/sriov_configure.cocci
new file mode 100644
index 0000000..52920b8
--- /dev/null
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/sriov_configure.cocci
@@ -0,0 +1,19 @@
+@r1@
+identifier s, func;
+@@
+
+struct pci_driver s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+.sriov_configure = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+};
+
+// ----------------------------------------------------------------------
+
+@@
+identifier r1.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
-- 
2.1.0

