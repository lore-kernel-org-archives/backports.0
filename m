Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64713 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3ESCqN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:46:13 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4342442pbb.6
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:46:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2] rel-html: rename compat-drivers.cfg to backports.cfg
Date: Sat, 18 May 2013 19:46:02 -0700
Message-Id: <1368931562-14009-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_044615_853675_936ACDE7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The compat-drivers project was renamed to backports.
Rename the project file and also update the config file
to add the v3.10 kernel as supported.

We also add the ignore_changelogs for this project given
that we want to skip these moving forward and simply provide
shortlogs upon releases and refer folks to use git for a full
changelog.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---

This v2 just uses -M for git format-patch to make it
easiser to read what actually changed after the rename.

 projects/{compat-drivers.cfg => backports.cfg} |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
 rename projects/{compat-drivers.cfg => backports.cfg} (87%)

diff --git a/projects/compat-drivers.cfg b/projects/backports.cfg
similarity index 87%
rename from projects/compat-drivers.cfg
rename to projects/backports.cfg
index e74046b..ee64a5c 100644
--- a/projects/compat-drivers.cfg
+++ b/projects/backports.cfg
@@ -1,15 +1,18 @@
 [project]
-rel_html_proj           = compat-drivers
+rel_html_proj		= backports
+rel_html_proj_aliases	= compat-drivers
 supported =
 	3.9
 	3.8
 	3.7
+	3.10
 rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
 rel_license 		= GPLv2
+ignore_changelogs	= True
 
 [html]
-title = compat-drivers: Linux kernel backports
+title = backports: Linux kernel backports
 
 nav_01_url = https://backports.wiki.kernel.org/
 nav_01_txt = Documentation
@@ -25,7 +28,7 @@ nav_03_txt = Mailing List
 release_title = Latest stable releases
 release_title_next = Latest development releases
 
-about_title = About compat-drivers
+about_title = About backports
 about = We provide drivers released on newer kernels backported for
 	usage on older kernels. Both daily snapshots based on
 	<a href="http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary">linux-next</a>,
-- 
1.7.10.4

