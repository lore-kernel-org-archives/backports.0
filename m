Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] compat-drivers: refresh patches
Date: Thu, 29 Nov 2012 00:07:47 +0100
Message-Id: <1354144069-28611-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This was done by running "./scripts/admin-refresh.sh refresh".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/03-swiotlb.patch                       |    8 +--
 patches/drm/04-revert-prime-support.patch          |   22 +++---
 patches/drm/05-i915-define-acpi-video-class.patch  |    2 +-
 .../drm/09-nouveau-compatify-kconfig-vars.patch    |   72 +++++++-------------
 .../10-radeon-revert-acpi-table-size-check.patch   |    6 +-
 patches/network/0001-netdev_ops.patch              |   24 +++----
 patches/network/0002-net-misc.patch                |    4 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +-
 patches/network/04-netns.patch                     |   14 ++--
 patches/network/08-rename-config-options.patch     |   28 ++++----
 patches/network/09-cfg80211-wext-padding.patch     |    2 +-
 patches/network/09-threaded-irq.patch              |    6 +-
 .../network/10-add-wext-handlers-to-netdev.patch   |    4 +-
 patches/network/11-dev-pm-ops.patch                |    8 +--
 patches/network/12-iw_handler-changes.patch        |    2 +-
 patches/network/14-device-type.patch               |    4 +-
 patches/network/15-symbol-export-conflicts.patch   |    2 +-
 patches/network/16-bluetooth.patch                 |    6 +-
 patches/network/17-netdev-queue.patch              |    4 +-
 patches/network/25-multicast-list_head.patch       |   36 +++++-----
 patches/network/26-sdio-quirks.patch               |    4 +-
 patches/network/29-sdio_no_suspend.patch           |   22 +++---
 patches/network/30-bridge-port.patch               |    2 +-
 patches/network/36-workqueue.patch                 |    2 +-
 patches/network/40-netdev-hw-features.patch        |    8 +--
 patches/network/42-netlink_seq.patch               |    2 +-
 patches/network/46-use_other_workqueue.patch       |    2 +-
 patches/network/54-get_ts_info.patch               |    2 +-
 patches/network/62-usb_driver_lpm.patch            |   18 ++---
 29 files changed, 146 insertions(+), 174 deletions(-)

