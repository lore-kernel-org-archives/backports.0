Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57240 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2JVJ46 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 22 Oct 2012 05:56:58 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so882872eek.19
        for <backports@vger.kernel.org>; Mon, 22 Oct 2012 02:56:57 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] compat-drivers: Separate code metrics for each subsystem
Date: Mon, 22 Oct 2012 12:56:51 +0300
Message-Id: <1350899811-16329-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add a subsystem marker before code metrics to differentiate between
multiple subsystems, e.g. drm, network, etc.:

compat-drivers code metrics

   1181683 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3109 - backport code changes
      2580 - backport code additions
       529 - backport code deletions
     12754 - backport from compat module
     15863 - total backport code
    1.3424 - % of code consists of backport work

   drm
   ----------------------------------------
       301 - backport code changes
       219 - backport code additions
        82 - backport code deletions
     12754 - backport from compat module
     13055 - total backport code
    1.1048 - % of code consists of backport work

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 9b85026..00900a4 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -664,6 +664,8 @@ printf "${PURPLE}%10s${NORMAL} - Total upstream lines of code being pulled\n" $O
 
 for subsystem in $SUBSYSTEMS; do
 
+	printf "\n   ${YELLOW}$subsystem${NORMAL}\n   ----------------------------------------\n" >> $CODE_METRICS
+
 	for dir in $EXTRA_PATCHES; do
 		LAST_ELEM=$dir
 	done
-- 
1.7.11.7

