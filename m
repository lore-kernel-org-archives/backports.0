Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35131 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3JWSYw (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:24:52 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/18] backports: remove DRM driver
Date: Wed, 23 Oct 2013 20:24:08 +0200
Message-Id: <1382552665-15678-2-git-send-email-hauke@hauke-m.de> (sfid-20131023_202455_621243_F5AFE084)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Maintaining the DRM driver takes a lot of recourses as there they are
depending on many API changes done to the core kernel code and
currently we do not have that many recourses to follow them. On the
other side one needs also new userspace drivers to make use of the new
features added to the DRM kernel drivers and it is not easy to update
the X drivers. Therefore we came to the conclusion to remove the drm
drivers for now.

There were also some problems with some DRM drivers, like the Intel
i915 driver caused kernel panic on some systems and was probably only
usable on some very recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                             |    1 -
 backport/Kconfig                                   |    2 -
 backport/Makefile.kernel                           |    2 -
 backport/defconfigs/drm                            |   49 ---------
 copy-list                                          |   37 -------
 dependencies                                       |   18 ---
 .../drm/0001-fb-info-vt_switch/INFO                |   44 --------
 .../drivers_gpu_drm_i915_intel_fb.patch            |   11 --
 .../drm/02-revert-vm_mmap/INFO                     |    5 -
 .../drivers_gpu_drm_drm_bufs.patch                 |   31 ------
 .../drivers_gpu_drm_i810_i810_dma.patch            |   37 -------
 .../10-radeon-revert-acpi-table-size-check/INFO    |    3 -
 .../drivers_gpu_drm_radeon_radeon_bios.patch       |   24 ----
 .../drivers_gpu_drm_drm_modes.patch                |   15 ---
 .../drm/12-revert-remove_proc_subtree/INFO         |   25 -----
 .../drivers_gpu_drm_drm_proc.patch                 |   62 -----------
 .../drm/13-nouveau-include-fix/INFO                |    2 -
 .../drivers_gpu_drm_nouveau_Makefile.patch         |   11 --
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |  116 --------------------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |  105 ------------------
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |   29 -----
 .../drm/16-remove-energy-read/i915.patch           |   28 -----
 .../drivers_gpu_drm_drm_sysfs.patch                |   14 ---
 23 files changed, 671 deletions(-)
 delete mode 100644 backport/defconfigs/drm
 delete mode 100644 patches/collateral-evolutions/drm/0001-fb-info-vt_switch/INFO
 delete mode 100644 patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/INFO
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
 delete mode 100644 patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/INFO
 delete mode 100644 patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
 delete mode 100644 patches/collateral-evolutions/drm/11-videomode-includes/drivers_gpu_drm_drm_modes.patch
 delete mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
 delete mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
 delete mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
 delete mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
 delete mode 100644 patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
 delete mode 100644 patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch

diff --git a/README b/README
index eacd116..9f7f1d6 100644
--- a/README
+++ b/README
@@ -8,7 +8,6 @@ down to older kernels. It currently backports the following subsystems:
   * Bluetooth
   * NFC
   * ieee802154
-  * GPU
   * Media
   * Regulator
 
diff --git a/backport/Kconfig b/backport/Kconfig
index 64a5f8b..0e24c79 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -36,8 +36,6 @@ source drivers/net/usb/Kconfig
 source drivers/ssb/Kconfig
 source drivers/bcma/Kconfig
 
-source drivers/gpu/drm/Kconfig
-
 source net/nfc/Kconfig
 
 source drivers/regulator/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index ca75ce1..0a2a569 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -8,7 +8,6 @@ NOSTDINC_FLAGS := \
 	-I$(M)/backport-include/uapi \
 	-I$(M)/include/ \
 	-I$(M)/include/uapi \
-	-I$(M)/include/drm \
 	-include $(M)/backport-include/backport/backport.h \
 	$(call backport-cc-disable-warning, unused-but-set-variable) \
 	-DBACKPORTS_VERSION=\"$(BACKPORTS_VERSION)\" \
@@ -30,7 +29,6 @@ obj-$(CPTCFG_SSB) += drivers/ssb/
 obj-$(CPTCFG_BCMA) += drivers/bcma/
 obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
-obj-$(CPTCFG_DRM) += drivers/gpu/drm/
 obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
