Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:47609 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab3G3J1H (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:27:07 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so2565400pbb.13
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:27:06 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 14/14] backports: refresh patches for next-20130712
Date: Tue, 30 Jul 2013 02:25:59 -0700
Message-Id: <1375176359-1331-15-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112708_982368_78B851AD)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
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

real    34m34.417s
user    933m25.264s
sys     129m41.580s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch   |    2 +-
 .../drm/14-shrinkers-api/drivers_gpu_drm_i915.patch        |   12 ++++++------
 .../network/0001-netdev_ops/alx.patch                      |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch               |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch            |    4 ++--
 .../drivers_net_ethernet_atheros_alx_main.patch            |    2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 62c4bf8..486693b 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4164,9 +4164,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4147,9 +4147,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index 3ee0727..c00d346 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4377,8 +4382,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4360,8 +4365,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4601,8 +4610,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4584,8 +4593,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4611,7 +4626,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4594,7 +4609,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4623,6 +4643,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4606,6 +4626,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4636,6 +4667,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4619,6 +4650,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4669,3 +4701,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4652,3 +4684,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
index 27409eb..465c4de 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1259,7 +1259,7 @@ static int alx_probe(struct pci_dev *pde
+@@ -1261,7 +1261,7 @@ static int alx_probe(struct pci_dev *pde
  		goto out_free_netdev;
  	}
  
diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
index 63df1f0..729fa6e 100644
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
+++ b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1264,8 +1264,10 @@ static int alx_probe(struct pci_dev *pde
+@@ -1266,8 +1266,10 @@ static int alx_probe(struct pci_dev *pde
  	netdev->irq = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 8dae6c0..0b32146 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1404,6 +1404,9 @@ static int alx_resume(struct device *dev
+@@ -1403,6 +1403,9 @@ static int alx_resume(struct device *dev
  	return __alx_open(alx, true);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1506,7 +1509,12 @@ static struct pci_driver alx_driver = {
+@@ -1505,7 +1508,12 @@ static struct pci_driver alx_driver = {
  	.probe       = alx_probe,
  	.remove      = alx_remove,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 742ae0f..dbc4d50 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1303,7 +1317,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1305,7 +1319,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
-- 
1.7.10.4

