Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/24] compat-drivers: make drm patches apply again
Date: Tue, 26 Feb 2013 21:38:07 +0100
Message-Id: <1361911096-29117-16-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/01-dma_buf_ops-addition.patch              |   34 ++++-------
 .../drm/04-revert-prime-support.patch              |   62 +++++++++-----------
 .../drm/06-rename-config-options.patch             |   24 +-------
 3 files changed, 41 insertions(+), 79 deletions(-)

diff --git a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition.patch b/patches/collateral-evolutions/drm/01-dma_buf_ops-addition.patch
index 3decf0e..e3ac70c 100644
--- a/patches/collateral-evolutions/drm/01-dma_buf_ops-addition.patch
+++ b/patches/collateral-evolutions/drm/01-dma_buf_ops-addition.patch
@@ -25,31 +25,17 @@ on kernels < 3.4.
  };
  
  struct dma_buf *i915_gem_prime_export(struct drm_device *dev,
---- a/drivers/gpu/drm/nouveau/nouveau_prime.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
-@@ -132,9 +132,11 @@ static const struct dma_buf_ops nouveau_
- 	.kmap_atomic = nouveau_gem_kmap_atomic,
- 	.kunmap = nouveau_gem_kunmap,
- 	.kunmap_atomic = nouveau_gem_kunmap_atomic,
+--- a/drivers/gpu/drm/drm_prime.c
++++ b/drivers/gpu/drm/drm_prime.c
+@@ -152,9 +152,11 @@ static const struct dma_buf_ops drm_gem_
+ 	.kmap_atomic = drm_gem_dmabuf_kmap_atomic,
+ 	.kunmap = drm_gem_dmabuf_kunmap,
+ 	.kunmap_atomic = drm_gem_dmabuf_kunmap_atomic,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.mmap = nouveau_gem_prime_mmap,
- 	.vmap = nouveau_gem_prime_vmap,
- 	.vunmap = nouveau_gem_prime_vunmap,
+ 	.mmap = drm_gem_dmabuf_mmap,
+ 	.vmap = drm_gem_dmabuf_vmap,
+ 	.vunmap = drm_gem_dmabuf_vunmap,
 +#endif
  };
  
