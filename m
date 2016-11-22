Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34355 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbcKVQAj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 22 Nov 2016 11:00:39 -0500
Received: by mail-pf0-f173.google.com with SMTP id c4so4848266pfb.1
        for <backports@vger.kernel.org>; Tue, 22 Nov 2016 08:00:11 -0800 (PST)
From: Thomas Pedersen <thomas@eero.com>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de, Thomas Pedersen <thomas@eero.com>
Subject: [PATCH 1/2] export KLIB_VERSION during make install
Date: Tue, 22 Nov 2016 07:59:54 -0800
Message-Id: <20161122155955.1038-1-thomas@eero.com> (sfid-20161122_170041_865911_2746ED2D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This should fix make install against non-running kernel
versions.

Signed-off-by: Thomas Pedersen <thomas@eero.com>
---
 backport/Makefile               | 6 ++++--
 backport/Makefile.real          | 4 ++--
 backport/scripts/mod_helpers.sh | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index 11678f6..edd36b7 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -11,16 +11,18 @@ BACKPORT_DIR := $(shell pwd)
 KMODDIR ?= updates
 ifneq ($(origin KLIB), undefined)
 KMODPATH_ARG := "INSTALL_MOD_PATH=$(KLIB)"
+KLIB_VERSION := $(shell basename $(KLIB))
 else
-KLIB := /lib/modules/$(shell uname -r)/
+KLIB_VERSION := $(shell uname -r)
 KMODPATH_ARG :=
+KLIB := /lib/modules/$(KLIB_VERSION)/
 endif
 KLIB_BUILD ?= $(KLIB)/build/
 KERNEL_CONFIG := $(KLIB_BUILD)/.config
 KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
 CONFIG_MD5 := $(shell md5sum $(KERNEL_CONFIG) 2>/dev/null | sed 's/\s.*//')
 
-export KLIB KLIB_BUILD BACKPORT_DIR KMODDIR KMODPATH_ARG
+export KLIB KLIB_VERSION KLIB_BUILD BACKPORT_DIR KMODDIR KMODPATH_ARG
 
 # disable built-in rules for this file
 .SUFFIXES:
diff --git a/backport/Makefile.real b/backport/Makefile.real
index a0f4916..5ec133e 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -95,7 +95,7 @@ install: modules
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
 	@./scripts/check_depmod.sh
-	@/sbin/depmod -a
+	@/sbin/depmod -a $(KLIB_VERSION)
 	@./scripts/update-initramfs.sh $(KLIB)
 	@echo
 	@echo Your backported driver modules should be installed now.
@@ -108,7 +108,7 @@ modules_install: install
 .PHONY: uninstall
 uninstall:
 	@./scripts/uninstall.sh
-	@/sbin/depmod -a
+	@/sbin/depmod -a $(KLIB_VERSION)
 	@./scripts/update-initramfs.sh $(KLIB)
 	@echo
 	@echo Your backported driver modules should be uninstalled now.
diff --git a/backport/scripts/mod_helpers.sh b/backport/scripts/mod_helpers.sh
index 0845b3e..4056a0f 100644
--- a/backport/scripts/mod_helpers.sh
+++ b/backport/scripts/mod_helpers.sh
@@ -2,7 +2,7 @@ function mod_filename()
 {
 	which modinfo > /dev/null 2>&1
 	if [[ $? -eq 0 ]]; then
-		MOD_QUERY="modinfo -F filename"
+		MOD_QUERY="modinfo -k ${KLIB_VERSION} -F filename"
 	else
 		MOD_QUERY="modprobe -l"
 	fi
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe backports" in
