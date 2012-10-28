Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52665 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab2J1Rzx (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 28 Oct 2012 13:55:53 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1431140eaa.19
        for <backports@vger.kernel.org>; Sun, 28 Oct 2012 10:55:51 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/3] compat-drivers: Rename CONFIG_DRM_RADEON_KMS
Date: Sun, 28 Oct 2012 19:55:43 +0200
Message-Id: <1351446945-23717-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Prefix it with CONFIG_COMPAT_ to allow setting it correctly.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 patches/drm/06-rename-config-options.patch | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index ad605ab..4d2cf72 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -107,3 +107,23 @@
  	count = drm_load_edid_firmware(connector);
  	if (count == 0)
  #endif
+--- a/drivers/gpu/drm/radeon/radeon_drv.c	2012-10-28 19:17:02.738091628 +0200
++++ b/drivers/gpu/drm/radeon/radeon_drv.c	2012-10-28 19:17:27.429558561 +0200
+@@ -226,7 +226,7 @@
+ 	radeon_PCI_IDS
+ };
+ 
+-#if defined(CONFIG_DRM_RADEON_KMS)
++#if defined(CONFIG_COMPAT_DRM_RADEON_KMS)
+ MODULE_DEVICE_TABLE(pci, pciidlist);
+ #endif
+ 
+@@ -431,7 +431,7 @@
+ #endif
+ 	/* if enabled by default */
+ 	if (radeon_modeset == -1) {
+-#ifdef CONFIG_DRM_RADEON_KMS
++#ifdef CONFIG_COMPAT_DRM_RADEON_KMS
+ 		DRM_INFO("radeon defaulting to kernel modesetting.\n");
+ 		radeon_modeset = 1;
+ #else
-- 
1.7.11.7

