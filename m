Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53235 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab3JUW1p (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:27:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] gentree.py: do not add full path into tar
Date: Tue, 22 Oct 2013 00:27:34 +0200
Message-Id: <1382394457-25147-2-git-send-email-hauke@hauke-m.de> (sfid-20131022_002748_447953_B87C0D6A)
In-Reply-To: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
References: <1382394457-25147-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dir_to_tar could be the absolute path to the directory to to tar, but
we do not want the full patch in the tar, just the basename.
In addition the second close is not necessary.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index 42cf37d..daf9033 100755
--- a/gentree.py
+++ b/gentree.py
@@ -363,9 +363,9 @@ def create_tar_and_bz2(tar_name, dir_to_tar):
     in the backend decompresses and verifies the tarball against
     our signature.
     """
-    parent = os.path.dirname(tar_name)
+    basename = os.path.basename(dir_to_tar)
     tar = tarfile.open(tar_name, "w")
-    tar.add(dir_to_tar)
+    tar.add(dir_to_tar, basename)
     tar.close()
 
     tar_file = open(tar_name, "r")
@@ -374,8 +374,6 @@ def create_tar_and_bz2(tar_name, dir_to_tar):
     bz2_file.write(tar_file.read())
     bz2_file.close()
 
-    tar.close()
-
 def upload_release(args, rel_prep, logwrite=lambda x:None):
     """
     Given a path of a relase make tarball out of it, PGP sign it, and
-- 
1.7.10.4

