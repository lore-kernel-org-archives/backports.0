Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:39999 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161970Ab3DEQij (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 12:38:39 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so1657388dak.11
        for <backports@vger.kernel.org>; Fri, 05 Apr 2013 09:38:38 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/5] backports: remove dma-buf patches
Date: Fri,  5 Apr 2013 09:38:17 -0700
Message-Id: <1365179899-7984-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130405_183841_724936_69607AD3)
In-Reply-To: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

These are no longer needed given that dma-buf is
now backported.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/01-dma_buf_ops-addition/INFO               |   10 ------
 .../drivers_gpu_drm_drm_prime.patch                |   14 --------
 .../drivers_gpu_drm_i915_i915_gem_dmabuf.patch     |   17 ---------
 .../drm/04-revert-prime-support/INFO               |    8 -----
 .../drivers_gpu_drm_drm_drv.patch                  |   13 -------
 .../drivers_gpu_drm_drm_fops.patch                 |   24 -------------
 .../drivers_gpu_drm_drm_gem.patch                  |   28 ---------------
 .../drivers_gpu_drm_drm_prime.patch                |   16 ---------
 .../drivers_gpu_drm_i915_i915_drv.patch            |   27 --------------
 .../drivers_gpu_drm_i915_i915_gem.patch            |   23 ------------
 .../drivers_gpu_drm_i915_i915_gem_dmabuf.patch     |   15 --------
 .../drivers_gpu_drm_nouveau_nouveau_bo.patch       |   38 --------------------
 .../drivers_gpu_drm_nouveau_nouveau_drm.patch      |   30 ----------------
 .../drivers_gpu_drm_nouveau_nouveau_gem.patch      |   13 -------
 .../drivers_gpu_drm_nouveau_nouveau_prime.patch    |   16 ---------
 .../drivers_gpu_drm_radeon_radeon_drv.patch        |   31 ----------------
 .../drivers_gpu_drm_radeon_radeon_gem.patch        |   13 -------
 .../drivers_gpu_drm_radeon_radeon_prime.patch      |   15 --------
 .../drivers_gpu_drm_radeon_radeon_ttm.patch        |   37 -------------------
 19 files changed, 388 deletions(-)
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/INFO
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_drm_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/INFO
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_fops.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_drm.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_ttm.patch

