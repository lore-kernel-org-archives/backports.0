Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:64123 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbaEHUkj (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:39 -0400
Received: by mail-we0-f177.google.com with SMTP id x48so3088983wes.36
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:38 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 10/10] backports: Makefile: update help text
Date: Thu,  8 May 2014 22:39:33 +0200
Message-Id: <1399581573-12072-11-git-send-email-s.martin49@gmail.com> (sfid-20140508_224041_107989_5018A8BE)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index 2f446e6..acc0e15 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -62,11 +62,17 @@ mrproper:
 	echo "/--------------"								;\
 	echo "| Your kernel headers are incomplete/not installed."			;\
 	echo "| Please install kernel headers, including a .config"			;\
-	echo "| file or use the KLIB/KLIB_BUILD make variables to"			;\
-	echo "| set the kernel to build against, e.g."					;\
-	echo "|   make KLIB=/lib/modules/3.1.7/"					;\
-	echo "| to compile/install for the installed kernel 3.1.7"			;\
-	echo "| (that isn't currently running.)"					;\
+	echo "| file or use the KROOT/KLIB_BUILD make variables to"			;\
+	echo "| set the kernel to build against, e.g.:"					;\
+	echo "| * to compile/install for the installed kernel 3.1.7"			;\
+	echo "|   (that isn't currently running.):"					;\
+	echo "|   $$ make KLIB_BUILD=/lib/modules/3.1.7/build"				;\
+	echo "| * to cross-compile/install for an arm target in /opt/arm-dev/rootfs:"	;\
+	echo "|   $$ make \\"								;\
+	echo "|        ARCH=arm	\\"							;\
+	echo "|        CROSS_COMPILE=/opt/ct-ng/arm-linux/bin/arm-linux- \\"		;\
+	echo "|        KROOT=/opt/arm-dev/rootfs \\"					;\
+	echo "|        KLIB_BUILD=/opt/arm-dev/linux"					;\
 	echo "\\--"									;\
 	false)
 	@set -e ; if [ "$$(cat .kernel_config_md5 2>/dev/null)" != "$(CONFIG_MD5)" ]	;\
-- 
1.9.2

