Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38046 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3B0Xxv (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 27 Feb 2013 18:53:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] compat-drivers: build driver/video/hdmi.ko
Date: Thu, 28 Feb 2013 00:53:39 +0100
Message-Id: <1362009219-20091-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1362009219-20091-1-git-send-email-hauke@hauke-m.de>
References: <1362009219-20091-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This module is needed by the drm driver now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 Makefile                |    1 +
 config.mk               |    1 +
 scripts/admin-update.sh |    9 ++++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e986a09..89bc991 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,7 @@ obj-y := compat/
 
 obj-$(CONFIG_COMPAT_RFKILL) += net/rfkill/
 obj-$(CONFIG_COMPAT_VIDEO_MODULES) += drivers/gpu/drm/
+obj-$(CONFIG_COMPAT_VIDEO_MODULES) += drivers/video/
 
 ifeq ($(BT),)
 obj-$(CONFIG_COMPAT_WIRELESS) += net/wireless/ net/mac80211/
diff --git a/config.mk b/config.mk
index add66c7..13b44d4 100644
--- a/config.mk
+++ b/config.mk
@@ -723,6 +723,7 @@ endif #CONFIG_COMPAT_KERNEL_2_6_31
 # tests have only started on 3.2.
 ifndef CONFIG_COMPAT_KERNEL_3_2
 # Basic DRM support
+export CONFIG_COMPAT_HDMI=m
 export CONFIG_COMPAT_VIDEO_MODULES=y
 export CONFIG_COMPAT_DRM=m
 export CONFIG_COMPAT_DRM_TTM=m
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 48055a9..e1e5f0d 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -444,7 +444,8 @@ mkdir -p include/net/bluetooth \
 	 $DRIVERS_WLAN \
 	 $DRIVERS_ETH \
 	 $DRIVERS_BT \
-	 $DRIVERS_DRM
+	 $DRIVERS_DRM \
+	 drivers/video
 
 
 
@@ -677,8 +678,14 @@ if [[ "$ENABLE_DRM" == "1" ]]; then
 
 	# Finally get the DRM top-level makefile
 	cp $GIT_TREE/drivers/gpu/drm/Makefile drivers/gpu/drm
+
+	DIR="drivers/video"
+	cp $GIT_TREE/$DIR/hdmi.c $DIR
+	echo "obj-\$(CONFIG_COMPAT_HDMI) += hdmi.o" > $DIR/Makefile
+	cp $GIT_TREE/include/linux/hdmi.h include/linux/hdmi.h
 else
 	touch drivers/gpu/drm/Makefile
+	touch drivers/video/Makefile
 fi
 
 # Staging drivers in their own directory
-- 
1.7.10.4

