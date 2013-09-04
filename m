Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:42571 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792Ab3IDWGX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 4 Sep 2013 18:06:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: fix intel i915 drm driver
Date: Thu,  5 Sep 2013 00:06:11 +0200
Message-Id: <1378332371-13832-1-git-send-email-hauke@hauke-m.de> (sfid-20130905_000626_478569_815E66F4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The intel i915 drm driver uses the declarations from intel-gtt.h to
interact with drivers/char/agp/intel-gtt.c which is not
backported by backports project. To prevent some strange problems when
using i915, use the headers from the kernel and do not use our own. This
causes some compile problems which where runtime problems before and
bumps the minimal kernel version to 3.7.

This i915 still crash on my device with kernel 3.7.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list                                          |   31 +++++++++++++++++++-
 dependencies                                       |    1 +
 .../drivers_gpu_drm_i915_i915_gem.patch            |   21 -------------
 .../drm/05-i915-define-acpi-video-class/INFO       |    4 ---
 .../drivers_gpu_drm_i915_intel_opregion.patch      |   12 --------
 .../collateral-evolutions/drm/07-intel-gtt/INFO    |   24 ---------------
 .../drivers_gpu_drm_i915_i915_gem.patch            |   13 --------
 .../drm/08-shmem_truncate_range/INFO               |   27 -----------------
 .../drivers_gpu_drm_i915_i915_gem.patch            |   16 ----------
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 ++++----
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |   29 ++++++++++++++++++
 11 files changed, 66 insertions(+), 124 deletions(-)
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/INFO
 delete mode 100644 patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
 delete mode 100644 patches/collateral-evolutions/drm/07-intel-gtt/INFO
 delete mode 100644 patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/08-shmem_truncate_range/INFO
 delete mode 100644 patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
 create mode 100644 patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch

diff --git a/copy-list b/copy-list
index 89147e8..1f9f78a 100644
--- a/copy-list
+++ b/copy-list
@@ -116,7 +116,36 @@ drivers/net/usb/sierra_net.c
 drivers/net/usb/qmi_wwan.c
 
 # DRM
-include/drm/
+include/drm/drm_buffer.h
+include/drm/drm_cache.h
+include/drm/drm_core.h
+include/drm/drm_crtc.h
+include/drm/drm_crtc_helper.h
+include/drm/drm_dp_helper.h
+include/drm/drm_edid.h
+include/drm/drm_encoder_slave.h
+include/drm/drm_fb_cma_helper.h
+include/drm/drm_fb_helper.h
+include/drm/drm_fixed.h
+include/drm/drm_gem_cma_helper.h
+include/drm/drm_global.h
+include/drm/drm_hashtab.h
+include/drm/drm_memory.h
+include/drm/drm_mem_util.h
+include/drm/drm_mm.h
+include/drm/drm_os_linux.h
+include/drm/drm_pciids.h
+include/drm/drmP.h
+include/drm/drm_rect.h
+include/drm/drm_sysfs.h
+include/drm/drm_usb.h
+include/drm/drm_vma_manager.h
+include/drm/exynos_drm.h
+include/drm/gma_drm.h
+include/drm/i915_drm.h
+include/drm/i915_powerwell.h
+include/drm/i2c/
+include/drm/ttm/
 include/uapi/drm/
 drivers/platform/x86/intel_ips.h
 drivers/gpu/drm/
diff --git a/dependencies b/dependencies
index 2afef61..ad27097 100644
--- a/dependencies
+++ b/dependencies
@@ -62,6 +62,7 @@ DRM_TTM 3.2
 # taking into consideration the radix_tree_node rcu change
 # on e2bdb933.
 DRM_QXL 3.3
+DRM_I915 3.7
 
 # Regulator
 # Because of -EPROBE_DEFER see commit d1c3414c and note that
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
deleted file mode 100644
index 9218716..0000000
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ /dev/null
@@ -1,21 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1293,10 +1293,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
- 		drm_gem_object_unreference_unlocked(obj);
- 		return -EINVAL;
- 	}
--
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-+	down_write(&current->mm->mmap_sem);
-+	addr = do_mmap(obj->filp, 0, args->size,
-+		       PROT_READ | PROT_WRITE, MAP_SHARED,
-+		       args->offset);
-+	up_write(&current->mm->mmap_sem);
-+#else
- 	addr = vm_mmap(obj->filp, 0, args->size,
- 		       PROT_READ | PROT_WRITE, MAP_SHARED,
- 		       args->offset);
-+#endif
- 	drm_gem_object_unreference_unlocked(obj);
- 	if (IS_ERR((void *)addr))
- 		return addr;
diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/INFO b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/INFO
deleted file mode 100644
index ebc9429..0000000
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-The definition of ACPI_VIDEO_CLASS was moved from video.c
-to video.h in 3.1. Define it here to fix build for kernels older
-than 3.1.
-
diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
deleted file mode 100644
index b4dcd2a..0000000
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/gpu/drm/i915/intel_opregion.c
-+++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -250,6 +250,9 @@ static int intel_opregion_video_event(st
- 	struct acpi_bus_event *event = data;
- 	int ret = NOTIFY_OK;
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0))
-+#define ACPI_VIDEO_CLASS "video"
-+#endif
- 	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
- 		return NOTIFY_DONE;
- 
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/INFO b/patches/collateral-evolutions/drm/07-intel-gtt/INFO
deleted file mode 100644
index 427fcb7..0000000
--- a/patches/collateral-evolutions/drm/07-intel-gtt/INFO
+++ /dev/null
@@ -1,24 +0,0 @@
-Kernels older than 3.6 don't have intel_enable_gtt() exported
-and most Linux distributions have CONFIG_AGP_INTEL as built-in
-(y) and as such we don't bother to make it available as
-modular here. The change to export intel_enable_gtt() was
-made through commit 8ecd1a66 but previous to this the driver
-never called intel_enable_gtt() so we can safely assume we
-can do the same for older kernels.
-
-There should be a way to export an intel_enable_gtt() for
-kernels with CONFIG_AGP_INTEL as built-in but that itself
-is a project.
-
-commit 8ecd1a6615f0d9de6759aafe229bc1cc4ee99c7b
-Author: Daniel Vetter <daniel.vetter@ffwll.ch>
-Date:   Thu Jun 7 15:56:03 2012 +0200
-
-    drm/i915: call intel_enable_gtt
-    
-    When drm/i915 is in control of the gtt, we need to call
-    the enable function at all the relevant places ourselves.
-    
-    Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
-    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
deleted file mode 100644
index 4913df8..0000000
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4182,8 +4182,10 @@ i915_gem_init_hw(struct drm_device *dev)
- 	drm_i915_private_t *dev_priv = dev->dev_private;
- 	int ret;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
- 	if (INTEL_INFO(dev)->gen < 6 && !intel_enable_gtt())
- 		return -EIO;
-+#endif
- 
- 	if (dev_priv->ellc_size)
- 		I915_WRITE(HSW_IDICR, I915_READ(HSW_IDICR) | IDIHASHMSK(0xf));
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/INFO b/patches/collateral-evolutions/drm/08-shmem_truncate_range/INFO
deleted file mode 100644
index 3b27ff4..0000000
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/INFO
+++ /dev/null
@@ -1,27 +0,0 @@
-Backport e2377fe0b -- this could likely be implemented
-on compat.git but I'd much prefer a better review of that.
-For now this stays as a patch.
-
-commit e2377fe0b65e3c7577ff6df1701c56ef477d336f
-Author: Hugh Dickins <hughd@google.com>
-Date:   Mon Jun 27 16:18:19 2011 -0700
-
-    drm/i915: use shmem_truncate_range
-    
-    The interface to ->truncate_range is changing very slightly: once "tmpfs:
-    take control of its truncate_range" has been applied, this can be applied.
-     For now there is only a slight inefficiency while this remains unapplied,
-    but it will soon become essential for managing shmem's use of swap.
-    
-    Change i915_gem_object_truncate() to use shmem_truncate_range() directly:
-    which should also spare i915 later change if we switch from
-    inode_operations->truncate_range to file_operations->fallocate.
-    
-    Signed-off-by: Hugh Dickins <hughd@google.com>
-    Cc: Christoph Hellwig <hch@infradead.org>
-    Cc: Chris Wilson <chris@chris-wilson.co.uk>
-    Cc: Keith Packard <keithp@keithp.com>
-    Cc: Dave Airlie <airlied@redhat.com>
-    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
-    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
-
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
deleted file mode 100644
index cc25a62..0000000
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1611,7 +1611,13 @@ i915_gem_object_truncate(struct drm_i915
- 	 * backing pages, *now*.
- 	 */
- 	inode = file_inode(obj->base.filp);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
- 	shmem_truncate_range(inode, 0, (loff_t)-1);
-+#else
-+	truncate_inode_pages(inode->i_mapping, 0);
-+	if (inode->i_op->truncate_range)
-+		inode->i_op->truncate_range(inode, 0, (loff_t)-1);
-+#endif
- 
- 	obj->madv = __I915_MADV_PURGED;
- }
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index 96333f8..ec1b046 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4409,8 +4414,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4394,8 +4399,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4633,8 +4642,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4618,8 +4627,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4644,7 +4659,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4629,7 +4644,12 @@ i915_gem_inactive_count(struct shrinker
  	struct i915_address_space *vm = &dev_priv->gtt.base;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4656,6 +4676,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4641,6 +4661,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4669,6 +4700,7 @@ i915_gem_inactive_count(struct shrinker
+@@ -4654,6 +4685,7 @@ i915_gem_inactive_count(struct shrinker
  	return count;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4702,3 +4734,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4687,3 +4719,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
new file mode 100644
index 0000000..400b065
--- /dev/null
+++ b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
@@ -0,0 +1,29 @@
+--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
++++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
+@@ -859,6 +859,9 @@ static int i915_gmch_probe(struct drm_de
+ {
+ 	struct drm_i915_private *dev_priv = dev->dev_private;
+ 	int ret;
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
++	const struct intel_gtt *gtt;
++#endif
+ 
+ 	ret = intel_gmch_probe(dev_priv->bridge_dev, dev_priv->dev->pdev, NULL);
+ 	if (!ret) {
+@@ -866,7 +869,16 @@ static int i915_gmch_probe(struct drm_de
+ 		return -EIO;
+ 	}
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+ 	intel_gtt_get(gtt_total, stolen, mappable_base, mappable_end);
++#else
++	gtt = intel_gtt_get();
++
++	*gtt_total = gtt->gtt_total_entries << PAGE_SHIFT;
++	*stolen = gtt->stolen_size;
++	*mappable_base = gtt->gma_bus_addr;
++	*mappable_end = gtt->gtt_mappable_entries << PAGE_SHIFT;
++#endif
+ 
+ 	dev_priv->gtt.do_idle_maps = needs_idle_maps(dev_priv->dev);
+ 	dev_priv->gtt.base.clear_range = i915_ggtt_clear_range;
-- 
1.7.10.4