diff --git a/backport/defconfigs/drm b/backport/defconfigs/drm
deleted file mode 100644
index 810b9e6..0000000
--- a/backport/defconfigs/drm
+++ /dev/null
@@ -1,49 +0,0 @@
-CPTCFG_DRM=y
-CPTCFG_DRM_USB=y
-CPTCFG_DRM_KMS_HELPER=y
-CPTCFG_DRM_LOAD_EDID_FIRMWARE=y
-CPTCFG_DRM_TTM=y
-CPTCFG_DRM_GEM_CMA_HELPER=y
-CPTCFG_DRM_KMS_CMA_HELPER=y
-CPTCFG_DRM_TDFX=y
-CPTCFG_DRM_R128=y
-CPTCFG_DRM_RADEON=y
-CPTCFG_DRM_I810=y
-CPTCFG_DRM_I915=y
-CPTCFG_DRM_I915_KMS=y
-CPTCFG_DRM_MGA=y
-CPTCFG_DRM_SIS=y
-CPTCFG_DRM_VIA=y
-CPTCFG_DRM_SAVAGE=y
-CPTCFG_DRM_I2C_CH7006=y
-CPTCFG_DRM_I2C_SIL164=y
-CPTCFG_DRM_I2C_NXP_TDA998X=y
-CPTCFG_DRM_RADEON_UMS=y
-CPTCFG_DRM_NOUVEAU=y
-CPTCFG_DRM_NOUVEAU_BACKLIGHT=y
-CPTCFG_DRM_EXYNOS=y
-CPTCFG_DRM_EXYNOS_IOMMU=y
-CPTCFG_DRM_EXYNOS_DMABUF=y
-CPTCFG_DRM_EXYNOS_FIMD=y
-CPTCFG_DRM_EXYNOS_HDMI=y
-CPTCFG_DRM_EXYNOS_VIDI=y
-CPTCFG_DRM_EXYNOS_G2D=y
-CPTCFG_DRM_EXYNOS_IPP=y
-CPTCFG_DRM_EXYNOS_FIMC=y
-CPTCFG_DRM_EXYNOS_ROTATOR=y
-CPTCFG_DRM_EXYNOS_GSC=y
-CPTCFG_DRM_VMWGFX=y
-CPTCFG_DRM_VMWGFX_FBCON=y
-CPTCFG_DRM_GMA500=y
-CPTCFG_DRM_GMA600=y
-CPTCFG_DRM_GMA3600=y
-CPTCFG_DRM_MEDFIELD=y
-CPTCFG_DRM_UDL=y
-CPTCFG_DRM_AST=y
-CPTCFG_DRM_MGAG200=y
-CPTCFG_DRM_CIRRUS_QEMU=y
-CPTCFG_DRM_SHMOBILE=y
-CPTCFG_DRM_TEGRA=y
-CPTCFG_DRM_TEGRA_DEBUG=y
-CPTCFG_DRM_OMAP=y
-CPTCFG_DRM_TILCDC=y
diff --git a/copy-list b/copy-list
index 8f5116a..b741c5d 100644
--- a/copy-list
+++ b/copy-list
@@ -115,43 +115,6 @@ drivers/net/usb/cdc_ncm.c
 drivers/net/usb/sierra_net.c
 drivers/net/usb/qmi_wwan.c
 
-# DRM
-include/drm/drm_agpsupport.h
-include/drm/drm_buffer.h
-include/drm/drm_cache.h
-include/drm/drm_core.h
-include/drm/drm_crtc.h
-include/drm/drm_crtc_helper.h
-include/drm/drm_dp_helper.h
-include/drm/drm_edid.h
-include/drm/drm_encoder_slave.h
-include/drm/drm_flip_work.h
-include/drm/drm_fb_cma_helper.h
-include/drm/drm_fb_helper.h
-include/drm/drm_fixed.h
-include/drm/drm_gem_cma_helper.h
-include/drm/drm_global.h
-include/drm/drm_hashtab.h
-include/drm/drm_memory.h
-include/drm/drm_mem_util.h
-include/drm/drm_mm.h
-include/drm/drm_os_linux.h
-include/drm/drm_pciids.h
-include/drm/drmP.h
-include/drm/drm_rect.h
-include/drm/drm_sysfs.h
-include/drm/drm_usb.h
-include/drm/drm_vma_manager.h
-include/drm/exynos_drm.h
-include/drm/gma_drm.h
-include/drm/i915_drm.h
-include/drm/i915_powerwell.h
-include/drm/i2c/
-include/drm/ttm/
-include/uapi/drm/
-drivers/platform/x86/intel_ips.h
-drivers/gpu/drm/
-
 # NFC core
 net/nfc/
 include/net/nfc/
