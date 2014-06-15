Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44887 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbaFOVWa (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id B396F7E5E
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:28 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/19] backports: remove const from pci error handlers on kernel < 3.7
Date: Sun, 15 Jun 2014 23:21:42 +0200
Message-Id: <1402867307-31337-15-git-send-email-hauke@hauke-m.de> (sfid-20140615_233457_399215_47D3ADEB)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes a warning on these older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0042-pci_error_handlers/alx.patch              | 14 ++++++++++++++
 .../network/0042-pci_error_handlers/atl1c.patch            | 14 ++++++++++++++
 .../network/0042-pci_error_handlers/atl1e.patch            | 14 ++++++++++++++
 .../network/0042-pci_error_handlers/ngene.patch            | 14 ++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch

diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
new file mode 100644
index 0000000..c26efa2
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/ethernet/atheros/alx/main.c
++++ b/drivers/net/ethernet/atheros/alx/main.c
+@@ -1521,7 +1521,11 @@ static void alx_pci_error_resume(struct
+ 	rtnl_unlock();
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers alx_err_handlers = {
++#else
++static struct pci_error_handlers alx_err_handlers = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = alx_pci_error_detected,
+ 	.slot_reset     = alx_pci_error_slot_reset,
+ 	.resume         = alx_pci_error_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
new file mode 100644
index 0000000..239d1b9
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
++++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+@@ -2782,7 +2782,11 @@ static void atl1c_io_resume(struct pci_d
+ 	netif_device_attach(netdev);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers atl1c_err_handler = {
++#else
++static struct pci_error_handlers atl1c_err_handler = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = atl1c_io_error_detected,
+ 	.slot_reset = atl1c_io_slot_reset,
+ 	.resume = atl1c_io_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
new file mode 100644
index 0000000..3ef2f93
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
++++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+@@ -2559,7 +2559,11 @@ static void atl1e_io_resume(struct pci_d
+ 	netif_device_attach(netdev);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers atl1e_err_handler = {
++#else
++static struct pci_error_handlers atl1e_err_handler = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = atl1e_io_error_detected,
+ 	.slot_reset = atl1e_io_slot_reset,
+ 	.resume = atl1e_io_resume,
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
new file mode 100644
index 0000000..620dbbe
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
@@ -0,0 +1,14 @@
+--- a/drivers/media/pci/ngene/ngene-cards.c
++++ b/drivers/media/pci/ngene/ngene-cards.c
+@@ -798,7 +798,11 @@ static void ngene_resume(struct pci_dev
+ 	printk(KERN_INFO DEVICE_NAME ": resume\n");
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers ngene_errors = {
++#else
++static struct pci_error_handlers ngene_errors = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = ngene_error_detected,
+ 	.link_reset = ngene_link_reset,
+ 	.slot_reset = ngene_slot_reset,
-- 
1.9.1

