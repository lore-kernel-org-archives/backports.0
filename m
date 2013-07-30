Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48636 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab3G3Jp0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:45:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so5969035pad.16
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:45:25 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3.11-rc3 1/2] backports: remove DRM shrinkers patches
Date: Tue, 30 Jul 2013 02:45:14 -0700
Message-Id: <1375177515-2537-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_114536_771418_37DC49BB)
In-Reply-To: <1375177515-2537-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375177515-2537-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

<sad_trombone>This did not make it to v3.11</sad_trombone>

commit 84292b549bf48f80d470215b357179ea13d64a35
Author: Dave Chinner <dchinner@redhat.com>
Date:   Wed Jul 3 10:19:58 2013 +1000

    drivers: convert shrinkers to new count/scan API

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |  116 --------------------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |  105 ------------------
 2 files changed, 221 deletions(-)
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
deleted file mode 100644
index c00d346..0000000
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ /dev/null
@@ -1,116 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_dma.c
-+++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1657,7 +1657,11 @@ int i915_driver_load(struct drm_device *
- 	return 0;
- 
- out_gem_unload:
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	if (dev_priv->mm.inactive_shrinker.scan_objects)
-+#else
-+	if (dev_priv->mm.inactive_shrinker.shrink)
-+#endif
- 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
- 
- 	if (dev->pdev->msi_enabled)
-@@ -1691,7 +1695,11 @@ int i915_driver_unload(struct drm_device
- 
- 	i915_teardown_sysfs(dev);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	if (dev_priv->mm.inactive_shrinker.scan_objects)
-+#else
-+	if (dev_priv->mm.inactive_shrinker.shrink)
-+#endif
- 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
- 
- 	mutex_lock(&dev->struct_mutex);
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -53,10 +53,15 @@ static void i915_gem_object_update_fence
- 					 struct drm_i915_fence_reg *fence,
- 					 bool enable);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static unsigned long i915_gem_inactive_count(struct shrinker *shrinker,
- 					     struct shrink_control *sc);
- static unsigned long i915_gem_inactive_scan(struct shrinker *shrinker,
- 					    struct shrink_control *sc);
-+#else
-+static int i915_gem_inactive_shrink(struct shrinker *shrinker,
-+				    struct shrink_control *sc);
-+#endif
- static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
- static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
- static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4360,8 +4365,12 @@ i915_gem_load(struct drm_device *dev)
- 
- 	dev_priv->mm.interruptible = true;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	dev_priv->mm.inactive_shrinker.scan_objects = i915_gem_inactive_scan;
- 	dev_priv->mm.inactive_shrinker.count_objects = i915_gem_inactive_count;
-+#else
-+	dev_priv->mm.inactive_shrinker.shrink = i915_gem_inactive_shrink;
-+#endif
- 	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
- 	register_shrinker(&dev_priv->mm.inactive_shrinker);
- }
-@@ -4584,8 +4593,14 @@ static bool mutex_is_locked_by(struct mu
- #endif
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static unsigned long
- i915_gem_inactive_count(struct shrinker *shrinker, struct shrink_control *sc)
-+#else
-+#define SHRINK_STOP -1
-+static int
-+i915_gem_inactive_shrink(struct shrinker *shrinker, struct shrink_control *sc)
-+#endif
- {
- 	struct drm_i915_private *dev_priv =
- 		container_of(shrinker,
-@@ -4594,7 +4609,12 @@ i915_gem_inactive_count(struct shrinker
- 	struct drm_device *dev = dev_priv->dev;
- 	struct drm_i915_gem_object *obj;
- 	bool unlock = true;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	unsigned long count;
-+#else
-+	int nr_to_scan = sc->nr_to_scan;
-+	int count;
-+#endif
- 
- 	if (!mutex_trylock(&dev->struct_mutex)) {
- 		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4606,6 +4626,17 @@ i915_gem_inactive_count(struct shrinker
- 		unlock = false;
- 	}
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0))
-+	if (nr_to_scan) {
-+		nr_to_scan -= i915_gem_purge(dev_priv, nr_to_scan);
-+		if (nr_to_scan > 0)
-+			nr_to_scan -= __i915_gem_shrink(dev_priv, nr_to_scan,
-+							false);
-+		if (nr_to_scan > 0)
-+			i915_gem_shrink_all(dev_priv);
-+	}
-+#endif
-+
- 	count = 0;
- 	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
- 		if (obj->pages_pin_count == 0)
-@@ -4619,6 +4650,7 @@ i915_gem_inactive_count(struct shrinker
- 	return count;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static unsigned long
- i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
- {
-@@ -4652,3 +4684,4 @@ i915_gem_inactive_scan(struct shrinker *
- 		mutex_unlock(&dev->struct_mutex);
- 	return freed;
- }
-+#endif
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
deleted file mode 100644
index d206043..0000000
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
+++ /dev/null
@@ -1,105 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
-+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
-@@ -377,6 +377,9 @@ out:
- 	return nr_free;
- }
- 
-+static unsigned long
-+ttm_pool_shrink_count(struct shrinker *shrink, struct shrink_control *sc);
-+
- /**
-  * Callback for mm to request pool to reduce number of page held.
-  *
-@@ -388,8 +391,13 @@ out:
-  *
-  * This code is crying out for a shrinker per pool....
-  */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static unsigned long
- ttm_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
-+#else
-+static int ttm_pool_mm_shrink(struct shrinker *shrink,
-+			      struct shrink_control *sc)
-+#endif
- {
- 	static atomic_t start_pool = ATOMIC_INIT(0);
- 	unsigned i;
-@@ -408,7 +416,12 @@ ttm_pool_shrink_scan(struct shrinker *sh
- 		shrink_pages = ttm_page_pool_free(pool, nr_free);
- 		freed += nr_free - shrink_pages;
- 	}
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	return freed;
-+#else
-+	/* return estimated number of unused pages in pool */
-+	return ttm_pool_shrink_count(shrink, sc);
-+#endif
- }
- 
- 
-@@ -426,8 +439,12 @@ ttm_pool_shrink_count(struct shrinker *s
- 
- static void ttm_pool_mm_shrink_init(struct ttm_pool_manager *manager)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	manager->mm_shrink.count_objects = ttm_pool_shrink_count;
- 	manager->mm_shrink.scan_objects = ttm_pool_shrink_scan;
-+#else
-+	manager->mm_shrink.shrink = ttm_pool_mm_shrink;
-+#endif
- 	manager->mm_shrink.seeks = 1;
- 	register_shrinker(&manager->mm_shrink);
- }
---- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-@@ -987,6 +987,9 @@ void ttm_dma_unpopulate(struct ttm_dma_t
- }
- EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
- 
-+static unsigned long
-+ttm_dma_pool_shrink_count(struct shrinker *shrink, struct shrink_control *sc);
-+
- /**
-  * Callback for mm to request pool to reduce number of page held.
-  *
-@@ -1000,8 +1003,14 @@ EXPORT_SYMBOL_GPL(ttm_dma_unpopulate);
-  * I'm getting sadder as I hear more pathetical whimpers about needing per-pool
-  * shrinkers
-  */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- static unsigned long
- ttm_dma_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
-+#else
-+#define SHRINK_STOP 0
-+static int ttm_dma_pool_mm_shrink(struct shrinker *shrink,
-+				  struct shrink_control *sc)
-+#endif
- {
- 	static atomic_t start_pool = ATOMIC_INIT(0);
- 	unsigned idx = 0;
-@@ -1034,7 +1043,12 @@ ttm_dma_pool_shrink_scan(struct shrinker
- 			 nr_free, shrink_pages);
- 	}
- 	mutex_unlock(&_manager->lock);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	return freed;
-+#else
-+	/* return estimated number of unused pages in pool */
-+	return ttm_dma_pool_shrink_count(shrink, sc);
-+#endif
- }
- 
- static unsigned long
-@@ -1052,8 +1066,12 @@ ttm_dma_pool_shrink_count(struct shrinke
- 
- static void ttm_dma_pool_mm_shrink_init(struct ttm_pool_manager *manager)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
- 	manager->mm_shrink.count_objects = ttm_dma_pool_shrink_count;
- 	manager->mm_shrink.scan_objects = &ttm_dma_pool_shrink_scan;
-+#else
-+	manager->mm_shrink.shrink = ttm_dma_pool_mm_shrink;
-+#endif
- 	manager->mm_shrink.seeks = 1;
- 	register_shrinker(&manager->mm_shrink);
- }
-- 
1.7.10.4

