Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:56878 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3ESCeT (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:19 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so3161008dan.10
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:18 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 6/8] rel-html: add v3.10 as supported for Linux
Date: Sat, 18 May 2013 19:33:40 -0700
Message-Id: <1368930822-13641-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043420_512939_8B4F6451)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Linus has released v3.10, add it to the linux project.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.cfg |    1 +
 1 file changed, 1 insertion(+)

diff --git a/rel-html.cfg b/rel-html.cfg
index 13c4fb4..31392a2 100644
--- a/rel-html.cfg
+++ b/rel-html.cfg
@@ -1,6 +1,7 @@
 [project]
 rel_html_proj           = linux
 supported =
+		3.10
 		3.9
 		3.8
 		3.7
-- 
1.7.10.4

