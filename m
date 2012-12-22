Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 3/3] update-initramfs: Add support for Fedora
Date: Sat, 22 Dec 2012 13:04:13 +0200
Message-Id: <1356174253-2192-3-git-send-email-ozancag@gmail.com>
In-Reply-To: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
References: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Fedora doesn't ship lsb_release anymore. So try to read /etc/os-release
to find whether distribution is Fedora.

If Fedora is found, generate a new initramfs suffixed with -compat-drivers
to not override the distribution kernel's default one. Also add a new
kernel entry to grub2 configuration without overriding the default boot
entry.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/update-initramfs | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/scripts/update-initramfs b/scripts/update-initramfs
index f926eeb..ec7aebe 100755
--- a/scripts/update-initramfs
+++ b/scripts/update-initramfs
@@ -6,12 +6,18 @@
 # of their distribution. This can also help people who may
 # want to wireless-boot their systems.
 
-LSB_RED_ID=$(/usr/bin/lsb_release -i -s &> /dev/null)
-
 KLIB=/lib/modules/$(uname -r)/build
 ver=$(echo $KLIB | awk -F "/lib/modules/" '{print $2}' | awk -F"/" '{print $1}')
 dir=/boot/
 
+LSB_RED_ID=$(/usr/bin/lsb_release -i -s &> /dev/null)
+
+if [[ -z $LSB_RED_ID && -f "/etc/os-release" ]]; then
+	# Let's try with os-release. Fedora doesn't have
+	# lsb_release anymore.
+	LSB_RED_ID=$(sed -n '/^NAME/ s/^NAME=\(.*\)$/\1/p' /etc/os-release)
+fi
+
 case $LSB_RED_ID in
 "Ubuntu")
 	echo "Updating ${LSB_RED_ID}'s initramfs for $ver under $dir ..."
@@ -25,6 +31,25 @@ case $LSB_RED_ID in
 	echo "Will now run update-grub to ensure grub will find the new initramfs ..."
 	update-grub
 	;;
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
 *)
 	echo "Warning:"
 	echo "You may or may not need to update your initramfs, you should if"
-- 
1.8.0.2
