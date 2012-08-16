Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44852 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab2HPPpA (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 11:45:00 -0400
Received: by eaac11 with SMTP id c11so934343eaa.19
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 08:44:59 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Clean up *.mod.c after everything
Date: Thu, 16 Aug 2012 18:44:51 +0300
Message-Id: <1345131891-2555-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Remove possible .mod.c leftovers at the end instead of after every
copying operation.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 73c3939..0b09708 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -412,7 +412,6 @@ for i in $NET_DIRS; do
 	cp $GIT_TREE/net/$i/*.[ch] net/$i/
 	cp $GIT_TREE/net/$i/Makefile net/$i/
 	cp $GIT_TREE/net/$i/Kconfig net/$i/
-	rm -f net/$i/*.mod.c
 done
 
 cp $GIT_TREE/MAINTAINERS ./
@@ -427,7 +426,6 @@ for i in $NET_BT_DIRS; do
 	echo "Copying $GIT_TREE/net/$i/*.[ch]"
 	cp $GIT_TREE/net/$i/*.[ch] net/$i/
 	cp $GIT_TREE/net/$i/Makefile net/$i/
-	rm -f net/$i/*.mod.c
 done
 
 # Drivers in their own directory
@@ -448,7 +446,6 @@ for i in $DRIVERS; do
 	if [ -f $GIT_TREE/$i/Kconfig ]; then
 		cp $GIT_TREE/$i/Kconfig $i/
 	fi
-	rm -f $i/*.mod.c
 done
 
 # Staging drivers in their own directory
@@ -462,7 +459,6 @@ for i in $STAGING_DRIVERS; do
 	echo -e "Copying ${RED}STAGING${NORMAL} $GIT_TREE/$i/*.[ch]"
 	# staging drivers tend to have their own subdirs...
 	cp -a $GIT_TREE/$i drivers/staging/
-	rm -f $i/*.mod.c
 done
 
 for i in $DRIVERS_BT; do
@@ -470,7 +466,6 @@ for i in $DRIVERS_BT; do
 	echo "Copying $GIT_TREE/$i/*.[ch]"
 	cp $GIT_TREE/$i/*.[ch] $i/
 	cp $GIT_TREE/$i/Makefile $i/
-	rm -f $i/*.mod.c
 done
 
 # For rndis_wlan, we need a new rndis_host.ko, cdc_ether.ko and usbnet.ko
@@ -515,7 +510,9 @@ cp -a $GIT_COMPAT_TREE/include/net/* include/net/
 cp -a $GIT_COMPAT_TREE/include/trace/* include/trace/
 cp -a $GIT_COMPAT_TREE/include/pcmcia/* include/pcmcia/
 cp -a $GIT_COMPAT_TREE/include/crypto/* include/crypto/
-rm -f $COMPAT/*.mod.c
+
+# Clean up possible *.mod.c leftovers
+find -type f -name "*.mod.c" -exec rm -f {} \;
 
 # files we suck in for wireless drivers
 export WSTABLE="
-- 
1.7.11.2

