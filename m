Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52032 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964786Ab2HPQMH (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 12:12:07 -0400
Received: by wibhq12 with SMTP id hq12so723782wib.1
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 09:12:06 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/2] compat-drivers: Add 2 convenience functions
Date: Thu, 16 Aug 2012 19:11:53 +0300
Message-Id: <1345133513-4592-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1345133513-4592-1-git-send-email-ozancag@gmail.com>
References: <1345133513-4592-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add copyFiles and copyDirectories. Their functionality is repeated
over and over in the current code. We'll start using them to get
rid of redundant code snippets.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index bf5fb8e..22365cd 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -163,6 +163,24 @@ nagometer() {
 
 }
 
+# Copy each file in $1 into $2
+copyFiles() {
+	FILES=$1
+	TARGET=$2
+	for file in $FILES; do
+		echo "Copying $GIT_TREE/$TARGET/$file"
+		cp "$GIT_TREE/$TARGET/$file" $TARGET/
+	done
+}
+
+copyDirectories() {
+	DIRS=$1
+	for dir in $DIRS; do
+		echo "Copying $GIT_TREE/$dir/*.[ch]"
+		cp $GIT_TREE/$dir/{Kconfig,Makefile,*.[ch]} $dir/ &> /dev/null
+	done
+}
+
 # First check cmdline args to understand
 # which patches to apply and which release tag to set.
 #
-- 
1.7.11.2

