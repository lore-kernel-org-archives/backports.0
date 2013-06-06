Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39722 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab3FFNXg (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 6 Jun 2013 09:23:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: use old shrinkers API on old kernels
Date: Thu,  6 Jun 2013 15:23:22 +0200
Message-Id: <1370525003-30531-2-git-send-email-hauke@hauke-m.de> (sfid-20130606_152345_083337_636C2FAA)
In-Reply-To: <1370525003-30531-1-git-send-email-hauke@hauke-m.de>
References: <1370525003-30531-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The shrinkers API was changed in new kernel versions. This patch makes
the drm drivers use the old version on older kernel versions.

This backports the following commit from mainline kernel:
commit 1c1df1f6646854cca15fede54ec475b0e9f6a162
Author: Dave Chinner <dchinner@redhat.com>
Date:   Thu Jun 6 10:40:41 2013 +1000

    drivers: convert shrinkers to new count/scan API

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |  120 ++++++++++++++++++
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |  128 ++++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
 create mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
new file mode 100644
index 0000000..9787fdc
--- /dev/null
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -0,0 +1,120 @@
+diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
+index 64cad3f..008009f 100644
+diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
+index 29eff1d..7fb1804 100644
+--- a/drivers/gpu/drm/i915/i915_dma.c
++++ b/drivers/gpu/drm/i915/i915_dma.c
+@@ -1654,7 +1654,11 @@ int i915_driver_load(struct drm_device *
+ 	return 0;
+ 
+ out_gem_unload:
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	if (dev_priv->mm.inactive_shrinker.scan_objects)
++#else
++	if (dev_priv->mm.inactive_shrinker.shrink)
++#endif
+ 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
+ 
+ 	if (dev->pdev->msi_enabled)
+@@ -1685,7 +1689,11 @@ int i915_driver_unload(struct drm_device
+ 
+ 	i915_teardown_sysfs(dev);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	if (dev_priv->mm.inactive_shrinker.scan_objects)
++#else
++	if (dev_priv->mm.inactive_shrinker.shrink)
++#endif
+ 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
+ 
+ 	mutex_lock(&dev->struct_mutex);
+--- a/drivers/gpu/drm/i915/i915_gem.c
++++ b/drivers/gpu/drm/i915/i915_gem.c
+@@ -53,10 +53,15 @@ static void i915_gem_object_update_fence
+ 					 struct drm_i915_fence_reg *fence,
+ 					 bool enable);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ static long i915_gem_inactive_count(struct shrinker *shrinker,
+ 				    struct shrink_control *sc);
+ static long i915_gem_inactive_scan(struct shrinker *shrinker,
+ 				   struct shrink_control *sc);
++#else
++static int i915_gem_inactive_shrink(struct shrinker *shrinker,
++				    struct shrink_control *sc);
++#endif
+ static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
+ static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
+ static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
+@@ -4277,8 +4282,12 @@ i915_gem_load(struct drm_device *dev)
+ 
+ 	dev_priv->mm.interruptible = true;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	dev_priv->mm.inactive_shrinker.scan_objects = i915_gem_inactive_scan;
+ 	dev_priv->mm.inactive_shrinker.count_objects = i915_gem_inactive_count;
++#else
++	dev_priv->mm.inactive_shrinker.shrink = i915_gem_inactive_shrink;
++#endif
+ 	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
+ 	register_shrinker(&dev_priv->mm.inactive_shrinker);
+ }
+@@ -4501,8 +4510,13 @@ static bool mutex_is_locked_by(struct mu
+ #endif
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ static long
+ i915_gem_inactive_count(struct shrinker *shrinker, struct shrink_control *sc)
++#else
++static int
++i915_gem_inactive_shrink(struct shrinker *shrinker, struct shrink_control *sc)
++#endif
+ {
+ 	struct drm_i915_private *dev_priv =
+ 		container_of(shrinker,
+@@ -4511,7 +4525,12 @@ i915_gem_inactive_count(struct shrinker
+ 	struct drm_device *dev = dev_priv->dev;
+ 	struct drm_i915_gem_object *obj;
+ 	bool unlock = true;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	long cnt;
++#else
++	int nr_to_scan = sc->nr_to_scan;
++	int cnt;
++#endif
+ 
+ 	if (!mutex_trylock(&dev->struct_mutex)) {
+ 		if (!mutex_is_locked_by(&dev->struct_mutex, current))
+@@ -4523,6 +4542,17 @@ i915_gem_inactive_count(struct shrinker
+ 		unlock = false;
+ 	}
+ 
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0))
++	if (nr_to_scan) {
++		nr_to_scan -= i915_gem_purge(dev_priv, nr_to_scan);
++		if (nr_to_scan > 0)
++			nr_to_scan -= __i915_gem_shrink(dev_priv, nr_to_scan,
++							false);
++		if (nr_to_scan > 0)
++			i915_gem_shrink_all(dev_priv);
++	}
++#endif
++
+ 	cnt = 0;
+ 	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
+ 		if (obj->pages_pin_count == 0)
+@@ -4535,6 +4565,8 @@ i915_gem_inactive_count(struct shrinker
+ 		mutex_unlock(&dev->struct_mutex);
+ 	return cnt;
+ }
++
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ static long
+ i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
+ {
+@@ -4568,3 +4600,4 @@ i915_gem_inactive_scan(struct shrinker *
+ 		mutex_unlock(&dev->struct_mutex);
+ 	return freed;
+ }
++#endif
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
new file mode 100644
index 0000000..8cb5b37
--- /dev/null
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
@@ -0,0 +1,128 @@
+diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
+index 83058a2..5f5bafe 100644
+diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+index b3b4f99..96e1efb 100644
+--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
++++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
+@@ -377,6 +377,11 @@ out:
+ 	return nr_free;
+ }
+ 
++static long
++ttm_pool_shrink_count(
++	struct shrinker		*shrink,
++	struct shrink_control	*sc);
++
+ /**
+  * Callback for mm to request pool to reduce number of page held.
+  *
+@@ -388,10 +393,15 @@ out:
+  *
+  * This code is crying out for a shrinker per pool....
+  */
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ static long
+ ttm_pool_shrink_scan(
+ 	struct shrinker		*shrink,
+ 	struct shrink_control	*sc)
++#else
++static int ttm_pool_mm_shrink(struct shrinker *shrink,
++			      struct shrink_control *sc)
++#endif
+ {
+ 	static atomic_t start_pool = ATOMIC_INIT(0);
+ 	unsigned i;
+@@ -410,7 +420,12 @@ ttm_pool_shrink_scan(
+ 		shrink_pages = ttm_page_pool_free(pool, nr_free);
+ 		freed += nr_free - shrink_pages;
+ 	}
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	return freed;
++#else
++	/* return estimated number of unused pages in pool */
++	return ttm_pool_shrink_count(shrink, sc);
++#endif
+ }
+ 
+ 
+@@ -430,8 +445,12 @@ ttm_pool_shrink_count(
+ 
+ static void ttm_pool_mm_shrink_init(struct ttm_pool_manager *manager)
+ {
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	manager->mm_shrink.count_objects = &ttm_pool_shrink_count;
+ 	manager->mm_shrink.scan_objects = &ttm_pool_shrink_scan;
++#else
++	manager->mm_shrink.shrink = &ttm_pool_mm_shrink;
++#endif
+ 	manager->mm_shrink.seeks = 1;
+ 	register_shrinker(&manager->mm_shrink);
+ }
+--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
++++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+@@ -987,6 +987,11 @@ void ttm_dma_unpopulate(struct ttm_dma_t
+ }
+ EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
+ 
++static long
++ttm_dma_pool_shrink_count(
++	struct shrinker		*shrink,
++	struct shrink_control	*sc);
++
+ /**
+  * Callback for mm to request pool to reduce number of page held.
+  *
+@@ -1000,10 +1005,15 @@ EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
+  * I'm getting sadder as I hear more pathetical whimpers about needing per-pool
+  * shrinkers
+  */
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ static long
+ ttm_dma_pool_shrink_scan(
+ 	struct shrinker		*shrink,
+ 	struct shrink_control	*sc)
++#else
++static int ttm_dma_pool_mm_shrink(struct shrinker *shrink,
++				  struct shrink_control *sc)
++#endif
+ {
+ 	static atomic_t start_pool = ATOMIC_INIT(0);
+ 	unsigned idx = 0;
+@@ -1013,7 +1023,11 @@ ttm_dma_pool_shrink_scan(
+ 	long freed = 0;
+ 
+ 	if (list_empty(&_manager->pools))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 		return -1;
++#else
++		return 0;
++#endif
+ 
+ 	mutex_lock(&_manager->lock);
+ 	pool_offset = pool_offset % _manager->npools;
+@@ -1036,7 +1050,12 @@ ttm_dma_pool_shrink_scan(
+ 			 nr_free, shrink_pages);
+ 	}
+ 	mutex_unlock(&_manager->lock);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	return freed;
++#else
++	/* return estimated number of unused pages in pool */
++	return ttm_dma_pool_shrink_count(shrink, sc);
++#endif
+ }
+ 
+ static long
+@@ -1056,8 +1075,12 @@ ttm_dma_pool_shrink_count(
+ 
+ static void ttm_dma_pool_mm_shrink_init(struct ttm_pool_manager *manager)
+ {
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+ 	manager->mm_shrink.count_objects = &ttm_dma_pool_shrink_count;
+ 	manager->mm_shrink.scan_objects = &ttm_dma_pool_shrink_scan;
++#else
++	manager->mm_shrink.shrink = &ttm_dma_pool_mm_shrink;
++#endif
+ 	manager->mm_shrink.seeks = 1;
+ 	register_shrinker(&manager->mm_shrink);
+ }
-- 
1.7.10.4

