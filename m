Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61081 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaDQSFi (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so628983pbb.19
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 6/8] backports: pycocci - make the Coccinelle wrapper a standalone tool
Date: Thu, 17 Apr 2014 11:04:54 -0700
Message-Id: <1397757896-32558-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200654_376080_79BCBBA7)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This lets us share it for general use as a generic tool, we'll upkeep
it here for now and if Coccinelle picks it up we can drop it and just
require folks to install it.

This lets us use the same solution for standard testing / regular
development and also for backports without any discrepencies.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/pycocci       | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gentree.py          |  20 ++++--
 lib/bpcoccinelle.py |  91 --------------------------
 3 files changed, 194 insertions(+), 97 deletions(-)
 create mode 100755 devel/pycocci
 delete mode 100644 lib/bpcoccinelle.py

diff --git a/devel/pycocci b/devel/pycocci
new file mode 100755
index 0000000..fde8190
--- /dev/null
+++ b/devel/pycocci
@@ -0,0 +1,180 @@
+#!/usr/bin/env python
+#
+# Copyright (c) 2014 Luis R. Rodriguez  <mcgrof@suse.com>
+# Copyright (c) 2013 Johannes Berg <johannes@sipsolutions.net>
+#
+# This file is released under the GPLv2.
+#
+# Python wrapper for Coccinelle for multithreaded support,
+# designed to be used for working on a git tree, and with sensible
+# defaults, specifically for kernel developers.
+
+from multiprocessing import Process, cpu_count, Queue
+import argparse, subprocess, os, sys
+import tempfile, shutil
+
+# simple tempdir wrapper object for 'with' statement
+#
+# Usage:
+# with tempdir.tempdir() as tmpdir:
+#     os.chdir(tmpdir)
+#     do something
+#
+class tempdir(object):
+    def __init__(self, suffix='', prefix='', dir=None, nodelete=False):
+        self.suffix = ''
+        self.prefix = ''
+        self.dir = dir
+        self.nodelete = nodelete
+
+    def __enter__(self):
+        self._name = tempfile.mkdtemp(suffix=self.suffix,
+                                      prefix=self.prefix,
+                                      dir=self.dir)
+        return self._name
+
+    def __exit__(self, type, value, traceback):
+        if self.nodelete:
+            print('not deleting directory %s!' % self._name)
+        else:
+            shutil.rmtree(self._name)
+
+class CoccinelleError(Exception):
+    pass
+class ExecutionError(CoccinelleError):
+    def __init__(self, cmd, errcode):
+        self.error_code = errcode
+        print('Failed command:')
+        print(' '.join(cmd))
+
+class ExecutionErrorThread(CoccinelleError):
+    def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
+        self.error_code = errcode
+        logwrite("Failed to apply changes from %s" % print_name)
+
+        logwrite("Specific log output from change that failed using %s" % print_name)
+        tf = open(fn, 'r')
+        for line in tf.read():
+            logwrite('> %s' % line)
+        tf.close()
+
+        logwrite("Full log using %s" % print_name)
+        for num in range(threads):
+            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
+            if (not os.path.isfile(fn)):
+                continue
+            tf = open(fn, 'r')
+            for line in tf.read():
+                logwrite('> %s' % line)
+            tf.close()
+            os.unlink(fn)
+
+def spatch(cocci_file, outdir,
+           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
+    cmd = ['spatch',
+            '--sp-file', cocci_file,
+            '--in-place',
+            '--recursive-includes',
+            '--relax-include-path',
+            '--use-coccigrep',
+            '--timeout', '120',
+            '--dir', outdir ]
+
+    if (max_threads > 1):
+        cmd.extend(['-max', str(max_threads), '-index', str(thread_id)])
+
+    cmd.extend(extra_args)
+
+    fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
+    outfile = open(fn, 'w')
+
+    sprocess = subprocess.Popen(cmd,
+                               stdout=outfile, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True)
+    sprocess.wait()
+    if sprocess.returncode != 0:
+        raise ExecutionError(cmd, sprocess.returncode)
+    outfile.close()
+    ret_q.put((sprocess.returncode, fn))
+
+def threaded_spatch(cocci_file, outdir, logwrite, num_jobs,
+                    print_name, extra_args=[]):
+    num_cpus = cpu_count()
+    if num_jobs:
+        threads = int(num_jobs)
+    else:
+        threads = num_cpus
+    jobs = list()
+    output = ""
+    ret_q = Queue()
+    with tempdir() as t:
+        for num in range(threads):
+            p = Process(target=spatch, args=(cocci_file, outdir,
+                                             threads, num, t, ret_q,
+                                             extra_args))
+            jobs.append(p)
+        for p in jobs:
+            p.start()
+
+        for num in range(threads):
+            ret, fn = ret_q.get()
+            if ret != 0:
+                raise ExecutionErrorThread(ret, fn, cocci_file, threads, t,
+                                           logwrite, print_name)
+        for job in jobs:
+            p.join()
+
+        for num in range(threads):
+            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
+            tf = open(fn, 'r')
+            output = output + tf.read()
+            tf.close()
+            os.unlink(fn)
+        return output
+
+def logwrite(msg):
+    sys.stdout.write(msg)
+    sys.stdout.flush()
+
+def _main():
+    parser = argparse.ArgumentParser(description='Multithreaded Python wrapper for Coccinelle ' +
+                                     'with sensible defaults, targetted specifically ' +
+                                     'for git development environments')
+    parser.add_argument('cocci_file', metavar='<Coccinelle SmPL rules file>', type=str,
+                        help='This is the Coccinelle file you want to use')
+    parser.add_argument('target_dir', metavar='<target directory>', type=str,
+                        help='Target source directory to modify')
+    parser.add_argument('-p', '--profile-cocci', const=True, default=False, action="store_const",
+                        help='Enable profile, this will pass --profile  to Coccinelle.')
+    parser.add_argument('-j', '--jobs', metavar='<jobs>', type=str, default=None,
+                        help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
+                        'also creates a git repo on the target directory for easy inspection ' +
+                        'of changes done by Coccinelle.')
+    parser.add_argument('-v', '--verbose', const=True, default=False, action="store_const",
+                        help='Enable output from Coccinelle')
+    args = parser.parse_args()
+
+    if not os.path.isfile(args.cocci_file):
+        return -2
+
+    extra_spatch_args = []
+    if args.profile_cocci:
+        extra_spatch_args.append('--profile')
+    jobs = 0
+    if args.jobs > 0:
+        jobs = args.jobs
+
+    output = threaded_spatch(args.cocci_file,
+                             args.target_dir,
+                             logwrite,
+                             jobs,
+                             os.path.basename(args.cocci_file),
+                             extra_args=extra_spatch_args)
+    if args.verbose:
+        logwrite(output)
+    return 0
+
+if __name__ == '__main__':
+    ret = _main()
+    if ret:
+        sys.exit(ret)
diff --git a/gentree.py b/gentree.py
index b890d28..44acb9a 100755
--- a/gentree.py
+++ b/gentree.py
@@ -14,7 +14,6 @@ from lib import kconfig, patch, make
 from lib import bpgit as git
 from lib import bpgpg as gpg
 from lib import bpkup as kup
-from lib import bpcoccinelle as coccinelle
 from lib.tempdir import tempdir
 
 def read_copy_list(copyfile):
@@ -712,16 +711,25 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
 
     for cocci_file in sempatches:
+        # Until Coccinelle picks this up
+        pycocci = os.path.join(source_dir, 'devel/pycocci')
+        cmd = [pycocci, cocci_file]
         extra_spatch_args = []
         if args.profile_cocci:
-            extra_spatch_args.append('--profile')
+            cmd.append('--profile-cocci')
+        cmd.append(args.outdir)
         print_name = cocci_file[prefix_len:]
         if args.verbose:
             logwrite("Applying SmPL patch %s" % print_name)
-
-        output = coccinelle.threaded_spatch(cocci_file, args.outdir,
-                                            logwrite, print_name,
-                                            extra_args=extra_spatch_args)
+        sprocess = subprocess.Popen(cmd,
+                                    stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                    close_fds=True, universal_newlines=True,
+                                    cwd=args.outdir)
+        output = sprocess.communicate()[0]
+        sprocess.wait()
+        if sprocess.returncode != 0:
+            logwrite("Failed to process SmPL patch %s" % print_name)
+            return 3
         output = output.split('\n')
         if output[-1] == '':
             output = output[:-1]
diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
deleted file mode 100644
index 2e0153e..0000000
--- a/lib/bpcoccinelle.py
+++ /dev/null
@@ -1,91 +0,0 @@
-from multiprocessing import Process, cpu_count, Queue
-import subprocess, os
-from lib.tempdir import tempdir
-
-class CoccinelleError(Exception):
-    pass
-class ExecutionError(CoccinelleError):
-    def __init__(self, errcode):
-        self.error_code = errcode
-class ExecutionErrorThread(CoccinelleError):
-    def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
-        self.error_code = errcode
-        logwrite("Failed to apply changes from %s" % print_name)
-
-        logwrite("Specific log output from change that failed using %s" % print_name)
-        tf = open(fn, 'r')
-        for line in tf.read():
-            logwrite('> %s' % line)
-        tf.close()
-
-        logwrite("Full log using %s" % print_name)
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            if (not os.path.isfile(fn)):
-                continue
-            tf = open(fn, 'r')
-            for line in tf.read():
-                logwrite('> %s' % line)
-            tf.close()
-            os.unlink(fn)
-
-def spatch(cocci_file, outdir,
-           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
-    cmd = ['spatch', '--sp-file', cocci_file, '--in-place',
-            '--recursive-includes',
-            '--relax-include-path',
-            '--use-coccigrep',
-            '--timeout', '120',
-            '--backup-suffix', '.cocci_backup', '--dir', '.']
-
-    if (max_threads > 1):
-        cmd.extend(['-max', str(max_threads), '-index', str(thread_id)])
-
-    cmd.extend(extra_args)
-
-    fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
-    outfile = open(fn, 'w')
-
-    sprocess = subprocess.Popen(cmd,
-                               stdout=outfile, stderr=subprocess.STDOUT,
-                               close_fds=True, universal_newlines=True,
-                               cwd=outdir)
-    sprocess.wait()
-    if sprocess.returncode != 0:
-        raise ExecutionError(sprocess.returncode)
-    outfile.close()
-    ret_q.put((sprocess.returncode, fn))
-
-def threaded_spatch(cocci_file, outdir, logwrite, print_name, extra_args=[]):
-    threads = cpu_count()
-    jobs = list()
-    output = ''
-    ret_q = Queue()
-    with tempdir() as t:
-
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
-
-        for job in jobs:
-            p.join()
-
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            tf = open(fn, 'r')
-            output = output + tf.read()
-            tf.close()
-            os.unlink(fn)
-
-        output = output + '\n'
-        return output
-- 
1.9.1

