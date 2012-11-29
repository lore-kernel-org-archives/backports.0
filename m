Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] compat-drivers: do not apply patches in natural sort order
Date: Thu, 29 Nov 2012 16:24:41 +0100
Message-Id: <1354202681-11787-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Without this patch the patches are applied in the natural sort order of
numbers, which caused this order for patches/network/:
patches/network/0001-netdev_ops.patch
patches/network/02-ksize.patch
patches/network/0002-net-misc.patch
patches/network/0003-netdev-needed_headroom_tailroom.patch
patches/network/03-rfkill.patch
patches/network/04-netns.patch
patches/network/0004-wext-namespace.patch
patches/network/0005-netlink-portid.patch
patches/network/05-usb.patch

The non natural sort order of numbers is more the intended way to order
the patches as now the spdiff patches are in front of all the other
patches. This makes the patches in patches/network/ to be applied in
the flowing order:
patches/network/0001-netdev_ops.patch
patches/network/0002-net-misc.patch
patches/network/0003-netdev-needed_headroom_tailroom.patch
patches/network/0004-wext-namespace.patch
patches/network/0005-netlink-portid.patch
patches/network/02-ksize.patch
patches/network/03-rfkill.patch
patches/network/04-netns.patch
patches/network/05-usb.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/admin-update.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index cdc5ce5..f05081a 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -699,7 +699,7 @@ for subsystem in $SUBSYSTEMS; do
 			continue
 		fi
 
-		for i in $(ls -v $PATCHDIR/*.patch); do
+		for i in $(ls $PATCHDIR/*.patch); do
 			echo -e "${GREEN}Applying backport patch${NORMAL}: ${BLUE}$i${NORMAL}"
 			patch -p1 -N -t < $i
 			RET=$?
-- 
1.7.10.4
