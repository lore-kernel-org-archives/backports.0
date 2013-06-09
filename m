Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51277 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab3FINYO (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 9 Jun 2013 09:24:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: adapt shrinkers api patch to next-20130607
Date: Sun,  9 Jun 2013 15:23:49 +0200
Message-Id: <1370784233-18228-1-git-send-email-hauke@hauke-m.de> (sfid-20130609_152416_716185_573B6113)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The shrinkers api changed a little in the last version, this patch
makes the patches apply again.

== ckmake-report.log ==

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

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   42 ++++++------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |   69 +++++++-------------
 2 files changed, 42 insertions(+), 69 deletions(-)

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index 9787fdc..8d63086 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -1,10 +1,6 @@
-diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
-index 64cad3f..008009f 100644
-diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
-index 29eff1d..7fb1804 100644
 --- a/drivers/gpu/drm/i915/i915_dma.c
 +++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1654,7 +1654,11 @@ int i915_driver_load(struct drm_device *
+@@ -1657,7 +1657,11 @@ int i915_driver_load(struct drm_device *
  	return 0;
  
  out_gem_unload:
@@ -16,7 +12,7 @@ index 29eff1d..7fb1804 100644
  		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
  
  	if (dev->pdev->msi_enabled)
-@@ -1685,7 +1689,11 @@ int i915_driver_unload(struct drm_device
+@@ -1691,7 +1695,11 @@ int i915_driver_unload(struct drm_device
  
  	i915_teardown_sysfs(dev);
  
@@ -35,10 +31,10 @@ index 29eff1d..7fb1804 100644
  					 bool enable);
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static long i915_gem_inactive_count(struct shrinker *shrinker,
- 				    struct shrink_control *sc);
- static long i915_gem_inactive_scan(struct shrinker *shrinker,
- 				   struct shrink_control *sc);
+ static unsigned long i915_gem_inactive_count(struct shrinker *shrinker,
+ 					     struct shrink_control *sc);
+ static unsigned long i915_gem_inactive_scan(struct shrinker *shrinker,
+ 					    struct shrink_control *sc);
 +#else
 +static int i915_gem_inactive_shrink(struct shrinker *shrinker,
 +				    struct shrink_control *sc);
@@ -59,34 +55,35 @@ index 29eff1d..7fb1804 100644
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4501,8 +4510,13 @@ static bool mutex_is_locked_by(struct mu
+@@ -4501,8 +4510,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static long
+ static unsigned long
  i915_gem_inactive_count(struct shrinker *shrinker, struct shrink_control *sc)
 +#else
++#define SHRINK_STOP -1
 +static int
 +i915_gem_inactive_shrink(struct shrinker *shrinker, struct shrink_control *sc)
 +#endif
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4511,7 +4525,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4511,7 +4526,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	long cnt;
+ 	unsigned long count;
 +#else
 +	int nr_to_scan = sc->nr_to_scan;
-+	int cnt;
++	int count;
 +#endif
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4523,6 +4542,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4523,6 +4543,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,19 +98,18 @@ index 29eff1d..7fb1804 100644
 +	}
 +#endif
 +
- 	cnt = 0;
+ 	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4535,6 +4565,8 @@ i915_gem_inactive_count(struct shrinker
- 		mutex_unlock(&dev->struct_mutex);
- 	return cnt;
+@@ -4536,6 +4567,7 @@ i915_gem_inactive_count(struct shrinker
+ 	return count;
  }
-+
+ 
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static long
+ static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4568,3 +4600,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4569,3 +4601,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
index 8cb5b37..d206043 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
@@ -1,30 +1,22 @@
-diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
-index 83058a2..5f5bafe 100644
-diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-index b3b4f99..96e1efb 100644
 --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
 +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
-@@ -377,6 +377,11 @@ out:
+@@ -377,6 +377,9 @@ out:
  	return nr_free;
  }
  
-+static long
-+ttm_pool_shrink_count(
-+	struct shrinker		*shrink,
-+	struct shrink_control	*sc);
++static unsigned long
++ttm_pool_shrink_count(struct shrinker *shrink, struct shrink_control *sc);
 +
  /**
   * Callback for mm to request pool to reduce number of page held.
   *
-@@ -388,10 +393,15 @@ out:
+@@ -388,8 +391,13 @@ out:
   *
   * This code is crying out for a shrinker per pool....
   */
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static long
- ttm_pool_shrink_scan(
- 	struct shrinker		*shrink,
- 	struct shrink_control	*sc)
+ static unsigned long
+ ttm_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 +#else
 +static int ttm_pool_mm_shrink(struct shrinker *shrink,
 +			      struct shrink_control *sc)
@@ -32,7 +24,7 @@ index b3b4f99..96e1efb 100644
  {
  	static atomic_t start_pool = ATOMIC_INIT(0);
  	unsigned i;
-@@ -410,7 +420,12 @@ ttm_pool_shrink_scan(
+@@ -408,7 +416,12 @@ ttm_pool_shrink_scan(struct shrinker *sh
  		shrink_pages = ttm_page_pool_free(pool, nr_free);
  		freed += nr_free - shrink_pages;
  	}
@@ -45,62 +37,47 @@ index b3b4f99..96e1efb 100644
  }
  
  
-@@ -430,8 +445,12 @@ ttm_pool_shrink_count(
+@@ -426,8 +439,12 @@ ttm_pool_shrink_count(struct shrinker *s
  
  static void ttm_pool_mm_shrink_init(struct ttm_pool_manager *manager)
  {
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	manager->mm_shrink.count_objects = &ttm_pool_shrink_count;
- 	manager->mm_shrink.scan_objects = &ttm_pool_shrink_scan;
+ 	manager->mm_shrink.count_objects = ttm_pool_shrink_count;
+ 	manager->mm_shrink.scan_objects = ttm_pool_shrink_scan;
 +#else
-+	manager->mm_shrink.shrink = &ttm_pool_mm_shrink;
++	manager->mm_shrink.shrink = ttm_pool_mm_shrink;
 +#endif
  	manager->mm_shrink.seeks = 1;
  	register_shrinker(&manager->mm_shrink);
  }
 --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
 +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-@@ -987,6 +987,11 @@ void ttm_dma_unpopulate(struct ttm_dma_t
+@@ -987,6 +987,9 @@ void ttm_dma_unpopulate(struct ttm_dma_t
  }
  EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
  
-+static long
-+ttm_dma_pool_shrink_count(
-+	struct shrinker		*shrink,
-+	struct shrink_control	*sc);
++static unsigned long
++ttm_dma_pool_shrink_count(struct shrinker *shrink, struct shrink_control *sc);
 +
  /**
   * Callback for mm to request pool to reduce number of page held.
   *
-@@ -1000,10 +1005,15 @@ EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
+@@ -1000,8 +1003,14 @@ EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
   * I'm getting sadder as I hear more pathetical whimpers about needing per-pool
   * shrinkers
   */
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static long
- ttm_dma_pool_shrink_scan(
- 	struct shrinker		*shrink,
- 	struct shrink_control	*sc)
+ static unsigned long
+ ttm_dma_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 +#else
++#define SHRINK_STOP 0
 +static int ttm_dma_pool_mm_shrink(struct shrinker *shrink,
 +				  struct shrink_control *sc)
 +#endif
  {
  	static atomic_t start_pool = ATOMIC_INIT(0);
  	unsigned idx = 0;
-@@ -1013,7 +1023,11 @@ ttm_dma_pool_shrink_scan(
- 	long freed = 0;
- 
- 	if (list_empty(&_manager->pools))
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 		return -1;
-+#else
-+		return 0;
-+#endif
- 
- 	mutex_lock(&_manager->lock);
- 	pool_offset = pool_offset % _manager->npools;
-@@ -1036,7 +1050,12 @@ ttm_dma_pool_shrink_scan(
+@@ -1034,7 +1043,12 @@ ttm_dma_pool_shrink_scan(struct shrinker
  			 nr_free, shrink_pages);
  	}
  	mutex_unlock(&_manager->lock);
@@ -112,16 +89,16 @@ index b3b4f99..96e1efb 100644
 +#endif
  }
  
- static long
-@@ -1056,8 +1075,12 @@ ttm_dma_pool_shrink_count(
+ static unsigned long
+@@ -1052,8 +1066,12 @@ ttm_dma_pool_shrink_count(struct shrinke
  
  static void ttm_dma_pool_mm_shrink_init(struct ttm_pool_manager *manager)
  {
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	manager->mm_shrink.count_objects = &ttm_dma_pool_shrink_count;
+ 	manager->mm_shrink.count_objects = ttm_dma_pool_shrink_count;
  	manager->mm_shrink.scan_objects = &ttm_dma_pool_shrink_scan;
 +#else
-+	manager->mm_shrink.shrink = &ttm_dma_pool_mm_shrink;
++	manager->mm_shrink.shrink = ttm_dma_pool_mm_shrink;
 +#endif
  	manager->mm_shrink.seeks = 1;
  	register_shrinker(&manager->mm_shrink);
-- 
1.7.10.4

