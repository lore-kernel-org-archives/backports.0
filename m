Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50759 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3FIARB (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 8 Jun 2013 20:17:01 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so5335141lbj.28
        for <backports@vger.kernel.org>; Sat, 08 Jun 2013 17:17:00 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 8 Jun 2013 17:17:00 -0700
Message-ID: <CAJqaZwyhCxQRqEQ8wKjD96u0avs3Qjjda2u_oxTb3y-Vj7ie8g@mail.gmail.com> (sfid-20130609_021706_989987_CC4C5C94)
Subject: [PATCH] backports: re-introduce make uninstall
From: ASIC Felix <ic.felix@gmail.com>
To: do-not <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Re-introducing make uninstall. It works, but feel more than welcome to
tidy it up.

Signed-off-by: Felix Bitterli <ic.felix@gmail.com>
---
 backport/Makefile.real        |   10 ++++++++++
 backport/scripts/uninstall.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
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
+    @./scripts/uninstall.sh
+    @/sbin/depmod -a
+    @./scripts/update-initramfs.sh $(KLIB)
+    @echo
+    @echo Your backported driver modules should be uninstalled now.
+    @echo Reboot.
+    @echo
+
 .PHONY: clean
 clean:
     @$(MAKE) -f Makefile.build clean
diff --git a/backport/scripts/uninstall.sh b/backport/scripts/uninstall.sh
new file mode 100755
index 0000000..4deb7c1
--- /dev/null
+++ b/backport/scripts/uninstall.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+set -e
+
+function mod_filename()
+{
+    which modinfo > /dev/null 2>&1
+    if [[ $? -eq 0 ]]; then
+        MOD_QUERY="modinfo -F filename"
+    else
+        MOD_QUERY="modprobe -l"
+    fi
+    mod_path="$($MOD_QUERY $1 | tail -1)"
+    echo $(basename "$mod_path")
+}
+
+if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
+    compr=".ko"
+else
+    compr=""
+fi
+
+for driver in $(find -type f -name *.ko); do
+    mod_name=$KLIB"updates/"$driver$compr
+    rm -f $mod_name
+done
--
1.7.9.5
