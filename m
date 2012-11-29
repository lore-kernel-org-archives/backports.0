Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] compat-drivers: prevent mixing patches from different directories in refresh
Date: Thu, 29 Nov 2012 16:24:39 +0100
Message-Id: <1354202681-11787-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The refresh script is able to take an already existing quilt run and
just refresh the further needed patches. This is needed to make it
possible to manually fix a patch which is not applying any more and
then automatically integrate it into the patches directory again. With
the integration of drm it could happen that quilt is running on two
different source directories like patches/network and patches/drm in one
call of admin-update.sh. If some of the drm patches did not apply and
needed a manual fix, quilt moved the patch in the second run into the
patches/network directory, because it was taken in the network refresh
run. This patch does not run quilt if there is still an unfinished
quilt job for a different patch directory.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/admin-update.sh |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 48c1070..10a2598 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -36,6 +36,14 @@ GIT_COMPAT_URL="git://github.com/mcgrof/compat.git"
 
 # Refresh patches using quilt
 patchRefresh() {
+	if [ -d .pc ] ; then
+		OLD_PATCH_DIR=$(cat .pc/.quilt_patches)
+		if [ "$OLD_PATCH_DIR" != "$1" ] ; then
+			echo "found old quilt run for ${OLD_PATCH_DIR}, will skip it for ${1}"
+			return;
+		fi
+	fi
+
 	if [ -d patches.orig ] ; then
 		rm -rf .pc patches/series
 	else
-- 
1.7.10.4
