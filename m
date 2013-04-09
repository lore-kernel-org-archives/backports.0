Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:55799 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935153Ab3DIJLk (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Apr 2013 05:11:40 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add backport version to all modules
Date: Tue,  9 Apr 2013 11:11:33 +0200
Message-Id: <1365498693-21795-1-git-send-email-johannes@sipsolutions.net> (sfid-20130409_111143_678876_9F6F96A7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

We print out the backports version at runtime, but it
can also be useful to be able to determine it from the
installed modules.

As we already override module_init() to make all our
backported modules depend on compat.ko (in order to do
exactly this -- print out the version at runtime) also
add some MODULE_VERSION directives to it.

This results in, for example for mac80211, this:

$ /sbin/modinfo .../net/mac80211/mac80211.ko
filename:       .../net/mac80211/mac80211.ko
license:        GPL
description:    IEEE 802.11 subsystem
version:        backported from: Linux (next-20130405-0-g7df052b)
version:        backports: 6e0475b
srcversion:     6C298E6033E34EA8E223D7B
depends:        cfg80211,compat
vermagic:       3.8.0 SMP mod_unload modversions
parm:           max_nullfunc_tries:Maximum nullfunc tx tries before disconnecting (reason 4). (int)
parm:           max_probe_tries:Maximum probe tries before disconnecting (reason 4). (int)
parm:           probe_wait_ms:Maximum time(ms) to wait for probe response before disconnecting (reason 4). (int)
parm:           ieee80211_default_rc_algo:Default rate control algorithm for mac80211 to use (charp)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.kernel            | 3 +++
 backport/compat/Makefile            | 3 ---
 backport/include/linux/compat-2.6.h | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 4d00bda..54a1218 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -9,6 +9,9 @@ NOSTDINC_FLAGS := \
 	-I$(M)/include/drm \
 	-include $(M)/include/linux/compat-2.6.h \
 	$(call backport-cc-disable-warning, unused-but-set-variable) \
+	-DBACKPORTS_VERSION=\"$(BACKPORTS_VERSION)\" \
+	-DBACKPORTED_KERNEL_VERSION=\"$(BACKPORTED_KERNEL_VERSION)\" \
+	-DBACKPORTED_KERNEL_NAME=\"$(BACKPORTED_KERNEL_NAME)\" \
 	$(CFLAGS)
 
 obj-y += compat/
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 62dd531..499d4c0 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -1,7 +1,4 @@
 ccflags-y += -I$(src)
-ccflags-y += -DBACKPORTS_VERSION=\"$(BACKPORTS_VERSION)\"
-ccflags-y += -DBACKPORTED_KERNEL_VERSION=\"$(BACKPORTED_KERNEL_VERSION)\"
-ccflags-y += -DBACKPORTED_KERNEL_NAME=\"$(BACKPORTED_KERNEL_NAME)\"
 obj-m += compat.o
 compat-y += main.o
 
diff --git a/backport/include/linux/compat-2.6.h b/backport/include/linux/compat-2.6.h
index 57a1c13..408fc60 100644
--- a/backport/include/linux/compat-2.6.h
+++ b/backport/include/linux/compat-2.6.h
@@ -38,7 +38,11 @@ void backport_dependency_symbol(void);
 		backport_dependency_symbol();				\
 		return initfn();					\
 	}								\
-	int init_module(void) __attribute__((alias("__init_backport")));
+	int init_module(void) __attribute__((alias("__init_backport")));\
+	MODULE_VERSION("backports: " BACKPORTS_VERSION);		\
+	MODULE_VERSION("backported from: " 				\
+			BACKPORTED_KERNEL_NAME " ("			\
+			BACKPORTED_KERNEL_VERSION ")");
 
 /*
  * Each compat file represents compatibility code for new kernel
-- 
1.8.0

