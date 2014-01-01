Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:51394 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbaAAThU (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 1 Jan 2014 14:37:20 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: combine spatches (unless using --gitdebug)
Date: Wed,  1 Jan 2014 20:37:13 +0100
Message-Id: <1388605033-18318-1-git-send-email-johannes@sipsolutions.net> (sfid-20140101_203722_256681_9B2A10E6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Since spatch is rather slow, but can handle multiple spatches
concatenated in a single file, just do that and run it only
once rather than for each spatch. That shaves off some of the
runtime (startup etc. and finding affected files.)

On my system, I go from

real    9m42.616s
user    8m48.352s
sys     0m22.884s

to

real    9m1.948s
user    8m40.108s
sys     0m12.088s

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 72 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/gentree.py b/gentree.py
index e16e297..af9b7a8 100755
--- a/gentree.py
+++ b/gentree.py
@@ -14,6 +14,7 @@ from lib import kconfig, patch, make
 from lib import bpgit as git
 from lib import bpgpg as gpg
 from lib import bpkup as kup
+from lib.tempdir import tempdir
 
 def read_copy_list(copyfile):
     """
@@ -679,37 +680,50 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         git_debug_snapshot(args, "apply backport patch %s" % print_name)
 
     sempatches.sort()
-    prefix_len = len(os.path.join(source_dir, 'patches')) + 1
-    for cocci_file in sempatches:
-        print_name = cocci_file[prefix_len:]
-        if args.verbose:
-            logwrite("Applying patch %s" % print_name)
-
-        process = subprocess.Popen(['spatch', '--sp-file', cocci_file, '--in-place',
-                                    '--backup-suffix', '.cocci_backup', '--dir', '.'],
-                                   stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-                                   close_fds=True, universal_newlines=True,
-                                   cwd=args.outdir)
-        output = process.communicate()[0]
-        output = output.split('\n')
-        if output[-1] == '':
-            output = output[:-1]
-        if args.verbose:
-            for line in output:
-                logwrite('> %s' % line)
-        if process.returncode != 0:
-            if not args.verbose:
-                logwrite("Failed to apply changes from %s" % print_name)
+    with tempdir() as t:
+        if not args.gitdebug:
+            # combine all spatches
+            fn = os.path.join(t, 'combined.cocci')
+            f = open(fn, 'w')
+            for cocci_file in sempatches:
+                for l in open(cocci_file, 'r'):
+                    f.write(l)
+                f.write('\n')
+            f.close()
+            sempatches = [fn]
+            prefix_len = 0
+        else:
+            prefix_len = len(os.path.join(source_dir, 'patches')) + 1
+        for cocci_file in sempatches:
+            print_name = cocci_file[prefix_len:]
+            if args.verbose:
+                logwrite("Applying patch %s" % print_name)
+
+            process = subprocess.Popen(['spatch', '--sp-file', cocci_file, '--in-place',
+                                        '--backup-suffix', '.cocci_backup', '--dir', '.'],
+                                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                       close_fds=True, universal_newlines=True,
+                                       cwd=args.outdir)
+            output = process.communicate()[0]
+            output = output.split('\n')
+            if output[-1] == '':
+                output = output[:-1]
+            if args.verbose:
                 for line in output:
                     logwrite('> %s' % line)
-            return 2
-
-        # remove cocci_backup files
-        for root, dirs, files in os.walk(args.outdir):
-            for f in files:
-                if f.endswith('.cocci_backup'):
-                    os.unlink(os.path.join(root, f))
-        git_debug_snapshot(args, "apply backport patch %s" % print_name)
+            if process.returncode != 0:
+                if not args.verbose:
+                    logwrite("Failed to apply changes from %s" % print_name)
+                    for line in output:
+                        logwrite('> %s' % line)
+                return 2
+
+            # remove cocci_backup files
+            for root, dirs, files in os.walk(args.outdir):
+                for f in files:
+                    if f.endswith('.cocci_backup'):
+                        os.unlink(os.path.join(root, f))
+            git_debug_snapshot(args, "apply backport patch %s" % print_name)
 
     # some post-processing is required
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
-- 
1.8.5.1

