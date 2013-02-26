Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 3/9] compat: ckmake: make return code 2 is error
Date: Tue, 26 Feb 2013 22:03:06 +0100
Message-Id: <1361912592-29591-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
References: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 9f0c7145e86d00246363c25d0f063994e17dd995

If make returns 2 it should be treat as an error and not as ok.
The documentation says 2 is returned if make encountered an error:
https://www.gnu.org/software/make/manual/html_node/Running.html

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/ckmake |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/bin/ckmake b/bin/ckmake
index 34bfb09..c821b0a 100755
--- a/bin/ckmake
+++ b/bin/ckmake
@@ -62,8 +62,6 @@ def get_processed_rel(i):
 def get_status_name(status):
 	if (status == 0):
 		return 'OK'
-	if (status == 2):
-		return 'OK'
 	elif (status == 130):
 		return 'TERM'
 	elif (status == 1234):
@@ -76,8 +74,6 @@ def get_status_name(status):
 def get_stat_pos(status):
 	if (status == 0):
 		return 34
-	if (status == 2):
-		return 34
 	elif (status == 130):
 		return 33
 	elif (status == 1234):
@@ -90,8 +86,6 @@ def get_stat_pos(status):
 def get_status_color(status):
 	if (status == 0):
 		return curses.color_pair(1)
-	if (status == 2):
-		return curses.color_pair(1)
 	elif (status == 130):
 		return curses.color_pair(2)
 	elif (status == 1234):
-- 
1.7.10.4
