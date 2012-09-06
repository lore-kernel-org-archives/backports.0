Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49643 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2IFTuK (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Sep 2012 15:50:10 -0400
Received: by wgbdr13 with SMTP id dr13so1941332wgb.1
        for <backports@vger.kernel.org>; Thu, 06 Sep 2012 12:50:09 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/2] compat-drivers: Update 53-pr_fmt.patch
Date: Thu,  6 Sep 2012 22:49:55 +0300
Message-Id: <1346960995-13363-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1346960995-13363-1-git-send-email-ozancag@gmail.com>
References: <1346960995-13363-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Fix ath5k/debug.c redefinition warning for pr_fmt macro

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 patches/network/53-pr_fmt.patch | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/patches/network/53-pr_fmt.patch b/patches/network/53-pr_fmt.patch
index 4c29be6..f1af016 100644
--- a/patches/network/53-pr_fmt.patch
+++ b/patches/network/53-pr_fmt.patch
@@ -819,3 +819,16 @@ compiler warnings. This is going to be sent upstream.
  #include <linux/slab.h>
  
  #include "ath5k.h"
+--- a/drivers/net/wireless/ath/ath5k/debug.c
++++ b/drivers/net/wireless/ath/ath5k/debug.c
+@@ -58,8 +58,10 @@
+  * THE POSSIBILITY OF SUCH DAMAGES.
+  */
+
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
++#include <linux/printk.h>
+ #include <linux/export.h>
+ #include <linux/moduleparam.h>
+
-- 
1.7.11.4

