Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53246 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3JUW1u (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:27:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] gentree.py: fix directory creating
Date: Tue, 22 Oct 2013 00:27:35 +0200
Message-Id: <1382394457-25147-3-git-send-email-hauke@hauke-m.de> (sfid-20131022_002751_425161_F7A4FD0A)
In-Reply-To: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
References: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The full path has to be provided not just the new directory to create.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index daf9033..d101bdb 100755
--- a/gentree.py
+++ b/gentree.py
@@ -423,7 +423,7 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
     for path in rel_prep['paths_to_create']:
         korg_path += '/' + path
         if (not args.kup_test):
-            logwrite(kup.mkdir(path))
+            logwrite(kup.mkdir(korg_path))
     if (not args.kup_test):
         logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
         logwrite("\nFinished upload!\n")
-- 
1.7.10.4