diff --git a/dependencies b/dependencies
index 142ea6b..dd3428d 100644
--- a/dependencies
+++ b/dependencies
@@ -46,24 +46,6 @@ WL1251 3.0
 
 MWIFIEX 2.6.27
 
-# DRM stuff
-HDMI 3.2
-DRM 3.2
-# As of 3.11 DRM depends on the new ww_mutex which is
-# backported via BACKPORT_BUILD_WW_MUTEX. This backported
-# feature however has does not yet have support for
-# DEBUG_MUTEXES and DEBUG_LOCK_ALLOC.
-DRM kconfig: !BACKPORT_KERNEL_3_11 || !DEBUG_MUTEXES
-DRM kconfig: !BACKPORT_KERNEL_3_11 || !DEBUG_LOCK_ALLOC
-DRM_TTM 3.2
-# See e2bdb933, this was added on v3.3, in order to
-# support DRM_QXL on 3.2 you'd have to backport 78c1d7848
-# to 3.2 on BACKPORT_BUILD_RADIX_HELPERS and that requires
-# taking into consideration the radix_tree_node rcu change
-# on e2bdb933.
-DRM_QXL 3.3
-DRM_I915 3.7
-
 # Regulator
 # Because of -EPROBE_DEFER see commit d1c3414c and note that
 # we can't backport the core regulator as its part of the core
