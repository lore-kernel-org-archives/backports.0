Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53255 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3JUW1x (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:27:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] gentree.py: add ending slash to upload path
Date: Tue, 22 Oct 2013 00:27:37 +0200
Message-Id: <1382394457-25147-5-git-send-email-hauke@hauke-m.de> (sfid-20131022_002754_245118_34FE2563)
In-Reply-To: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
References: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

the filename in kup put should end with a slash otherwise it tried to
overwrite this file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/gentree.py b/gentree.py
index cb5431d..bc446d4 100755
--- a/gentree.py
+++ b/gentree.py
@@ -425,6 +425,7 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
         if (not args.kup_test):
             logwrite("create directory: %s" % korg_path)
             logwrite(kup.mkdir(korg_path))
+    korg_path += '/'
     if (not args.kup_test):
         logwrite("upload file %s to %s" % (bzip2_name, korg_path))
         logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
-- 
1.7.10.4

