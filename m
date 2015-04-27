Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35913 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbbD0X46 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 27 Apr 2015 19:56:58 -0400
Received: by wizk4 with SMTP id k4so119129852wiz.1
        for <backports@vger.kernel.org>; Mon, 27 Apr 2015 16:56:56 -0700 (PDT)
Message-ID: <553ECCC6.2060604@gmail.com> (sfid-20150428_015701_951543_96E0A665)
Date: Tue, 28 Apr 2015 01:56:54 +0200
From: Mathy Vanhoef <vanhoefm@gmail.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: [PATCH] backports: fix high RC version parsing in dependency library
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This updates the dependency library to handle RC versions up to 39. For
example, coccinelle version "1.0.0" is now correctly treated as being higher
than version "1.0.0-rc24".

Signed-off-by: Mathy Vanhoef <vanhoefm@gmail.com>
---
 lib/bpreqs.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpreqs.py b/lib/bpreqs.py
index 6c46670..4399c6d 100644
--- a/lib/bpreqs.py
+++ b/lib/bpreqs.py
@@ -98,7 +98,7 @@ class Req:
                 if (rc == ""):
                     rc = 0
                 else:
-                    rc = int(rc) - 20
+                    rc = int(rc) - 40
                 extra = int(rc)
             else:
                 extra = int(rel_specs['EXTRAVERSION']) + 10
-- 
1.7.10.4

