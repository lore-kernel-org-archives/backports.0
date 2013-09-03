Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:35273 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab3ICPJV (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 3 Sep 2013 11:09:21 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so1822542wes.14
        for <backports@vger.kernel.org>; Tue, 03 Sep 2013 08:09:20 -0700 (PDT)
From: Eliad Peller <eliad@wizery.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: <backports@vger.kernel.org>
Subject: [PATCH] backports: skip some install operations if KLIB is defined
Date: Tue,  3 Sep 2013 18:09:12 +0300
Message-Id: <1378220952-9610-1-git-send-email-eliad@wizery.com> (sfid-20130903_170959_326123_54BD576C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When a custom rootfs is being used, there is no point
in running various installation operations (such as depmod)
on the host file system.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
I assume here KLIB is only used when some cross-compilation is
used, so local installation probably won't follow.
I'm not sure this is correct, though...
is there a better way to detect such scenario (without
false positives)?

 backport/Makefile      | 4 +++-
 backport/Makefile.real | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index ca69f41..3165c0e 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -11,16 +11,18 @@ BACKPORT_PWD := $(shell pwd)
 KMODDIR ?= updates
 ifneq ($(origin KLIB), undefined)
 KMODPATH_ARG := "INSTALL_MOD_PATH=$(KLIB)"
+ROOTFS_DIR := $(KLIB)
 else
 KLIB := /lib/modules/$(shell uname -r)/
 KMODPATH_ARG :=
+ROOTFS_DIR :=
 endif
 KLIB_BUILD ?= $(KLIB)/build/
 KERNEL_CONFIG := $(KLIB_BUILD)/.config
 KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
 CONFIG_MD5 := $(shell md5sum $(KERNEL_CONFIG) 2>/dev/null | sed 's/\s.*//')
 
-export KLIB KLIB_BUILD BACKPORT_PWD KMODDIR KMODPATH_ARG
+export KLIB KLIB_BUILD BACKPORT_PWD KMODDIR KMODPATH_ARG ROOTFS_DIR
 
 # disable built-in rules for this file
 .SUFFIXES:
diff --git a/backport/Makefile.real b/backport/Makefile.real
index c09663c..9756c32 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -87,12 +87,14 @@ install: modules
 	@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_PWD)			\
 		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
 		modules_install
+ifeq ($(ROOTFS_DIR),)
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
 	@./scripts/check_depmod.sh
 	@./scripts/backport_firmware_install.sh
 	@/sbin/depmod -a
 	@./scripts/update-initramfs.sh $(KLIB)
+endif
 	@echo
 	@echo Your backported driver modules should be installed now.
 	@echo Reboot.
-- 
1.8.3.rc1.35.g9b79519

