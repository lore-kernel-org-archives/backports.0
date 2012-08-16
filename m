Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48010 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2HPQrp (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 12:47:45 -0400
Received: by weyx8 with SMTP id x8so1869944wey.19
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 09:47:44 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Use case instead of if/if/.. blocks
Date: Thu, 16 Aug 2012 19:47:36 +0300
Message-Id: <1345135656-9563-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

case is much cleaner both for reading and for extending.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 71 ++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 22365cd..69b5287 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -205,41 +205,44 @@ if [ $# -ge 1 ]; then
 		usage $0
 		exit
 	fi
-	if [[ $1 = "-h" || $1 = "--help" ]]; then
-		usage $0
-		exit
-	fi
 	while [ $# -ne 0 ]; do
-		if [[ "$1" = "-s" ]]; then
-			GET_STABLE_PENDING="y"
-			EXTRA_PATCHES="${EXTRA_PATCHES} pending-stable" 
-			EXTRA_PATCHES="${EXTRA_PATCHES} pending-stable/backports/"
-			POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}s"
-			shift; continue;
-		fi
-		if [[ "$1" = "-n" ]]; then
-			EXTRA_PATCHES="${EXTRA_PATCHES} linux-next-cherry-picks"
-			POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}n"
-			shift; continue;
-		fi
-		if [[ "$1" = "-p" ]]; then
-			EXTRA_PATCHES="${EXTRA_PATCHES} linux-next-pending"
-			POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}p"
-			shift; continue;
-		fi
-		if [[ "$1" = "-c" ]]; then
-			EXTRA_PATCHES="${EXTRA_PATCHES} crap"
-			POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}c"
-			shift; continue;
-		fi
-		if [[ "$1" = "refresh" ]]; then
-			REFRESH="y"
-			shift; continue;
-		fi
-
-		echo "Unexpected argument passed: $1"
-		usage $0
-		exit
+		case $1 in
+			"-s")
+				GET_STABLE_PENDING="y"
+				EXTRA_PATCHES="${EXTRA_PATCHES} pending-stable"
+				EXTRA_PATCHES="${EXTRA_PATCHES} pending-stable/backports/"
+				POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}s"
+				shift
+				;;
+			"-n")
+				EXTRA_PATCHES="${EXTRA_PATCHES} linux-next-cherry-picks"
+				POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}n"
+				shift
+				;;
+			"-p")
+				EXTRA_PATCHES="${EXTRA_PATCHES} linux-next-pending"
+				POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}p"
+				shift
+				;;
+			"-c")
+				EXTRA_PATCHES="${EXTRA_PATCHES} crap"
+				POSTFIX_RELEASE_TAG="${POSTFIX_RELEASE_TAG}c"
+				shift
+				;;
+			"refresh")
+				REFRESH="y"
+				shift
+				;;
+			"-h" | "--help")
+				usage $0
+				exit
+				;;
+			*)
+				echo "Unexpected argument passed: $1"
+				usage $0
+				exit
+				;;
+		esac
 	done
 
 fi
-- 
1.7.11.2

