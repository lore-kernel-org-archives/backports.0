Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:38504 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHUkW (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:22 -0400
Received: by mail-wg0-f51.google.com with SMTP id x13so3085685wgg.22
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:21 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 04/10] backports: blacklist.sh: support install root not in /
Date: Thu,  8 May 2014 22:39:27 +0200
Message-Id: <1399581573-12072-5-git-send-email-s.martin49@gmail.com> (sfid-20140508_224023_901135_F307B002)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile.real        | 2 +-
 backport/scripts/blacklist.sh | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index f60d5ca..5a25db4 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -92,7 +92,7 @@ install: modules
 	@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_PWD)			\
 		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
 		modules_install
-	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
+	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR) $(KROOT)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
 	@./scripts/check_depmod.sh
 	@/sbin/depmod -a
diff --git a/backport/scripts/blacklist.sh b/backport/scripts/blacklist.sh
index f941c4a..f995f11 100755
--- a/backport/scripts/blacklist.sh
+++ b/backport/scripts/blacklist.sh
@@ -1,10 +1,11 @@
 #!/bin/bash
 
-BLACKLIST_CONF="/etc/modprobe.d/backports.conf"
-BLACKLIST_MAP=".blacklist.map"
-
 MODULE_DIR=$1
 MODULE_UPDATES=$2
+KROOT=$3
+
+BLACKLIST_CONF="$KROOT/etc/modprobe.d/backports.conf"
+BLACKLIST_MAP=".blacklist.map"
 
 if [[ ! -d $MODULE_DIR ]]; then
 	exit
-- 
1.9.2

