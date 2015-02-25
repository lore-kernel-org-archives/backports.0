Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbbBYOWO (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:14 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 05/10] backports: replace struct pci_error_handlers changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:49 +0100
Message-Id: <1424874054-22956-6-git-send-email-sassmann@kpanic.de> (sfid-20150225_152219_091899_06997400)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0042-pci_error_handlers/alx.patch              | 14 --------------
 .../network/0042-pci_error_handlers/atl1c.patch            | 14 --------------
 .../0042-pci_error_handlers/igb_pci_error_handlers.cocci   |  9 +++++++++
 .../0042-pci_error_handlers/igb_pci_error_handlers.patch   | 14 --------------
 .../network/0042-pci_error_handlers/ngene.patch            | 14 --------------
 5 files changed, 9 insertions(+), 56 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
 delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.cocci
 delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
 delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch

diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
deleted file mode 100644
index 97b7d4a..0000000
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1523,7 +1523,11 @@ static void alx_pci_error_resume(struct
- 	rtnl_unlock();
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- static const struct pci_error_handlers alx_err_handlers = {
-+#else
-+static struct pci_error_handlers alx_err_handlers = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 	.error_detected = alx_pci_error_detected,
- 	.slot_reset     = alx_pci_error_slot_reset,
- 	.resume         = alx_pci_error_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
deleted file mode 100644
index 239d1b9..0000000
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2782,7 +2782,11 @@ static void atl1c_io_resume(struct pci_d
- 	netif_device_attach(netdev);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- static const struct pci_error_handlers atl1c_err_handler = {
-+#else
-+static struct pci_error_handlers atl1c_err_handler = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 	.error_detected = atl1c_io_error_detected,
- 	.slot_reset = atl1c_io_slot_reset,
- 	.resume = atl1c_io_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.cocci b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.cocci
new file mode 100644
index 0000000..19147e9
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.cocci
@@ -0,0 +1,9 @@
+@@
+identifier s;
+@@
+
+static
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+const
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+struct pci_error_handlers s = { ... };
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
deleted file mode 100644
index 9064edb..0000000
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -232,7 +232,11 @@ static pci_ers_result_t igb_io_error_det
- static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
- static void igb_io_resume(struct pci_dev *);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- static const struct pci_error_handlers igb_err_handler = {
-+#else
-+static struct pci_error_handlers igb_err_handler = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 	.error_detected = igb_io_error_detected,
- 	.slot_reset = igb_io_slot_reset,
- 	.resume = igb_io_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
deleted file mode 100644
index 620dbbe..0000000
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/media/pci/ngene/ngene-cards.c
-+++ b/drivers/media/pci/ngene/ngene-cards.c
-@@ -798,7 +798,11 @@ static void ngene_resume(struct pci_dev
- 	printk(KERN_INFO DEVICE_NAME ": resume\n");
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- static const struct pci_error_handlers ngene_errors = {
-+#else
-+static struct pci_error_handlers ngene_errors = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 	.error_detected = ngene_error_detected,
- 	.link_reset = ngene_link_reset,
- 	.slot_reset = ngene_slot_reset,
-- 
2.1.0

