Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57340 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3FDMWA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 4 Jun 2013 08:22:00 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree/git-tracker: make python 3 compatible
Date: Tue,  4 Jun 2013 14:21:52 +0200
Message-Id: <1370348512-15068-1-git-send-email-johannes@sipsolutions.net> (sfid-20130604_142204_019162_76DE36B4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Make the python scripting compatible with python 3
(as tested with python 3.3). The patch library was
a bit tricky.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 20 ++++++++++--------
 gentree.py           |  8 ++++----
 lib/patch.py         | 58 ++++++++++++++++++++++++++++++++++++++--------------
 lib/tempdir.py       |  2 +-
 4 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index b74105a..3bd62f9 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -12,7 +12,11 @@ problem to occur (although this is less useful since lots of commits
 need to be squashed in the output tree.)
 """
 
-import sys, re, os, argparse, ConfigParser, shutil
+import sys, re, os, argparse, shutil
+try:
+    import configparser as ConfigParser
+except:
+    import ConfigParser
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -67,7 +71,7 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
             })
             msg = 'Failed to create backport\n\n%s%s: %s' % (PREFIX, FAIL, failure)
             for l in log:
-                print l
+                print(l)
             newline=''
             if prev_kernel_rev:
                 msg += '\n%s%s-last-success: %s' % (PREFIX, tree, prev_kernel_rev)
@@ -120,14 +124,14 @@ if __name__ == '__main__':
     # check required parameters
     trees = config.sections()
     if not trees:
-        print "No trees are defined, see git-tracker.ini.example!"
+        print("No trees are defined, see git-tracker.ini.example!")
         sys.exit(3)
     for tree in trees:
         if not config.has_option(tree, 'input'):
-            print "No input defined in section %s" % tree
+            print("No input defined in section %s" % tree)
             sys.exit(3)
         if not config.has_option(tree, 'output'):
-            print "No output defined in section %s" % tree
+            print("No output defined in section %s" % tree)
             sys.exit(3)
 
     with tempdir.tempdir() as kernel_tmpdir:
@@ -212,7 +216,7 @@ if __name__ == '__main__':
                         catch_up_from_failure = False
                     commits = git.log_commits(prev, kernel_head, tree=kernelobjdir)
                     if len(commits) > MAX_COMMITS:
-                        print "too many commits (%d)!" % len(commits)
+                        print("too many commits (%d)!" % len(commits))
                         sys.exit(10)
                     prev_commits = {}
                     p = prev
@@ -220,7 +224,7 @@ if __name__ == '__main__':
                         prev_commits[commit] = p
                         p = commit
                     for commit in commits:
-                        print 'updating to commit', commit
+                        print('updating to commit %s' % commit)
                         env = git.commit_env_vars(commit, tree=kernelobjdir)
                         if prev_commits[commit] == prev:
                             # committing multiple commits
@@ -230,7 +234,7 @@ if __name__ == '__main__':
                                 shortlog = git.shortlog(prev, '%s^2' % commit,
                                                         tree=kernelobjdir)
                                 msg += "\nCommits in this merge:\n\n" + shortlog
-                            except git.ExecutionError, e:
+                            except git.ExecutionError as e:
                                 # will fail if it wasn't a merge commit
                                 pass
                         else:
diff --git a/gentree.py b/gentree.py
index fef2faf..356871d 100755
--- a/gentree.py
+++ b/gentree.py
@@ -69,7 +69,7 @@ def check_output_dir(d, clean):
         shutil.rmtree(d, ignore_errors=True)
     try:
         os.rmdir(d)
-    except OSError, e:
+    except OSError as e:
         if e.errno != errno.ENOENT:
             raise
 
@@ -146,7 +146,7 @@ def copy_files(srcpath, copy_list, outdir):
         else:
             try:
                 os.makedirs(os.path.join(outdir, os.path.dirname(tgtitem)))
-            except OSError, e:
+            except OSError as e:
                 # ignore dirs we might have created just now
                 if e.errno != errno.EEXIST:
                     raise
@@ -180,7 +180,7 @@ def add_automatic_backports(args):
     bpi = kconfig.get_backport_info(os.path.join(args.outdir, 'compat', 'Kconfig'))
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
     all_selects = configtree.all_selects()
-    for sym, vals in bpi.iteritems():
+    for sym, vals in bpi.items():
         if sym.startswith('BACKPORT_BUILD_'):
             if not sym[15:] in all_selects:
                 continue
@@ -508,7 +508,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         new = []
         for dep in deplist[sym]:
             if dep == "DISABLE":
-		    new.append('BACKPORT_DISABLED_KCONFIG_OPTION')
+                    new.append('BACKPORT_DISABLED_KCONFIG_OPTION')
             else:
                     new.append('!BACKPORT_KERNEL_%s' % dep.replace('.', '_'))
         deplist[sym] = new
diff --git a/lib/patch.py b/lib/patch.py
index 615a3d6..97964b5 100644
--- a/lib/patch.py
+++ b/lib/patch.py
@@ -19,15 +19,42 @@ __version__ = "1.12.12dev"
 import copy
 import logging
 import re
-# cStringIO doesn't support unicode in 2.5
-from StringIO import StringIO
-import urllib2
+import sys
+
+try:
+  # cStringIO doesn't support unicode in 2.5
+  from StringIO import StringIO
+except ImportError:
+  # StringIO has been renamed to 'io' in 3.x
+  from io import StringIO
+
+try:
+    import urllib2
+except ImportError:
+    import urllib.request as urllib2
 
 from os.path import exists, isfile, abspath
 import os
 import shutil
 
 
+_open = open
+
+if sys.version_info >= (3,):
+    # Open files with universal newline support but no newline translation (3.x)
+    def open(filename, mode='r'):
+        return _open(filename, mode, newline='')
+else:
+    # Open files with universal newline support but no newline translation (2.x)
+    def open(filename, mode='r'):
+        return _open(filename, mode + 'b')
+
+    # Python 3.x has changed iter.next() to be next(iter) instead, so for
+    # backwards compatibility, we'll just define a next() function under 2.x
+    def next(iter):
+        return iter.next()
+
+
 #------------------------------------------------
 # Logging is controlled by logger named after the
 # module name (e.g. 'patch' for patch.py module)
@@ -114,7 +141,7 @@ def fromfile(filename):
   """
   patchset = PatchSet()
   debug("reading %s" % filename)
-  fp = open(filename, "rb")
+  fp = open(filename, "r")
   res = patchset.parse(fp)
   fp.close()
   if res == True:
@@ -226,17 +253,16 @@ class PatchSet(object):
     hunkactual = dict(linessrc=None, linestgt=None)
 
 
-    class wrapumerate(enumerate):
+    class wrapumerate(object):
       """Enumerate wrapper that uses boolean end of stream status instead of
       StopIteration exception, and properties to access line information.
       """
 
-      def __init__(self, *args, **kwargs):
-        # we don't call parent, it is magically created by __new__ method
-
+      def __init__(self, stream):
         self._exhausted = False
         self._lineno = False     # after end of stream equal to the num of lines
         self._line = False       # will be reset to False after end of stream
+        self._iter = enumerate(stream)
 
       def next(self):
         """Try to read the next line and return True if it is available,
@@ -245,12 +271,14 @@ class PatchSet(object):
           return False
 
         try:
-          self._lineno, self._line = super(wrapumerate, self).next()
+          self._lineno, self._line = next(self._iter)
         except StopIteration:
           self._exhausted = True
           self._line = False
           return False
         return True
+      # python 3 uses __next__ consistent with next(iter)
+      __next__ = next
 
       @property
       def is_empty(self):
@@ -286,7 +314,7 @@ class PatchSet(object):
     # start of main cycle
     # each parsing block already has line available in fe.line
     fe = wrapumerate(stream)
-    while fe.next():
+    while next(fe):
 
       # -- deciders: these only switch state to decide who should process
       # --           line fetched at the start of this cycle
@@ -305,7 +333,7 @@ class PatchSet(object):
         while not fe.is_empty and not fe.line.startswith("--- "):
             header.append(fe.line)
             self.top_header += fe.line
-            fe.next()
+            next(fe)
         if fe.is_empty:
             if p == None:
               debug("no patch data found")  # error is shown later
@@ -516,7 +544,7 @@ class PatchSet(object):
           nexthunkno += 1
           continue
 
-    # /while fe.next()
+    # /while next(fe)
 
     if p:
       self.items.append(p)
@@ -969,8 +997,8 @@ class PatchSet(object):
 
 
   def write_hunks(self, srcname, tgtname, hunks):
-    src = open(srcname, "rb")
-    tgt = open(tgtname, "wb")
+    src = open(srcname, "r")
+    tgt = open(tgtname, "w")
 
     debug("processing target file %s" % tgtname)
 
@@ -1040,7 +1068,7 @@ if __name__ == "__main__":
       patch = fromfile(patchfile)
 
   if options.diffstat:
-    print patch.diffstat()
+    print(patch.diffstat())
     sys.exit(0)
 
   #pprint(patch)
diff --git a/lib/tempdir.py b/lib/tempdir.py
index 43c6945..ef92153 100644
--- a/lib/tempdir.py
+++ b/lib/tempdir.py
@@ -23,6 +23,6 @@ class tempdir(object):
 
     def __exit__(self, type, value, traceback):
         if self.nodelete:
-            print 'not deleting directory %s!' % self._name
+            print('not deleting directory %s!' % self._name)
         else:
             shutil.rmtree(self._name)
-- 
1.8.0

