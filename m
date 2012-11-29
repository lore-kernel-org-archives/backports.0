Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] compat-drivers: print original name and path of patch in refresh
Date: Thu, 29 Nov 2012 16:24:37 +0100
Message-Id: <1354202681-11787-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

In the old version patches.orig/<patch name>.patch was printed as the
current patch quilt is working on in refresh, now e.g. patches/network
/<patch name>.patch is printed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/admin-update.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 6a085e3..89aae9f 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -51,7 +51,7 @@ patchRefresh() {
 			echo -e "${RED}No patches found in $1${NORMAL}"
 			break;
 		fi
-		echo -e "${GREEN}Refresh backport patch${NORMAL}: ${BLUE}$i${NORMAL}"
+		echo -e "${GREEN}Refresh backport patch${NORMAL}: ${BLUE}${1}/$(basename $i)${NORMAL}"
 		quilt import $i
 		quilt push -f
 		RET=$?
-- 
1.7.10.4
