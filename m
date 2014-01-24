Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48367 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaAXWsL (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:48:11 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so3770797pab.23
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:48:11 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 09/11] rel-html: add 3.14 release to iw project
Date: Fri, 24 Jan 2014 14:47:14 -0800
Message-Id: <1390603636-27841-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20140124_234813_395734_A642796F)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This prepares rel-html to make 3.14 based releases, which
are not yet released.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/iw.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/iw.cfg b/projects/iw.cfg
index c019bca..23f2944 100644
--- a/projects/iw.cfg
+++ b/projects/iw.cfg
@@ -6,6 +6,7 @@ supported =
 	3.11
 	3.12
 	3.13
+	3.14
 rel_html_testing_ver	= latest
 rel_html_url_releases	= https://www.kernel.org/pub/software/network/iw/
 rel_license 		= ISC
-- 
1.8.5.2

