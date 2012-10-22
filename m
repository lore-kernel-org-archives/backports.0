Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40626 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab2JVL6H (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 22 Oct 2012 07:58:07 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so929388eek.19
        for <backports@vger.kernel.org>; Mon, 22 Oct 2012 04:58:05 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
Date: Mon, 22 Oct 2012 14:57:59 +0300
Message-Id: <1350907079-31735-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in 3.4. Rename the option in the relevant source file
and enable CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE in config.mk to build
the symbol into DRM_KMS_HELPER kernel module.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 config.mk                                  |  1 +
 patches/drm/06-rename-config-options.patch | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/config.mk b/config.mk
index c9b2353..4a390fd 100644
--- a/config.mk
+++ b/config.mk
@@ -702,5 +702,6 @@ ifndef CONFIG_COMPAT_KERNEL_3_2
 export CONFIG_COMPAT_VIDEO_MODULES=y
 export CONFIG_COMPAT_DRM=m
 export CONFIG_COMPAT_DRM_I915=m
+export CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE=y
 export CONFIG_COMPAT_DRM_KMS_HELPER=m
 endif #CONFIG_COMPAT_KERNEL_3_2
diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index 1096fce..9fda1f8 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -75,3 +75,14 @@
  sil164-y := sil164_drv.o
 -obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
 +obj-$(CONFIG_COMPAT_DRM_I2C_SIL164) += sil164.o
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
-- 
1.7.11.7