diff --git a/patches/drm/03-swiotlb.patch b/patches/drm/03-swiotlb.patch
index be09c64..697c063 100644
--- a/patches/drm/03-swiotlb.patch
+++ b/patches/drm/03-swiotlb.patch
@@ -36,7 +36,7 @@ to backport it to compat.git. So revert the changes.
  		if (ttm_dma->dma_address[i]) {
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -602,11 +602,13 @@ static int radeon_ttm_tt_populate(struct
+@@ -601,11 +601,13 @@ static int radeon_ttm_tt_populate(struct
  	}
  #endif
  
@@ -50,7 +50,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -648,12 +650,14 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -647,12 +649,14 @@ static void radeon_ttm_tt_unpopulate(str
  	}
  #endif
  
@@ -65,7 +65,7 @@ to backport it to compat.git. So revert the changes.
  
  	for (i = 0; i < ttm->num_pages; i++) {
  		if (gtt->ttm.dma_address[i]) {
-@@ -876,6 +880,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -875,6 +879,7 @@ static int radeon_ttm_debugfs_init(struc
  	radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
  	radeon_mem_types_list[i].driver_features = 0;
  	radeon_mem_types_list[i++].data = NULL;
@@ -73,7 +73,7 @@ to backport it to compat.git. So revert the changes.
  #ifdef CONFIG_SWIOTLB
  	if (swiotlb_nr_tbl()) {
  		sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
-@@ -885,6 +890,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -884,6 +889,7 @@ static int radeon_ttm_debugfs_init(struc
  		radeon_mem_types_list[i++].data = NULL;
  	}
  #endif
diff --git a/patches/drm/04-revert-prime-support.patch b/patches/drm/04-revert-prime-support.patch
index b244210..e12c396 100644
--- a/patches/drm/04-revert-prime-support.patch
+++ b/patches/drm/04-revert-prime-support.patch
@@ -21,7 +21,7 @@ not < 3.3.0.
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETCRTC, drm_mode_getcrtc, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 --- a/drivers/gpu/drm/drm_fops.c
 +++ b/drivers/gpu/drm/drm_fops.c
-@@ -267,8 +267,10 @@ static int drm_open_helper(struct inode
+@@ -283,8 +283,10 @@ static int drm_open_helper(struct inode
  	if (dev->driver->driver_features & DRIVER_GEM)
  		drm_gem_open(dev, priv);
  
@@ -32,7 +32,7 @@ not < 3.3.0.
  
  	if (dev->driver->open) {
  		ret = dev->driver->open(dev, priv);
-@@ -521,8 +523,10 @@ int drm_release(struct inode *inode, str
+@@ -537,8 +539,10 @@ int drm_release(struct inode *inode, str
  	if (dev->driver->postclose)
  		dev->driver->postclose(dev, file_priv);
  
@@ -120,7 +120,7 @@ not < 3.3.0.
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -345,8 +345,10 @@ static const struct file_operations rade
+@@ -354,8 +354,10 @@ static const struct file_operations rade
  static struct drm_driver kms_driver = {
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
@@ -133,7 +133,7 @@ not < 3.3.0.
  	.dev_priv_size = 0,
  	.load = radeon_driver_load_kms,
  	.firstopen = radeon_driver_firstopen_kms,
-@@ -381,10 +383,12 @@ static struct drm_driver kms_driver = {
+@@ -390,10 +392,12 @@ static struct drm_driver kms_driver = {
  	.dumb_destroy = radeon_mode_dumb_destroy,
  	.fops = &radeon_driver_kms_fops,
  
@@ -161,7 +161,7 @@ not < 3.3.0.
  }
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -583,17 +583,21 @@ static int radeon_ttm_tt_populate(struct
+@@ -582,17 +582,21 @@ static int radeon_ttm_tt_populate(struct
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
  	int r;
@@ -183,7 +183,7 @@ not < 3.3.0.
  
  	rdev = radeon_get_rdev(ttm->bdev);
  #if __OS_HAS_AGP
-@@ -637,10 +641,12 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -636,10 +640,12 @@ static void radeon_ttm_tt_unpopulate(str
  	struct radeon_device *rdev;
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
@@ -236,7 +236,7 @@ not < 3.3.0.
  	dev = drm->dev;
 --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -581,7 +581,10 @@ driver = {
+@@ -591,7 +591,10 @@ driver = {
  	.driver_features =
  		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
  		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
@@ -248,7 +248,7 @@ not < 3.3.0.
  
  	.load = nouveau_drm_load,
  	.unload = nouveau_drm_unload,
-@@ -602,10 +605,12 @@ driver = {
+@@ -612,10 +615,12 @@ driver = {
  	.ioctls = nouveau_ioctls,
  	.fops = &nouveau_driver_fops,
  
@@ -286,7 +286,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -967,7 +967,11 @@ static struct drm_driver driver = {
+@@ -1018,7 +1018,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -298,7 +298,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -990,10 +994,12 @@ static struct drm_driver driver = {
+@@ -1041,10 +1045,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
@@ -323,7 +323,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3776,8 +3778,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3778,8 +3780,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
diff --git a/patches/drm/05-i915-define-acpi-video-class.patch b/patches/drm/05-i915-define-acpi-video-class.patch
index 49725af..cf7eb38 100644
--- a/patches/drm/05-i915-define-acpi-video-class.patch
+++ b/patches/drm/05-i915-define-acpi-video-class.patch
@@ -4,7 +4,7 @@ than 3.1.
 
 --- a/drivers/gpu/drm/i915/intel_opregion.c
 +++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -305,6 +305,9 @@ static int intel_opregion_video_event(st
+@@ -307,6 +307,9 @@ static int intel_opregion_video_event(st
  	struct acpi_bus_event *event = data;
  	int ret = NOTIFY_OK;
  
diff --git a/patches/drm/09-nouveau-compatify-kconfig-vars.patch b/patches/drm/09-nouveau-compatify-kconfig-vars.patch
index d866006..ba46365 100644
--- a/patches/drm/09-nouveau-compatify-kconfig-vars.patch
+++ b/patches/drm/09-nouveau-compatify-kconfig-vars.patch
@@ -1,10 +1,8 @@
 Rename CONFIG_NOUVEAU_DEBUG and CONFIG_NOUVEAU_DEBUG_DEFAULT to
 CONFIG_COMPAT_*.
 
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/core/option.c
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/core/option.c
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/core/option.c
+--- a/drivers/gpu/drm/nouveau/core/core/option.c
++++ b/drivers/gpu/drm/nouveau/core/core/option.c
 @@ -86,7 +86,7 @@ nouveau_boolopt(const char *optstr, cons
  int
  nouveau_dbgopt(const char *optstr, const char *sub)
@@ -14,10 +12,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/core/option.c
  
  	while (optstr) {
  		int len = strcspn(optstr, ",=");
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/client.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/client.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/client.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/client.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/client.h
 @@ -15,7 +15,7 @@ struct nouveau_client {
  static inline struct nouveau_client *
  nv_client(void *obj)
@@ -27,10 +23,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/client.h
  	if (unlikely(!nv_iclass(obj, NV_CLIENT_CLASS)))
  		nv_assert("BAD CAST -> NvClient, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/device.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/device.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/device.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/device.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/device.h
 @@ -96,7 +96,7 @@ nv_device(void *obj)
  	if (device->parent)
  		device = device->parent;
@@ -40,10 +34,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/device.h
  	if (unlikely(!nv_iclass(device, NV_SUBDEV_CLASS) ||
  		     (nv_hclass(device) & 0xff) != NVDEV_SUBDEV_DEVICE)) {
  		nv_assert("BAD CAST -> NvDevice, 0x%08x 0x%08x",
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engctx.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/engctx.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engctx.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/engctx.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/engctx.h
 @@ -20,7 +20,7 @@ struct nouveau_engctx {
  static inline struct nouveau_engctx *
  nv_engctx(void *obj)
@@ -53,10 +45,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engctx.h
  	if (unlikely(!nv_iclass(obj, NV_ENGCTX_CLASS)))
  		nv_assert("BAD CAST -> NvEngCtx, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engine.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/engine.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engine.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/engine.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/engine.h
 @@ -22,7 +22,7 @@ struct nouveau_engine {
  static inline struct nouveau_engine *
  nv_engine(void *obj)
@@ -66,10 +56,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engine.h
  	if (unlikely(!nv_iclass(obj, NV_ENGINE_CLASS)))
  		nv_assert("BAD CAST -> NvEngine, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
 @@ -27,7 +27,7 @@ struct nouveau_gpuobj {
  static inline struct nouveau_gpuobj *
  nv_gpuobj(void *obj)
@@ -79,10 +67,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
  	if (unlikely(!nv_iclass(obj, NV_GPUOBJ_CLASS)))
  		nv_assert("BAD CAST -> NvGpuObj, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/namedb.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/namedb.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/namedb.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/namedb.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/namedb.h
 @@ -14,7 +14,7 @@ struct nouveau_namedb {
  static inline struct nouveau_namedb *
  nv_namedb(void *obj)
@@ -92,10 +78,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/namedb.h
  	if (unlikely(!nv_iclass(obj, NV_NAMEDB_CLASS)))
  		nv_assert("BAD CAST -> NvNameDB, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/object.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/object.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/object.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/object.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/object.h
 @@ -20,7 +20,7 @@ struct nouveau_object {
  	struct nouveau_object *engine;
  	atomic_t refcount;
@@ -114,10 +98,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/object.h
  	if (likely(obj)) {
  		struct nouveau_object *object = obj;
  		if (unlikely(object->_magic != NOUVEAU_OBJECT_MAGIC))
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/parent.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/parent.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/parent.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/parent.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/parent.h
 @@ -29,7 +29,7 @@ struct nouveau_parent {
  static inline struct nouveau_parent *
  nv_parent(void *obj)
@@ -127,10 +109,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/parent.h
  	if (unlikely(!(nv_iclass(obj, NV_PARENT_CLASS))))
  		nv_assert("BAD CAST -> NvParent, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/printk.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/printk.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/printk.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/printk.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/printk.h
 @@ -18,7 +18,7 @@ struct nouveau_object;
  void nv_printk_(struct nouveau_object *, const char *, int, const char *, ...);
  
@@ -149,10 +129,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/printk.h
  		nv_printk_(NULL, NV_PRINTK_FATAL, NV_DBG_FATAL, f "\n", ##a);  \
  	BUG_ON(1);                                                             \
  } while(0)
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/subdev.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/subdev.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/subdev.h
+--- a/drivers/gpu/drm/nouveau/core/include/core/subdev.h
++++ b/drivers/gpu/drm/nouveau/core/include/core/subdev.h
 @@ -20,7 +20,7 @@ struct nouveau_subdev {
  static inline struct nouveau_subdev *
  nv_subdev(void *obj)
@@ -162,10 +140,8 @@ Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/subdev.h
  	if (unlikely(!nv_iclass(obj, NV_SUBDEV_CLASS)))
  		nv_assert("BAD CAST -> NvSubDev, %08x", nv_hclass(obj));
  #endif
-Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
-+++ compat-drivers/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
+--- a/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
++++ b/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
 @@ -16,7 +16,7 @@ struct nouveau_instobj {
  static inline struct nouveau_instobj *
  nv_memobj(void *obj)
diff --git a/patches/drm/10-radeon-revert-acpi-table-size-check.patch b/patches/drm/10-radeon-revert-acpi-table-size-check.patch
index d595a98..8adaeb3 100644
--- a/patches/drm/10-radeon-revert-acpi-table-size-check.patch
+++ b/patches/drm/10-radeon-revert-acpi-table-size-check.patch
@@ -1,10 +1,8 @@
 acpi_get_table_with_size() was exported with kernels >= 3.6. Revert the
 size checking for kernels < 3.6.
 
-Index: compat-drivers/drivers/gpu/drm/radeon/radeon_bios.c
-===================================================================
---- compat-drivers.orig/drivers/gpu/drm/radeon/radeon_bios.c
-+++ compat-drivers/drivers/gpu/drm/radeon/radeon_bios.c
+--- a/drivers/gpu/drm/radeon/radeon_bios.c
++++ b/drivers/gpu/drm/radeon/radeon_bios.c
 @@ -554,12 +554,21 @@ static bool radeon_acpi_vfct_bios(struct
  {
  	bool ret = false;
diff --git a/patches/network/0001-netdev_ops.patch b/patches/network/0001-netdev_ops.patch
index 9453049..eb0c5a4 100644
--- a/patches/network/0001-netdev_ops.patch
+++ b/patches/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1420,7 +1420,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1422,7 +1422,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
@@ -60,7 +60,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1285,7 +1285,7 @@ static const struct net_device_ops ath6k
+@@ -1322,7 +1322,7 @@ static const struct net_device_ops ath6k
  
  void init_netdev(struct net_device *dev)
  {
@@ -71,7 +71,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3436,7 +3436,7 @@ static int rndis_wlan_bind(struct usbnet
+@@ -3442,7 +3442,7 @@ static int rndis_wlan_bind(struct usbnet
  	 * rndis_host wants to avoid all OID as much as possible
  	 * so do promisc/multicast handling in rndis_wlan.
  	 */
@@ -93,7 +93,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->irq = sdev->irq;
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6106,7 +6106,7 @@ static struct net_device *ipw2100_alloc_
+@@ -6103,7 +6103,7 @@ static struct net_device *ipw2100_alloc_
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
@@ -104,7 +104,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	priv->wireless_data.libipw = priv->ieee;
 --- a/drivers/net/wireless/ipw2x00/ipw2200.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2200.c
-@@ -11684,7 +11684,7 @@ static int ipw_prom_alloc(struct ipw_pri
+@@ -11690,7 +11690,7 @@ static int ipw_prom_alloc(struct ipw_pri
  	memcpy(priv->prom_net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
  
  	priv->prom_net_dev->type = ARPHRD_IEEE80211_RADIOTAP;
@@ -113,7 +113,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
  	priv->prom_priv->ieee->iw_mode = IW_MODE_MONITOR;
  	SET_NETDEV_DEV(priv->prom_net_dev, &priv->pci_dev->dev);
-@@ -11822,7 +11822,7 @@ static int __devinit ipw_pci_probe(struc
+@@ -11828,7 +11828,7 @@ static int __devinit ipw_pci_probe(struc
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
@@ -146,7 +146,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1299,7 +1299,7 @@ static const struct net_device_ops hwsim
+@@ -1601,7 +1601,7 @@ static const struct net_device_ops hwsim
  
  static void hwsim_mon_setup(struct net_device *dev)
  {
@@ -157,7 +157,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->tx_queue_len = 0;
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -663,7 +663,7 @@ static const struct net_device_ops mwifi
+@@ -645,7 +645,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
@@ -168,7 +168,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	priv->media_connected = false;
 --- a/net/bluetooth/bnep/netdev.c
 +++ b/net/bluetooth/bnep/netdev.c
-@@ -224,7 +224,7 @@ void bnep_net_setup(struct net_device *d
+@@ -223,7 +223,7 @@ void bnep_net_setup(struct net_device *d
  
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -223,7 +223,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -993,7 +993,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1008,7 +1008,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -232,7 +232,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1156,7 +1156,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1171,7 +1171,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -241,7 +241,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1191,7 +1191,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1206,7 +1206,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/network/0002-net-misc.patch b/patches/network/0002-net-misc.patch
index 1e22d60..b103c01 100644
--- a/patches/network/0002-net-misc.patch
+++ b/patches/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -994,6 +994,11 @@ static void ieee80211_if_setup(struct ne
+@@ -1009,6 +1009,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
@@ -36,7 +36,7 @@ compile tested against older kernels.
  
 --- a/net/bluetooth/bnep/netdev.c
 +++ b/net/bluetooth/bnep/netdev.c
-@@ -162,8 +162,12 @@ static int bnep_net_proto_filter(struct
+@@ -161,8 +161,12 @@ static int bnep_net_proto_filter(struct
  }
  #endif
  
diff --git a/patches/network/0003-netdev-needed_headroom_tailroom.patch b/patches/network/0003-netdev-needed_headroom_tailroom.patch
index 7322b9e..be60b19 100644
--- a/patches/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/network/0003-netdev-needed_headroom_tailroom.patch
@@ -4,7 +4,7 @@ could be used.
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1478,6 +1478,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1493,6 +1493,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -12,7 +12,7 @@ could be used.
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1486,6 +1487,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1501,6 +1502,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/network/04-netns.patch b/patches/network/04-netns.patch
index 4a8e049..1365b45 100644
--- a/patches/network/04-netns.patch
+++ b/patches/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5790,7 +5790,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -5940,7 +5940,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
@@ -34,7 +34,7 @@ files...
  
  static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
  {
-@@ -342,7 +344,9 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -344,7 +346,9 @@ struct wiphy *wiphy_new(const struct cfg
  	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
  #endif
  
@@ -44,7 +44,7 @@ files...
  
  	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
  	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-@@ -836,8 +840,10 @@ static int cfg80211_netdev_notifier_call
+@@ -843,8 +847,10 @@ static int cfg80211_netdev_notifier_call
  		wdev->identifier = ++rdev->wdev_id;
  		list_add_rcu(&wdev->list, &rdev->wdev_list);
  		rdev->devlist_generation++;
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1028,6 +1034,7 @@ static struct notifier_block cfg80211_ne
+@@ -1035,6 +1041,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1045,14 +1052,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1052,14 +1059,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1087,8 +1097,10 @@ out_fail_nl80211:
+@@ -1094,8 +1104,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1100,7 +1112,9 @@ static void __exit cfg80211_exit(void)
+@@ -1107,7 +1119,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
diff --git a/patches/network/08-rename-config-options.patch b/patches/network/08-rename-config-options.patch
index a92760a..518d233 100644
--- a/patches/network/08-rename-config-options.patch
+++ b/patches/network/08-rename-config-options.patch
@@ -30,6 +30,15 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  obj-$(CONFIG_RTL8180)		+= rtl818x/
  obj-$(CONFIG_RTL8187)		+= rtl818x/
  obj-$(CONFIG_RTLWIFI)		+= rtlwifi/
+@@ -53,7 +53,7 @@ obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211
+ 
+ obj-$(CONFIG_WL_TI)	+= ti/
+ 
+-obj-$(CONFIG_MWIFIEX)	+= mwifiex/
++obj-$(CONFIG_COMPAT_MWIFIEX)	+= mwifiex/
+ 
+ obj-$(CONFIG_BRCMFMAC)	+= brcm80211/
+ obj-$(CONFIG_BRCMSMAC)	+= brcm80211/
 --- a/drivers/net/wireless/iwlegacy/Makefile
 +++ b/drivers/net/wireless/iwlegacy/Makefile
 @@ -5,7 +5,7 @@ iwlegacy-$(CONFIG_IWLEGACY_DEBUGFS) += d
@@ -115,7 +124,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  ath9k-$(CONFIG_ATH9K_DEBUGFS) += debug.o
 --- a/drivers/net/wireless/ath/ath9k/init.c
 +++ b/drivers/net/wireless/ath/ath9k/init.c
-@@ -764,7 +764,7 @@ void ath9k_set_hw_capab(struct ath_softc
+@@ -760,7 +760,7 @@ void ath9k_set_hw_capab(struct ath_softc
  	sc->ant_rx = hw->wiphy->available_antennas_rx;
  	sc->ant_tx = hw->wiphy->available_antennas_tx;
  
@@ -126,9 +135,9 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  
 --- a/drivers/net/wireless/ath/ath9k/rc.h
 +++ b/drivers/net/wireless/ath/ath9k/rc.h
-@@ -215,7 +215,7 @@ struct ath_rate_priv {
- 	struct ath_rc_stats rcstats[RATE_TABLE_SIZE];
- };
+@@ -231,7 +231,7 @@ static inline void ath_debug_stat_retrie
+ }
+ #endif
  
 -#ifdef CONFIG_ATH9K_RATE_CONTROL
 +#ifdef CONFIG_COMPAT_ATH9K_RATE_CONTROL
@@ -165,17 +174,6 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  		lock_sock(sk);
  		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
  		release_sock(sk);
---- a/drivers/net/wireless/Makefile
-+++ b/drivers/net/wireless/Makefile
-@@ -38,7 +38,7 @@ obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211
- 
- obj-$(CONFIG_WL_TI)	+= ti/
- 
--obj-$(CONFIG_MWIFIEX)	+= mwifiex/
-+obj-$(CONFIG_COMPAT_MWIFIEX)	+= mwifiex/
- 
- obj-$(CONFIG_BRCMFMAC)	+= brcm80211/
- obj-$(CONFIG_BRCMSMAC)	+= brcm80211/
 --- a/drivers/net/wireless/mwifiex/Makefile
 +++ b/drivers/net/wireless/mwifiex/Makefile
 @@ -39,7 +39,7 @@ mwifiex-y += sta_rx.o
diff --git a/patches/network/09-cfg80211-wext-padding.patch b/patches/network/09-cfg80211-wext-padding.patch
index a0f47b3..5942cae 100644
--- a/patches/network/09-cfg80211-wext-padding.patch
+++ b/patches/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2168,6 +2168,9 @@ struct wiphy_wowlan_support {
+@@ -2259,6 +2259,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/network/09-threaded-irq.patch b/patches/network/09-threaded-irq.patch
index 929d527..a7d2fe6 100644
--- a/patches/network/09-threaded-irq.patch
+++ b/patches/network/09-threaded-irq.patch
@@ -63,7 +63,7 @@ thread in process context as well.
  /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5567,14 +5567,25 @@ static void wlcore_nvs_cb(const struct f
+@@ -5568,14 +5568,25 @@ static void wlcore_nvs_cb(const struct f
  	wl->set_power = pdata->set_power;
  	wl->if_ops = pdata->ops;
  
@@ -89,7 +89,7 @@ thread in process context as well.
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -5649,7 +5660,11 @@ out_unreg:
+@@ -5650,7 +5661,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -101,7 +101,7 @@ thread in process context as well.
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -5695,7 +5710,12 @@ int __devexit wlcore_remove(struct platf
+@@ -5696,7 +5711,12 @@ int __devexit wlcore_remove(struct platf
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/network/10-add-wext-handlers-to-netdev.patch b/patches/network/10-add-wext-handlers-to-netdev.patch
index 16074e2..d9977d7 100644
--- a/patches/network/10-add-wext-handlers-to-netdev.patch
+++ b/patches/network/10-add-wext-handlers-to-netdev.patch
@@ -18,7 +18,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -343,10 +343,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -345,10 +345,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_LIST_HEAD(&rdev->bss_list);
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
@@ -29,7 +29,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -864,6 +860,15 @@ static int cfg80211_netdev_notifier_call
+@@ -871,6 +867,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/network/11-dev-pm-ops.patch b/patches/network/11-dev-pm-ops.patch
index 2df8809..9001b52 100644
--- a/patches/network/11-dev-pm-ops.patch
+++ b/patches/network/11-dev-pm-ops.patch
@@ -109,7 +109,7 @@ calls on compat code with only slight modifications.
  module_pci_driver(ath5k_pci_driver);
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -345,14 +345,10 @@ static int ath_pci_resume(struct device
+@@ -333,14 +333,10 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -128,7 +128,7 @@ calls on compat code with only slight modifications.
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
  
-@@ -370,7 +366,12 @@ static struct pci_driver ath_pci_driver
+@@ -358,7 +354,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
@@ -210,7 +210,7 @@ calls on compat code with only slight modifications.
  
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -339,6 +339,9 @@ static int iwl_pci_resume(struct device
+@@ -338,6 +338,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -220,7 +220,7 @@ calls on compat code with only slight modifications.
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -354,7 +357,12 @@ static struct pci_driver iwl_pci_driver
+@@ -353,7 +356,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = __devexit_p(iwl_pci_remove),
diff --git a/patches/network/12-iw_handler-changes.patch b/patches/network/12-iw_handler-changes.patch
index 5b54509..5b22ef8 100644
--- a/patches/network/12-iw_handler-changes.patch
+++ b/patches/network/12-iw_handler-changes.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6109,7 +6109,11 @@ static struct net_device *ipw2100_alloc_
+@@ -6106,7 +6106,11 @@ static struct net_device *ipw2100_alloc_
  	netdev_attach_ops(dev, &ipw2100_netdev_ops);
  	dev->ethtool_ops = &ipw2100_ethtool_ops;
  	dev->wireless_handlers = &ipw2100_wx_handler_def;
diff --git a/patches/network/14-device-type.patch b/patches/network/14-device-type.patch
index cfe97b7..765a783 100644
--- a/patches/network/14-device-type.patch
+++ b/patches/network/14-device-type.patch
@@ -8,7 +8,7 @@ compile warning.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -796,9 +796,11 @@ void cfg80211_unregister_wdev(struct wir
+@@ -803,9 +803,11 @@ void cfg80211_unregister_wdev(struct wir
  }
  EXPORT_SYMBOL(cfg80211_unregister_wdev);
  
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1337,13 +1337,17 @@ static const struct net_device_ops usbne
+@@ -1339,13 +1339,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
diff --git a/patches/network/15-symbol-export-conflicts.patch b/patches/network/15-symbol-export-conflicts.patch
index b222076..a836b94 100644
--- a/patches/network/15-symbol-export-conflicts.patch
+++ b/patches/network/15-symbol-export-conflicts.patch
@@ -3,7 +3,7 @@ To avoid conflicts with the other export we rename our.
 
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -3144,7 +3144,12 @@ void ieee80211_rx(struct ieee80211_hw *h
+@@ -3203,7 +3203,12 @@ void ieee80211_rx(struct ieee80211_hw *h
   drop:
  	kfree_skb(skb);
  }
diff --git a/patches/network/16-bluetooth.patch b/patches/network/16-bluetooth.patch
index d456750..8c690ae 100644
--- a/patches/network/16-bluetooth.patch
+++ b/patches/network/16-bluetooth.patch
@@ -462,7 +462,7 @@ here still, but for now we keep this here.
  	struct rfcomm_dlc *dlc = dev->dlc;
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -432,8 +432,12 @@ static struct sock *sco_sock_alloc(struc
+@@ -433,8 +433,12 @@ static struct sock *sco_sock_alloc(struc
  	return sk;
  }
  
@@ -475,8 +475,8 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -662,7 +666,11 @@ static int sco_sock_sendmsg(struct kiocb
- 	return err;
+@@ -685,7 +689,11 @@ static int sco_sock_recvmsg(struct kiocb
+ 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
diff --git a/patches/network/17-netdev-queue.patch b/patches/network/17-netdev-queue.patch
index 9a1ef17..af10e5a 100644
--- a/patches/network/17-netdev-queue.patch
+++ b/patches/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1595,6 +1595,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1613,6 +1613,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1622,6 +1623,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1640,6 +1641,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/network/25-multicast-list_head.patch b/patches/network/25-multicast-list_head.patch
index d5c8ee2..3efa9e2 100644
--- a/patches/network/25-multicast-list_head.patch
+++ b/patches/network/25-multicast-list_head.patch
@@ -307,7 +307,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/drivers/net/wireless/mwifiex/debugfs.c
 +++ b/drivers/net/wireless/mwifiex/debugfs.c
-@@ -216,7 +216,11 @@ mwifiex_info_read(struct file *file, cha
+@@ -217,7 +217,11 @@ mwifiex_info_read(struct file *file, cha
  
  		netdev_for_each_mc_addr(ha, netdev)
  			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
@@ -321,7 +321,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2567,15 +2567,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2574,15 +2574,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -343,7 +343,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2596,13 +2602,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2603,13 +2609,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -371,7 +371,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
  	}
  
-@@ -4828,7 +4848,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -4836,7 +4856,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -383,7 +383,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -4839,7 +4863,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -4847,7 +4871,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -395,7 +395,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	return (unsigned long)cmd;
  }
-@@ -4961,7 +4989,11 @@ static void mwl8k_configure_filter(struc
+@@ -4969,7 +4997,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
@@ -480,7 +480,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	return 1; /* update */
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -1629,7 +1629,11 @@ static void set_multicast_list(struct us
+@@ -1632,7 +1632,11 @@ static void set_multicast_list(struct us
  
  		netdev_for_each_mc_addr(ha, usbdev->net)
  			memcpy(mc_addrs + i++ * ETH_ALEN,
@@ -637,7 +637,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	return hash.low | ((u64)hash.high << 32);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
-@@ -132,7 +132,11 @@ static void _brcmf_set_multicast_list(st
+@@ -95,7 +95,11 @@ static void _brcmf_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		if (!cnt)
  			break;
@@ -651,8 +651,8 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2407,7 +2407,11 @@ struct ieee80211_ops {
- 				 u32 changed);
+@@ -2494,7 +2494,11 @@ struct ieee80211_ops {
+ 	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
@@ -665,7 +665,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  				 unsigned int *total_flags,
 --- a/net/bluetooth/bnep/netdev.c
 +++ b/net/bluetooth/bnep/netdev.c
-@@ -94,8 +94,13 @@ static void bnep_net_set_mc_list(struct
+@@ -93,8 +93,13 @@ static void bnep_net_set_mc_list(struct
  		netdev_for_each_mc_addr(ha, dev) {
  			if (i == BNEP_MAX_MULTICAST_FILTERS)
  				break;
@@ -712,7 +712,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -918,7 +918,12 @@ struct ieee80211_local {
+@@ -925,7 +925,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
@@ -727,7 +727,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -728,8 +728,13 @@ static void ieee80211_do_stop(struct iee
+@@ -762,8 +762,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -905,7 +910,12 @@ static void ieee80211_set_multicast_list
+@@ -920,7 +925,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
@@ -768,7 +768,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -637,9 +641,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -642,9 +646,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
@@ -782,7 +782,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1201,7 +1201,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1238,7 +1238,11 @@ static void ath6kl_set_multicast_list(st
  	list_for_each_entry_safe(mc_filter, tmp, &vif->mc_filter, list) {
  		found = false;
  		netdev_for_each_mc_addr(ha, ndev) {
@@ -794,7 +794,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
  				found = true;
  				break;
-@@ -1235,7 +1239,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1272,7 +1276,11 @@ static void ath6kl_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		found = false;
  		list_for_each_entry(mc_filter, &vif->mc_filter, list) {
@@ -806,7 +806,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
  				found = true;
  				break;
-@@ -1250,7 +1258,11 @@ static void ath6kl_set_multicast_list(st
+@@ -1287,7 +1295,11 @@ static void ath6kl_set_multicast_list(st
  				goto out;
  			}
  
diff --git a/patches/network/26-sdio-quirks.patch b/patches/network/26-sdio-quirks.patch
index c6b19d3..0281c6b 100644
--- a/patches/network/26-sdio-quirks.patch
+++ b/patches/network/26-sdio-quirks.patch
@@ -2,7 +2,7 @@ The quirks attribute is not available on older kernels.
 
 --- a/drivers/net/wireless/libertas/if_sdio.c
 +++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -852,6 +852,7 @@ static int if_sdio_power_on(struct if_sd
+@@ -873,6 +873,7 @@ static int if_sdio_power_on(struct if_sd
  	if (ret)
  		goto release;
  
@@ -10,7 +10,7 @@ The quirks attribute is not available on older kernels.
  	/* For 1-bit transfers to the 8686 model, we need to enable the
  	 * interrupt flag in the CCCR register. Set the MMC_QUIRK_LENIENT_FN0
  	 * bit to allow access to non-vendor registers. */
-@@ -870,6 +871,7 @@ static int if_sdio_power_on(struct if_sd
+@@ -891,6 +892,7 @@ static int if_sdio_power_on(struct if_sd
  		if (ret)
  			goto disable;
  	}
diff --git a/patches/network/29-sdio_no_suspend.patch b/patches/network/29-sdio_no_suspend.patch
index 58b8360..b3654a2 100644
--- a/patches/network/29-sdio_no_suspend.patch
+++ b/patches/network/29-sdio_no_suspend.patch
@@ -13,7 +13,7 @@ suspend and resume that are not backported.
  static int ath6kl_set_sdio_pm_caps(struct ath6kl *ar)
  {
  	struct ath6kl_sdio *ar_sdio = ath6kl_sdio_priv(ar);
-@@ -956,6 +957,17 @@ static int ath6kl_sdio_resume(struct ath
+@@ -940,6 +941,17 @@ static int ath6kl_sdio_resume(struct ath
  
  	return 0;
  }
@@ -31,7 +31,7 @@ suspend and resume that are not backported.
  
  /* set the window address register (using 4-byte register access ). */
  static int ath6kl_set_addrwin_reg(struct ath6kl *ar, u32 reg_addr, u32 addr)
-@@ -1267,7 +1279,7 @@ static const struct ath6kl_hif_ops ath6k
+@@ -1251,7 +1263,7 @@ static const struct ath6kl_hif_ops ath6k
  	.stop = ath6kl_sdio_stop,
  };
  
@@ -40,7 +40,7 @@ suspend and resume that are not backported.
  
  /*
   * Empty handlers so that mmc subsystem doesn't remove us entirely during
-@@ -1417,7 +1429,9 @@ static struct sdio_driver ath6kl_sdio_dr
+@@ -1401,7 +1413,9 @@ static struct sdio_driver ath6kl_sdio_dr
  	.id_table = ath6kl_sdio_devices,
  	.probe = ath6kl_sdio_probe,
  	.remove = ath6kl_sdio_remove,
@@ -52,7 +52,7 @@ suspend and resume that are not backported.
  static int __init ath6kl_sdio_init(void)
 --- a/drivers/net/wireless/libertas/if_sdio.c
 +++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -1320,6 +1320,7 @@ static void if_sdio_remove(struct sdio_f
+@@ -1341,6 +1341,7 @@ static void if_sdio_remove(struct sdio_f
  	lbs_deb_leave(LBS_DEB_SDIO);
  }
  
@@ -60,7 +60,7 @@ suspend and resume that are not backported.
  static int if_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1378,15 +1379,18 @@ static const struct dev_pm_ops if_sdio_p
+@@ -1399,15 +1400,18 @@ static const struct dev_pm_ops if_sdio_p
  	.suspend	= if_sdio_suspend,
  	.resume		= if_sdio_resume,
  };
@@ -100,7 +100,7 @@ suspend and resume that are not backported.
  /*
   * SDIO suspend.
   *
-@@ -254,6 +257,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -255,6 +258,7 @@ static int mwifiex_sdio_resume(struct de
  
  	return 0;
  }
@@ -108,7 +108,7 @@ suspend and resume that are not backported.
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -272,10 +276,12 @@ static const struct sdio_device_id mwifi
+@@ -273,10 +277,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -121,7 +121,7 @@ suspend and resume that are not backported.
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -284,7 +290,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -285,7 +291,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
@@ -151,8 +151,8 @@ suspend and resume that are not backported.
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -542,7 +542,7 @@ static void brcmf_ops_sdio_remove(struct
- 	}
+@@ -550,7 +550,7 @@ static void brcmf_ops_sdio_remove(struct
+ 	brcmf_dbg(TRACE, "Exit\n");
  }
  
 -#ifdef CONFIG_PM_SLEEP
@@ -160,7 +160,7 @@ suspend and resume that are not backported.
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -592,7 +592,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -600,7 +600,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
  	.name = "brcmfmac",
  	.id_table = brcmf_sdmmc_ids,
diff --git a/patches/network/30-bridge-port.patch b/patches/network/30-bridge-port.patch
index f1a93f6..b4106b7 100644
--- a/patches/network/30-bridge-port.patch
+++ b/patches/network/30-bridge-port.patch
@@ -34,7 +34,7 @@ compat-drivers.
  	     ntype == NL80211_IFTYPE_P2P_CLIENT))
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1888,7 +1888,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2014,7 +2014,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/network/36-workqueue.patch b/patches/network/36-workqueue.patch
index aad2401..f7a2b1a 100644
--- a/patches/network/36-workqueue.patch
+++ b/patches/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1176,6 +1176,10 @@ static void __exit ieee80211_exit(void)
+@@ -1194,6 +1194,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/network/40-netdev-hw-features.patch b/patches/network/40-netdev-hw-features.patch
index 3206057..605e97f 100644
--- a/patches/network/40-netdev-hw-features.patch
+++ b/patches/network/40-netdev-hw-features.patch
@@ -332,7 +332,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  #endif /* ATLX_C */
 --- a/drivers/net/wireless/ath/ath6kl/main.c
 +++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1112,6 +1112,7 @@ static struct net_device_stats *ath6kl_g
+@@ -1149,6 +1149,7 @@ static struct net_device_stats *ath6kl_g
  	return &vif->net_stats;
  }
  
@@ -340,7 +340,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  static int ath6kl_set_features(struct net_device *dev,
  			       netdev_features_t features)
  {
-@@ -1144,6 +1145,7 @@ static int ath6kl_set_features(struct ne
+@@ -1181,6 +1182,7 @@ static int ath6kl_set_features(struct ne
  
  	return err;
  }
@@ -348,7 +348,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  
  static void ath6kl_set_multicast_list(struct net_device *ndev)
  {
-@@ -1291,7 +1293,9 @@ static const struct net_device_ops ath6k
+@@ -1328,7 +1330,9 @@ static const struct net_device_ops ath6k
  	.ndo_stop               = ath6kl_close,
  	.ndo_start_xmit         = ath6kl_data_tx,
  	.ndo_get_stats          = ath6kl_get_stats,
@@ -358,7 +358,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	.ndo_set_rx_mode	= ath6kl_set_multicast_list,
  };
  
-@@ -1306,7 +1310,11 @@ void init_netdev(struct net_device *dev)
+@@ -1343,7 +1347,11 @@ void init_netdev(struct net_device *dev)
  				sizeof(struct wmi_data_hdr) + HTC_HDR_LENGTH
  				+ WMI_MAX_TX_META_SZ + ATH6KL_HTC_ALIGN_BYTES;
  
diff --git a/patches/network/42-netlink_seq.patch b/patches/network/42-netlink_seq.patch
index 216e4aa..bb065ab 100644
--- a/patches/network/42-netlink_seq.patch
+++ b/patches/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -4772,7 +4772,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -4910,7 +4910,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/network/46-use_other_workqueue.patch b/patches/network/46-use_other_workqueue.patch
index 7496b8c..16fa39b 100644
--- a/patches/network/46-use_other_workqueue.patch
+++ b/patches/network/46-use_other_workqueue.patch
@@ -4,7 +4,7 @@ position before.
 
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -1691,8 +1691,12 @@ int hci_register_dev(struct hci_dev *hde
+@@ -1789,8 +1789,12 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/network/54-get_ts_info.patch b/patches/network/54-get_ts_info.patch
index 5300b17..d28b39b 100644
--- a/patches/network/54-get_ts_info.patch
+++ b/patches/network/54-get_ts_info.patch
@@ -27,7 +27,7 @@ Date:   Tue Apr 3 22:59:17 2012 +0000
 
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -908,7 +908,9 @@ static const struct ethtool_ops usbnet_e
+@@ -910,7 +910,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/network/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
index 59b34ee..02f18bb 100644
--- a/patches/network/62-usb_driver_lpm.patch
+++ b/patches/network/62-usb_driver_lpm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -452,7 +452,9 @@ static struct usb_driver ath3k_driver =
+@@ -453,7 +453,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
@@ -48,7 +48,7 @@
  module_usb_driver(bpa10x_driver);
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1222,7 +1222,9 @@ static struct usb_driver btusb_driver =
+@@ -1224,7 +1224,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
@@ -84,7 +84,7 @@
  module_usb_driver(rndis_driver);
 --- a/drivers/net/wireless/at76c50x-usb.c
 +++ b/drivers/net/wireless/at76c50x-usb.c
-@@ -2458,7 +2458,9 @@ static struct usb_driver at76_driver = {
+@@ -2453,7 +2453,9 @@ static struct usb_driver at76_driver = {
  	.probe = at76_probe,
  	.disconnect = at76_disconnect,
  	.id_table = dev_table,
@@ -96,7 +96,7 @@
  static int __init at76_mod_init(void)
 --- a/drivers/net/wireless/ath/ath6kl/usb.c
 +++ b/drivers/net/wireless/ath/ath6kl/usb.c
-@@ -1191,7 +1191,9 @@ static struct usb_driver ath6kl_usb_driv
+@@ -1201,7 +1201,9 @@ static struct usb_driver ath6kl_usb_driv
  	.disconnect = ath6kl_usb_remove,
  	.id_table = ath6kl_usb_ids,
  	.supports_autosuspend = true,
@@ -132,9 +132,9 @@
  module_usb_driver(carl9170_driver);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1538,7 +1538,9 @@ static struct usb_driver brcmf_usbdrvr =
- 	.suspend = brcmf_usb_suspend,
+@@ -1502,7 +1502,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
+ 	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
  	.disable_hub_initiated_lpm = 1,
@@ -192,7 +192,7 @@
  module_usb_driver(p54u_driver);
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3755,7 +3755,9 @@ static struct usb_driver rndis_wlan_driv
+@@ -3761,7 +3761,9 @@ static struct usb_driver rndis_wlan_driv
  	.disconnect =	usbnet_disconnect,
  	.suspend =	usbnet_suspend,
  	.resume =	usbnet_resume,
@@ -216,7 +216,7 @@
  module_usb_driver(rt2500usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1283,7 +1283,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1284,7 +1284,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
@@ -252,7 +252,7 @@
  module_usb_driver(rtl8187_driver);
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -376,7 +376,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -377,7 +377,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
-- 
1.7.10.4
