Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:58482 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbaEHUkY (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:24 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so2988493wes.23
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:23 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 05/10] backports: check_depmod.sh: support install root not in /
Date: Thu,  8 May 2014 22:39:28 +0200
Message-Id: <1399581573-12072-6-git-send-email-s.martin49@gmail.com> (sfid-20140508_224025_987691_96125E77)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile.real           | 6 ++++--
 backport/scripts/check_depmod.sh | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 5a25db4..a12a0db 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -6,6 +6,8 @@ else
 export BACKPORTS_GIT_TRACKER_DEF=
 endif
 
+DEPMOD ?= /sbin/depmod
+
 # disable built-in rules for this file
 .SUFFIXES:
 
@@ -94,8 +96,8 @@ install: modules
 		modules_install
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR) $(KROOT)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
-	@./scripts/check_depmod.sh
-	@/sbin/depmod -a
+	@./scripts/check_depmod.sh $(DEPMOD) $(KROOT)
+	@$(DEPMOD) -a
 	@./scripts/update-initramfs.sh $(KLIB)
 	@echo
 	@echo Your backported driver modules should be installed now.
diff --git a/backport/scripts/check_depmod.sh b/backport/scripts/check_depmod.sh
index 6123894..9f2e238 100755
--- a/backport/scripts/check_depmod.sh
+++ b/backport/scripts/check_depmod.sh
@@ -6,13 +6,14 @@
 
 # Seems Mandriva has an $DEPMOD_DIR but it doesn't have any files,
 # so lets deal with those distributions.
-DEPMOD_CONF="/etc/depmod.conf"
+DEPMOD_CMD="${1:-depmod}"
+KROOT="${2:-/}"
+DEPMOD_CONF="$KROOT/etc/depmod.conf"
 DEPMOD_CONF_TMP="$DEPMOD_CONF.backports.old"
-DEPMOD_DIR="/etc/depmod.d/"
+DEPMOD_DIR="$KROOT/etc/depmod.d/"
 BACKPORT_DEPMOD_FILE="backports.conf"
 GREP_REGEX_UPDATES="^[[:space:]]*search.*[[:space:]]updates\([[:space:]]\|$\)"
 GREP_REGEX_SEARCH="^[[:space:]]*search[[:space:]].\+$"
-DEPMOD_CMD="depmod"
 
 function add_compat_depmod_conf {
 	echo "NOTE: Your distribution lacks an $DEPMOD_DIR directory with "
-- 
1.9.2

