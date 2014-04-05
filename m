Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56759 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so4689956pab.33
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 13/27] backports: add threaded Coccinelle spatch support
Date: Sat,  5 Apr 2014 05:40:47 -0700
Message-Id: <1396701662-15165-14-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_992703_6BCE7A06)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Turns out Coccinelle has threaded support, it lets you
break down the target code you need to parse for a spatch
file into separate buckets, each bucket handling a subset of
the target files needed to be evaluated. This adds support
for that and shaves down the amount of time it gets to
generate target code by 97.19%.

Using:

mcgrof@drvbp1 ~/backports (git::master)$ time \
	./gentree.py	--verbose \
			--clean \
			--refresh \
			/home/mcgrof/linux-next/ \
			/home/mcgrof/build/next-20140311

Before this patch:

real    19m34.867s
user    18m43.492s
sys     0m21.244s

After this patch by using num_cpus threads:

real    2m42.012s
user    21m53.616s
sys     0m22.748s

After this patch by using 3 * num_cpus threads:

real    1m33.316s
user    24m6.080s
sys     0m28.264s

Using num_cpus threads alone was giving 2m42.012s, its why I
experimented in increasing this. I also experimented with
6 * num_cpus threads as well but the amount of time spent
running didn't reduce, lets keep this at 3 * num_cpus for now
and we can experiment and empirically find the best setting for
any system or just make this configurable.

We had SmPL patch integration first committed via
86d99c9d4 back then we were able to scale to a reasonable
similar time:

mcgrof@drvbp1 ~/backports (git::cocci-added)$ time \
	./gentree.py --verbsose \
		     --clean \
		     --refresh \
		     /home/mcgrof/linux-next
		     /home/mcgrof/build/next-20131113
real    1m1.967s
user    0m49.304s
sys     0m11.880s

For history's purpose here's our run time without Coccinelle on
commit 338c4388cc:

mcgrof@drvbp1 ~/backports (git::before-smpl)$ time \
        ./gentree.py --verbose \
                     --clean \
                     --refresh \
                     /home/mcgrof/linux-next/ \
                     /home/mcgrof/build/next-20131029
real    0m29.639s
user    0m17.508s
sys     0m11.568s

This new changes sets us back on track with the timing for when we first
introduced Coccinelle support we just have a lot 5 Coccinelle patches
now. I hope this shows we should be able to scale with Coccinelle much more
efficiently for collateral evolutions that sprinkle through tons of
files.

Screenshots available using htop before [0] and after the patch [1]
while coccinelle is running, this shows how the system is using
resources much more efficiently when doing spatch evaluation for
patch generation on target code.

[0] http://drvbp1.linux-foundation.org/~mcgrof/images/coccinelle-backports/before-threaded-cocci.png
[1] http://drvbp1.linux-foundation.org/~mcgrof/images/coccinelle-backports/after-threaded-cocci.png

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py          | 14 ++-------
 lib/bpcoccinelle.py | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100644 lib/bpcoccinelle.py

diff --git a/gentree.py b/gentree.py
index f6f766f..8924b08 100755
--- a/gentree.py
+++ b/gentree.py
@@ -14,6 +14,7 @@ from lib import kconfig, patch, make
 from lib import bpgit as git
 from lib import bpgpg as gpg
 from lib import bpkup as kup
+from lib import bpcoccinelle as coccinelle
 from lib.tempdir import tempdir
 
 def read_copy_list(copyfile):
@@ -699,24 +700,13 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             if args.verbose:
                 logwrite("Applying patch %s" % print_name)
 
-            process = subprocess.Popen(['spatch', '--sp-file', cocci_file, '--in-place',
-                                        '--backup-suffix', '.cocci_backup', '--dir', '.'],
-                                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-                                       close_fds=True, universal_newlines=True,
-                                       cwd=args.outdir)
-            output = process.communicate()[0]
+            output = coccinelle.threaded_spatch(cocci_file, args.outdir, logwrite, print_name)
             output = output.split('\n')
             if output[-1] == '':
                 output = output[:-1]
             if args.verbose:
                 for line in output:
                     logwrite('> %s' % line)
-            if process.returncode != 0:
-                if not args.verbose:
-                    logwrite("Failed to apply changes from %s" % print_name)
-                    for line in output:
-                        logwrite('> %s' % line)
-                return 2
 
             # remove cocci_backup files
             for root, dirs, files in os.walk(args.outdir):
diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
new file mode 100644
index 0000000..d9a3cc8
--- /dev/null
+++ b/lib/bpcoccinelle.py
@@ -0,0 +1,87 @@
+from multiprocessing import Process, cpu_count, Queue
+import subprocess, os
+from lib.tempdir import tempdir
+
+class CoccinelleError(Exception):
+    pass
+class ExecutionError(CoccinelleError):
+    def __init__(self, errcode):
+        self.error_code = errcode
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
+    cmd = ['spatch', '--sp-file', cocci_file, '--in-place',
+            '--backup-suffix', '.cocci_backup', '--dir', '.']
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
+                               close_fds=True, universal_newlines=True,
+                               cwd=outdir)
+    sprocess.wait()
+    if sprocess.returncode != 0:
+        raise ExecutionError(sprocess.returncode)
+    outfile.close()
+    ret_q.put((sprocess.returncode, fn))
+
+def threaded_spatch(cocci_file, outdir, logwrite, print_name):
+    num_cpus = cpu_count()
+    threads = num_cpus * 3
+    jobs = list()
+    output = ''
+    ret_q = Queue()
+    with tempdir() as t:
+
+        for num in range(threads):
+            p = Process(target=spatch, args=(cocci_file, outdir,
+                                             threads, num, t, ret_q))
+            jobs.append(p)
+        for p in jobs:
+            p.start()
+
+        for num in range(threads):
+            ret, fn = ret_q.get()
+            if ret != 0:
+                raise ExecutionErrorThread(ret, fn, cocci_file, threads, t,
+                                           logwrite, print_name)
+
+        for job in jobs:
+            p.join()
+
+        for num in range(threads):
+            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
+            tf = open(fn, 'r')
+            output = output + tf.read()
+            tf.close()
+            os.unlink(fn)
+
+        output = output + '\n'
+        return output
-- 
1.8.5.3

