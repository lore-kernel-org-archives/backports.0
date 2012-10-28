Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 6/7] compat-drivers: Enable nouveau DRM driver for kernels >= 3.3
Date: Sun, 28 Oct 2012 19:04:20 +0200
Message-Id: <1351443861-26280-6-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Enable Nouveau DRM driver for kernels >= 3.3.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 config.mk | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.mk b/config.mk
index f743e05..5941135 100644
--- a/config.mk
+++ b/config.mk
@@ -709,3 +709,12 @@ export CONFIG_COMPAT_DRM_I915=m
 export CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE=y
 export CONFIG_COMPAT_DRM_KMS_HELPER=m
 endif #CONFIG_COMPAT_KERNEL_3_2
+
+# Enable nouveau on >= 3.3
+ifndef CONFIG_COMPAT_KERNEL_3_3
+export CONFIG_COMPAT_DRM_TTM=m
+export CONFIG_COMPAT_DRM_NOUVEAU=m
+export CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT=y
+export CONFIG_COMPAT_NOUVEAU_DEBUG=5
+export CONFIG_COMPAT_NOUVEAU_DEBUG_DEFAULT=3
+endif #CONFIG_COMPAT_KERNEL_3_3
-- 
1.7.11.7
