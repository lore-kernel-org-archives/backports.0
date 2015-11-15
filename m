Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35712 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbbKOVcA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 16:32:00 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] rel-html: backports: add version 4.3 and 4.4
Date: Sun, 15 Nov 2015 22:31:52 +0100
Message-Id: <1447623112-26088-1-git-send-email-hauke@hauke-m.de> (sfid-20151115_223201_306751_B9EAE2FE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds backports versions based on kernel 4.3 and 4.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 projects/backports.cfg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index 1f93aa3..b9ee078 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,6 +2,8 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	4.4
+	4.3
 	4.2
 	4.1
 	4.0
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
