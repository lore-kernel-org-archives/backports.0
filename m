Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33942 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab3BZUig (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Feb 2013 15:38:36 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/24] compat-drivers: remove devinit and devexit from alx driver
Date: Tue, 26 Feb 2013 21:37:53 +0100
Message-Id: <1361911096-29117-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

devinit and devexit were removed from kernel version 3.8 and using it
causes compile problems.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0003-alx-remove-devinit-devexit.patch  |  116 ++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch

diff --git a/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch b/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
new file mode 100644
index 0000000..0b0ba96
--- /dev/null
+++ b/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
@@ -0,0 +1,116 @@
+--- a/drivers/net/ethernet/atheros/alx/alx.h
++++ b/drivers/net/ethernet/atheros/alx/alx.h
+@@ -190,7 +190,7 @@ struct alx_adapter {
+ 
+ /* needed by alx_ethtool.c */
+ extern void alx_reinit(struct alx_adapter *adpt);
+-extern void __devinit alx_set_ethtool_ops(struct net_device *dev);
++extern void alx_set_ethtool_ops(struct net_device *dev);
+ extern char alx_drv_name[];
+ extern char alx_drv_version[];
+ 
+--- a/drivers/net/ethernet/atheros/alx/alx_ethtool.c
++++ b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
+@@ -965,7 +965,7 @@ static const struct ethtool_ops alx_etht
+ 	.set_priv_flags  = alx_set_priv_flags,
+ };
+ 
+-void __devinit alx_set_ethtool_ops(struct net_device *dev)
++void alx_set_ethtool_ops(struct net_device *dev)
+ {
+ 	SET_ETHTOOL_OPS(dev, &alx_ethtool_ops);
+ }
+--- a/drivers/net/ethernet/atheros/alx/alx_hw.c
++++ b/drivers/net/ethernet/atheros/alx/alx_hw.c
+@@ -1379,12 +1379,12 @@ void __alx_update_hw_stats(struct alx_hw
+ 	}
+ }
+ 
+-static const struct alx_platform_patch plats[] __devinitdata = {
++static const struct alx_platform_patch plats[] = {
+ {0x1091, 0x00, 0x1969, 0x0091, 0x1001},
+ {0},
+ };
+ 
+-void __devinit alx_patch_assign(struct alx_hw *hw)
++void alx_patch_assign(struct alx_hw *hw)
+ {
+ 	int i = 0;
+ 
+@@ -1403,7 +1403,7 @@ void __devinit alx_patch_assign(struct a
+ 	}
+ }
+ 
+-bool __devinit alx_get_phy_info(struct alx_hw *hw)
++bool alx_get_phy_info(struct alx_hw *hw)
+ {
+ 	u16  devs1, devs2;
+ 
+--- a/drivers/net/ethernet/atheros/alx/alx_hw.h
++++ b/drivers/net/ethernet/atheros/alx/alx_hw.h
+@@ -674,7 +674,7 @@ struct alx_platform_patch {
+ #define ALX_PF_ANY_REV		0x10000
+ 
+ 
+-void __devinit alx_patch_assign(struct alx_hw *hw);
+-bool __devinit alx_get_phy_info(struct alx_hw *hw);
++void alx_patch_assign(struct alx_hw *hw);
++bool alx_get_phy_info(struct alx_hw *hw);
+ 
+ #endif
+--- a/drivers/net/ethernet/atheros/alx/alx_main.c
++++ b/drivers/net/ethernet/atheros/alx/alx_main.c
+@@ -1007,7 +1007,7 @@ static void alx_free_irq(struct alx_adap
+ }
+ 
+ 
+-static int __devinit alx_identify_hw(struct alx_adapter *adpt)
++static int alx_identify_hw(struct alx_adapter *adpt)
+ {
+ 	struct pci_dev *pdev = adpt->pdev;
+ 	struct alx_hw *hw = &adpt->hw;
+@@ -1045,7 +1045,7 @@ static int __devinit alx_identify_hw(str
+ }
+ 
+ 
+-static const u8 def_rss_key[40] __devinitdata = {
++static const u8 def_rss_key[40] = {
+ 	0xE2, 0x91, 0xD7, 0x3D, 0x18, 0x05, 0xEC, 0x6C,
+ 	0x2A, 0x94, 0xB3, 0x0D, 0xA5, 0x4F, 0x2B, 0xEC,
+ 	0xEA, 0x49, 0xAF, 0x7C, 0xE2, 0x14, 0xAD, 0x3D,
+@@ -1071,7 +1071,7 @@ static void alx_init_def_rss_idt(struct
+  *    initialize general software structure (struct alx_adapter).
+  *    fields are inited based on PCI device information.
+  */
+-static int __devinit alx_init_sw(struct alx_adapter *adpt)
++static int alx_init_sw(struct alx_adapter *adpt)
+ {
+ 	struct pci_dev	*pdev = adpt->pdev;
+ 	struct alx_hw *hw = &adpt->hw;
+@@ -2484,7 +2484,7 @@ static const struct net_device_ops alx_n
+ };
+ 
+ /* alx_probe - Device Initialization Routine */
+-static int __devinit
++static int
+ alx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+ {
+ 	struct net_device *netdev;
+@@ -2704,7 +2704,7 @@ err_dma_mask:
+ }
+ 
+ /* alx_remove - Device Removal Routine */
+-static void __devexit alx_remove(struct pci_dev *pdev)
++static void alx_remove(struct pci_dev *pdev)
+ {
+ 	struct alx_adapter *adpt = pci_get_drvdata(pdev);
+ 	struct alx_hw *hw = &adpt->hw;
+@@ -2826,7 +2826,7 @@ static struct pci_driver alx_driver = {
+ 	.name        = alx_drv_name,
+ 	.id_table    = alx_pci_tbl,
+ 	.probe       = alx_probe,
+-	.remove      = __devexit_p(alx_remove),
++	.remove      = alx_remove,
+ 	.shutdown    = alx_shutdown,
+ 	.err_handler = &alx_err_handler,
+ #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
-- 
1.7.10.4

