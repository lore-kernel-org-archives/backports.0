Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52665 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab2J1Rzz (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 28 Oct 2012 13:55:55 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1431140eaa.19
        for <backports@vger.kernel.org>; Sun, 28 Oct 2012 10:55:55 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 3/3] compat-drivers: Enable ATI/AMD Radeon for kernels >= 3.2
Date: Sun, 28 Oct 2012 19:55:45 +0200
Message-Id: <1351446945-23717-3-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351446945-23717-1-git-send-email-ozancag@gmail.com>
References: <1351446945-23717-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 config.mk | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/config.mk b/config.mk
index 5941135..3c0a8bd 100644
--- a/config.mk
+++ b/config.mk
@@ -703,16 +703,21 @@ endif #CONFIG_COMPAT_KERNEL_2_6_31
 # compilation has been tested down to 3.0 but run time
 # tests have only started on 3.2.
 ifndef CONFIG_COMPAT_KERNEL_3_2
+# Basic DRM support
 export CONFIG_COMPAT_VIDEO_MODULES=y
 export CONFIG_COMPAT_DRM=m
-export CONFIG_COMPAT_DRM_I915=m
-export CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE=y
+export CONFIG_COMPAT_DRM_TTM=m
 export CONFIG_COMPAT_DRM_KMS_HELPER=m
+export CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE=y
+# Intel i915
+export CONFIG_COMPAT_DRM_I915=m
+# ATI/AMD Radeon
+export CONFIG_COMPAT_DRM_RADEON=m
+export CONFIG_COMPAT_DRM_RADEON_KMS=y
 endif #CONFIG_COMPAT_KERNEL_3_2
 
 # Enable nouveau on >= 3.3
 ifndef CONFIG_COMPAT_KERNEL_3_3
-export CONFIG_COMPAT_DRM_TTM=m
 export CONFIG_COMPAT_DRM_NOUVEAU=m
 export CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT=y
 export CONFIG_COMPAT_NOUVEAU_DEBUG=5
-- 
1.7.11.7

