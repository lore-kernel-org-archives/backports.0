Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54587 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUAf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:00:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] gentree: create *.tar.gz instead of *.tar.bz for kernel.org
Date: Sat, 18 Jan 2014 21:00:25 +0100
Message-Id: <1390075225-6686-1-git-send-email-hauke@hauke-m.de> (sfid-20140118_210037_039406_44790E8E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kernel.org does not support bzip2 any more, use gzip instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/gentree.py b/gentree.py
index af9b7a8..f6f766f 100755
--- a/gentree.py
+++ b/gentree.py
@@ -4,7 +4,7 @@
 #
 
 import argparse, sys, os, errno, shutil, re, subprocess
-import tarfile, bz2
+import tarfile, gzip
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -357,9 +357,9 @@ def get_rel_prep(rel):
                     paths_to_create = paths)
     return rel_prep
 
-def create_tar_and_bz2(tar_name, dir_to_tar):
+def create_tar_and_gz(tar_name, dir_to_tar):
     """
-    We need both a tar file and bzip2 for kernel.org, the tar file
+    We need both a tar file and gzip for kernel.org, the tar file
     gets signed, then we upload the compressed version, kup-server
     in the backend decompresses and verifies the tarball against
     our signature.
@@ -371,9 +371,9 @@ def create_tar_and_bz2(tar_name, dir_to_tar):
 
     tar_file = open(tar_name, "r")
 
-    bz2_file = bz2.BZ2File(tar_name + ".bz2", 'wb', compresslevel=9)
-    bz2_file.write(tar_file.read())
-    bz2_file.close()
+    gz_file = gzip.GzipFile(tar_name + ".gz", 'wb')
+    gz_file.write(tar_file.read())
+    gz_file.close()
 
 def upload_release(args, rel_prep, logwrite=lambda x:None):
     """
@@ -406,9 +406,9 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
     parent = os.path.dirname(args.outdir)
     release = os.path.basename(args.outdir)
     tar_name = parent + '/' + release + ".tar"
-    bzip2_name = tar_name + ".bz2"
+    gzip_name = tar_name + ".gz"
 
-    create_tar_and_bz2(tar_name, args.outdir)
+    create_tar_and_gz(tar_name, args.outdir)
 
     logwrite(gpg.sign(tar_name, extra_args=['--armor', '--detach-sign']))
 
@@ -428,13 +428,13 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
             logwrite(kup.mkdir(korg_path))
     korg_path += '/'
     if (not args.kup_test):
-        logwrite("upload file %s to %s" % (bzip2_name, korg_path))
-        logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
+        logwrite("upload file %s to %s" % (gzip_name, korg_path))
+        logwrite(kup.put(gzip_name, tar_name + '.asc', korg_path))
         logwrite("\nFinished upload!\n")
         logwrite("Target path contents:")
         logwrite(kup.ls(path=korg_path))
     else:
-        kup_cmd = "kup put /\n\t\t%s /\n\t\t%s /\n\t\t%s" % (bzip2_name, tar_name + '.asc', korg_path)
+        kup_cmd = "kup put /\n\t\t%s /\n\t\t%s /\n\t\t%s" % (gzip_name, tar_name + '.asc', korg_path)
         logwrite("kup-test: skipping cmd: %s" % kup_cmd)
 
 def _main():
-- 
1.7.10.4

