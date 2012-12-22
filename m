Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:64387 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab2LVLEg (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 22 Dec 2012 06:04:36 -0500
Received: by mail-ee0-f43.google.com with SMTP id e49so2904856eek.2
        for <backports@vger.kernel.org>; Sat, 22 Dec 2012 03:04:35 -0800 (PST)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/3] update-initramfs: Update comments, fix some typos
Date: Sat, 22 Dec 2012 13:04:11 +0200
Message-Id: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

update-initramfs is crucial for DRM drivers, let's clarify this.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/update-initramfs | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/update-initramfs b/scripts/update-initramfs
index e388df2..dcc1ee6 100755
--- a/scripts/update-initramfs
+++ b/scripts/update-initramfs
@@ -1,12 +1,10 @@
 #!/bin/bash
 # Copyright 2009        Luis R. Rodriguez <mcgrof@gmail.com>
 #
-# Since we provide ssb, the Ethernet module b44 some people may
-# rely on it to netboot, so update the initrafms for each
-# distribution.
-#
-# Note that in the future people may want to wireless-boot
-# so this will help with that as well.
+# Since we provide ssb, ethernet modules and most importantly
+# DRM drivers, people may want top update the initramfs image
+# of their distribution. This can also help people who may
+# want to wireless-boot their systems.
 
 LSB_RED_ID=$(/usr/bin/lsb_release -i -s)
 
@@ -29,7 +27,7 @@ case $LSB_RED_ID in
 	;;
 *)
 	echo "Warning:"
-	echo "You may or may not need to update your initframfs, you should if"
+	echo "You may or may not need to update your initramfs, you should if"
 	echo "any of the modules installed are part of your initramfs. To add"
 	echo "support for your distribution to do this automatically send a"
 	echo "patch against $0. If your distribution does not require this"
-- 
1.8.0.2

