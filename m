Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:41603 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3ESCeX (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:23 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so4374002pbc.29
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:23 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 7/8] rel-html: update iw release
Date: Sat, 18 May 2013 19:33:41 -0700
Message-Id: <1368930822-13641-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043425_158455_E612C8E7)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Johannes released the v3.10 release of iw so update
the config file for the project to annotate it as supported.
Note that there was no v3.9 relase for iw.

Johannes is now following the releases of the kernel for iw
release.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/iw.cfg |    1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/iw.cfg b/projects/iw.cfg
index becefa8..a8c2305 100644
--- a/projects/iw.cfg
+++ b/projects/iw.cfg
@@ -2,6 +2,7 @@
 rel_html_proj           = iw
 supported =
 	3.8
+	3.10
 rel_html_testing_ver	= latest
 rel_html_url_releases	= https://www.kernel.org/pub/software/network/iw/
 rel_license 		= ISC
-- 
1.7.10.4

