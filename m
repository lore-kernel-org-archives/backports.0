Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] compat-drivers: rename drm config symbols
Date: Tue,  6 Nov 2012 00:11:55 +0100
Message-Id: <1352157115-13469-9-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

When config symbols are renamed they should be renamed at all places
and not just at some places.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/06-rename-config-options.patch |  122 ++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index 4d2cf72..3b8e78e 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -63,6 +63,42 @@
 +obj-$(CONFIG_COMPAT_DRM_AST) += ast/
 +obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
  obj-y			+= i2c/
+--- a/drivers/gpu/drm/ast/Makefile
++++ b/drivers/gpu/drm/ast/Makefile
+@@ -6,4 +6,4 @@ ccflags-y := -Iinclude/drm
+ 
+ ast-y := ast_drv.o ast_main.o ast_mode.o ast_fb.o ast_ttm.o ast_post.o
+ 
+-obj-$(CONFIG_DRM_AST) := ast.o
+\ No newline at end of file
++obj-$(CONFIG_COMPAT_DRM_AST) := ast.o
+--- a/drivers/gpu/drm/cirrus/Makefile
++++ b/drivers/gpu/drm/cirrus/Makefile
+@@ -2,4 +2,4 @@ ccflags-y := -Iinclude/drm
+ cirrus-y  := cirrus_main.o cirrus_mode.o \
+ 	cirrus_drv.o cirrus_fbdev.o cirrus_ttm.o
+ 
+-obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus.o
++obj-$(CONFIG_COMPAT_DRM_CIRRUS_QEMU) += cirrus.o
+--- a/drivers/gpu/drm/drm_crtc_helper.c
++++ b/drivers/gpu/drm/drm_crtc_helper.c
+@@ -119,7 +119,7 @@ int drm_helper_probe_single_connector_mo
+ 		goto prune;
+ 	}
+ 
+-#ifdef CONFIG_DRM_LOAD_EDID_FIRMWARE
++#ifdef CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE
+ 	count = drm_load_edid_firmware(connector);
+ 	if (count == 0)
+ #endif
+--- a/drivers/gpu/drm/gma500/Makefile
++++ b/drivers/gpu/drm/gma500/Makefile
+@@ -49,4 +49,4 @@ gma500_gfx-$(CONFIG_DRM_MEDFIELD) += mdf
+ 	  mdfld_tmd_vid.o \
+ 	  tc35876x-dsi-lvds.o
+ 
+-obj-$(CONFIG_DRM_GMA500) += gma500_gfx.o
++obj-$(CONFIG_COMPAT_DRM_GMA500) += gma500_gfx.o
 --- a/drivers/gpu/drm/i2c/Makefile
 +++ b/drivers/gpu/drm/i2c/Makefile
 @@ -1,7 +1,7 @@
@@ -75,6 +111,32 @@
  sil164-y := sil164_drv.o
 -obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
 +obj-$(CONFIG_COMPAT_DRM_I2C_SIL164) += sil164.o
+--- a/drivers/gpu/drm/i810/Makefile
++++ b/drivers/gpu/drm/i810/Makefile
+@@ -5,4 +5,4 @@
+ ccflags-y := -Iinclude/drm
+ i810-y := i810_drv.o i810_dma.o
+ 
+-obj-$(CONFIG_DRM_I810)	+= i810.o
++obj-$(CONFIG_COMPAT_DRM_I810)	+= i810.o
+--- a/drivers/gpu/drm/i915/Makefile
++++ b/drivers/gpu/drm/i915/Makefile
+@@ -47,6 +47,6 @@ i915-$(CONFIG_COMPAT)   += i915_ioc32.o
+ 
+ i915-$(CONFIG_ACPI)	+= intel_acpi.o
+ 
+-obj-$(CONFIG_DRM_I915)  += i915.o
++obj-$(CONFIG_COMPAT_DRM_I915)  += i915.o
+ 
+ CFLAGS_i915_trace_points.o := -I$(src)
+--- a/drivers/gpu/drm/mgag200/Makefile
++++ b/drivers/gpu/drm/mgag200/Makefile
+@@ -2,4 +2,4 @@ ccflags-y := -Iinclude/drm
+ mgag200-y   := mgag200_main.o mgag200_mode.o \
+ 	mgag200_drv.o mgag200_fb.o mgag200_i2c.o mgag200_ttm.o
+ 
+-obj-$(CONFIG_DRM_MGAG200) += mgag200.o
++obj-$(CONFIG_COMPAT_DRM_MGAG200) += mgag200.o
 --- a/drivers/gpu/drm/nouveau/Makefile
 +++ b/drivers/gpu/drm/nouveau/Makefile
 @@ -187,6 +187,6 @@ nouveau-y += nouveau_mem.o
