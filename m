Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbbBYOWN (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:13 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 10/10] backports: require coccinelle version 1.0.0-rc24
Date: Wed, 25 Feb 2015 15:20:54 +0100
Message-Id: <1424874054-22956-11-git-send-email-sassmann@kpanic.de> (sfid-20150225_152219_718506_7F51F664)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The new more generic ethernet patches require spatch 1.0.0-rc24.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 8df3906..edff138 100755
--- a/gentree.py
+++ b/gentree.py
@@ -625,7 +625,7 @@ def _main():
     # Our binary requirements go here
     req = reqs.Req()
     req.require('git')
-    req.coccinelle('1.0.0-rc21')
+    req.coccinelle('1.0.0-rc24')
     if not req.reqs_match():
         sys.exit(1)
 
-- 
2.1.0

