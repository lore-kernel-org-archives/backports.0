Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57981 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3DJLhC (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:37:02 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so269868pad.30
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:37:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 18/18] backports: add update-initramfs support
Date: Wed, 10 Apr 2013 04:35:28 -0700
Message-Id: <1365593728-5720-19-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_134304_838254_8C069708)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

You'll need to update your initramfs for for a few modules.
This is very distribution specific.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile.real            |    1 +
 backport/scripts/update-initramfs |   62 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100755 backport/scripts/update-initramfs

diff --git a/backport/Makefile.real b/backport/Makefile.real
index f2b5b56..c788f89 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -96,6 +96,7 @@ install: modules
 	@./scripts/check_depmod
 	@./scripts/backport_firmware_install
 	@/sbin/depmod -a
+	@./scripts/update-initramfs $(KLIB)
 	@echo
 	@echo Your backported driver modules should be installed now.
 	@echo Reboot.
diff --git a/backport/scripts/update-initramfs b/backport/scripts/update-initramfs
new file mode 100755
index 0000000..9396cb3
--- /dev/null
+++ b/backport/scripts/update-initramfs
@@ -0,0 +1,62 @@
+#!/bin/bash
+# Copyright 2009-2013        Luis R. Rodriguez <mcgrof@do-not-panic.com>
+#
+# Since we provide ssb, ethernet modules and most importantly
+# DRM drivers, people may want to update the initramfs image
+# of their distribution. This can also help people who may
+# want to wireless-boot their systems.
+
+KLIB=1
+ver=$(echo $KLIB | awk -F "/lib/modules/" '{print $2}' | awk -F"/" '{print $1}')
+dir=/boot/
+
+LSB_RED_ID=$(/usr/bin/lsb_release -i -s &> /dev/null)
+
+if [[ -z $LSB_RED_ID && -f "/etc/os-release" ]]; then
+	# Let's try with os-release. Fedora doesn't have
+	# lsb_release anymore.
+	LSB_RED_ID=$(sed -n '/^NAME/ s/^NAME=\(.*\)$/\1/p' /etc/os-release)
+fi
+
+case $LSB_RED_ID in
+"Ubuntu")
+	echo "Updating ${LSB_RED_ID}'s initramfs for $ver under $dir ..."
+	mkinitramfs -o $dir/initrd.img-$ver $ver
+	echo "Will now run update-grub to ensure grub will find the new initramfs ..."
+	update-grub
+	;;
+"Debian")
+	echo "Updating ${LSB_RED_ID}'s initramfs for $ver under $dir ..."
+	mkinitramfs -o $dir/initrd.img-$ver $ver
+	echo "Will now run update-grub to ensure grub will find the new initramfs ..."
+	update-grub
+	;;
+"Fedora")
+	# This adds a -compat-drivers suffixed initramfs with a new grub2
+	# entry to not override distribution's default stuff.
+	INITRAMFS=${dir}initramfs-$ver-compat-drivers.img
+	KERNEL=${dir}vmlinuz-$ver
+	GRUB_TITLE="Fedora ($ver) with compat-drivers"
+
+	echo "Updating ${LSB_RED_ID}'s initramfs for $ver under $dir ..."
+	mkinitrd --force $INITRAMFS $ver
+
+	# If a previous compat-drivers entry for the same kernel exists
+	# do not add it again.
+	grep -q "${GRUB_TITLE}" /etc/grub2.cfg &> /dev/null
+	if [[ "$?" == "1" ]]; then
+		echo "Will now run grubby to add a new kernel entry ..."
+		# Add a new kernel entry
+		grubby --grub2 --copy-default --add-kernel="$KERNEL" --initrd="$INITRAMFS" --title="$GRUB_TITLE"
+	fi
+	;;
+*)
+	echo "Warning:"
+	echo "You may or may not need to update your initramfs, you should if"
+	echo "any of the modules installed are part of your initramfs. To add"
+	echo "support for your distribution to do this automatically send a"
+	echo "patch against $0. If your distribution does not require this"
+	echo "send a patch against the '/usr/bin/lsb_release -i -s': $LSB_RED_ID"
+	echo "tag for your distribution to avoid this warning."
+        ;;
+esac
-- 
1.7.10.4

