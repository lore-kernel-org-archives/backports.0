Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:38712 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab3HWL2j (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 23 Aug 2013 07:28:39 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: remove alx patch for < 2.6.24
Date: Fri, 23 Aug 2013 13:28:34 +0200
Message-Id: <1377257314-1065-1-git-send-email-johannes@sipsolutions.net> (sfid-20130823_132840_805905_97009B0D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Since we don't support kernels before 2.6.24 anymore
there's no need to carry this patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/0007-pci_dev_dev_flags/INFO            | 28 ----------------------
 .../network/0007-pci_dev_dev_flags/alx.patch       | 13 ----------
 2 files changed, 41 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0007-pci_dev_dev_flags/INFO
 delete mode 100644 patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch

diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/INFO b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/INFO
deleted file mode 100644
index fc95b61..0000000
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/INFO
+++ /dev/null
@@ -1,28 +0,0 @@
-The struct pci_dev dev_flags member was added as of
-v2.6.24 via ba698ad4. This collateral evolution can be
-enhanced and backported atomically through these series
-of patches. The end goal is to optimize this in SmPL form.
-
-mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains ba698ad4
-v2.6.24-rc2~28^2~6
-
-commit ba698ad4b7e466cbb4a8bde6b9da8080ab06808d
-Author: David Miller <davem@davemloft.net>
-Date:   Thu Oct 25 01:16:30 2007 -0700
-
-    PCI: Add quirk for devices which disable MSI when INTX_DISABLE is set.
-    
-    A reasonably common problem with some devices is that they will
-    disable MSI generation when the INTX_DISABLE bit is set in the
-    PCI_COMMAND register.
-    
-    Quirk this explicitly, guarding the pci_intx() calls in msi.c with
-    this quirk indication.
-    
-    The first entries for this quirk are for 5714 and 5780 Tigon3 chips,
-    and thus we can remove the workaround code from the tg3.c driver.
-    
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-    Acked-by: Michael Chan <mchan@broadcom.com>
-    Acked-by: Jeff Garzik <jgarzik@redhat.com>
-    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
deleted file mode 100644
index 729fa6e..0000000
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1266,8 +1266,10 @@ static int alx_probe(struct pci_dev *pde
- 	netdev->irq = pdev->irq;
- 	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
- 	if (ent->driver_data & ALX_DEV_QUIRK_MSI_INTX_DISABLE_BUG)
- 		pdev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
-+#endif
- 
- 	err = alx_init_sw(alx);
- 	if (err) {
-- 
1.8.4.rc2

