Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33266 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLgm (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so265884pab.22
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 14/18] backports: add support for module compression
Date: Wed, 10 Apr 2013 04:35:24 -0700
Message-Id: <1365593728-5720-15-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133644_459305_596DFDC7)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Some Linux distributions like to compress their modules.
Add support to detect this in a modutils / modprobe agnostic
way.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile.real               |    6 +++++-
 backport/scripts/are_mods_compressed |    8 ++++++++
 backport/scripts/mod_path            |    8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100755 backport/scripts/are_mods_compressed
 create mode 100755 backport/scripts/mod_path

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 032a8d7..250676d 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -88,13 +88,17 @@ install: modules
 		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
 		modules_install
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
+	@./scripts/are_mods_compressed || (				\
+        for driver in $$(find $(KLIB)/$(KMODDIR) 			\
+			-type f -name *.ko); do        			\
+			gzip -9 $$driver				;\
+	done )
 	@/sbin/depmod -ae
 	@echo
 	@echo Your backported driver modules should be installed now.
 	@echo Try loading them with modprobe.
 	@echo
 # FIXME:
-#	compress modules
 #	check depmod
 #	install/load/unload/... scripts?
 #	compat firmware class udev stuff
diff --git a/backport/scripts/are_mods_compressed b/backport/scripts/are_mods_compressed
new file mode 100755
index 0000000..989da2f
--- /dev/null
+++ b/backport/scripts/are_mods_compressed
@@ -0,0 +1,8 @@
+#!/bin/bash
+MODULE=$(./scripts/mod_path mac80211)
+MODULE=${MODULE##*/}
+if [ "$MODULE" = "mac80211.ko.gz" ]; then
+	COMPRESSION_FOUND="y"
+	exit 1
+fi
+exit 0
diff --git a/backport/scripts/mod_path b/backport/scripts/mod_path
new file mode 100755
index 0000000..f37321f
--- /dev/null
+++ b/backport/scripts/mod_path
@@ -0,0 +1,8 @@
+#!/bin/bash
+which modinfo > /dev/null 2>&1
+if [[ $? -eq 0 ]]; then
+	MOD_QUERY="modinfo -F filename"
+else
+	MOD_QUERY="modprobe -l"
+fi
+$MOD_QUERY $1 | tail -1
-- 
1.7.10.4

