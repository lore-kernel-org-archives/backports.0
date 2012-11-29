Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] compat-drivers: run refresh for all patches
Date: Thu, 29 Nov 2012 16:24:40 +0100
Message-Id: <1354202681-11787-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

In the past refresh with quilt was just run for the last patch
directory being applied and not for all, because our script had
problems when patchRefresh() was called more then once in a single
admin-update.sh run. This was fixed in the last patch and now it is
safe to run it on all patches.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/admin-update.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 10a2598..cdc5ce5 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -690,7 +690,7 @@ for subsystem in $SUBSYSTEMS; do
 			echo -e "${RED}Patches: $PATCHDIR empty, skipping...${NORMAL}"
 			continue
 		fi
-		if [[ $LAST_ELEM = $dir && "$REFRESH" = y ]]; then
+		if [[ "$REFRESH" = y ]]; then
 			patchRefresh $PATCHDIR
 		fi
 
-- 
1.7.10.4
