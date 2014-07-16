Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34925 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaGPXX0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 16 Jul 2014 19:23:26 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so2018742pdi.11
        for <backports@vger.kernel.org>; Wed, 16 Jul 2014 16:23:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] rel-html: update latest project releases versions
Date: Wed, 16 Jul 2014 16:23:21 -0700
Message-Id: <1405553001-8796-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140717_012328_568505_AC42D84D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This updates the configuration for all supported projects
to match the latest releases. We really just gotta infer
this somehow... It'd be nice if we could somehow get this
from git, but its unclear how we'd be able to maintain a
list of "supported releases" or "tags".

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/backports.cfg      | 9 +++------
 projects/crda.cfg           | 3 ++-
 projects/hostapd.cfg        | 1 +
 projects/iw.cfg             | 5 ++---
 projects/wireless-regdb.cfg | 2 +-
 rel-html.cfg                | 3 ++-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index afe52e9..c6d4548 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,16 +2,13 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	3.17
+	3.16
 	3.15
 	3.14
-	3.13
 	3.12
-	3.11
 	3.10
-eol =
-	3.9
-	3.8
-	3.7
+
 rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2014/
diff --git a/projects/crda.cfg b/projects/crda.cfg
index 116de9b..22b8ada 100644
--- a/projects/crda.cfg
+++ b/projects/crda.cfg
@@ -1,9 +1,10 @@
 [project]
 rel_html_proj           = crda
 supported =
-	3.13
 	3.14
 	3.15
+	3.16
+	3.17
 rel_html_url_releases	= http://kernel.org/pub/software/network/crda/
 rel_license 		= copyleft-next
 ignore_changelogs	= True
diff --git a/projects/hostapd.cfg b/projects/hostapd.cfg
index 0e1841e..e29c8c4 100644
--- a/projects/hostapd.cfg
+++ b/projects/hostapd.cfg
@@ -4,6 +4,7 @@ supported =
 	1.1
 	2.0
 	2.1
+	2.2
 rel_html_url_releases	= http://hostap.epitest.fi/releases/
 rel_license 		= BSD
 ignore_signatures	= True
diff --git a/projects/iw.cfg b/projects/iw.cfg
index 85713d6..0006752 100644
--- a/projects/iw.cfg
+++ b/projects/iw.cfg
@@ -1,13 +1,12 @@
 [project]
 rel_html_proj           = iw
 supported =
-	3.8
 	3.10
-	3.11
 	3.12
-	3.13
 	3.14
 	3.15
+	3.16
+	3.17
 rel_html_testing_ver	= latest
 rel_html_url_releases	= https://www.kernel.org/pub/software/network/iw/
 rel_license 		= ISC
diff --git a/projects/wireless-regdb.cfg b/projects/wireless-regdb.cfg
index 7b14d78..017d51d 100644
--- a/projects/wireless-regdb.cfg
+++ b/projects/wireless-regdb.cfg
@@ -1,7 +1,7 @@
 [project]
 rel_html_proj           = wireless-regdb
 supported =
-	2013.11.27
+	2014.06.13
 rel_html_url_releases	= http://kernel.org/pub/software/network/wireless-regdb/
 rel_license 		= ISC
 ignore_changelogs	= True
diff --git a/rel-html.cfg b/rel-html.cfg
index 4213798..b53025a 100644
--- a/rel-html.cfg
+++ b/rel-html.cfg
@@ -1,9 +1,10 @@
 [project]
 rel_html_proj           = linux
 supported =
+		3.17
+		3.16
 		3.15
 		3.14
-		3.13
 		3.12
 		3.10
 		3.4
-- 
1.9.1

