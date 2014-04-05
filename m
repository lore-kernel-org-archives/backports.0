Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33096 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMm0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so4631509pbc.7
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 16/27] backports: add support for testing only a single Coccinelle SmPL patch
Date: Sat,  5 Apr 2014 05:40:50 -0700
Message-Id: <1396701662-15165-17-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_589857_1D615513)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

You can just pass now one cocci file with the --test-cocci to test
only that single Coccinelle SmPL patch. If you are not sure what
an SmPL patch produces and you only want to study the results of
applying only a single SmPL patch you can use this flag to trigger
enabling git on the target directory, a commit will be done before
applying the SmPL patch and then another commit will be performed
after the SmPL patch is applied. You can then use git show as you'd
expect to inspect the results.

Note that if you don't use --test-cocci and run gentree.py regularly
you can always still use --git-debug to see atomically what is happening
after each patch, including Coccinelle patches.

This modifies the coccinelle library to use 10 * num_cpus threads
for when in testing Coccinelle mode.

$ time ./gentree.py --clean --verbose --test-cocci 11-dev-pm-ops.cocci \
        /home/mcgrof/linux-next/ \
        /home/mcgrof/build/next-20140311

real    0m28.964s
user    6m57.848s
sys     0m25.124s

Note that you can pass either a full path or the file name alone
of the target Coccinelle SmPL patch you want to test.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py          | 37 +++++++++++++++++++++++++++++++------
 lib/bpcoccinelle.py |  4 +++-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/gentree.py b/gentree.py
index 8924b08..fc272b9 100755
--- a/gentree.py
+++ b/gentree.py
@@ -474,6 +474,10 @@ def _main():
                              'however run `kup ls` on the target paths so ' +
                              'at the very least we test your kup configuration. ' +
                              'If this is your first time uploading use this first!')
+    parser.add_argument('--test-cocci', metavar='<sp_file>', type=str, default=None,
+                        help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
+                             'also creates a git repo on the target directory for easy inspection ' +
+                             'of changes done by Coccinelle.')
     args = parser.parse_args()
 
     def logwrite(msg):
@@ -488,19 +492,22 @@ def _main():
                    extra_driver=args.extra_driver,
                    kup=args.kup,
                    kup_test=args.kup_test,
+                   test_cocci=args.test_cocci,
                    logwrite=logwrite)
 
 def process(kerneldir, outdir, copy_list_file, git_revision=None,
             clean=False, refresh=False, base_name="Linux", gitdebug=False,
             verbose=False, extra_driver=[], kup=False,
             kup_test=False,
+            test_cocci=None,
             logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
         def __init__(self, kerneldir, outdir, copy_list_file,
                      git_revision, clean, refresh, base_name,
                      gitdebug, verbose, extra_driver, kup,
-                     kup_test):
+                     kup_test,
+                     test_cocci):
             self.kerneldir = kerneldir
             self.outdir = outdir
             self.copy_list = copy_list_file
@@ -513,6 +520,9 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.extra_driver = extra_driver
             self.kup = kup
             self.kup_test = kup_test
+            self.test_cocci = test_cocci
+            if self.test_cocci:
+                self.gitdebug = True
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
         if (data['r'] != 0):
@@ -524,7 +534,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     args = Args(kerneldir, outdir, copy_list_file,
                 git_revision, clean, refresh, base_name,
-                gitdebug, verbose, extra_driver, kup, kup_test)
+                gitdebug, verbose, extra_driver, kup, kup_test,
+                test_cocci)
     rel_prep = None
 
     # start processing ...
@@ -594,14 +605,22 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
+    # Extend with other tests for Coccinelle
+    test_cocci = args.test_cocci
+
     logwrite('Apply patches ...')
     patches = []
     sempatches = []
     for root, dirs, files in os.walk(os.path.join(source_dir, 'patches')):
         for f in files:
-            if f.endswith('.patch'):
+            if not test_cocci and f.endswith('.patch'):
                 patches.append(os.path.join(root, f))
             if f.endswith('.cocci'):
+                if test_cocci:
+                    if f not in test_cocci:
+                        continue
+                    if args.test_cocci:
+                        logwrite("Testing Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
@@ -698,9 +717,11 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         for cocci_file in sempatches:
             print_name = cocci_file[prefix_len:]
             if args.verbose:
-                logwrite("Applying patch %s" % print_name)
+                logwrite("Applying SmPL patch %s" % print_name)
 
-            output = coccinelle.threaded_spatch(cocci_file, args.outdir, logwrite, print_name)
+            output = coccinelle.threaded_spatch(cocci_file, args.outdir,
+                                                logwrite, print_name,
+                                                test_cocci)
             output = output.split('\n')
             if output[-1] == '':
                 output = output[:-1]
@@ -713,7 +734,11 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                 for f in files:
                     if f.endswith('.cocci_backup'):
                         os.unlink(os.path.join(root, f))
-            git_debug_snapshot(args, "apply backport patch %s" % print_name)
+            git_debug_snapshot(args, "apply backport SmPL patch %s" % print_name)
+
+    if test_cocci:
+        logwrite('Done!')
+        return 0
 
     # some post-processing is required
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index d9a3cc8..77e9d6d 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -52,9 +52,11 @@ def spatch(cocci_file, outdir,
     outfile.close()
     ret_q.put((sprocess.returncode, fn))
 
-def threaded_spatch(cocci_file, outdir, logwrite, print_name):
+def threaded_spatch(cocci_file, outdir, logwrite, print_name, test_cocci):
     num_cpus = cpu_count()
     threads = num_cpus * 3
+    if test_cocci:
+        threads = num_cpus * 10
     jobs = list()
     output = ''
     ret_q = Queue()
-- 
1.8.5.3

