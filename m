Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33959 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbbD0JTT (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 27 Apr 2015 05:19:19 -0400
Received: by wicmx19 with SMTP id mx19so79281997wic.1
        for <backports@vger.kernel.org>; Mon, 27 Apr 2015 02:19:18 -0700 (PDT)
Received: from localhost.localdomain ([93.172.48.98])
        by mx.google.com with ESMTPSA id g5sm20645062wjq.6.2015.04.27.02.19.15
        for <backports@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 02:19:16 -0700 (PDT)
From: Eliad Peller <eliad@wizery.com>
To: <backports@vger.kernel.org>
Subject: [PATCH] backports: fix coccinelle version check
Date: Mon, 27 Apr 2015 12:19:04 +0300
Message-Id: <1430126344-1068-1-git-send-email-eliad@wizery.com> (sfid-20150427_111921_425569_2821B03C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

bpreqs.py assumes the max rc level is 20. However,
backports currently requires coccinelle 1.0.0-rc24
(which is the latest rc before 1.0.0).

This resulted in 1.0.0-rc24 getting higher weight
than 1.0.0, which failed the dependency check.

Fix it by increasing the max rc to 25 (and use
a constant for it)

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 lib/bpreqs.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bpreqs.py b/lib/bpreqs.py
index 6c46670..1325fd2 100644
--- a/lib/bpreqs.py
+++ b/lib/bpreqs.py
@@ -78,6 +78,8 @@ class Req:
             sys.stdout.write("You are using for version: %s\n" % stdout.split()[version_pos])
             sys.stdout.write("Specifically your idx, element: %s\n" % ([[i, x] for i, x in enumerate(stdout.split())][version_pos]))
         return stdout.split()[version_pos]
+
+    MAX_RC = 25
     def __compute_rel_weight(self, rel_specs):
         weight = 0
         extra = 0
@@ -98,7 +100,7 @@ class Req:
                 if (rc == ""):
                     rc = 0
                 else:
-                    rc = int(rc) - 20
+                    rc = int(rc) - (Req.MAX_RC + 1)
                 extra = int(rc)
             else:
                 extra = int(rel_specs['EXTRAVERSION']) + 10
-- 
1.8.5.2.229.g4448466.dirty

