Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f68.google.com ([209.85.215.68]:55117 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965549Ab3FUFCx (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 21 Jun 2013 01:02:53 -0400
Received: by mail-la0-f68.google.com with SMTP id fq12so2500027lab.11
        for <backports@vger.kernel.org>; Thu, 20 Jun 2013 22:02:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwxoKwwXX2ROh2XZ113Fbi+7GO_qnM03ZYvnoGmCBVdXNQ@mail.gmail.com>
References: <CAJqaZwyOqP+2x7tfzd5Q=Ugt4c3Zn-JU_pjOH-6ypqpWdS--hg@mail.gmail.com>
	<CAB=NE6X17uSMo7B_Gf9uTBn4be45HBupvqwXfZHfiOrVxicF=A@mail.gmail.com>
	<CAJqaZwxoKwwXX2ROh2XZ113Fbi+7GO_qnM03ZYvnoGmCBVdXNQ@mail.gmail.com>
Date: Thu, 20 Jun 2013 22:02:52 -0700
Message-ID: <CAJqaZwzigpvYhzw2i1b9exxXq9RE7KnMY8CzY_k1d1tYR=u1kA@mail.gmail.com> (sfid-20130621_070258_084546_0020F5D2)
Subject: [PATCH v3] backports: re-introduce make uninstall
From: ASIC Felix <ic.felix@gmail.com>
To: do-not <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Bitterli <ic.felix@gmail.com>
---
 backport/Makefile.real               |   10 ++++++++++
 backport/scripts/compress_modules.sh |   13 ++-----------
 backport/scripts/mod_helpers.sh      |   11 +++++++++++
 backport/scripts/uninstall.sh        |   17 +++++++++++++++++
 4 files changed, 40 insertions(+), 11 deletions(-)
 create mode 100644 backport/scripts/mod_helpers.sh
 create mode 100755 backport/scripts/uninstall.sh

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 2a1f640..40d91bd 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -101,6 +101,16 @@ install: modules
 .PHONY: modules_install
 modules_install: install

+.PHONY: uninstall
+uninstall:
+	@./scripts/uninstall.sh
+	@/sbin/depmod -a
+	@./scripts/update-initramfs.sh $(KLIB)
+	@echo
+	@echo Your backported driver modules should be uninstalled now.
+	@echo Reboot.
+	@echo
+	
 .PHONY: clean
 clean:
 	@$(MAKE) -f Makefile.build clean
diff --git a/backport/scripts/compress_modules.sh
b/backport/scripts/compress_modules.sh
index bbf264f..b2034c2 100755
--- a/backport/scripts/compress_modules.sh
+++ b/backport/scripts/compress_modules.sh
@@ -2,20 +2,11 @@

 set -e

-function mod_filename()
-{
-	which modinfo > /dev/null 2>&1
-	if [[ $? -eq 0 ]]; then
-		MOD_QUERY="modinfo -F filename"
-	else
-		MOD_QUERY="modprobe -l"
-	fi
-	mod_path="$($MOD_QUERY $1 | tail -1)"
-	echo $(basename "$mod_path")
-}
+source ./scripts/mod_helpers.sh

 if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
 	for driver in $(find "$1" -type f -name *.ko); do
+		echo COMPRESS $driver
 		gzip -9 $driver
 	done
 fi
diff --git a/backport/scripts/mod_helpers.sh b/backport/scripts/mod_helpers.sh
new file mode 100644
index 0000000..0845b3e
--- /dev/null
+++ b/backport/scripts/mod_helpers.sh
@@ -0,0 +1,11 @@
+function mod_filename()
+{
+	which modinfo > /dev/null 2>&1
+	if [[ $? -eq 0 ]]; then
+		MOD_QUERY="modinfo -F filename"
+	else
+		MOD_QUERY="modprobe -l"
+	fi
+	mod_path="$($MOD_QUERY $1 | tail -1)"
+	echo $(basename "$mod_path")
+}
diff --git a/backport/scripts/uninstall.sh b/backport/scripts/uninstall.sh
new file mode 100755
index 0000000..7b54d2a
--- /dev/null
+++ b/backport/scripts/uninstall.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+set -e
+
+source ./scripts/mod_helpers.sh
+
+if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
+	compr=".gz"
+else
+	compr=""
+fi
+
+for driver in $(find ${BACKPORT_PWD} -type f -name *.ko); do
+	mod_name=${KLIB}${KMODDIR}/${driver}${compr}
+	echo "  uninstall" $mod_name
+	rm -f $mod_name
+done
-- 
1.7.9.5
