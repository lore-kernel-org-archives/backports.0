Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56168 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbbGKXip (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 19:38:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] rel-html: backports: add version 4.2
Date: Sun, 12 Jul 2015 01:38:38 +0200
Message-Id: <1436657918-16124-1-git-send-email-hauke@hauke-m.de> (sfid-20150712_013847_930612_863556F2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the version 4.2 to the list of supported versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 projects/backports.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index 97f5a98..1f93aa3 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,6 +2,7 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	4.2
 	4.1
 	4.0
 	3.19
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
