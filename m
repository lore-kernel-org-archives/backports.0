Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56147 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757334AbcGJVPD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/19] gentree.py: print some more error messages when spatch fails.
Date: Sun, 10 Jul 2016 23:14:43 +0200
Message-Id: <1468185285-28265-18-git-send-email-hauke@hauke-m.de> (sfid-20160711_013912_051003_575CA71C)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I saw some problems here, add more debug output.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 772095f..e97ead0 100755
--- a/gentree.py
+++ b/gentree.py
@@ -601,7 +601,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
         output = sprocess.communicate()[0]
         sprocess.wait()
         if sprocess.returncode != 0:
-            logwrite("Failed to process SmPL patch %s" % print_name)
+            logwrite("Failed to process SmPL patch %s with %i" % (print_name, sprocess.returncode))
             raise Exception('SmPL patch failed')
         output = output.split('\n')
         if output[-1] == '':
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
