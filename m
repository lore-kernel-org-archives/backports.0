Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33926 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdIHLL2 (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 07:11:28 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] use spatch's built-in concurrency
Date: Fri,  8 Sep 2017 13:11:24 +0200
Message-Id: <20170908111124.26455-1-johannes@sipsolutions.net> (sfid-20170908_131130_349683_26C9B2A2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/pycocci | 174 ----------------------------------------------------------
 gentree.py    |  16 ++++--
 2 files changed, 11 insertions(+), 179 deletions(-)
 delete mode 100755 devel/pycocci

diff --git a/devel/pycocci b/devel/pycocci
deleted file mode 100755
index 4aa1d3638347..000000000000
--- a/devel/pycocci
+++ /dev/null
@@ -1,174 +0,0 @@
-#!/usr/bin/env python
-#
-# Copyright (c) 2014 Luis R. Rodriguez  <mcgrof@suse.com>
-# Copyright (c) 2013 Johannes Berg <johannes@sipsolutions.net>
-#
-# This file is released under the GPLv2.
-#
-# Python wrapper for Coccinelle for multithreaded support,
-# designed to be used for working on a git tree, and with sensible
-# defaults, specifically for kernel developers.
-
-from multiprocessing import Process, cpu_count, Queue
-import argparse, subprocess, os, sys
-import tempfile, shutil
-
-# simple tempdir wrapper object for 'with' statement
-#
-# Usage:
-# with tempdir.tempdir() as tmpdir:
-#     os.chdir(tmpdir)
-#     do something
-#
-class tempdir(object):
-    def __init__(self, suffix='', prefix='', dir=None, nodelete=False):
-        self.suffix = ''
-        self.prefix = ''
-        self.dir = dir
-        self.nodelete = nodelete
-
-    def __enter__(self):
-        self._name = tempfile.mkdtemp(suffix=self.suffix,
-                                      prefix=self.prefix,
-                                      dir=self.dir)
-        return self._name
-
-    def __exit__(self, type, value, traceback):
-        if self.nodelete:
-            print('not deleting directory %s!' % self._name)
-        else:
-            shutil.rmtree(self._name)
-
-class CoccinelleError(Exception):
-    pass
-
-class ExecutionErrorThread(CoccinelleError):
-    def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
-        self.error_code = errcode
-        logwrite("Failed to apply changes from %s\n" % print_name)
-
-        logwrite("Specific log output from change that failed using %s\n" % print_name)
-        tf = open(fn, 'r')
-        for line in tf.read():
-            logwrite(line)
-        tf.close()
-
-        logwrite("Full log using %s\n" % print_name)
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            if (not os.path.isfile(fn)):
-                continue
-            tf = open(fn, 'r')
-            for line in tf.read():
-                logwrite(line)
-            tf.close()
-            os.unlink(fn)
-
-def spatch(cocci_file, outdir,
-           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
-    cmd = ['spatch',
-            '--sp-file', cocci_file,
-            '--in-place',
-            '--recursive-includes',
-            '--relax-include-path',
-            '--use-coccigrep',
-            '--timeout', '120',
-            '--dir', outdir ]
-
-    if (max_threads > 1):
-        cmd.extend(['-max', str(max_threads), '-index', str(thread_id)])
-
-    cmd.extend(extra_args)
-
-    fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
-    outfile = open(fn, 'w')
-    logwrite("%s\n" % " ".join(cmd))
-
-    sprocess = subprocess.Popen(cmd,
-                               stdout=outfile, stderr=subprocess.STDOUT,
-                               close_fds=True, universal_newlines=True)
-    sprocess.wait()
-    outfile.close()
-    ret_q.put((sprocess.returncode, fn))
-
-def threaded_spatch(cocci_file, outdir, logwrite, num_jobs,
-                    print_name, extra_args=[]):
-    num_cpus = cpu_count()
-    if num_jobs:
-        threads = int(num_jobs)
-    else:
-        threads = num_cpus
-    jobs = list()
-    output = ""
-    ret_q = Queue()
-    with tempdir() as t:
-        for num in range(threads):
-            p = Process(target=spatch, args=(cocci_file, outdir,
-                                             threads, num, t, ret_q,
-                                             extra_args))
-            jobs.append(p)
-        for p in jobs:
-            p.start()
-
-        for num in range(threads):
-            ret, fn = ret_q.get()
-            if ret != 0:
-                raise ExecutionErrorThread(ret, fn, cocci_file, threads, t,
-                                           logwrite, print_name)
-        for job in jobs:
-            p.join()
-
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            tf = open(fn, 'r')
-            output = output + tf.read()
-            tf.close()
-            os.unlink(fn)
-        return output
-
-def logwrite(msg):
-    sys.stdout.write(msg)
-    sys.stdout.flush()
-
-def _main():
-    parser = argparse.ArgumentParser(description='Multithreaded Python wrapper for Coccinelle ' +
-                                     'with sensible defaults, targetted specifically ' +
-                                     'for git development environments')
-    parser.add_argument('cocci_file', metavar='<Coccinelle SmPL rules file>', type=str,
-                        help='This is the Coccinelle file you want to use')
-    parser.add_argument('target_dir', metavar='<target directory>', type=str,
-                        help='Target source directory to modify')
-    parser.add_argument('-p', '--profile-cocci', const=True, default=False, action="store_const",
-                        help='Enable profile, this will pass --profile  to Coccinelle.')
-    parser.add_argument('-j', '--jobs', metavar='<jobs>', type=str, default=None,
-                        help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
-                        'also creates a git repo on the target directory for easy inspection ' +
-                        'of changes done by Coccinelle.')
-    parser.add_argument('-v', '--verbose', const=True, default=False, action="store_const",
-                        help='Enable output from Coccinelle')
-    args = parser.parse_args()
-
-    if not os.path.isfile(args.cocci_file):
-        return -2
-
-    extra_spatch_args = []
-    if args.profile_cocci:
-        extra_spatch_args.append('--profile')
-    jobs = 0
-    if args.jobs > 0:
-        jobs = args.jobs
-
-    output = threaded_spatch(args.cocci_file,
-                             args.target_dir,
-                             logwrite,
-                             jobs,
-                             os.path.basename(args.cocci_file),
-                             extra_args=extra_spatch_args)
-    if args.verbose:
-        logwrite(output)
-    return 0
-
-if __name__ == '__main__':
-    ret = _main()
-    if ret:
-        sys.exit(ret)
diff --git a/gentree.py b/gentree.py
index 026afdc2e02d..7d3f4a4f7b8f 100755
--- a/gentree.py
+++ b/gentree.py
@@ -5,6 +5,7 @@
 
 import argparse, sys, os, errno, shutil, re, subprocess
 import tarfile, gzip
+from multiprocessing import cpu_count
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -584,13 +585,18 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
     prefix_len = len(os.path.join(source_dir, patch_src)) + 1
 
     for cocci_file in sempatches:
-        # Until Coccinelle picks this up
-        pycocci = os.path.join(source_dir, 'devel/pycocci')
-        cmd = [pycocci, cocci_file]
+        cmd = ['spatch',
+            '--sp-file', cocci_file,
+            '--in-place',
+            '--recursive-includes',
+            '--relax-include-path',
+            '--use-coccigrep',
+            '--timeout', '120',
+            '-j', '%d' % cpu_count(),
+            '--dir', os.path.abspath(target_dir) ]
         extra_spatch_args = []
         if args.profile_cocci:
-            cmd.append('--profile-cocci')
-        cmd.append(os.path.abspath(target_dir))
+            cmd.append('--profile')
         print_name = cocci_file[prefix_len:]
         if args.verbose:
             logwrite("Applying SmPL patch %s" % print_name)
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
