Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:59667 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3BCSeE (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 3 Feb 2013 13:34:04 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so907561wib.4
        for <backports@vger.kernel.org>; Sun, 03 Feb 2013 10:34:02 -0800 (PST)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Add possibility to build every subsystem separately
Date: Sun,  3 Feb 2013 20:33:45 +0200
Message-Id: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Currently we're enabling both drm and network drivers in
scripts/admin-update.sh by default.

One of the problems is that I don't want to build network drivers at
all. If I change admin-update.sh to disable network drivers, another
problem arises: Makefile tries to add objects without looking at all
what subsystem is enabled.

This patch addresses this problem by keeping the names of enabled
subsystems in a text file called ".enabled_subsystems". Makefile then
looks in it to conditionally enable drm, network or both.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 Makefile                | 22 +++++++++++++---------
 scripts/admin-clean.sh  |  1 +
 scripts/admin-update.sh |  8 +++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index e986a09..1f42511 100644
--- a/Makefile
+++ b/Makefile
@@ -40,10 +40,13 @@ NOSTDINC_FLAGS := \
 
 obj-y := compat/
 
-obj-$(CONFIG_COMPAT_RFKILL) += net/rfkill/
-obj-$(CONFIG_COMPAT_VIDEO_MODULES) += drivers/gpu/drm/
 
-ifeq ($(BT),)
+ifneq (,$(findstring drm, $(SUBSYSTEMS)))
+	obj-$(CONFIG_COMPAT_VIDEO_MODULES) += drivers/gpu/drm/
+endif
+
+ifneq (,$(findstring network, $(SUBSYSTEMS)))
+obj-$(CONFIG_COMPAT_RFKILL) += net/rfkill/
 obj-$(CONFIG_COMPAT_WIRELESS) += net/wireless/ net/mac80211/
 obj-$(CONFIG_COMPAT_WIRELESS_MODULES) += drivers/net/wireless/
 
@@ -56,14 +59,14 @@ obj-$(CONFIG_COMPAT_VAR_MODULES) += drivers/ssb/
 obj-$(CONFIG_COMPAT_VAR_MODULES) += drivers/bcma/
 obj-$(CONFIG_COMPAT_VAR_MODULES) += drivers/misc/eeprom/
 
+obj-$(CONFIG_COMPAT_BLUETOOTH) += net/bluetooth/
+obj-$(CONFIG_COMPAT_BLUETOOTH_MODULES) += drivers/bluetooth/
+
 ifeq ($(CONFIG_STAGING_EXCLUDE_BUILD),)
 endif
 
 endif
 
-obj-$(CONFIG_COMPAT_BLUETOOTH) += net/bluetooth/
-obj-$(CONFIG_COMPAT_BLUETOOTH_MODULES) += drivers/bluetooth/
-
 else
 
 export PWD :=	$(shell pwd)
@@ -90,6 +93,7 @@ export COMPAT_AUTOCONF=include/linux/compat_autoconf.h
 export CREL=$(shell cat $(PWD)/.compat_version)
 export CREL_PRE:=.compat_autoconf_
 export CREL_CHECK:=$(PWD)/$(CREL_PRE)$(CREL)
+export SUBSYSTEMS = $(shell cat $(PWD)/.enabled_subsystems)
 
 all: modules
 
@@ -102,7 +106,7 @@ modules: $(CREL_CHECK)
 
 bt: $(CREL_CHECK)
 	+@./scripts/check_config.sh
-	$(MAKE) -C $(KLIB_BUILD) M=$(PWD) BT=TRUE modules
+	$(MAKE) -C $(KLIB_BUILD) M=$(PWD) modules
 	@touch $@
 
 # We use a CREL_CHECK variable which will depend on the environment used to
@@ -124,7 +128,7 @@ $(CREL_CHECK):
 btinstall: btuninstall bt-install-modules
 
 bt-install-modules: bt
-	$(MAKE) -C $(KLIB_BUILD) M=$(PWD) $(KMODDIR_ARG) $(KMODPATH_ARG) BT=TRUE \
+	$(MAKE) -C $(KLIB_BUILD) M=$(PWD) $(KMODDIR_ARG) $(KMODPATH_ARG) \
 		modules_install
 	@/sbin/depmod -ae
 	@echo
@@ -145,7 +149,7 @@ btuninstall:
 	@echo
 
 btclean:
-	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) BT=TRUE clean
+	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
 	@rm -f $(CREL_PRE)*
 
 install: uninstall install-modules install-scripts
diff --git a/scripts/admin-clean.sh b/scripts/admin-clean.sh
index dd26670..2579046 100755
--- a/scripts/admin-clean.sh
+++ b/scripts/admin-clean.sh
@@ -10,5 +10,6 @@ rm -rf udev
 rm -f .compat_base_tree
 rm -f .compat_base_tree_version
 rm -f .compat_version
+rm -f .enabled_subsystems
 rm -f code-metrics.txt
 echo "Cleaned compat-drivers"
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 73f0cea..5a63064 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -222,8 +222,8 @@ copyDirectories() {
 # drivers will be fetched in from the GIT repository. To retain
 # compatibility with compat-wireless, wlan/bt/eth drivers are
 # fetched in by default.
-ENABLE_NETWORK=1
-ENABLE_DRM=1
+ENABLE_NETWORK=0
+ENABLE_DRM=0
 ENABLE_UNIFIED=0
 SUBSYSTEMS=
 UNIFIED_DRIVERS=
@@ -576,7 +576,6 @@ if [ $# -ge 1 ]; then
 				;;
 			"network")
 				ENABLE_NETWORK=1
-				ENABLE_DRM=0
 				shift
 				;;
 			"drm")
@@ -606,6 +605,9 @@ if [[ "$ENABLE_DRM" == "1" ]]; then
 	SUBSYSTEMS+=" drm"
 fi
 
+# Write down enabled subsystems
+echo "$SUBSYSTEMS" > .enabled_subsystems
+
 if [[ "$ENABLE_NETWORK" == "1" ]]; then
 	# WLAN and bluetooth files
 	copyFiles "$INCLUDE_LINUX_WLAN"			"include/linux"
-- 
1.8.1.2

