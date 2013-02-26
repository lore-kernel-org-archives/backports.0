Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 8/8] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:42:35 +0100
Message-Id: <1361911355-29256-9-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
References: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

refreshes patches based on linux 3.8.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/drm/03-swiotlb.patch       |   12 ++++++------
 .../drm/04-revert-prime-support.patch                    |   14 +++++++-------
 .../collateral-evolutions/network/0001-netdev_ops.patch  |    2 +-
 .../collateral-evolutions/network/11-dev-pm-ops.patch    |    4 ++--
 .../network/40-netdev-hw-features.patch                  |    6 +++---
 .../network/61-netdev-addr_assign_type.patch             |    2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/patches/collateral-evolutions/drm/03-swiotlb.patch b/patches/collateral-evolutions/drm/03-swiotlb.patch
index e6dc53f..8554da5 100644
--- a/patches/collateral-evolutions/drm/03-swiotlb.patch
+++ b/patches/collateral-evolutions/drm/03-swiotlb.patch
@@ -5,7 +5,7 @@ to backport it to compat.git. So revert the changes.
 
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1373,11 +1373,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1374,11 +1374,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	}
  #endif
  
@@ -19,7 +19,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -1423,12 +1425,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1424,12 +1426,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	}
  #endif
  
@@ -36,7 +36,7 @@ to backport it to compat.git. So revert the changes.
  		if (ttm_dma->dma_address[i]) {
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -602,11 +602,13 @@ static int radeon_ttm_tt_populate(struct
+@@ -603,11 +603,13 @@ static int radeon_ttm_tt_populate(struct
  	}
  #endif
  
@@ -50,7 +50,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -648,12 +650,14 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -649,12 +651,14 @@ static void radeon_ttm_tt_unpopulate(str
  	}
  #endif
  
@@ -65,7 +65,7 @@ to backport it to compat.git. So revert the changes.
  
  	for (i = 0; i < ttm->num_pages; i++) {
  		if (gtt->ttm.dma_address[i]) {
-@@ -876,6 +880,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -877,6 +881,7 @@ static int radeon_ttm_debugfs_init(struc
  	radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
  	radeon_mem_types_list[i].driver_features = 0;
  	radeon_mem_types_list[i++].data = NULL;
@@ -73,7 +73,7 @@ to backport it to compat.git. So revert the changes.
  #ifdef CONFIG_SWIOTLB
  	if (swiotlb_nr_tbl()) {
  		sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
-@@ -885,6 +890,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -886,6 +891,7 @@ static int radeon_ttm_debugfs_init(struc
  		radeon_mem_types_list[i++].data = NULL;
  	}
  #endif
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 95f2586..95e3fd7 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -161,7 +161,7 @@ not < 3.3.0.
  }
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -583,17 +583,21 @@ static int radeon_ttm_tt_populate(struct
+@@ -584,17 +584,21 @@ static int radeon_ttm_tt_populate(struct
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
  	int r;
@@ -183,7 +183,7 @@ not < 3.3.0.
  
  	rdev = radeon_get_rdev(ttm->bdev);
  #if __OS_HAS_AGP
-@@ -637,10 +641,12 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -638,10 +642,12 @@ static void radeon_ttm_tt_unpopulate(str
  	struct radeon_device *rdev;
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
@@ -198,7 +198,7 @@ not < 3.3.0.
  #if __OS_HAS_AGP
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1351,11 +1351,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1352,11 +1352,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	struct drm_device *dev;
  	unsigned i;
  	int r;
@@ -213,7 +213,7 @@ not < 3.3.0.
  	if (slave && ttm->sg) {
  		/* make userspace faulting work */
  		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-@@ -1363,6 +1366,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1364,6 +1367,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  		ttm->state = tt_unbound;
  		return 0;
  	}
@@ -221,7 +221,7 @@ not < 3.3.0.
  
  	drm = nouveau_bdev(ttm->bdev);
  	dev = drm->dev;
-@@ -1410,10 +1414,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1411,10 +1415,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	struct nouveau_drm *drm;
  	struct drm_device *dev;
  	unsigned i;
@@ -236,7 +236,7 @@ not < 3.3.0.
  	dev = drm->dev;
 --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -627,7 +627,10 @@ driver = {
+@@ -630,7 +630,10 @@ driver = {
  	.driver_features =
  		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
  		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
@@ -248,7 +248,7 @@ not < 3.3.0.
  
  	.load = nouveau_drm_load,
  	.unload = nouveau_drm_unload,
-@@ -648,10 +651,12 @@ driver = {
+@@ -651,10 +654,12 @@ driver = {
  	.ioctls = nouveau_ioctls,
  	.fops = &nouveau_driver_fops,
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index 716bc82..bfcaf00 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -201,7 +201,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	atl1e_set_ethtool_ops(netdev);
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2416,7 +2416,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2473,7 +2473,7 @@ static int atl1c_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index 6a7eb3e..9825b53 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -34,7 +34,7 @@ calls on compat code with only slight modifications.
  int __init bcma_host_pci_init(void)
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2690,6 +2690,9 @@ static const struct pci_error_handlers a
+@@ -2747,6 +2747,9 @@ static const struct pci_error_handlers a
  	.resume = atl1c_io_resume,
  };
  
@@ -44,7 +44,7 @@ calls on compat code with only slight modifications.
  static SIMPLE_DEV_PM_OPS(atl1c_pm_ops, atl1c_suspend, atl1c_resume);
  
  static struct pci_driver atl1c_driver = {
-@@ -2699,7 +2702,12 @@ static struct pci_driver atl1c_driver =
+@@ -2756,7 +2759,12 @@ static struct pci_driver atl1c_driver =
  	.remove   = atl1c_remove,
  	.shutdown = atl1c_shutdown,
  	.err_handler = &atl1c_err_handler,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features.patch b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
index 59f2667..d944e6f 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
@@ -84,7 +84,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2405,8 +2418,10 @@ static const struct net_device_ops atl1c
+@@ -2462,8 +2475,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -95,7 +95,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2425,6 +2440,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2482,6 +2497,7 @@ static int atl1c_init_netdev(struct net_
  	atl1c_set_ethtool_ops(netdev);
  
  	/* TODO: add when ready */
@@ -103,7 +103,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	netdev->hw_features =	NETIF_F_SG	   |
  				NETIF_F_HW_CSUM	   |
  				NETIF_F_HW_VLAN_RX |
-@@ -2432,6 +2448,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2489,6 +2505,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features |
  				NETIF_F_HW_VLAN_TX;
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
index b476617..d9f0087 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
@@ -17,7 +17,7 @@ v2.6.36-rc1~571^2~104
  
  	atl1c_hw_set_mac_addr(&adapter->hw, adapter->hw.mac_addr);
  
-@@ -2568,7 +2570,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2625,7 +2627,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
-- 
1.7.10.4
