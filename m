Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 4/7] compat-drivers: Rename CONFIG_DRM_NOUVEAU_BACKLIGHT
Date: Sun, 28 Oct 2012 19:04:18 +0200
Message-Id: <1351443861-26280-4-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This was forgotten during the generation of the renaming patch.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 patches/drm/06-rename-config-options.patch | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index 9fda1f8..ad605ab 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -75,6 +75,27 @@
  sil164-y := sil164_drv.o
 -obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
 +obj-$(CONFIG_COMPAT_DRM_I2C_SIL164) += sil164.o
+--- a/drivers/gpu/drm/nouveau/Makefile
++++ b/drivers/gpu/drm/nouveau/Makefile
+@@ -187,6 +187,6 @@ nouveau-y += nouveau_mem.o
+ # other random bits
+ nouveau-$(CONFIG_COMPAT) += nouveau_ioc32.o
+ nouveau-$(CONFIG_ACPI) += nouveau_acpi.o
+-nouveau-$(CONFIG_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
++nouveau-$(CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
+ 
+ obj-$(CONFIG_DRM_NOUVEAU)+= nouveau.o
+--- a/drivers/gpu/drm/nouveau/nouveau_display.h	2012-10-28 17:57:24.844141245 +0200
++++ b/drivers/gpu/drm/nouveau/nouveau_display.h	2012-10-28 17:57:41.408834396 +0200
+@@ -76,7 +76,7 @@
+ 
+ void nouveau_hdmi_mode_set(struct drm_encoder *, struct drm_display_mode *);
+ 
+-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
++#ifdef CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT
+ extern int nouveau_backlight_init(struct drm_device *);
+ extern void nouveau_backlight_exit(struct drm_device *);
+ #else
 --- a/drivers/gpu/drm/drm_crtc_helper.c
 +++ b/drivers/gpu/drm/drm_crtc_helper.c
 @@ -119,7 +119,7 @@ int drm_helper_probe_single_connector_mo
-- 
1.7.11.7