diff --git a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/INFO b/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/INFO
deleted file mode 100644
index d46c6b1..0000000
--- a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/INFO
+++ /dev/null
@@ -1,10 +0,0 @@
-Assign vmap, vunmap and mmap fields in dma_buf_ops structs only
-if kernel version >= 3.5.0 as they are added in 3.5. The begin_cpu_access
-was added as of the original dma-buf code via 3.4.
-
-mcgrof@frijol ~/linux-next (git::master)$ git describe --contains fc13020e086bfedf2afb95c91c026d5af1f80107
-v3.4-rc1~57^2~3
-
-Note that the dma-buf itself was added with 3.4. It is not available
-on kernels < 3.4. 
-
diff --git a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_drm_prime.patch b/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_drm_prime.patch
deleted file mode 100644
index cb332ca..0000000
--- a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_drm_prime.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/gpu/drm/drm_prime.c
-+++ b/drivers/gpu/drm/drm_prime.c
-@@ -152,9 +152,11 @@
- 	.kmap_atomic = drm_gem_dmabuf_kmap_atomic,
- 	.kunmap = drm_gem_dmabuf_kunmap,
- 	.kunmap_atomic = drm_gem_dmabuf_kunmap_atomic,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.mmap = drm_gem_dmabuf_mmap,
- 	.vmap = drm_gem_dmabuf_vmap,
- 	.vunmap = drm_gem_dmabuf_vunmap,
-+#endif
- };
- 
- /**
diff --git a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_i915_i915_gem_dmabuf.patch b/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
deleted file mode 100644
index 48a2537..0000000
--- a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem_dmabuf.c
-+++ b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
-@@ -216,10 +216,14 @@
- 	.kmap_atomic = i915_gem_dmabuf_kmap_atomic,
- 	.kunmap = i915_gem_dmabuf_kunmap,
- 	.kunmap_atomic = i915_gem_dmabuf_kunmap_atomic,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.mmap = i915_gem_dmabuf_mmap,
- 	.vmap = i915_gem_dmabuf_vmap,
- 	.vunmap = i915_gem_dmabuf_vunmap,
-+#endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	.begin_cpu_access = i915_gem_begin_cpu_access,
-+#endif
- };
- 
- struct dma_buf *i915_gem_prime_export(struct drm_device *dev,
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/INFO b/patches/collateral-evolutions/drm/04-revert-prime-support/INFO
deleted file mode 100644
index 94cafb7..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/INFO
+++ /dev/null
@@ -1,8 +0,0 @@
-Disable PRIME support in core drm, radeon, nouveau and i915 for
-kernels < 3.4.0.
-
-PRIME depends on dma-buf which is added to the kernel with 3.3 but
-the one in 3.3 is mostly stub, e.g. it is a skeleton API which
-is highly modified in 3.4. So disable PRIME for kernels < 3.4.0,
-not < 3.3.0.
-
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_drv.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_drv.patch
deleted file mode 100644
index 36b1730..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_drv.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/drm_drv.c
-+++ b/drivers/gpu/drm/drm_drv.c
-@@ -137,8 +137,10 @@
- 
- 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	DRM_IOCTL_DEF(DRM_IOCTL_PRIME_HANDLE_TO_FD, drm_prime_handle_to_fd_ioctl, DRM_AUTH|DRM_UNLOCKED),
- 	DRM_IOCTL_DEF(DRM_IOCTL_PRIME_FD_TO_HANDLE, drm_prime_fd_to_handle_ioctl, DRM_AUTH|DRM_UNLOCKED),
-+#endif
- 
- 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETPLANERESOURCES, drm_mode_getplane_res, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
- 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETCRTC, drm_mode_getcrtc, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_fops.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_fops.patch
deleted file mode 100644
index b847d9e..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_fops.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/gpu/drm/drm_fops.c
-+++ b/drivers/gpu/drm/drm_fops.c
-@@ -284,8 +284,10 @@
- 	if (dev->driver->driver_features & DRIVER_GEM)
- 		drm_gem_open(dev, priv);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (drm_core_check_feature(dev, DRIVER_PRIME))
- 		drm_prime_init_file_private(&priv->prime);
-+#endif
- 
- 	if (dev->driver->open) {
- 		ret = dev->driver->open(dev, priv);
-@@ -538,8 +540,10 @@
- 	if (dev->driver->postclose)
- 		dev->driver->postclose(dev, file_priv);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (drm_core_check_feature(dev, DRIVER_PRIME))
- 		drm_prime_destroy_file_private(&file_priv->prime);
-+#endif
- 
- 	put_pid(file_priv->pid);
- 	kfree(file_priv);
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_gem.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_gem.patch
deleted file mode 100644
index 322739c..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_gem.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/gpu/drm/drm_gem.c
-+++ b/drivers/gpu/drm/drm_gem.c
-@@ -35,7 +35,9 @@
- #include <linux/mman.h>
- #include <linux/pagemap.h>
- #include <linux/shmem_fs.h>
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- #include <linux/dma-buf.h>
-+#endif
- #include <drm/drmP.h>
- 
- /** @file drm_gem.c
-@@ -204,6 +206,7 @@
- static void
- drm_gem_remove_prime_handles(struct drm_gem_object *obj, struct drm_file *filp)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (obj->import_attach) {
- 		drm_prime_remove_imported_buf_handle(&filp->prime,
- 				obj->import_attach->dmabuf);
-@@ -212,6 +215,7 @@
- 		drm_prime_remove_imported_buf_handle(&filp->prime,
- 				obj->export_dma_buf);
- 	}
-+#endif
- }
- 
- /**
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_prime.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_prime.patch
deleted file mode 100644
index f440d6d..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_prime.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/gpu/drm/drm_prime.c
-+++ b/drivers/gpu/drm/drm_prime.c
-@@ -26,6 +26,8 @@
-  *
-  */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+
- #include <linux/export.h>
- #include <linux/dma-buf.h>
- #include <drm/drmP.h>
-@@ -532,3 +534,4 @@
- 	mutex_unlock(&prime_fpriv->lock);
- }
- EXPORT_SYMBOL(drm_prime_remove_imported_buf_handle);
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_drv.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_drv.patch
deleted file mode 100644
index 6b9ae9d..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_drv.patch
+++ /dev/null
@@ -1,27 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_drv.c
-+++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -1058,7 +1058,11 @@
- 	 */
- 	.driver_features =
- 	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM | DRIVER_PRIME,
-+#else
-+	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM,
-+#endif
- 	.load = i915_driver_load,
- 	.unload = i915_driver_unload,
- 	.open = i915_driver_open,
-@@ -1081,10 +1085,12 @@
- 	.gem_free_object = i915_gem_free_object,
- 	.gem_vm_ops = &i915_gem_vm_ops,
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
- 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
- 	.gem_prime_export = i915_gem_prime_export,
- 	.gem_prime_import = i915_gem_prime_import,
-+#endif
- 
- 	.dumb_create = i915_gem_dumb_create,
- 	.dumb_map_offset = i915_gem_mmap_gtt,
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem.patch
deleted file mode 100644
index 4182342..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem.patch
+++ /dev/null
@@ -1,23 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -34,7 +34,9 @@
- #include <linux/slab.h>
- #include <linux/swap.h>
- #include <linux/pci.h>
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- #include <linux/dma-buf.h>
-+#endif
- 
- static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
- static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3825,8 +3827,10 @@
- 
- 	BUG_ON(obj->pages);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (obj->base.import_attach)
- 		drm_prime_gem_destroy(&obj->base, NULL);
-+#endif
- 
- 	drm_gem_object_release(&obj->base);
- 	i915_gem_info_remove_obj(dev_priv, obj->base.size);
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem_dmabuf.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
deleted file mode 100644
index 8cc6e02..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem_dmabuf.c
-+++ b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
-@@ -23,6 +23,7 @@
-  * Authors:
-  *	Dave Airlie <airlied@redhat.com>
-  */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- #include <drm/drmP.h>
- #include "i915_drv.h"
- #include <linux/dma-buf.h>
-@@ -307,3 +308,4 @@
- 	dma_buf_detach(dma_buf, attach);
- 	return ERR_PTR(ret);
- }
-+#endif
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_bo.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_bo.patch
deleted file mode 100644
index d4c4fee..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_bo.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/drivers/gpu/drm/nouveau/nouveau_bo.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1352,11 +1352,14 @@
- 	struct drm_device *dev;
- 	unsigned i;
- 	int r;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
-+#endif
- 
- 	if (ttm->state != tt_unpopulated)
- 		return 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (slave && ttm->sg) {
- 		/* make userspace faulting work */
- 		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-@@ -1364,6 +1367,7 @@
- 		ttm->state = tt_unbound;
- 		return 0;
- 	}
-+#endif
- 
- 	drm = nouveau_bdev(ttm->bdev);
- 	dev = drm->dev;
-@@ -1411,10 +1415,12 @@
- 	struct nouveau_drm *drm;
- 	struct drm_device *dev;
- 	unsigned i;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
- 
- 	if (slave)
- 		return;
-+#endif
- 
- 	drm = nouveau_bdev(ttm->bdev);
- 	dev = drm->dev;
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_drm.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_drm.patch
deleted file mode 100644
index c2dcb6c..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_drm.patch
+++ /dev/null
@@ -1,30 +0,0 @@
---- a/drivers/gpu/drm/nouveau/nouveau_drm.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -662,7 +662,10 @@
- 	.driver_features =
- 		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
- 		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
--		DRIVER_MODESET | DRIVER_PRIME,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+		DRIVER_PRIME |
-+#endif
-+		DRIVER_MODESET,
- 
- 	.load = nouveau_drm_load,
- 	.unload = nouveau_drm_unload,
-@@ -688,6 +691,7 @@
- 	.ioctls = nouveau_ioctls,
- 	.fops = &nouveau_driver_fops,
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
- 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
- 	.gem_prime_export = drm_gem_prime_export,
-@@ -697,6 +701,7 @@
- 	.gem_prime_import_sg_table = nouveau_gem_prime_import_sg_table,
- 	.gem_prime_vmap = nouveau_gem_prime_vmap,
- 	.gem_prime_vunmap = nouveau_gem_prime_vunmap,
-+#endif
- 
- 	.gem_init_object = nouveau_gem_object_new,
- 	.gem_free_object = nouveau_gem_object_del,
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_gem.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_gem.patch
deleted file mode 100644
index 7795a12..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_gem.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/nouveau/nouveau_gem.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
-@@ -55,8 +55,10 @@
- 		nouveau_bo_unpin(nvbo);
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (gem->import_attach)
- 		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-+#endif
- 
- 	ttm_bo_unref(&bo);
- 
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_prime.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_prime.patch
deleted file mode 100644
index e4765b3..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_prime.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/gpu/drm/nouveau/nouveau_prime.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
-@@ -22,6 +22,8 @@
-  * Authors: Dave Airlie
-  */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+
- #include <drm/drmP.h>
- 
- #include "nouveau_drm.h"
-@@ -93,3 +95,4 @@
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_drv.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_drv.patch
deleted file mode 100644
index 0ad62d6..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_drv.patch
+++ /dev/null
@@ -1,31 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_drv.c
-+++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -374,8 +374,10 @@
- static struct drm_driver kms_driver = {
- 	.driver_features =
- 	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
--	    DRIVER_HAVE_IRQ | DRIVER_HAVE_DMA | DRIVER_IRQ_SHARED | DRIVER_GEM |
--	    DRIVER_PRIME,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+	    DRIVER_PRIME |
-+#endif
-+	    DRIVER_HAVE_IRQ | DRIVER_HAVE_DMA | DRIVER_IRQ_SHARED | DRIVER_GEM,
- 	.dev_priv_size = 0,
- 	.load = radeon_driver_load_kms,
- 	.firstopen = radeon_driver_firstopen_kms,
-@@ -410,6 +412,7 @@
- 	.dumb_destroy = radeon_mode_dumb_destroy,
- 	.fops = &radeon_driver_kms_fops,
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
- 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
- 	.gem_prime_export = drm_gem_prime_export,
-@@ -419,6 +422,7 @@
- 	.gem_prime_import_sg_table = radeon_gem_prime_import_sg_table,
- 	.gem_prime_vmap = radeon_gem_prime_vmap,
- 	.gem_prime_vunmap = radeon_gem_prime_vunmap,
-+#endif
- 
- 	.name = DRIVER_NAME,
- 	.desc = DRIVER_DESC,
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_gem.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_gem.patch
deleted file mode 100644
index 457d8d2..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_gem.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_gem.c
-+++ b/drivers/gpu/drm/radeon/radeon_gem.c
-@@ -41,8 +41,10 @@
- 	struct radeon_bo *robj = gem_to_radeon_bo(gobj);
- 
- 	if (robj) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 		if (robj->gem_base.import_attach)
- 			drm_prime_gem_destroy(&robj->gem_base, robj->tbo.sg);
-+#endif
- 		radeon_bo_unref(&robj);
- 	}
- }
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_prime.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_prime.patch
deleted file mode 100644
index 291eea6..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_prime.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_prime.c
-+++ b/drivers/gpu/drm/radeon/radeon_prime.c
-@@ -23,6 +23,7 @@
-  *
-  * Authors: Alex Deucher
-  */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- #include <drm/drmP.h>
- 
- #include "radeon.h"
-@@ -96,3 +97,4 @@
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_ttm.patch b/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_ttm.patch
deleted file mode 100644
index 4bbabe3..0000000
--- a/patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_ttm.patch
+++ /dev/null
@@ -1,37 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_ttm.c
-+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -584,17 +584,21 @@
- 	struct radeon_ttm_tt *gtt = (void *)ttm;
- 	unsigned i;
- 	int r;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
-+#endif
- 
- 	if (ttm->state != tt_unpopulated)
- 		return 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	if (slave && ttm->sg) {
- 		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
- 						 gtt->ttm.dma_address, ttm->num_pages);
- 		ttm->state = tt_unbound;
- 		return 0;
- 	}
-+#endif
- 
- 	rdev = radeon_get_rdev(ttm->bdev);
- #if __OS_HAS_AGP
-@@ -638,10 +642,12 @@
- 	struct radeon_device *rdev;
- 	struct radeon_ttm_tt *gtt = (void *)ttm;
- 	unsigned i;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
- 
- 	if (slave)
- 		return;
-+#endif
- 
- 	rdev = radeon_get_rdev(ttm->bdev);
- #if __OS_HAS_AGP
-- 
1.7.10.4

