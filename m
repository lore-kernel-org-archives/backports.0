Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] compat-drivers: remove copy of README in refresh
Date: Thu, 29 Nov 2012 16:24:38 +0100
Message-Id: <1354202681-11787-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

There is no README file in the patches folder like patches/drm/README
any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/admin-update.sh |    1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 89aae9f..48c1070 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -66,7 +66,6 @@ patchRefresh() {
 	done
 	quilt pop -a
 
-	cp patches.orig/README $1/README
 	rm -rf patches.orig .pc $1/series
 }
 
-- 
1.7.10.4
