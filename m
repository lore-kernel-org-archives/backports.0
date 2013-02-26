Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 4/8] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:42:31 +0100
Message-Id: <1361911355-29256-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
References: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

refreshes patches based on linux 3.8-rc5 and alx alx-20130124

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/04-revert-prime-support.patch              |    4 +--
 .../drm/06-rename-config-options.patch             |    4 +--
 .../network/0001-backport-alx.patch                |   16 ++++++------
 .../network/0003-alx-remove-devinit-devexit.patch  |   26 ++++++++++----------
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 7fba759..95f2586 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -120,7 +120,7 @@ not < 3.3.0.
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -358,8 +358,10 @@ static const struct file_operations rade
+@@ -359,8 +359,10 @@ static const struct file_operations rade
  static struct drm_driver kms_driver = {
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
@@ -133,7 +133,7 @@ not < 3.3.0.
  	.dev_priv_size = 0,
  	.load = radeon_driver_load_kms,
  	.firstopen = radeon_driver_firstopen_kms,
-@@ -394,10 +396,12 @@ static struct drm_driver kms_driver = {
+@@ -395,10 +397,12 @@ static struct drm_driver kms_driver = {
  	.dumb_destroy = radeon_mode_dumb_destroy,
  	.fops = &radeon_driver_kms_fops,
  
diff --git a/patches/collateral-evolutions/drm/06-rename-config-options.patch b/patches/collateral-evolutions/drm/06-rename-config-options.patch
index c52e13b..13ee755 100644
--- a/patches/collateral-evolutions/drm/06-rename-config-options.patch
+++ b/patches/collateral-evolutions/drm/06-rename-config-options.patch
@@ -174,7 +174,7 @@
  CFLAGS_radeon_trace_points.o := -I$(src)
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -230,7 +230,7 @@ static struct pci_device_id pciidlist[]
+@@ -231,7 +231,7 @@ static struct pci_device_id pciidlist[]
  	radeon_PCI_IDS
  };
  
@@ -183,7 +183,7 @@
  MODULE_DEVICE_TABLE(pci, pciidlist);
  #endif
  
-@@ -444,7 +444,7 @@ static int __init radeon_init(void)
+@@ -445,7 +445,7 @@ static int __init radeon_init(void)
  #endif
  	/* if enabled by default */
  	if (radeon_modeset == -1) {
diff --git a/patches/unified-drivers/network/0001-backport-alx.patch b/patches/unified-drivers/network/0001-backport-alx.patch
index 228a033..9bd7666 100644
--- a/patches/unified-drivers/network/0001-backport-alx.patch
+++ b/patches/unified-drivers/network/0001-backport-alx.patch
@@ -25,7 +25,7 @@ This should go into patches/01-netdev.patch
  
  	memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
  	memcpy(hw->mac_addr, addr->sa_data, netdev->addr_len);
-@@ -1135,6 +1141,7 @@ static void alx_set_vlan_mode(struct alx
+@@ -1137,6 +1143,7 @@ static void alx_set_vlan_mode(struct alx
  }
  
  
@@ -33,7 +33,7 @@ This should go into patches/01-netdev.patch
  static netdev_features_t alx_fix_features(struct net_device *netdev,
  					  netdev_features_t features)
  {
-@@ -1167,6 +1174,7 @@ static int alx_set_features(struct net_d
+@@ -1169,6 +1176,7 @@ static int alx_set_features(struct net_d
  
  	return 0;
  }
@@ -41,7 +41,7 @@ This should go into patches/01-netdev.patch
  
  /* alx_change_mtu - Change the Maximum Transfer Unit */
  static int alx_change_mtu(struct net_device *netdev, int new_mtu)
-@@ -1191,7 +1199,17 @@ static int alx_change_mtu(struct net_dev
+@@ -1193,7 +1201,17 @@ static int alx_change_mtu(struct net_dev
  		adpt->hw.mtu = new_mtu;
  		adpt->rxbuf_size = new_mtu > ALX_DEF_RXBUF_SIZE ?
  				   ALIGN(max_frame, 8) : ALX_DEF_RXBUF_SIZE;
@@ -59,7 +59,7 @@ This should go into patches/01-netdev.patch
  		if (netif_running(netdev))
  			alx_reinit(adpt);
  	}
-@@ -2474,8 +2474,10 @@ static const struct net_device_ops alx_n
+@@ -2458,8 +2476,10 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -70,7 +70,7 @@ This should go into patches/01-netdev.patch
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -2577,7 +2579,7 @@ alx_probe(struct pci_dev *pdev, const st
+@@ -2561,7 +2581,7 @@ alx_probe(struct pci_dev *pdev, const st
  		goto err_iomap;
  	}
  
@@ -79,7 +79,7 @@ This should go into patches/01-netdev.patch
  	alx_set_ethtool_ops(netdev);
  	netdev->irq  = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
-@@ -2622,12 +2624,21 @@ alx_probe(struct pci_dev *pdev, const st
+@@ -2606,12 +2626,21 @@ alx_probe(struct pci_dev *pdev, const st
  		}
  	}
  
@@ -101,7 +101,7 @@ This should go into patches/01-netdev.patch
  
  	/* read permanent mac addr from register or eFuse */
  	if (alx_get_perm_macaddr(hw, hw->perm_addr)) {
-@@ -2803,6 +2814,8 @@ static struct pci_error_handlers alx_err
+@@ -2787,6 +2816,8 @@ static struct pci_error_handlers alx_err
  };
  
  #ifdef CONFIG_PM_SLEEP
@@ -110,7 +110,7 @@ This should go into patches/01-netdev.patch
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -2816,7 +2829,12 @@ static struct pci_driver alx_driver = {
+@@ -2800,7 +2831,12 @@ static struct pci_driver alx_driver = {
  	.remove      = __devexit_p(alx_remove),
  	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handler,
diff --git a/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch b/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
index 0b0ba96..aedb845 100644
--- a/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
+++ b/patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
@@ -1,8 +1,8 @@
 --- a/drivers/net/ethernet/atheros/alx/alx.h
 +++ b/drivers/net/ethernet/atheros/alx/alx.h
-@@ -190,7 +190,7 @@ struct alx_adapter {
- 
- /* needed by alx_ethtool.c */
+@@ -206,7 +206,7 @@ extern int alx_alloc_rxring_buf(struct a
+ extern void alx_init_intr(struct alx_adapter *adpt);
+ extern void alx_disable_advanced_intr(struct alx_adapter *adpt);
  extern void alx_reinit(struct alx_adapter *adpt);
 -extern void __devinit alx_set_ethtool_ops(struct net_device *dev);
 +extern void alx_set_ethtool_ops(struct net_device *dev);
@@ -11,8 +11,8 @@
  
 --- a/drivers/net/ethernet/atheros/alx/alx_ethtool.c
 +++ b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
-@@ -965,7 +965,7 @@ static const struct ethtool_ops alx_etht
- 	.set_priv_flags  = alx_set_priv_flags,
+@@ -1795,7 +1795,7 @@ static const struct ethtool_ops alx_etht
+ 	.set_priv_flags	 = alx_set_priv_flags,
  };
  
 -void __devinit alx_set_ethtool_ops(struct net_device *dev)
@@ -22,7 +22,7 @@
  }
 --- a/drivers/net/ethernet/atheros/alx/alx_hw.c
 +++ b/drivers/net/ethernet/atheros/alx/alx_hw.c
-@@ -1379,12 +1379,12 @@ void __alx_update_hw_stats(struct alx_hw
+@@ -1416,12 +1416,12 @@ void __alx_update_hw_stats(struct alx_hw
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	int i = 0;
  
-@@ -1403,7 +1403,7 @@ void __devinit alx_patch_assign(struct a
+@@ -1440,7 +1440,7 @@ void __devinit alx_patch_assign(struct a
  	}
  }
  
@@ -48,7 +48,7 @@
  
 --- a/drivers/net/ethernet/atheros/alx/alx_hw.h
 +++ b/drivers/net/ethernet/atheros/alx/alx_hw.h
-@@ -674,7 +674,7 @@ struct alx_platform_patch {
+@@ -655,7 +655,7 @@ struct alx_platform_patch {
  #define ALX_PF_ANY_REV		0x10000
  
  
@@ -60,7 +60,7 @@
  #endif
 --- a/drivers/net/ethernet/atheros/alx/alx_main.c
 +++ b/drivers/net/ethernet/atheros/alx/alx_main.c
-@@ -1007,7 +1007,7 @@ static void alx_free_irq(struct alx_adap
+@@ -1000,7 +1000,7 @@ static void alx_free_irq(struct alx_adap
  }
  
  
@@ -78,7 +78,7 @@
  	0xE2, 0x91, 0xD7, 0x3D, 0x18, 0x05, 0xEC, 0x6C,
  	0x2A, 0x94, 0xB3, 0x0D, 0xA5, 0x4F, 0x2B, 0xEC,
  	0xEA, 0x49, 0xAF, 0x7C, 0xE2, 0x14, 0xAD, 0x3D,
-@@ -1071,7 +1071,7 @@ static void alx_init_def_rss_idt(struct
+@@ -1072,7 +1072,7 @@ void alx_init_def_rss_idt(struct alx_ada
   *    initialize general software structure (struct alx_adapter).
   *    fields are inited based on PCI device information.
   */
@@ -87,7 +87,7 @@
  {
  	struct pci_dev	*pdev = adpt->pdev;
  	struct alx_hw *hw = &adpt->hw;
-@@ -2484,7 +2484,7 @@ static const struct net_device_ops alx_n
+@@ -2486,7 +2486,7 @@ static const struct net_device_ops alx_n
  };
  
  /* alx_probe - Device Initialization Routine */
@@ -96,7 +96,7 @@
  alx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  {
  	struct net_device *netdev;
-@@ -2704,7 +2704,7 @@ err_dma_mask:
+@@ -2706,7 +2706,7 @@ err_dma_mask:
  }
  
  /* alx_remove - Device Removal Routine */
@@ -105,7 +105,7 @@
  {
  	struct alx_adapter *adpt = pci_get_drvdata(pdev);
  	struct alx_hw *hw = &adpt->hw;
-@@ -2826,7 +2826,7 @@ static struct pci_driver alx_driver = {
+@@ -2828,7 +2828,7 @@ static struct pci_driver alx_driver = {
  	.name        = alx_drv_name,
  	.id_table    = alx_pci_tbl,
  	.probe       = alx_probe,
-- 
1.7.10.4
