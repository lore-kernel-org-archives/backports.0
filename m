Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37574 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWxs (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] backports: the shrinkers api did not made it into 3.11
Date: Thu,  8 Aug 2013 00:53:18 +0200
Message-Id: <1375916005-16411-4-git-send-email-hauke@hauke-m.de> (sfid-20130808_005349_925646_C0B2A2FD)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Change the conditions to use the backported code also in 3.11

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This should also go into the 3.11 branch.

 .../drm/14-shrinkers-api/drivers_gpu_drm_i915.patch    |   16 ++++++++--------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch     |   12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index c00d346..651f2c6 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -4,7 +4,7 @@
  	return 0;
  
  out_gem_unload:
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	if (dev_priv->mm.inactive_shrinker.scan_objects)
 +#else
 +	if (dev_priv->mm.inactive_shrinker.shrink)
@@ -16,7 +16,7 @@
  
  	i915_teardown_sysfs(dev);
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	if (dev_priv->mm.inactive_shrinker.scan_objects)
 +#else
 +	if (dev_priv->mm.inactive_shrinker.shrink)
@@ -30,7 +30,7 @@
  					 struct drm_i915_fence_reg *fence,
  					 bool enable);
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long i915_gem_inactive_count(struct shrinker *shrinker,
  					     struct shrink_control *sc);
  static unsigned long i915_gem_inactive_scan(struct shrinker *shrinker,
@@ -46,7 +46,7 @@
  
  	dev_priv->mm.interruptible = true;
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	dev_priv->mm.inactive_shrinker.scan_objects = i915_gem_inactive_scan;
  	dev_priv->mm.inactive_shrinker.count_objects = i915_gem_inactive_count;
 +#else
@@ -59,7 +59,7 @@
  #endif
  }
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  i915_gem_inactive_count(struct shrinker *shrinker, struct shrink_control *sc)
 +#else
@@ -74,7 +74,7 @@
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	unsigned long count;
 +#else
 +	int nr_to_scan = sc->nr_to_scan;
@@ -87,7 +87,7 @@
  		unlock = false;
  	}
  
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0))
 +	if (nr_to_scan) {
 +		nr_to_scan -= i915_gem_purge(dev_priv, nr_to_scan);
 +		if (nr_to_scan > 0)
@@ -105,7 +105,7 @@
  	return count;
  }
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
index d206043..5a8176d 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
@@ -14,7 +14,7 @@
   *
   * This code is crying out for a shrinker per pool....
   */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  ttm_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 +#else
@@ -28,7 +28,7 @@
  		shrink_pages = ttm_page_pool_free(pool, nr_free);
  		freed += nr_free - shrink_pages;
  	}
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	return freed;
 +#else
 +	/* return estimated number of unused pages in pool */
@@ -41,7 +41,7 @@
  
  static void ttm_pool_mm_shrink_init(struct ttm_pool_manager *manager)
  {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	manager->mm_shrink.count_objects = ttm_pool_shrink_count;
  	manager->mm_shrink.scan_objects = ttm_pool_shrink_scan;
 +#else
@@ -66,7 +66,7 @@
   * I'm getting sadder as I hear more pathetical whimpers about needing per-pool
   * shrinkers
   */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  static unsigned long
  ttm_dma_pool_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 +#else
@@ -81,7 +81,7 @@
  			 nr_free, shrink_pages);
  	}
  	mutex_unlock(&_manager->lock);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	return freed;
 +#else
 +	/* return estimated number of unused pages in pool */
@@ -94,7 +94,7 @@
  
  static void ttm_dma_pool_mm_shrink_init(struct ttm_pool_manager *manager)
  {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
  	manager->mm_shrink.count_objects = ttm_dma_pool_shrink_count;
  	manager->mm_shrink.scan_objects = &ttm_dma_pool_shrink_scan;
 +#else
-- 
1.7.10.4

