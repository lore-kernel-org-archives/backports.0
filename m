Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52836 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLgr (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so269768pad.30
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 15/18] backports: add check_depmod to look for module search path
Date: Wed, 10 Apr 2013 04:35:25 -0700
Message-Id: <1365593728-5720-16-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_134304_170244_188A46CE)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backports project relies on you being able to update
your Linux distribution modules by looking at an updates
search path, if one is not found we update depmod to look
for the new path for you.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile.real        |    2 +-
 backport/scripts/check_depmod |   78 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100755 backport/scripts/check_depmod

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 250676d..f70932e 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -93,12 +93,12 @@ install: modules
 			-type f -name *.ko); do        			\
 			gzip -9 $$driver				;\
 	done )
+	@./scripts/check_depmod
 	@/sbin/depmod -ae
 	@echo
 	@echo Your backported driver modules should be installed now.
 	@echo Try loading them with modprobe.
 	@echo
 # FIXME:
-#	check depmod
 #	install/load/unload/... scripts?
 #	compat firmware class udev stuff
diff --git a/backport/scripts/check_depmod b/backport/scripts/check_depmod
new file mode 100755
index 0000000..6123894
--- /dev/null
+++ b/backport/scripts/check_depmod
@@ -0,0 +1,78 @@
+#!/bin/bash
+# Copyright 2009-2013	Luis R. Rodriguez <mcgrof@do-not-panic.com>
+#
+# Ensures your distribution likes to prefer updates/ over the kernel/
+# search updates built-in
+
+# Seems Mandriva has an $DEPMOD_DIR but it doesn't have any files,
+# so lets deal with those distributions.
+DEPMOD_CONF="/etc/depmod.conf"
+DEPMOD_CONF_TMP="$DEPMOD_CONF.backports.old"
+DEPMOD_DIR="/etc/depmod.d/"
+BACKPORT_DEPMOD_FILE="backports.conf"
+GREP_REGEX_UPDATES="^[[:space:]]*search.*[[:space:]]updates\([[:space:]]\|$\)"
+GREP_REGEX_SEARCH="^[[:space:]]*search[[:space:]].\+$"
+DEPMOD_CMD="depmod"
+
+function add_compat_depmod_conf {
+	echo "NOTE: Your distribution lacks an $DEPMOD_DIR directory with "
+	echo "updates/ directory being prioritized for modules, we're adding "
+	echo "one for you."
+	mkdir -p $DEPMOD_DIR
+	FIRST_FILE=$(ls $DEPMOD_DIR|head -1)
+	[ -n "$FIRST_FILE" ] && while [[ $FIRST_FILE < $BACKPORT_DEPMOD_FILE ]]; do
+		BACKPORT_DEPMOD_FILE="0$BACKPORT_DEPMOD_FILE"
+	done
+	echo "search updates" > $DEPMOD_DIR/$BACKPORT_DEPMOD_FILE
+}
+
+function add_global_depmod_conf {
+	echo "NOTE: Your distribution lacks updates/ directory being"
+	echo "prioritized for modules, we're adding it to $DEPMOD_CONF."
+	rm -f $DEPMOD_CONF_TMP
+	[ -f $DEPMOD_CONF ] && cp -f $DEPMOD_CONF $DEPMOD_CONF_TMP
+	echo "search updates" > $DEPMOD_CONF
+	[ -f $DEPMOD_CONF_TMP ] && cat $DEPMOD_CONF_TMP >> $DEPMOD_CONF
+}
+
+function depmod_updates_ok {
+	echo "depmod will prefer updates/ over kernel/ -- OK!"
+}
+
+function add_depmod_conf {
+	if [ -f "$DEPMOD_CONF" ]; then
+		add_global_depmod_conf
+	else
+		DEPMOD_VERSION=$($DEPMOD_CMD --version | cut -d" " -f2 | sed "s/\.//")
+		if [[ $DEPMOD_VERSION -gt 36 ]]; then
+			add_compat_depmod_conf
+		else
+			add_global_depmod_conf
+		fi
+	fi
+}
+
+GREP_FILES=""
+[ -f $DEPMOD_CONF ] && GREP_FILES="$DEPMOD_CONF"
+if [ -d $DEPMOD_DIR ]; then
+	DEPMOD_FILE_COUNT=$(ls $DEPMOD_DIR | wc -l)
+	[[ $DEPMOD_FILE_COUNT -gt 0 ]] && GREP_FILES="$GREP_FILES $DEPMOD_DIR/*"
+fi
+
+if [ -n "$GREP_FILES" ]; then
+	grep -q "$GREP_REGEX_SEARCH" $GREP_FILES
+	if [[ $? -eq 0 ]]; then
+		grep -q "$GREP_REGEX_UPDATES" $GREP_FILES
+		if [[ $? -eq 0 ]]; then
+			depmod_updates_ok
+		else
+			add_depmod_conf
+		fi
+	else
+		depmod_updates_ok
+	fi
+else
+	depmod_updates_ok
+fi
+
+exit 0
-- 
1.7.10.4