diff --git a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/INFO b/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/INFO
deleted file mode 100644
index cb9dd67..0000000
--- a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/INFO
+++ /dev/null
@@ -1,44 +0,0 @@
-Commit 3cf2667 as of next-20130301 extended the struct fb_info
-with a skip_vt_switch to allow drivers to skip the VT switch
-at suspend/resume time. For older kernels we can skip this
-as all this switch does is call pm_vt_switch_required() with true
-or false depending on this new flag and later
-pm_vt_switch_unregister() would not have been made.
-
-This patch cannot be broken down further so I'm pegging
-this as the first one with 4 digits under the DRM folder
-for collateral evolutions. This reflects its as atomic as
-is possible.
-
-Relevant commits below, starting with the first one that
-added this new collateral evolution.
-
-commit 3cf2667b9f8b2c2fe298a427deb399e52321da6b
-Author: Jesse Barnes <jbarnes@virtuousgeek.org>
-Date:   Mon Feb 4 13:37:21 2013 +0000
-
-    fb: add support for drivers not needing VT switch at suspend/resume time
-    
-    Use the new PM routines to indicate whether we need to VT switch at suspend
-    and resume time.  When a new driver is bound, set its flag accordingly,
-    and when unbound, remove it from the PM's console tracking list.
-    
-    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
-    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-
-commit 24576d23976746cb52e7700c4cadbf4bc1bc3472
-Author: Jesse Barnes <jbarnes@virtuousgeek.org>
-Date:   Tue Mar 26 09:25:45 2013 -0700
-
-    drm/i915: enable VT switchless resume v3
-    
-    With the other bits in place, we can do this safely.
-    
-    v2: disable backlight on suspend to prevent premature enablement on resume
-    v3: disable CRTCs on suspend to allow RTD3 (Kristen)
-    
-    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
-    Reviewed-by: Rodrigo Vivi <rodrigo.vivi@gmail.com>
-    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-
diff --git a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch b/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
deleted file mode 100644
index c0fab51..0000000
--- a/patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/i915/intel_fb.c
-+++ b/drivers/gpu/drm/i915/intel_fb.c
-@@ -152,7 +152,7 @@ static int intelfb_create(struct drm_fb_
- 	info->screen_size = size;
- 
- 	/* This driver doesn't need a VT switch to restore the mode on resume */
--	info->skip_vt_switch = true;
-+	fb_enable_skip_vt_switch(info);
- 
- 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->depth);
- 	drm_fb_helper_fill_var(info, &ifbdev->helper, sizes->fb_width, sizes->fb_height);
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/INFO b/patches/collateral-evolutions/drm/02-revert-vm_mmap/INFO
deleted file mode 100644
index 977b4b7..0000000
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/INFO
+++ /dev/null
@@ -1,5 +0,0 @@
-vm_mmap() and vm_munmap() were introduced in kernels >= 3.4.0. Revert
-those changes for versions older than that.
-
-These can't be backported as they rely on non-exported symbols.
-
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
deleted file mode 100644
index c1af648..0000000
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
+++ /dev/null
@@ -1,31 +0,0 @@
---- a/drivers/gpu/drm/drm_bufs.c
-+++ b/drivers/gpu/drm/drm_bufs.c
-@@ -1406,6 +1406,20 @@ int drm_mapbufs(struct drm_device *dev,
- 				retcode = -EINVAL;
- 				goto done;
- 			}
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-+			down_write(&current->mm->mmap_sem);
-+			virtual = do_mmap(file_priv->filp, 0, map->size,
-+					  PROT_READ | PROT_WRITE,
-+					  MAP_SHARED,
-+					  token);
-+			up_write(&current->mm->mmap_sem);
-+		} else {
-+			down_write(&current->mm->mmap_sem);
-+			virtual = do_mmap(file_priv->filp, 0, dma->byte_count,
-+					  PROT_READ | PROT_WRITE,
-+					  MAP_SHARED, 0);
-+			up_write(&current->mm->mmap_sem);
-+#else
- 			virtual = vm_mmap(file_priv->filp, 0, map->size,
- 					  PROT_READ | PROT_WRITE,
- 					  MAP_SHARED,
-@@ -1414,6 +1428,7 @@ int drm_mapbufs(struct drm_device *dev,
- 			virtual = vm_mmap(file_priv->filp, 0, dma->byte_count,
- 					  PROT_READ | PROT_WRITE,
- 					  MAP_SHARED, 0);
-+#endif
- 		}
- 		if (virtual > -1024UL) {
- 			/* Real error */
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
deleted file mode 100644
index e3d60b3..0000000
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
+++ /dev/null
@@ -1,37 +0,0 @@
---- a/drivers/gpu/drm/i810/i810_dma.c
-+++ b/drivers/gpu/drm/i810/i810_dma.c
-@@ -134,9 +134,17 @@ static int i810_map_buffer(struct drm_bu
- 	old_fops = file_priv->filp->f_op;
- 	file_priv->filp->f_op = &i810_buffer_fops;
- 	dev_priv->mmap_buffer = buf;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-+	down_write(&current->mm->mmap_sem);
-+	buf_priv->virtual = (void *)do_mmap(file_priv->filp, 0, buf->total,
-+					    PROT_READ | PROT_WRITE,
-+					    MAP_SHARED, buf->bus_address);
-+	up_write(&current->mm->mmap_sem);
-+#else
- 	buf_priv->virtual = (void *)vm_mmap(file_priv->filp, 0, buf->total,
- 					    PROT_READ | PROT_WRITE,
- 					    MAP_SHARED, buf->bus_address);
-+#endif
- 	dev_priv->mmap_buffer = NULL;
- 	file_priv->filp->f_op = old_fops;
- 	if (IS_ERR(buf_priv->virtual)) {
-@@ -157,9 +165,15 @@ static int i810_unmap_buffer(struct drm_
- 	if (buf_priv->currently_mapped != I810_BUF_MAPPED)
- 		return -EINVAL;
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-+	down_write(&current->mm->mmap_sem);
-+	retcode = do_munmap(current->mm, (unsigned long)buf_priv->virtual,
-+			    (size_t) buf->total);
-+	up_write(&current->mm->mmap_sem);
-+#else
- 	retcode = vm_munmap((unsigned long)buf_priv->virtual,
- 			    (size_t) buf->total);
--
-+#endif
- 	buf_priv->currently_mapped = I810_BUF_UNMAPPED;
- 	buf_priv->virtual = NULL;
- 
diff --git a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/INFO b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/INFO
deleted file mode 100644
index 28db5d2..0000000
--- a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-acpi_get_table_with_size() was exported with kernels >= 3.6. Revert the
-size checking for kernels < 3.6.
-
diff --git a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
deleted file mode 100644
index 29c2bb8..0000000
--- a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_bios.c
-+++ b/drivers/gpu/drm/radeon/radeon_bios.c
-@@ -581,12 +581,21 @@ static bool radeon_acpi_vfct_bios(struct
- {
- 	bool ret = false;
- 	struct acpi_table_header *hdr;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
- 	acpi_size tbl_size;
-+#else
-+	/* acpi_get_table_with_size() not exported on kernels < 3.6 */
-+	acpi_size tbl_size = 0x7fffffff;
-+#endif
- 	UEFI_ACPI_VFCT *vfct;
- 	GOP_VBIOS_CONTENT *vbios;
- 	VFCT_IMAGE_HEADER *vhdr;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
- 	if (!ACPI_SUCCESS(acpi_get_table_with_size("VFCT", 1, &hdr, &tbl_size)))
-+#else
-+	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
-+#endif
- 		return false;
- 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
- 		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
diff --git a/patches/collateral-evolutions/drm/11-videomode-includes/drivers_gpu_drm_drm_modes.patch b/patches/collateral-evolutions/drm/11-videomode-includes/drivers_gpu_drm_drm_modes.patch
deleted file mode 100644
index 1858cc3..0000000
--- a/patches/collateral-evolutions/drm/11-videomode-includes/drivers_gpu_drm_drm_modes.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/gpu/drm/drm_modes.c
-+++ b/drivers/gpu/drm/drm_modes.c
-@@ -35,8 +35,12 @@
- #include <linux/export.h>
- #include <drm/drmP.h>
- #include <drm/drm_crtc.h>
-+#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
- #include <video/of_videomode.h>
-+#endif
-+#if IS_ENABLED(CONFIG_VIDEOMODE)
- #include <video/videomode.h>
-+#endif
- 
- /**
-  * drm_mode_debug_printmodeline - debug print a mode
diff --git a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
deleted file mode 100644
index 8dbcf8a..0000000
--- a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
+++ /dev/null
@@ -1,25 +0,0 @@
-We cannot backport remove_proc_subtree() modularly so the
-only thing we can do is revert its usage. This patch reverts
-all of its usage and the commits that added them are listed
-below.
-
-Another thing we could do is look at each driver's usage of
-proc and see if its reasonable to instead covert it to use
-debugfs. This needs to be dealt with on a case by case basis.
-
-From 8bc742e13fb2c9cd64988816749295e9ddf53101 Mon Sep 17 00:00:00 2001
-From: David Howells <dhowells@redhat.com>
-Date: Fri, 12 Apr 2013 16:15:07 +0100
-Subject: [PATCH] drm: proc: Use remove_proc_subtree()
-
-Use remove_proc_subtree() rather than remove_proc_entry() to remove a
-minor-specific drm proc directory and all its children.
-
-Things could theoretically be improved by storing the drm_minor pointer in the
-minor-specific dir proc_dir_entry struct data and then scrapping the list of
-proc files - but that's shared with the debugfs interface where you can't do
-that, so I don't see an easy way of doing it.
-
-Signed-off-by: David Howells <dhowells@redhat.com>
-cc: dri-devel@lists.freedesktop.org
-Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
diff --git a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
deleted file mode 100644
index 6a578e5..0000000
--- a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
+++ /dev/null
@@ -1,62 +0,0 @@
---- a/drivers/gpu/drm/drm_proc.c
-+++ b/drivers/gpu/drm/drm_proc.c
-@@ -95,7 +95,7 @@ static int drm_proc_create_files(const s
- 	struct drm_device *dev = minor->dev;
- 	struct proc_dir_entry *ent;
- 	struct drm_info_node *tmp;
--	int i;
-+	int i, ret;
- 
- 	for (i = 0; i < count; i++) {
- 		u32 features = files[i].driver_features;
-@@ -105,9 +105,10 @@ static int drm_proc_create_files(const s
- 			continue;
- 
- 		tmp = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
--		if (!tmp)
--			return -1;
--
-+		if (tmp == NULL) {
-+			ret = -1;
-+			goto fail;
-+		}
- 		tmp->minor = minor;
- 		tmp->info_ent = &files[i];
- 		list_add(&tmp->list, &minor->proc_nodes.list);
-@@ -119,10 +120,16 @@ static int drm_proc_create_files(const s
- 				  minor->index, files[i].name);
- 			list_del(&tmp->list);
- 			kfree(tmp);
--			return -1;
-+			ret = -1;
-+			goto fail;
- 		}
- 	}
- 	return 0;
-+
-+fail:
-+	for (i = 0; i < count; i++)
-+		remove_proc_entry(drm_proc_list[i].name, minor->proc_root);
-+	return ret;
- }
- 
- /**
-@@ -153,7 +160,7 @@ int drm_proc_init(struct drm_minor *mino
- 	ret = drm_proc_create_files(drm_proc_list, DRM_PROC_ENTRIES,
- 				    minor->proc_root, minor);
- 	if (ret) {
--		remove_proc_subtree(name, root);
-+		remove_proc_entry(name, root);
- 		minor->proc_root = NULL;
- 		DRM_ERROR("Failed to create core drm proc files\n");
- 		return ret;
-@@ -203,7 +210,8 @@ int drm_proc_cleanup(struct drm_minor *m
- 	drm_proc_remove_files(drm_proc_list, DRM_PROC_ENTRIES, minor);
- 
- 	sprintf(name, "%d", minor->index);
--	remove_proc_subtree(name, root);
-+	remove_proc_entry(name, root);
-+
- 	return 0;
- }
- 
diff --git a/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO b/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
deleted file mode 100644
index 9fda4df..0000000
--- a/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
+++ /dev/null
@@ -1,2 +0,0 @@
-The headers are not being picked up and require
-ensuring we are pointing to our backport selection.
diff --git a/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch b/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
deleted file mode 100644
index dace69b..0000000
--- a/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/Makefile
-+++ b/drivers/gpu/drm/nouveau/Makefile
-@@ -2,7 +2,7 @@
- # Makefile for the drm device driver.  This driver provides support for the
- # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
- 
--ccflags-y := -Iinclude/drm
-+ccflags-y += -I$(backport_srctree)/include/drm
- ccflags-y += -I$(src)/core/include
- ccflags-y += -I$(src)/core
- ccflags-y += -I$(src)
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
deleted file mode 100644
index 1bb5fb2..0000000
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ /dev/null
@@ -1,116 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_dma.c
-+++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -1659,7 +1659,11 @@ int i915_driver_load(struct drm_device *
- 	return 0;
- 
- out_gem_unload:
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- 	if (dev_priv->mm.inactive_shrinker.scan_objects)
-+#else
-+	if (dev_priv->mm.inactive_shrinker.shrink)
-+#endif
- 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
- 
- 	if (dev->pdev->msi_enabled)
-@@ -1698,7 +1702,11 @@ int i915_driver_unload(struct drm_device
- 
- 	i915_teardown_sysfs(dev);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- 	if (dev_priv->mm.inactive_shrinker.scan_objects)
-+#else
-+	if (dev_priv->mm.inactive_shrinker.shrink)
-+#endif
- 		unregister_shrinker(&dev_priv->mm.inactive_shrinker);
- 
- 	mutex_lock(&dev->struct_mutex);
---- a/drivers/gpu/drm/i915/i915_gem.c
-+++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -57,10 +57,15 @@ static void i915_gem_object_update_fence
- 					 struct drm_i915_fence_reg *fence,
- 					 bool enable);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-@@ -4559,8 +4564,12 @@ i915_gem_load(struct drm_device *dev)
- 
- 	dev_priv->mm.interruptible = true;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- 	dev_priv->mm.inactive_shrinker.scan_objects = i915_gem_inactive_scan;
- 	dev_priv->mm.inactive_shrinker.count_objects = i915_gem_inactive_count;
-+#else
-+	dev_priv->mm.inactive_shrinker.shrink = i915_gem_inactive_shrink;
-+#endif
- 	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
- 	register_shrinker(&dev_priv->mm.inactive_shrinker);
- }
-@@ -4783,8 +4792,14 @@ static bool mutex_is_locked_by(struct mu
- #endif
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-@@ -4793,7 +4808,12 @@ i915_gem_inactive_count(struct shrinker
- 	struct drm_device *dev = dev_priv->dev;
- 	struct drm_i915_gem_object *obj;
- 	bool unlock = true;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- 	unsigned long count;
-+#else
-+	int nr_to_scan = sc->nr_to_scan;
-+	int count;
-+#endif
- 
- 	if (!mutex_trylock(&dev->struct_mutex)) {
- 		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4805,6 +4825,17 @@ i915_gem_inactive_count(struct shrinker
- 		unlock = false;
- 	}
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0))
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
-@@ -4884,6 +4915,7 @@ unsigned long i915_gem_obj_size(struct d
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- static unsigned long
- i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
- {
-@@ -4917,3 +4949,4 @@ i915_gem_inactive_scan(struct shrinker *
- 		mutex_unlock(&dev->struct_mutex);
- 	return freed;
- }
-+#endif
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
deleted file mode 100644
index 5a8176d..0000000
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
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
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
- 	manager->mm_shrink.count_objects = ttm_dma_pool_shrink_count;
- 	manager->mm_shrink.scan_objects = &ttm_dma_pool_shrink_scan;
-+#else
-+	manager->mm_shrink.shrink = ttm_dma_pool_mm_shrink;
-+#endif
- 	manager->mm_shrink.seeks = 1;
- 	register_shrinker(&manager->mm_shrink);
- }
diff --git a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
deleted file mode 100644
index 9a3074f..0000000
--- a/patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_gem_gtt.c
-+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
-@@ -881,6 +881,9 @@ static int i915_gmch_probe(struct drm_de
- {
- 	struct drm_i915_private *dev_priv = dev->dev_private;
- 	int ret;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
-+	const struct intel_gtt *gtt;
-+#endif
- 
- 	ret = intel_gmch_probe(dev_priv->bridge_dev, dev_priv->dev->pdev, NULL);
- 	if (!ret) {
-@@ -888,7 +891,16 @@ static int i915_gmch_probe(struct drm_de
- 		return -EIO;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
- 	intel_gtt_get(gtt_total, stolen, mappable_base, mappable_end);
-+#else
-+	gtt = intel_gtt_get();
-+
-+	*gtt_total = gtt->gtt_total_entries << PAGE_SHIFT;
-+	*stolen = gtt->stolen_size;
-+	*mappable_base = gtt->gma_bus_addr;
-+	*mappable_end = gtt->gtt_mappable_entries << PAGE_SHIFT;
-+#endif
- 
- 	dev_priv->gtt.do_idle_maps = needs_idle_maps(dev_priv->dev);
- 	dev_priv->gtt.base.clear_range = i915_ggtt_clear_range;
diff --git a/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch b/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
deleted file mode 100644
index 6511b99..0000000
--- a/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_debugfs.c
-+++ b/drivers/gpu/drm/i915/i915_debugfs.c
-@@ -1770,6 +1770,7 @@ static int i915_edp_psr_status(struct se
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int i915_energy_uJ(struct seq_file *m, void *data)
- {
- 	struct drm_info_node *node = m->private;
-@@ -1790,6 +1791,7 @@ static int i915_energy_uJ(struct seq_fil
- 	seq_printf(m, "%llu", (long long unsigned)power);
- 	return 0;
- }
-+#endif
- 
- static int
- i915_wedged_get(void *data, u64 *val)
-@@ -2230,7 +2232,9 @@ static struct drm_info_list i915_debugfs
- 	{"i915_dpio", i915_dpio_info, 0},
- 	{"i915_llc", i915_llc, 0},
- 	{"i915_edp_psr_status", i915_edp_psr_status, 0},
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- 	{"i915_energy_uJ", i915_energy_uJ, 0},
-+#endif
- };
- #define I915_DEBUGFS_ENTRIES ARRAY_SIZE(i915_debugfs_list)
- 
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
deleted file mode 100644
index 2f715a1..0000000
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/gpu/drm/drm_sysfs.c
-+++ b/drivers/gpu/drm/drm_sysfs.c
-@@ -98,7 +98,11 @@ static const struct dev_pm_ops drm_class
- 	.freeze		= drm_class_freeze,
- };
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- static char *drm_devnode(struct device *dev, umode_t *mode)
-+#else
-+static char *drm_devnode(struct device *dev, mode_t *mode)
-+#endif
- {
- 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
- }
-- 
1.7.10.4

