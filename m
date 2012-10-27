Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Copy core/ subdir of nouveau driver
Date: Sat, 27 Oct 2012 17:22:03 +0300
Message-Id: <1351347723-21884-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This was introduced with the latest nouveau code rewrite. Copy
this directory too.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index e94f9bd..68a5b27 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -537,6 +537,9 @@ if [[ "$ENABLE_DRM" == "1" ]]; then
 	# Copy radeon reg_srcs for hostprogs
 	cp -a $GIT_TREE/drivers/gpu/drm/radeon/reg_srcs drivers/gpu/drm/radeon
 
+	# Copy core/ from nouveau/ (Introduced after new code rewrite in 3.7)
+	cp -a $GIT_TREE/drivers/gpu/drm/nouveau/core drivers/gpu/drm/nouveau
+
 	# Finally get the DRM top-level makefile
 	cp $GIT_TREE/drivers/gpu/drm/Makefile drivers/gpu/drm
 else
-- 
1.7.11.7
