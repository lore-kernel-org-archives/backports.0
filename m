Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52580 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbD3RKZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Apr 2015 13:10:25 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] rel-html: update backports versions
Date: Thu, 30 Apr 2015 19:10:14 +0200
Message-Id: <1430413814-4817-2-git-send-email-hauke@hauke-m.de> (sfid-20150430_191027_504052_BC337E43)
In-Reply-To: <1430413814-4817-1-git-send-email-hauke@hauke-m.de>
References: <1430413814-4817-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds version 4.0 and 4.1 to the list of stable versions and adds
the 2015 next versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 projects/backports.cfg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index d1406ba..97f5a98 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,6 +2,8 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	4.1
+	4.0
 	3.19
 	3.18
 	3.17
@@ -14,6 +16,7 @@ supported =
 rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2014/
+			  http://www.kernel.org/pub/linux/kernel/projects/backports/2015/
 rel_license 		= GPLv2
 ignore_changelogs	= True
 
-- 
1.9.1