- static int
---- a/drivers/gpu/drm/radeon/radeon_prime.c
-+++ b/drivers/gpu/drm/radeon/radeon_prime.c
-@@ -133,9 +133,11 @@ const static struct dma_buf_ops radeon_d
- 	.kmap_atomic = radeon_gem_kmap_atomic,
- 	.kunmap = radeon_gem_kunmap,
- 	.kunmap_atomic = radeon_gem_kunmap_atomic,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.mmap = radeon_gem_prime_mmap,
- 	.vmap = radeon_gem_prime_vmap,
- 	.vunmap = radeon_gem_prime_vunmap,
-+#endif
- };
- 
- static int radeon_prime_create(struct drm_device *dev,
+ /**
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 8747b0e..bf88e15 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -82,26 +82,26 @@ not < 3.3.0.
  #include <linux/export.h>
  #include <linux/dma-buf.h>
  #include <drm/drmP.h>
-@@ -350,3 +352,4 @@ void drm_prime_remove_imported_buf_handl
+@@ -536,3 +538,4 @@ void drm_prime_remove_imported_buf_handl
  	mutex_unlock(&prime_fpriv->lock);
  }
  EXPORT_SYMBOL(drm_prime_remove_imported_buf_handle);
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
-@@ -24,6 +24,7 @@
- 
- #include <linux/dma-buf.h>
+@@ -22,6 +22,8 @@
+  * Authors: Dave Airlie
+  */
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
++
  #include <drm/drmP.h>
  
  #include "nouveau_drm.h"
-@@ -225,4 +226,4 @@ fail_detach:
- 	dma_buf_detach(dma_buf, attach);
- 	return ERR_PTR(ret);
+@@ -93,3 +95,4 @@ int nouveau_gem_prime_pin(struct drm_gem
+ 
+ 	return 0;
  }
--
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/radeon/radeon_prime.c
 +++ b/drivers/gpu/drm/radeon/radeon_prime.c
@@ -113,14 +113,14 @@ not < 3.3.0.
  #include <drm/drmP.h>
  
  #include "radeon.h"
-@@ -226,3 +227,4 @@ fail_detach:
- 	dma_buf_detach(dma_buf, attach);
- 	return ERR_PTR(ret);
+@@ -96,3 +97,4 @@ int radeon_gem_prime_pin(struct drm_gem_
+ 
+ 	return 0;
  }
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -359,8 +359,10 @@ static const struct file_operations rade
+@@ -373,8 +373,10 @@ static const struct file_operations rade
  static struct drm_driver kms_driver = {
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
@@ -133,15 +133,18 @@ not < 3.3.0.
  	.dev_priv_size = 0,
  	.load = radeon_driver_load_kms,
  	.firstopen = radeon_driver_firstopen_kms,
-@@ -395,10 +397,12 @@ static struct drm_driver kms_driver = {
+@@ -409,6 +411,7 @@ static struct drm_driver kms_driver = {
  	.dumb_destroy = radeon_mode_dumb_destroy,
  	.fops = &radeon_driver_kms_fops,
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
- 	.gem_prime_export = radeon_gem_prime_export,
- 	.gem_prime_import = radeon_gem_prime_import,
+ 	.gem_prime_export = drm_gem_prime_export,
+@@ -418,6 +421,7 @@ static struct drm_driver kms_driver = {
+ 	.gem_prime_import_sg_table = radeon_gem_prime_import_sg_table,
+ 	.gem_prime_vmap = radeon_gem_prime_vmap,
+ 	.gem_prime_vunmap = radeon_gem_prime_vunmap,
 +#endif
  
  	.name = DRIVER_NAME,
@@ -236,7 +239,7 @@ not < 3.3.0.
  	dev = drm->dev;
 --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -627,7 +627,10 @@ driver = {
+@@ -630,7 +630,10 @@ driver = {
  	.driver_features =
  		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
  		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
@@ -248,32 +251,25 @@ not < 3.3.0.
  
  	.load = nouveau_drm_load,
  	.unload = nouveau_drm_unload,
-@@ -648,10 +651,12 @@ driver = {
+@@ -651,6 +654,7 @@ driver = {
  	.ioctls = nouveau_ioctls,
  	.fops = &nouveau_driver_fops,
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
- 	.gem_prime_export = nouveau_gem_prime_export,
- 	.gem_prime_import = nouveau_gem_prime_import,
+ 	.gem_prime_export = drm_gem_prime_export,
+@@ -660,6 +664,7 @@ driver = {
+ 	.gem_prime_import_sg_table = nouveau_gem_prime_import_sg_table,
+ 	.gem_prime_vmap = nouveau_gem_prime_vmap,
+ 	.gem_prime_vunmap = nouveau_gem_prime_vunmap,
 +#endif
  
  	.gem_init_object = nouveau_gem_object_new,
  	.gem_free_object = nouveau_gem_object_del,
 --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
-@@ -24,7 +24,9 @@
-  *
-  */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
- #include <linux/dma-buf.h>
-+#endif
- 
- #include <subdev/fb.h>
- 
-@@ -57,8 +59,10 @@ nouveau_gem_object_del(struct drm_gem_ob
+@@ -55,8 +55,10 @@ nouveau_gem_object_del(struct drm_gem_ob
  		nouveau_bo_unpin(nvbo);
  	}
  
@@ -286,7 +282,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -1018,7 +1018,11 @@ static struct drm_driver driver = {
+@@ -1022,7 +1022,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -298,7 +294,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -1041,10 +1045,12 @@ static struct drm_driver driver = {
+@@ -1045,10 +1049,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
@@ -323,7 +319,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3819,8 +3821,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3812,8 +3814,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
diff --git a/patches/collateral-evolutions/drm/06-rename-config-options.patch b/patches/collateral-evolutions/drm/06-rename-config-options.patch
index 13ee755..3f43c97 100644
--- a/patches/collateral-evolutions/drm/06-rename-config-options.patch
+++ b/patches/collateral-evolutions/drm/06-rename-config-options.patch
@@ -124,7 +124,7 @@
 +obj-$(CONFIG_COMPAT_DRM_I810)	+= i810.o
 --- a/drivers/gpu/drm/i915/Makefile
 +++ b/drivers/gpu/drm/i915/Makefile
-@@ -47,6 +47,6 @@ i915-$(CONFIG_COMPAT)   += i915_ioc32.o
+@@ -48,6 +48,6 @@ i915-$(CONFIG_COMPAT)   += i915_ioc32.o
  
  i915-$(CONFIG_ACPI)	+= intel_acpi.o
  
@@ -164,7 +164,7 @@
  #else
 --- a/drivers/gpu/drm/radeon/Makefile
 +++ b/drivers/gpu/drm/radeon/Makefile
-@@ -78,6 +78,6 @@ radeon-$(CONFIG_COMPAT) += radeon_ioc32.
+@@ -82,6 +82,6 @@ radeon-$(CONFIG_COMPAT) += radeon_ioc32.
  radeon-$(CONFIG_VGA_SWITCHEROO) += radeon_atpx_handler.o
  radeon-$(CONFIG_ACPI) += radeon_acpi.o
  
@@ -172,26 +172,6 @@
 +obj-$(CONFIG_COMPAT_DRM_RADEON)+= radeon.o
  
  CFLAGS_radeon_trace_points.o := -I$(src)
---- a/drivers/gpu/drm/radeon/radeon_drv.c
-+++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -231,7 +231,7 @@ static struct pci_device_id pciidlist[]
- 	radeon_PCI_IDS
- };
- 
--#if defined(CONFIG_DRM_RADEON_KMS)
-+#if defined(CONFIG_COMPAT_DRM_RADEON_KMS)
- MODULE_DEVICE_TABLE(pci, pciidlist);
- #endif
- 
-@@ -445,7 +445,7 @@ static int __init radeon_init(void)
- #endif
- 	/* if enabled by default */
- 	if (radeon_modeset == -1) {
--#ifdef CONFIG_DRM_RADEON_KMS
-+#ifdef CONFIG_COMPAT_DRM_RADEON_KMS
- 		DRM_INFO("radeon defaulting to kernel modesetting.\n");
- 		radeon_modeset = 1;
- #else
 --- a/drivers/gpu/drm/ttm/Makefile
 +++ b/drivers/gpu/drm/ttm/Makefile
 @@ -11,4 +11,4 @@ ifeq ($(CONFIG_SWIOTLB),y)
-- 
1.7.10.4
