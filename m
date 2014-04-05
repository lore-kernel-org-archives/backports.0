Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:37628 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmb (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:31 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4451704pdj.8
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 17/27] backports: add Coccinelle SmPL profiling support to gentree.py
Date: Sat,  5 Apr 2014 05:40:51 -0700
Message-Id: <1396701662-15165-18-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_716802_6945ACD2)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds support to let you pass --profile when running Coccinelle.
This will skip all patches, rewriting Makefiles, Kconfigs, etc, and
it will also keep a copy of the original src directory prior to
applying the spatch. You pass the spatch file as an argument when
using this.

Screenshot of relevant output on 11-dev-pm-ops.cocci:

$ time ./gentree.py --clean --verbose --profile-cocci 11-dev-pm-ops.cocci \
        /home/mcgrof/linux-next/ \
        /home/mcgrof/build/backports-20140311

Copy original source files ...
Apply patches ...
Profiling Coccinelle SmPL patch: 11-dev-pm-ops.cocci
Applying SmPL patch collateral-evolutions/network/11-dev-pm-ops.cocci
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> warning: line 15: should pci be a metavariable?
> (ONCE) Expected tokens pm pci_driver driver pci SIMPLE_DEV_PM_OPS
> MODULE_DEVICE_TABLE
> Skipping:./net/mac802154/ieee802154_dev.c
> Skipping:./net/mac802154/mac_cmd.c
> Skipping:./net/mac802154/mib.c
> Skipping:./net/mac802154/monitor.c
> Skipping:./net/mac802154/rx.c
> Skipping:./net/mac802154/tx.c
> Skipping:./net/mac802154/wpan.c
> starting: Common.group_assoc_bykey_eff
> ending: Common.group_assoc_bykey_eff, 0.000114s
> ---------------------
> profiling result
> ---------------------
> Main total                               :      0.584 sec          1 count
> parse cocci                              :      0.422 sec          1 count
> pre_engine                               :      0.422 sec          1 count
> Main.infiles computation                 :      0.156 sec          1 count
> HACK                                     :      0.069 sec          1 count
> C parsing.tokens                         :      0.043 sec          1 count
> C parsing.fix_define                     :      0.022 sec          1 count
> get_glimpse_constants                    :      0.021 sec          1 count
> C parsing.lex_ident                      :      0.006 sec        673 count
> Common.full_charpos_to_pos_large         :      0.006 sec          1 count
> Main.outfiles computation                :      0.004 sec          1 count
> worth_trying                             :      0.004 sec          7 count
> Common.full_charpos_to_pos               :      0.003 sec          2 count
> Common.=~                                :      0.000 sec          4 count
> check_duplicate                          :      0.000 sec          1 count
> Main.result analysis                     :      0.000 sec          1 count
> Common.group_assoc_bykey_eff             :      0.000 sec          1 count
> asttoctl2                                :      0.000 sec          1 count
> post_engine                              :      0.000 sec          1 count
> show_xxx                                 :      0.000 sec          2 count

This goes on... and a page per thread spawned and the results will be
specific to the files tha the thread worked on. On the above results
we can see Coccinelle spent little to no time working on the above
files as it determined it had nothing to do there.

On big iron backports server:

real    0m31.226s
user    7m25.712s
sys     0m34.492s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py          | 25 +++++++++++++++++++------
 lib/bpcoccinelle.py |  6 ++++--
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/gentree.py b/gentree.py
index fc272b9..bffa7e4 100755
--- a/gentree.py
+++ b/gentree.py
@@ -478,6 +478,10 @@ def _main():
                         help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
                              'also creates a git repo on the target directory for easy inspection ' +
                              'of changes done by Coccinelle.')
+    parser.add_argument('--profile-cocci', metavar='<sp_file>', type=str, default=None,
+                        help='Only use the cocci file passed and pass --profile  to Coccinelle, ' +
+                             'also creates a git repo on the target directory for easy inspection ' +
+                             'of changes done by Coccinelle.')
     args = parser.parse_args()
 
     def logwrite(msg):
@@ -493,6 +497,7 @@ def _main():
                    kup=args.kup,
                    kup_test=args.kup_test,
                    test_cocci=args.test_cocci,
+                   profile_cocci=args.profile_cocci,
                    logwrite=logwrite)
 
 def process(kerneldir, outdir, copy_list_file, git_revision=None,
@@ -500,6 +505,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             verbose=False, extra_driver=[], kup=False,
             kup_test=False,
             test_cocci=None,
+            profile_cocci=None,
             logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
@@ -507,7 +513,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                      git_revision, clean, refresh, base_name,
                      gitdebug, verbose, extra_driver, kup,
                      kup_test,
-                     test_cocci):
+                     test_cocci,
+                     profile_cocci):
             self.kerneldir = kerneldir
             self.outdir = outdir
             self.copy_list = copy_list_file
@@ -521,7 +528,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.kup = kup
             self.kup_test = kup_test
             self.test_cocci = test_cocci
-            if self.test_cocci:
+            self.profile_cocci = profile_cocci
+            if self.test_cocci or self.profile_cocci:
                 self.gitdebug = True
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
@@ -535,7 +543,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     args = Args(kerneldir, outdir, copy_list_file,
                 git_revision, clean, refresh, base_name,
                 gitdebug, verbose, extra_driver, kup, kup_test,
-                test_cocci)
+                test_cocci, profile_cocci)
     rel_prep = None
 
     # start processing ...
@@ -605,8 +613,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
-    # Extend with other tests for Coccinelle
-    test_cocci = args.test_cocci
+    test_cocci = args.test_cocci or args.profile_cocci
 
     logwrite('Apply patches ...')
     patches = []
@@ -621,6 +628,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                         continue
                     if args.test_cocci:
                         logwrite("Testing Coccinelle SmPL patch: %s" % test_cocci)
+                    elif args.profile_cocci:
+                        logwrite("Profiling Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
@@ -715,13 +724,17 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         else:
             prefix_len = len(os.path.join(source_dir, 'patches')) + 1
         for cocci_file in sempatches:
+            extra_spatch_args = []
+            if args.profile_cocci:
+                extra_spatch_args.append('--profile')
             print_name = cocci_file[prefix_len:]
             if args.verbose:
                 logwrite("Applying SmPL patch %s" % print_name)
 
             output = coccinelle.threaded_spatch(cocci_file, args.outdir,
                                                 logwrite, print_name,
-                                                test_cocci)
+                                                test_cocci,
+                                                extra_args=extra_spatch_args)
             output = output.split('\n')
             if output[-1] == '':
                 output = output[:-1]
diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index 77e9d6d..37307d2 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -52,7 +52,8 @@ def spatch(cocci_file, outdir,
     outfile.close()
     ret_q.put((sprocess.returncode, fn))
 
-def threaded_spatch(cocci_file, outdir, logwrite, print_name, test_cocci):
+def threaded_spatch(cocci_file, outdir, logwrite, print_name,
+                    test_cocci, extra_args=[]):
     num_cpus = cpu_count()
     threads = num_cpus * 3
     if test_cocci:
@@ -64,7 +65,8 @@ def threaded_spatch(cocci_file, outdir, logwrite, print_name, test_cocci):
 
         for num in range(threads):
             p = Process(target=spatch, args=(cocci_file, outdir,
-                                             threads, num, t, ret_q))
+                                             threads, num, t, ret_q,
+                                             extra_args))
             jobs.append(p)
         for p in jobs:
             p.start()
-- 
1.8.5.3

