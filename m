Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41358 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaAXWsS (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:48:18 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so3776379pad.39
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:48:18 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 10/11] rel-html: update CRDA project file
Date: Fri, 24 Jan 2014 14:47:15 -0800
Message-Id: <1390603636-27841-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20140125_000006_748885_3E863F48)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

CRDA is now licensed under the copyleft-next project.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/crda.cfg | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/projects/crda.cfg b/projects/crda.cfg
index c52bb6b..33c2c66 100644
--- a/projects/crda.cfg
+++ b/projects/crda.cfg
@@ -1,9 +1,10 @@
 [project]
 rel_html_proj           = crda
 supported =
-	1.1
+	3.13
+	3.14
 rel_html_url_releases	= http://kernel.org/pub/software/network/crda/
-rel_license 		= ISC
+rel_license 		= copyleft-next
 ignore_changelogs	= True
 
 [html]
-- 
1.8.5.2