@@ -84,10 +146,11 @@
 -nouveau-$(CONFIG_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
 +nouveau-$(CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
  
- obj-$(CONFIG_DRM_NOUVEAU)+= nouveau.o
---- a/drivers/gpu/drm/nouveau/nouveau_display.h	2012-10-28 17:57:24.844141245 +0200
-+++ b/drivers/gpu/drm/nouveau/nouveau_display.h	2012-10-28 17:57:41.408834396 +0200
-@@ -76,7 +76,7 @@
+-obj-$(CONFIG_DRM_NOUVEAU)+= nouveau.o
++obj-$(CONFIG_COMPAT_DRM_NOUVEAU)+= nouveau.o
+--- a/drivers/gpu/drm/nouveau/nouveau_display.h
++++ b/drivers/gpu/drm/nouveau/nouveau_display.h
+@@ -76,7 +76,7 @@ int  nouveau_display_dumb_destroy(struct
  
  void nouveau_hdmi_mode_set(struct drm_encoder *, struct drm_display_mode *);
  
@@ -96,20 +159,19 @@
  extern int nouveau_backlight_init(struct drm_device *);
  extern void nouveau_backlight_exit(struct drm_device *);
  #else
---- a/drivers/gpu/drm/drm_crtc_helper.c
-+++ b/drivers/gpu/drm/drm_crtc_helper.c
-@@ -119,7 +119,7 @@ int drm_helper_probe_single_connector_mo
- 		goto prune;
- 	}
+--- a/drivers/gpu/drm/radeon/Makefile
++++ b/drivers/gpu/drm/radeon/Makefile
+@@ -78,6 +78,6 @@ radeon-$(CONFIG_COMPAT) += radeon_ioc32.
+ radeon-$(CONFIG_VGA_SWITCHEROO) += radeon_atpx_handler.o
+ radeon-$(CONFIG_ACPI) += radeon_acpi.o
  
--#ifdef CONFIG_DRM_LOAD_EDID_FIRMWARE
-+#ifdef CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE
- 	count = drm_load_edid_firmware(connector);
- 	if (count == 0)
- #endif
---- a/drivers/gpu/drm/radeon/radeon_drv.c	2012-10-28 19:17:02.738091628 +0200
-+++ b/drivers/gpu/drm/radeon/radeon_drv.c	2012-10-28 19:17:27.429558561 +0200
-@@ -226,7 +226,7 @@
+-obj-$(CONFIG_DRM_RADEON)+= radeon.o
++obj-$(CONFIG_COMPAT_DRM_RADEON)+= radeon.o
+ 
+ CFLAGS_radeon_trace_points.o := -I$(src)
+--- a/drivers/gpu/drm/radeon/radeon_drv.c
++++ b/drivers/gpu/drm/radeon/radeon_drv.c
+@@ -226,7 +226,7 @@ static struct pci_device_id pciidlist[]
  	radeon_PCI_IDS
  };
  
@@ -118,7 +180,7 @@
  MODULE_DEVICE_TABLE(pci, pciidlist);
  #endif
  
-@@ -431,7 +431,7 @@
+@@ -431,7 +431,7 @@ static int __init radeon_init(void)
  #endif
  	/* if enabled by default */
  	if (radeon_modeset == -1) {
@@ -127,3 +189,27 @@
  		DRM_INFO("radeon defaulting to kernel modesetting.\n");
  		radeon_modeset = 1;
  #else
+--- a/drivers/gpu/drm/ttm/Makefile
++++ b/drivers/gpu/drm/ttm/Makefile
+@@ -11,4 +11,4 @@ ifeq ($(CONFIG_SWIOTLB),y)
+ ttm-y += ttm_page_alloc_dma.o
+ endif
+ 
+-obj-$(CONFIG_DRM_TTM) += ttm.o
++obj-$(CONFIG_COMPAT_DRM_TTM) += ttm.o
+--- a/drivers/gpu/drm/via/Makefile
++++ b/drivers/gpu/drm/via/Makefile
+@@ -5,4 +5,4 @@
+ ccflags-y := -Iinclude/drm
+ via-y    := via_irq.o via_drv.o via_map.o via_mm.o via_dma.o via_verifier.o via_video.o via_dmablit.o
+ 
+-obj-$(CONFIG_DRM_VIA)	+=via.o
++obj-$(CONFIG_COMPAT_DRM_VIA)	+=via.o
+--- a/drivers/gpu/drm/vmwgfx/Makefile
++++ b/drivers/gpu/drm/vmwgfx/Makefile
+@@ -7,4 +7,4 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.
+ 	    vmwgfx_overlay.o vmwgfx_marker.o vmwgfx_gmrid_manager.o \
+ 	    vmwgfx_fence.o vmwgfx_dmabuf.o vmwgfx_scrn.o
+ 
+-obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
++obj-$(CONFIG_COMPAT_DRM_VMWGFX) := vmwgfx.o
-- 
1.7.10.4
