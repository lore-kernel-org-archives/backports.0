Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56137 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbbGKVeQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:34:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] devel: convert backports-update-manager to python3
Date: Sat, 11 Jul 2015 23:34:08 +0200
Message-Id: <1436650450-2696-2-git-send-email-hauke@hauke-m.de> (sfid-20150711_233419_728879_51E86BFE)
In-Reply-To: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
References: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This converts the backports-update-manager to use python3 instead of
python2. python3 is needed because new Debian packages are compressed
with the xz algorithm and only the tar module of python3 supports this
algorithm.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 1a85d7b..228916d 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -1,7 +1,8 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 import argparse, os, sys, errno, getopt, re
-import shutil, urllib2
-from urlparse import urljoin
+import shutil
+from urllib.request import urlopen
+from urllib.parse import urljoin
 import tarfile, tempfile
 import fileinput, subprocess
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -179,7 +180,7 @@ class backport_kernel_updater:
         sys.stdout.write("** This is a terrible idea. Consider running " \
                          "as a non root.\n")
         if not self.force:
-            answer = raw_input("Do you still want to continue (y/N)? ")
+            answer = input("Do you still want to continue (y/N)? ")
             if answer != "y":
                 sys.exit(1)
     def warn_size_reqs_about(self):
@@ -235,7 +236,7 @@ class backport_kernel_updater:
                     sys.stdout.write("%s\n" % (git_tree.get('directory')))
             sys.stdout.write("\n")
     def warn_size_reqs_prompt(self):
-        answer = raw_input("Do you still want to continue (y/N)? ")
+        answer = input("Do you still want to continue (y/N)? ")
         if answer != "y":
             sys.exit(1)
         sys.stdout.write("\n")
@@ -367,10 +368,10 @@ class backport_kernel_updater:
     def wget_url(self, url, dir_target):
         sys.stdout.write('Trying URL:  %s\n' % url)
         target = os.path.join(dir_target, url.split('/')[-1])
-        u = urllib2.urlopen(url)
+        u = urlopen(url)
         f = open(target, 'wb')
         meta = u.info()
-        target_size = int(meta.getheaders("Content-Length")[0])
+        target_size = int(meta.get_all("Content-Length")[0])
         sys.stdout.write('Target path: %s bytes: %s\n' % (target, target_size))
         target_size_now = os.path.getsize(target)
         check = 8192
@@ -387,18 +388,18 @@ class backport_kernel_updater:
                 break
             target_size_now += len(buff)
             f.write(buff)
-            stat = r"%10d  [%3.2f%%]" % (target_size_now, target_size_now * 100. / target_size)
-            stat = stat + chr(8)*(len(stat) + 1)
-            print stat,
+            sys.stdout.write('\r')
+            sys.stdout.write("%10d  [%3.2f%%]" % (target_size_now, target_size_now * 100. / target_size))
+            sys.stdout.flush()
         f.close()
         sys.stdout.write("\n")
     def url_file_chunks_missing(self, url, dir_target):
         target = os.path.join(dir_target, url.split('/')[-1])
         if not os.path.isfile(target):
             return True
-        u = urllib2.urlopen(url)
+        u = urlopen(url)
         meta = u.info()
-        target_size = int(meta.getheaders("Content-Length")[0])
+        target_size = int(meta.get_all("Content-Length")[0])
         target_size_now = os.path.getsize(target)
         if target_size_now < target_size:
             return True
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
