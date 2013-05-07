Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42975 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3EGDDf (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 23:03:35 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so70507pdj.12
        for <backports@vger.kernel.org>; Mon, 06 May 2013 20:03:35 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, techtonik@gmail.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: update patch Python library
Date: Mon,  6 May 2013 20:03:18 -0700
Message-Id: <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050337_358516_A02705A7)
In-Reply-To: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This updates the backports project up to synch with the
latest patch.py from svn trunk.

Cc: techtonik@gmail.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/patch.py |   43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/lib/patch.py b/lib/patch.py
index 01ad070..4a7578d 100644
--- a/lib/patch.py
+++ b/lib/patch.py
@@ -9,12 +9,12 @@
     Project home: http://code.google.com/p/python-patch/
 
 
-    $Id: patch.py 181 2012-11-23 16:03:05Z techtonik $
-    $HeadURL: https://python-patch.googlecode.com/svn/trunk/patch.py $
+    $Id$
+    $HeadURL$
 """
 
 __author__ = "anatoly techtonik <techtonik@gmail.com>"
-__version__ = "1.12.11"
+__version__ = "1.12.12dev"
 
 import copy
 import logging
@@ -163,6 +163,7 @@ class Hunk(object):
     self.starttgt=None
     self.linestgt=None
     self.invalid=False
+    self.desc=''
     self.text=[]
 
 #  def apply(self, estream):
@@ -273,7 +274,7 @@ class PatchSet(object):
     hunkparsed = False # state after successfully parsed hunk
 
     # regexp to match start of hunk, used groups - 1,3,4,6
-    re_hunk_start = re.compile("^@@ -(\d+)(,(\d+))? \+(\d+)(,(\d+))?")
+    re_hunk_start = re.compile("^@@ -(\d+)(,(\d+))? \+(\d+)(,(\d+))? @@")
     
     self.errors = 0
     # temp buffers for header and filenames info
@@ -478,7 +479,7 @@ class PatchSet(object):
               continue
 
       if hunkhead:
-        match = re.match("^@@ -(\d+)(,(\d+))? \+(\d+)(,(\d+))?", line)
+        match = re.match("^@@ -(\d+)(,(\d+))? \+(\d+)(,(\d+))? @@(.*)", line)
         if not match:
           if not p.hunks:
             warning("skipping invalid patch with no hunks for file %s" % p.source)
@@ -502,6 +503,7 @@ class PatchSet(object):
           hunk.linestgt = 1
           if match.group(6): hunk.linestgt = int(match.group(6))
           hunk.invalid = False
+          hunk.desc = match.group(7)[1:].rstrip()
           hunk.text = []
 
           hunkactual["linessrc"] = hunkactual["linestgt"] = 0
@@ -627,6 +629,20 @@ class PatchSet(object):
         return None
     """
     for i,p in enumerate(self.items):
+      if p.type in (HG, GIT):
+        # TODO: figure out how to deal with /dev/null entries
+        debug("stripping a/ and b/ prefixes")
+        if p.source != '/dev/null':
+          if not p.source.startswith("a/"):
+            warning("invalid source filename")
+          else:
+            p.source = p.source[2:]
+        if p.target != '/dev/null':
+          if not p.target.startswith("b/"):
+            warning("invalid target filename")
+          else:
+            p.target = p.target[2:]
+
       p.source = xnormpath(p.source)
       p.target = xnormpath(p.target)
 
@@ -712,10 +728,14 @@ class PatchSet(object):
     return output
 
 
-  def apply(self, strip=0):
-    """ apply parsed patch
+  def apply(self, strip=0, root=None):
+    """ Apply parsed patch, optionally stripping leading components
+        from file paths. `root` parameter specifies working dir.
         return True on success
     """
+    if root:
+      prevdir = os.getcwd()
+      os.chdir(root)
 
     total = len(self.items)
     errors = 0
@@ -742,7 +762,7 @@ class PatchSet(object):
           debug("stripping %s leading component from '%s'" % (strip, f2patch))
           f2patch = pathstrip(f2patch, strip)
         if not exists(f2patch):
-          warning("source/target file does not exist\n--- %s\n+++ %s" % (p.source, f2patch))
+          warning("source/target file does not exist:\n  --- %s\n  +++ %s" % (p.source, f2patch))
           errors += 1
           continue
       if not isfile(f2patch):
@@ -839,6 +859,9 @@ class PatchSet(object):
             # todo: proper rejects
             shutil.move(backupname, filename)
 
+    if root:
+      os.chdir(prevdir)
+
     # todo: check for premature eof
     return (errors == 0)
 
@@ -989,6 +1012,8 @@ if __name__ == "__main__":
   opt.add_option("--debug", action="store_true", dest="debugmode", help="debug mode")
   opt.add_option("--diffstat", action="store_true", dest="diffstat",
                                            help="print diffstat and exit")
+  opt.add_option("-d", "--directory", metavar='DIR',
+                                           help="specify root directory for applying patch")
   opt.add_option("-p", "--strip", type="int", metavar='N', default=0,
                                            help="strip N path components from filenames")
   (options, args) = opt.parse_args()
@@ -1031,7 +1056,7 @@ if __name__ == "__main__":
     sys.exit(0)
 
   #pprint(patch)
-  patch.apply(options.strip) or sys.exit(-1)
+  patch.apply(options.strip, root=options.directory) or sys.exit(-1)
 
   # todo: document and test line ends handling logic - patch.py detects proper line-endings
   #       for inserted hunks and issues a warning if patched file has incosistent line ends
-- 
1.7.10.4

