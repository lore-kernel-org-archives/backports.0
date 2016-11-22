Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33485 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753626AbcKVQAj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 22 Nov 2016 11:00:39 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so8959601pgd.0
        for <backports@vger.kernel.org>; Tue, 22 Nov 2016 08:00:13 -0800 (PST)
From: Thomas Pedersen <thomas@eero.com>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de, Thomas Pedersen <thomas@eero.com>
Subject: [PATCH 2/2] remove KMODPATH_ARG
Date: Tue, 22 Nov 2016 07:59:55 -0800
Message-Id: <20161122155955.1038-2-thomas@eero.com> (sfid-20161122_170042_424549_77EB9565)
In-Reply-To: <20161122155955.1038-1-thomas@eero.com>
References: <20161122155955.1038-1-thomas@eero.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This interferes with module install when specifying KLIB.

According to kernel docs, INSTALL_MOD_PATH is the module
install path prefix:

	INSTALL_MOD_PATH
	--------------------------------------------------
	INSTALL_MOD_PATH specifies a prefix to MODLIB for
	module directory relocations required by build
	roots.  This is not defined in the makefile but
	the argument can be passed to make if needed.

Which causes modules to be installed in
/lib/modules/$KLIB_VERSION/lib/modules/$KLIB_VERSION.

Signed-off-by: Thomas Pedersen <thomas@eero.com>
---
 backport/Makefile      | 4 +---
 backport/Makefile.real | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index edd36b7..8cf1096 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -10,11 +10,9 @@ BACKPORT_DIR := $(shell pwd)
 
 KMODDIR ?= updates
 ifneq ($(origin KLIB), undefined)
-KMODPATH_ARG := "INSTALL_MOD_PATH=$(KLIB)"
 KLIB_VERSION := $(shell basename $(KLIB))
 else
 KLIB_VERSION := $(shell uname -r)
-KMODPATH_ARG :=
 KLIB := /lib/modules/$(KLIB_VERSION)/
 endif
 KLIB_BUILD ?= $(KLIB)/build/
@@ -22,7 +20,7 @@ KERNEL_CONFIG := $(KLIB_BUILD)/.config
 KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
 CONFIG_MD5 := $(shell md5sum $(KERNEL_CONFIG) 2>/dev/null | sed 's/\s.*//')
 
-export KLIB KLIB_VERSION KLIB_BUILD BACKPORT_DIR KMODDIR KMODPATH_ARG
+export KLIB KLIB_VERSION KLIB_BUILD BACKPORT_DIR KMODDIR
 
 # disable built-in rules for this file
 .SUFFIXES:
diff --git a/backport/Makefile.real b/backport/Makefile.real
index 5ec133e..b65474b 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -90,7 +90,7 @@ modules: backport-include/backport/autoconf.h
 .PHONY: install
 install: modules
 	@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR)			\
-		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
+		INSTALL_MOD_DIR=$(KMODDIR)				\
 		modules_install
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe backports" in
