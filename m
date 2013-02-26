Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/24] compat-drivers: do not include videomode headers when this feature is deactivated
Date: Tue, 26 Feb 2013 21:38:09 +0100
Message-Id: <1361911096-29117-18-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/11-videomode-includes.patch                     |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/11-videomode-includes.patch

diff --git a/patches/collateral-evolutions/drm/11-videomode-includes.patch b/patches/collateral-evolutions/drm/11-videomode-includes.patch
new file mode 100644
index 0000000..1858cc3
--- /dev/null
+++ b/patches/collateral-evolutions/drm/11-videomode-includes.patch
@@ -0,0 +1,15 @@
+--- a/drivers/gpu/drm/drm_modes.c
++++ b/drivers/gpu/drm/drm_modes.c
+@@ -35,8 +35,12 @@
+ #include <linux/export.h>
+ #include <drm/drmP.h>
+ #include <drm/drm_crtc.h>
++#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
+ #include <video/of_videomode.h>
++#endif
++#if IS_ENABLED(CONFIG_VIDEOMODE)
+ #include <video/videomode.h>
++#endif
+ 
+ /**
+  * drm_mode_debug_printmodeline - debug print a mode
-- 
1.7.10.4
