Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbaEPLWq (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:46 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 02/13] backports: handle new sriov_configure pointer in struct pci_driver
Date: Fri, 16 May 2014 13:21:13 +0200
Message-Id: <1400239284-2916-3-git-send-email-sassmann@kpanic.de> (sfid-20140516_135148_016955_8275A533)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.8 struct pci_driver got a new function pointer sriov_configure.
Address this by putting ifdef around the code.

commit 1789382a72a537447d65ea4131d8bcc1ad85ce7b
Author: Donald Dutile <ddutile@redhat.com>
Date:   Mon Nov 5 15:20:36 2012 -0500

    PCI: SRIOV control and status via sysfs

git describe --contains 1789382a72a537447d65ea4131d8bcc1ad85ce7b
v3.8-rc1~128^2~6^2~4

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0032-sriov_configure/INFO              | 13 +++++
 .../0032-sriov_configure/igb_sriov_configure.patch | 56 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/INFO
 create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch

diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/INFO b/patches/collateral-evolutions/network/0032-sriov_configure/INFO
new file mode 100644
index 0000000..813d352
--- /dev/null
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/INFO
@@ -0,0 +1,13 @@
+In kernel 3.8 struct pci_driver got a new function pointer sriov_configure.
+Address this by putting ifdef around the code.
+
+
+commit 1789382a72a537447d65ea4131d8bcc1ad85ce7b
+Author: Donald Dutile <ddutile@redhat.com>
+Date:   Mon Nov 5 15:20:36 2012 -0500
+
+    PCI: SRIOV control and status via sysfs
+
+git describe --contains 1789382a72a537447d65ea4131d8bcc1ad85ce7b
+v3.8-rc1~128^2~6^2~4
+
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
new file mode 100644
index 0000000..1e4df5d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -0,0 +1,56 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 0270da9..09564d0 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -198,7 +198,9 @@ static const struct dev_pm_ops igb_pm_ops = {
+ };
+ #endif
+ static void igb_shutdown(struct pci_dev *);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ #ifdef CONFIG_IGB_DCA
+ static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
+ static struct notifier_block dca_notifier = {
+@@ -239,7 +241,9 @@ static struct pci_driver igb_driver = {
+ 	.driver.pm = &igb_pm_ops,
+ #endif
+ 	.shutdown = igb_shutdown,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 	.sriov_configure = igb_pci_sriov_configure,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ 	.err_handler = &igb_err_handler
+ };
+ 
+@@ -7591,6 +7595,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_disable_sriov(struct pci_dev *dev)
+ {
+ 	int err = igb_disable_sriov(dev);
+@@ -7600,6 +7605,7 @@ static int igb_pci_disable_sriov(struct pci_dev *dev)
+ 
+ 	return err;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ 
+ static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
+ {
+@@ -7617,6 +7623,7 @@ out:
+ }
+ 
+ #endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+ {
+ #ifdef CONFIG_PCI_IOV
+@@ -7627,6 +7634,7 @@ static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+ #endif
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
+ 
+ #ifdef CONFIG_NET_POLL_CONTROLLER
+ /* Polling 'interrupt' - used by things like netconsole to send skbs
-- 
1.9.0

