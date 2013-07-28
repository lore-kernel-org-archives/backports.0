Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50198 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3G1BRz (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:17:55 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so4222586pdj.14
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:17:55 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 9/9] backports: refresh patches for next-20130703
Date: Sat, 27 Jul 2013 18:16:30 -0700
Message-Id: <1374974190-31561-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031757_575360_7BACE92B)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

real    32m59.877s
user    880m31.524s
sys     124m11.996s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch  |    2 +-
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch   |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch                    |    2 +-
 .../drm/14-shrinkers-api/drivers_gpu_drm_i915.patch        |   12 ++++++------
 .../network/0001-netdev_ops/alx.patch                      |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch               |    2 +-
 .../09-threaded-irq/drivers_net_wireless_b43_main.patch    |    6 +++---
 .../network/11-dev-pm-ops/drivers_bcma_host_pci.patch      |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch            |    4 ++--
 .../drivers_net_ethernet_atheros_alx_main.patch            |   10 +++++-----
 .../drivers_net_wireless_b43_main.patch                    |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch      |    2 +-
 12 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index 9218716..3167c0b 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1293,10 +1293,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1292,10 +1292,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 354face..62c4bf8 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4178,9 +4178,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4164,9 +4164,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 7d42edc..052a2c5 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1617,7 +1617,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1616,7 +1616,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index aef9aa3..3ee0727 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4390,8 +4395,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4377,8 +4382,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4614,8 +4623,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4601,8 +4610,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4624,7 +4639,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4611,7 +4626,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4636,6 +4656,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4623,6 +4643,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4649,6 +4680,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4636,6 +4667,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4682,3 +4714,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4669,3 +4701,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
index 46ed1fe..2d419f8 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1317,7 +1317,7 @@ static int alx_probe(struct pci_dev *pde
+@@ -1320,7 +1320,7 @@ static int alx_probe(struct pci_dev *pde
  		goto out_free_netdev;
  	}
  
diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
index aa782b7..17d311c 100644
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
+++ b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1322,8 +1322,10 @@ static int alx_probe(struct pci_dev *pde
+@@ -1325,8 +1325,10 @@ static int alx_probe(struct pci_dev *pde
  	netdev->irq = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index aaa0aa0..46e881e 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4236,8 +4236,13 @@ redo:
+@@ -4238,8 +4238,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4283,9 +4288,17 @@ static int b43_wireless_core_start(struc
+@@ -4285,9 +4290,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5108,6 +5121,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5110,6 +5123,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
index 1b9b578..00790a6 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(bcma_pm_ops, bcma_host_pci_suspend,
  			 bcma_host_pci_resume);
  #define BCMA_PM_OPS	(&bcma_pm_ops)
-@@ -285,7 +288,12 @@ static struct pci_driver bcma_pci_bridge
+@@ -286,7 +289,12 @@ static struct pci_driver bcma_pci_bridge
  	.id_table = bcma_pci_bridge_tbl,
  	.probe = bcma_host_pci_probe,
  	.remove = bcma_host_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 4f4cce9..626f5c5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1590,6 +1590,8 @@ static const struct pci_error_handlers a
+@@ -1593,6 +1593,8 @@ static const struct pci_error_handlers a
  };
  
  #ifdef CONFIG_PM_SLEEP
@@ -9,7 +9,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1615,7 +1617,12 @@ static struct pci_driver alx_driver = {
+@@ -1618,7 +1620,12 @@ static struct pci_driver alx_driver = {
  	.remove      = alx_remove,
  	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 35e3371..4adbb0d 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -737,6 +737,7 @@ static int alx_init_sw(struct alx_priv *
+@@ -738,6 +738,7 @@ static int alx_init_sw(struct alx_priv *
  }
  
  
@@ -8,7 +8,7 @@
  static netdev_features_t alx_fix_features(struct net_device *netdev,
  					  netdev_features_t features)
  {
-@@ -745,6 +746,7 @@ static netdev_features_t alx_fix_feature
+@@ -746,6 +747,7 @@ static netdev_features_t alx_fix_feature
  
  	return features;
  }
@@ -16,7 +16,7 @@
  
  static void alx_netif_stop(struct alx_priv *alx)
  {
-@@ -820,7 +822,17 @@ static int alx_change_mtu(struct net_dev
+@@ -822,7 +824,17 @@ static int alx_change_mtu(struct net_dev
  	alx->hw.mtu = mtu;
  	alx->rxbuf_size = mtu > ALX_DEF_RXBUF_SIZE ?
  			   ALIGN(max_frame, 8) : ALX_DEF_RXBUF_SIZE;
@@ -34,7 +34,7 @@
  	if (netif_running(netdev))
  		alx_reinit(alx);
  	return 0;
-@@ -1238,7 +1250,9 @@ static const struct net_device_ops alx_n
+@@ -1241,7 +1253,9 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1361,7 +1375,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1364,7 +1378,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 43c2163..850e1a3 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3449,11 +3449,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3451,11 +3451,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index 148925e..c8da6e7 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -740,7 +740,9 @@ static struct usb_driver cdc_driver = {
+@@ -752,7 +752,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

