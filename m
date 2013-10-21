Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53251 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3JUW1v (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:27:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] gentree.py: log kup command before executing
Date: Tue, 22 Oct 2013 00:27:36 +0200
Message-Id: <1382394457-25147-4-git-send-email-hauke@hauke-m.de> (sfid-20131022_002752_848771_F3E417F9)
In-Reply-To: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
References: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add a logging of the next command to be executed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/gentree.py b/gentree.py
index d101bdb..cb5431d 100755
--- a/gentree.py
+++ b/gentree.py
@@ -423,8 +423,10 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
     for path in rel_prep['paths_to_create']:
         korg_path += '/' + path
         if (not args.kup_test):
+            logwrite("create directory: %s" % korg_path)
             logwrite(kup.mkdir(korg_path))
     if (not args.kup_test):
+        logwrite("upload file %s to %s" % (bzip2_name, korg_path))
         logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
         logwrite("\nFinished upload!\n")
         logwrite("Target path contents:")
-- 
1.7.10.4

