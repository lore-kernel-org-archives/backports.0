Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.stepping-stone.ch ([194.176.109.206]:33191 "EHLO
	mail.stepping-stone.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab3CBTRO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 2 Mar 2013 14:17:14 -0500
From: stefan.kuhn@foss-group.ch
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Stefan Kuhn <stefan.kuhn@hispeed.ch>
Subject: [compat-drivers 1/1] scripts/driver-select: use $BACKUP_EXT everywhere
Date: Sat,  2 Mar 2013 20:07:41 +0100
Message-Id: <1362251261-7270-2-git-send-email-stefan.kuhn@hispeed.ch>
In-Reply-To: <1362251261-7270-1-git-send-email-stefan.kuhn@hispeed.ch>
References: <1362251261-7270-1-git-send-email-stefan.kuhn@hispeed.ch>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Kuhn <stefan.kuhn@hispeed.ch>
---
 scripts/driver-select | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/scripts/driver-select b/scripts/driver-select
index 4f71e34..4dfbe3f 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -20,9 +20,6 @@ SSB_MAKEFILE="drivers/ssb/Makefile"
 BCMA_MAKEFILE="drivers/bcma/Makefile"
 
 # used to backup files from foo to foo.${BACKUP_EXT}
-# If you change this also modify restore_compat() and
-# restore_file() below I couldn't find a way to use
-# the $BACKUP_EXT there.
 BACKUP_EXT="bk"
 
 # Pretty colors
@@ -90,7 +87,7 @@ function backup_file {
 		return
 	fi
 	echo -e "Backing up makefile: ${CYAN}${1}.${BACKUP_EXT}${NORMAL}"
-	cp $1 $1.bk
+	cp "${1}" "${1}.${BACKUP_EXT}"
 }
 
 function disable_makefile
@@ -301,16 +298,14 @@ function select_brcm80211_driver
 }
 
 function restore_file {
-	#ORIG=$(shell ${1%%.${BACKUP_EXT}})
-	ORIG=${1%%.bk}
+	local ORIG="${1%%${BACKUP_EXT}}"
 	cp $1 $ORIG
 	rm -f $1
 	echo -e "Restored makefile: ${CYAN}${ORIG}${NORMAL} (and removed backup)"
 }
 
 function restore_compat {
-	#FILES=$(find ./ -type f -name *.$BACKUP_EXT)
-	FILES=$(find ./ -type f -name *.bk)
+	local FILES=$(find ./ -type f -name *"${BACKUP_EXT}")
 	for i in $FILES; do
 		restore_file $i
 	done
-- 
1.7.12.4

