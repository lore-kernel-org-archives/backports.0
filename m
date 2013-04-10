Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38143 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLgh (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:37 -0400
Received: by mail-pb0-f51.google.com with SMTP id rr4so217632pbb.38
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 13/18] backports: add blacklist module support
Date: Wed, 10 Apr 2013 04:35:23 -0700
Message-Id: <1365593728-5720-14-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133640_105354_E6DDC8A1)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This lets us provide a simple map of new drivers and old
drivers that it replaces at install time. This generates
a blacklist via the file:

/etc/modprobe.d/backports.conf

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/.blacklist.map       |   10 ++++++++++
 backport/Makefile.real        |    3 +--
 backport/scripts/blacklist.sh |   35 +++++++++++++++++++++++++++++++++++
 gentree.py                    |    1 +
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 backport/.blacklist.map
 create mode 100755 backport/scripts/blacklist.sh

diff --git a/backport/.blacklist.map b/backport/.blacklist.map
new file mode 100644
index 0000000..a96d03e
--- /dev/null
+++ b/backport/.blacklist.map
@@ -0,0 +1,10 @@
+# Update this map when a driver gets renamed or
+# symbols from old drivers get moved to a newer
+# driver. If you have the driver on the right
+# hand side it will be blacklisted upon installation
+# only if you actually installed the driver on the
+# left.
+
+# new-driver	old-driver
+iwlagn		iwlwifi
+iwlagn		iwl4965
diff --git a/backport/Makefile.real b/backport/Makefile.real
index 40668c2..032a8d7 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -87,6 +87,7 @@ install: modules
 	@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_PWD)			\
 		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
 		modules_install
+	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
 	@/sbin/depmod -ae
 	@echo
 	@echo Your backported driver modules should be installed now.
@@ -95,7 +96,5 @@ install: modules
 # FIXME:
 #	compress modules
 #	check depmod
-#	iwlwifi vs. iwlagn
-#	iwl4965 vs. iwlagn
 #	install/load/unload/... scripts?
 #	compat firmware class udev stuff
diff --git a/backport/scripts/blacklist.sh b/backport/scripts/blacklist.sh
new file mode 100755
index 0000000..921585f
--- /dev/null
+++ b/backport/scripts/blacklist.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+
+BLACKLIST_CONF="/etc/modprobe.d/backports.conf"
+BLACKLIST_MAP=".blacklist.map"
+
+MODULE_DIR=$1
+MODULE_UPDATES=$2
+
+if [[ ! -d $MODULE_DIR ]]; then
+	exit
+fi
+
+if [[ ! -d $MODULE_UPDATES ]]; then
+	exit
+fi
+
+mkdir -p $(dirname $BLACKLIST_CONF)
+rm -f $BLACKLIST_CONF
+
+echo "# To be used when using backported drivers" >> $BLACKLIST_CONF
+
+for i in $(grep -v ^# $BLACKLIST_MAP | cut -f 2); do
+	MODULE="${i}.ko"
+	MODULE_UPDATE="$(grep -v ^# $BLACKLIST_MAP | grep $i | cut -f 1 | head -1).ko"
+
+	COUNT=$(find $MODULE_DIR -type f -name ${MODULE} -or -name ${MODULE}.gz | wc -l)
+	COUNT_REPLACE=$(find $MODULE_UPDATES -type f -name ${MODULE_UPDATE} -or -name ${MODULE_UPDATE}.gz | wc -l)
+
+	if [ $COUNT -ne 0 ]; then
+		if [ $COUNT_REPLACE -ne 0 ]; then
+			echo "Blacklisting $MODULE ..."
+			echo blacklist $i >> $BLACKLIST_CONF
+		fi
+	fi
+done
diff --git a/gentree.py b/gentree.py
index adef899..3f875c7 100755
--- a/gentree.py
+++ b/gentree.py
@@ -324,6 +324,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     backport_files = [(x, x) for x in [
         'Kconfig', 'Makefile', 'Makefile.build', 'Makefile.kernel', '.gitignore',
         'Makefile.real', 'compat/', 'include/', 'kconfig/', 'defconfigs/',
+	'scripts/', '.blacklist.map',
     ]]
     if not args.git_revision:
         logwrite('Copy original source files ...')
-- 
1.7.10.4

