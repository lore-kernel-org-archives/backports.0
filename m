Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64152 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab3KNNkg (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 14 Nov 2013 08:40:36 -0500
Received: by mail-wi0-f169.google.com with SMTP id hi5so818129wib.2
        for <backports@vger.kernel.org>; Thu, 14 Nov 2013 05:40:33 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] rel-html: add 3.12 and 3.13 for projects
Date: Thu, 14 Nov 2013 14:40:30 +0100
Message-Id: <1384436430-23664-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131114_144045_176174_EFE69567)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This updates all projects relying on following the
Linux kernel. Annotate which kernels are also EOL now
for the Linux kernel and remove completely unsupported
kernels. While at it, add 3.13 proactively, we may want
to just guestimate future releases but how do we do that?

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/backports.cfg |  2 ++
 projects/iw.cfg        |  3 +++
 rel-html.cfg           | 13 +++++--------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index ba6a275..2ea2ca3 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,6 +2,8 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	3.13
+	3.12
 	3.11
 	3.10
 eol =
diff --git a/projects/iw.cfg b/projects/iw.cfg
index a8c2305..c019bca 100644
--- a/projects/iw.cfg
+++ b/projects/iw.cfg
@@ -3,6 +3,9 @@ rel_html_proj           = iw
 supported =
 	3.8
 	3.10
+	3.11
+	3.12
+	3.13
 rel_html_testing_ver	= latest
 rel_html_url_releases	= https://www.kernel.org/pub/software/network/iw/
 rel_license 		= ISC
diff --git a/rel-html.cfg b/rel-html.cfg
index 31392a2..d6b010e 100644
--- a/rel-html.cfg
+++ b/rel-html.cfg
@@ -1,19 +1,16 @@
 [project]
 rel_html_proj           = linux
 supported =
-		3.10
-		3.9
-		3.8
-		3.7
+		3.13
+		3.12
+		3.12
 		3.4
 		3.2
-		3.0
 		2.6.34
 		2.6.32
 eol =
-		3.6
-		3.5
-		3.3
+		3.11
+		3.0
 rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/v3.0/testing
 			  http://www.kernel.org/pub/linux/kernel/v3.0
 			  http://www.kernel.org/pub/linux/kernel/v2.6
-- 
1.8.4.rc3

