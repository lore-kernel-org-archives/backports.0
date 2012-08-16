Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40940 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab2HPR0X (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 13:26:23 -0400
Received: by wicr5 with SMTP id r5so913035wic.1
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 10:26:21 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/2] compat-drivers: Fetch in DRM drivers
Date: Thu, 16 Aug 2012 20:26:11 +0300
Message-Id: <1345137971-12169-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1345137971-12169-1-git-send-email-ozancag@gmail.com>
References: <1345137971-12169-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Grab DRM drivers from $GIT_URL if drm is passed in the command line.

Note that 'make' will not currently build these drivers. This is just
for fetching them in.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 4828efa..29f9980 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -422,6 +422,23 @@ DRIVERS_WLAN_FILES="adm8211.c
 		    mwl8k.c
 		    rndis_wlan.c"
 
+# DRM drivers
+DRIVERS_DRM="drivers/gpu/drm/ast
+	     drivers/gpu/drm/cirrus
+	     drivers/gpu/drm/gma500
+	     drivers/gpu/drm/i2c
+	     drivers/gpu/drm/i810
+	     drivers/gpu/drm/i915
+	     drivers/gpu/drm/mgag200
+	     drivers/gpu/drm/nouveau
+	     drivers/gpu/drm/radeon
+	     drivers/gpu/drm/ttm
+	     drivers/gpu/drm/via
+	     drivers/gpu/drm/vmwgfx"
+
+# UDL uses the new dma-buf API, let's disable this for now
+#DRIVERS="$DRIVERS drivers/gpu/drm/udl"
+
 rm -rf drivers/
 
 mkdir -p include/net/bluetooth \
@@ -435,13 +452,15 @@ mkdir -p include/net/bluetooth \
 	 drivers/misc/eeprom \
 	 drivers/net/usb \
 	 drivers/net/ethernet/broadcom \
+	 drivers/platform/x86 \
 	 drivers/ssb \
 	 drivers/staging \
 	 $NET_WLAN_DIRS \
 	 $NET_BT_DIRS \
 	 $DRIVERS_WLAN \
 	 $DRIVERS_ETH \
-	 $DRIVERS_BT
+	 $DRIVERS_BT \
+	 $DRIVERS_DRM
 
 if [[ -n "$ENABLE_NETWORK" ]]; then
 	# WLAN and bluetooth files
@@ -479,6 +498,27 @@ if [[ -n "$ENABLE_NETWORK" ]]; then
 	echo "obj-\$(CONFIG_B44) += b44.o" > drivers/net/ethernet/broadcom/Makefile
 fi
 
+if [[ -n "$ENABLE_DRM" ]]; then
+	# DRM drivers
+	copyDirectories "$DRIVERS_DRM"
+
+	# Copy standalone drivers
+	echo "Copying $GIT_TREE/drivers/gpu/drm/*.[ch]"
+	cp $GIT_TREE/drivers/gpu/drm/{Makefile,*.[ch]} drivers/gpu/drm/
+
+	# Copy DRM headers
+	cp -a $GIT_TREE/include/drm include/
+
+	# drivers/gpu/drm/i915/intel_pm.c requires this
+	cp $GIT_TREE/drivers/platform/x86/intel_ips.h drivers/platform/x86
+
+	# Copy radeon reg_srcs for hostprogs
+	cp -a $GIT_TREE/drivers/gpu/drm/radeon/reg_srcs drivers/gpu/drm/radeon
+
+	# Finally get the DRM top-level makefile
+	cp $GIT_TREE/drivers/gpu/drm/Makefile drivers/gpu/drm
+fi
+
 # Staging drivers in their own directory
 for i in $STAGING_DRIVERS; do
 	if [ ! -d $GIT_TREE/$i ]; then
-- 
1.7.11.2

