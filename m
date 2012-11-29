Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat-drivers: make patches apply again
Date: Thu, 29 Nov 2012 16:26:15 +0100
Message-Id: <1354202775-11838-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/06-rename-config-options.patch |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index 9ca7ed9..9ad2f89 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -1,11 +1,12 @@
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -15,38 +15,38 @@ drm-y       :=	drm_auth.o drm_buffer.o d
+@@ -15,39 +15,39 @@ drm-y       :=	drm_auth.o drm_buffer.o d
  		drm_trace_points.o drm_global.o drm_prime.o
  
  drm-$(CONFIG_COMPAT) += drm_ioc32.o
 -drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
 +drm-$(CONFIG_COMPAT_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
+ drm-$(CONFIG_PCI) += ati_pcigart.o
  
  drm-usb-y   := drm_usb.o
  
@@ -84,7 +85,7 @@
 +obj-$(CONFIG_COMPAT_DRM_CIRRUS_QEMU) += cirrus.o
 --- a/drivers/gpu/drm/drm_crtc_helper.c
 +++ b/drivers/gpu/drm/drm_crtc_helper.c
-@@ -142,7 +142,7 @@ int drm_helper_probe_single_connector_mo
+@@ -152,7 +152,7 @@ int drm_helper_probe_single_connector_mo
  		goto prune;
  	}
  
-- 
1.7.10.4
