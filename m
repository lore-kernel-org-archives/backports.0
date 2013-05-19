Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54610 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3ESCeB (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:01 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so4651444pab.40
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:00 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/8] rel-html: rename compat-drivers.cfg to backports.cfg
Date: Sat, 18 May 2013 19:33:36 -0700
Message-Id: <1368930822-13641-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043402_707226_0BC446C7)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
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
 projects/backports.cfg      |   37 +++++++++++++++++++++++++++++++++++++
 projects/compat-drivers.cfg |   34 ----------------------------------
 2 files changed, 37 insertions(+), 34 deletions(-)
 create mode 100644 projects/backports.cfg
 delete mode 100644 projects/compat-drivers.cfg

diff --git a/projects/backports.cfg b/projects/backports.cfg
new file mode 100644
index 0000000..ee64a5c
--- /dev/null
+++ b/projects/backports.cfg
@@ -0,0 +1,37 @@
+[project]
+rel_html_proj		= backports
+rel_html_proj_aliases	= compat-drivers
+supported =
+	3.9
+	3.8
+	3.7
+	3.10
+rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
+			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
+rel_license 		= GPLv2
+ignore_changelogs	= True
+
+[html]
+title = backports: Linux kernel backports
+
+nav_01_url = https://backports.wiki.kernel.org/
+nav_01_txt = Documentation
+
+# XXX: Note: two % added here to help with what seems to be a python ConfigParser.py bug.
+#      We should address this eventually.
+nav_02_url = https://bugzilla.kernel.org/enter_bug.cgi?product=Backports%%20project
+nav_02_txt = Bugs
+
+nav_03_url = https://backports.wiki.kernel.org/index.php/Mailing_list
+nav_03_txt = Mailing List
+
+release_title = Latest stable releases
+release_title_next = Latest development releases
+
+about_title = About backports
+about = We provide drivers released on newer kernels backported for
+	usage on older kernels. Both daily snapshots based on
+	<a href="http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary">linux-next</a>,
+	and stable releases based on 
+	<a href="http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary">Linux's stable releases</a>
+	are provided. The Linux drivers are <b>automatically backported</b>.
diff --git a/projects/compat-drivers.cfg b/projects/compat-drivers.cfg
deleted file mode 100644
index e74046b..0000000
--- a/projects/compat-drivers.cfg
+++ /dev/null
@@ -1,34 +0,0 @@
-[project]
-rel_html_proj           = compat-drivers
-supported =
-	3.9
-	3.8
-	3.7
-rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
-			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
-rel_license 		= GPLv2
-
-[html]
-title = compat-drivers: Linux kernel backports
-
-nav_01_url = https://backports.wiki.kernel.org/
-nav_01_txt = Documentation
-
-# XXX: Note: two % added here to help with what seems to be a python ConfigParser.py bug.
-#      We should address this eventually.
-nav_02_url = https://bugzilla.kernel.org/enter_bug.cgi?product=Backports%%20project
-nav_02_txt = Bugs
-
-nav_03_url = https://backports.wiki.kernel.org/index.php/Mailing_list
-nav_03_txt = Mailing List
-
-release_title = Latest stable releases
-release_title_next = Latest development releases
-
-about_title = About compat-drivers
-about = We provide drivers released on newer kernels backported for
-	usage on older kernels. Both daily snapshots based on
-	<a href="http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary">linux-next</a>,
-	and stable releases based on 
-	<a href="http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary">Linux's stable releases</a>
-	are provided. The Linux drivers are <b>automatically backported</b>.
-- 
1.7.10.4

