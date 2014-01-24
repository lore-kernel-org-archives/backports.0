Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43241 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbaAXWrj (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:47:39 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so3784073pbb.1
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:47:39 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/11] rel-html: update Linux project file
Date: Fri, 24 Jan 2014 14:47:08 -0800
Message-Id: <1390603636-27841-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140124_234750_729421_1BDD5F63)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This reflects the latest changes for kernel release
project maintenance. The 3.14-rc1 is not out yet but
should be out soon.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.cfg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rel-html.cfg b/rel-html.cfg
index d6b010e..a4baa15 100644
--- a/rel-html.cfg
+++ b/rel-html.cfg
@@ -1,9 +1,10 @@
 [project]
 rel_html_proj           = linux
 supported =
+		3.14
 		3.13
 		3.12
-		3.12
+		3.10
 		3.4
 		3.2
 		2.6.34
-- 
1.8.5.2

