Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:47617 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3LLMih (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 12 Dec 2013 07:38:37 -0500
Received: by mail-we0-f178.google.com with SMTP id u57so367403wes.9
        for <backports@vger.kernel.org>; Thu, 12 Dec 2013 04:38:36 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 1/2] backports: add Coccinelle SmPL profiling support to gentree.py
Date: Thu, 12 Dec 2013 13:38:33 +0100
Message-Id: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131212_133841_122311_2069536F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds support to let you pass --profile when running Coccinelle.
This will skip all patches, rewriting Makefiles, Kconfigs, etc, and
it will also keep a copy of the original src directory prior to
applying the spatch. You pass the spatch file as an argument when
using this.

Screenshot of relevant output on 11-dev-pm-ops.cocci:

$ ./gentree.py --clean --verbose --profile-cocci \
	patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/backports-20131206

On big iron backports server:

---------------------
profiling result
---------------------
Main total                               :    275.327 sec          1 count
Main.outfiles computation                :    274.761 sec          1 count
full_engine                              :    272.034 sec        291 count
C parsing                                :    158.143 sec        346 count
TOTAL                                    :    158.141 sec        346 count
HACK                                     :     69.680 sec        696 count
C parsing.tokens                         :     54.000 sec        693 count
Parsing: 1st pass                        :     43.870 sec      22728 count
YACC                                     :     42.921 sec      22615 count
C parsing.fix_cpp                        :     36.855 sec        349 count
MACRO mgmt prep 2                        :     32.787 sec        346 count
TAC.annotate_program                     :     32.779 sec        318 count
flow                                     :     31.251 sec      21004 count
LEXING                                   :     26.415 sec        346 count
bigloop                                  :     15.298 sec        291 count
process_a_ctl_a_env_a_toplevel           :     14.840 sec      46661 count
C parsing.lookahead                      :     13.254 sec    1965389 count
mysat                                    :     12.777 sec      46661 count
show_xxx                                 :     11.933 sec      49645 count
C parsing.fix_define                     :      6.957 sec        693 count
Type_c.type_of_s                         :      6.729 sec     135896 count
module_pci                               :      6.653 sec        291 count
rule starting on line 28                 :      6.630 sec        291 count
fix_flow                                 :      6.498 sec      20038 count
C parsing.lex_ident                      :      6.388 sec    1695857 count
C consistencycheck                       :      6.213 sec        346 count
Pattern3.match_re_node                   :      6.110 sec     969235 count
Common.full_charpos_to_pos_large         :      5.684 sec        693 count
C parsing.mk_info_item                   :      3.556 sec      22728 count
worth_trying                             :      2.683 sec       1902 count
Parsing: multi pass                      :      2.574 sec        206 count
simple_dev_pm                            :      2.011 sec        291 count
TAC.unwrap_unfold_env                    :      2.007 sec     171026 count
TAC.typedef_fix                          :      1.948 sec     273295 count
TAC.lookup_env                           :      1.583 sec     236568 count
TAC.add_binding                          :      0.896 sec      57620 count
MACRO managment                          :      0.439 sec        118 count
Main.result analysis                     :      0.418 sec          1 count
Common.=~                                :      0.305 sec      80558 count
C unparsing                              :      0.168 sec         41 count
MACRO mgmt prep 1                        :      0.148 sec        346 count
parse cocci                              :      0.115 sec          1 count
pre_engine                               :      0.115 sec          1 count
Common.info_from_charpos                 :      0.102 sec         54 count
Main.infiles computation                 :      0.033 sec          1 count
ctl                                      :      0.019 sec         94 count
Transformation3.transform                :      0.006 sec         27 count
TAC.lookup_typedef                       :      0.004 sec        332 count
check_duplicate                          :      0.003 sec          1 count
Common.group_assoc_bykey_eff             :      0.003 sec          1 count
merge_env                                :      0.003 sec        649 count
post_engine                              :      0.000 sec          1 count
get_glimpse_constants                    :      0.000 sec          1 count
Common.full_charpos_to_pos               :      0.000 sec          2 count
asttoctl2                                :      0.000 sec          1 count

On a Chromebook Pixel:

---------------------
profiling result
---------------------
Main total                               :    379.349 sec          1 count
Main.outfiles computation                :    379.139 sec          1 count
full_engine                              :    372.905 sec       1902 count
HACK                                     :     96.134 sec       2785 count
C parsing.tokens                         :     76.053 sec       2769 count
Parsing: 1st pass                        :     57.708 sec      82287 count
YACC                                     :     56.033 sec      81918 count
C parsing.fix_cpp                        :     52.167 sec       1400 count
TAC.annotate_program                     :     46.560 sec       1356 count
MACRO mgmt prep 2                        :     43.976 sec       1384 count
flow                                     :     41.027 sec      80563 count
LEXING                                   :     38.111 sec       1384 count
bigloop                                  :     17.631 sec       1329 count
process_a_ctl_a_env_a_toplevel           :     17.174 sec     161123 count
C parsing.lookahead                      :     15.138 sec    6737589 count
mysat                                    :     14.537 sec     161123 count
Type_c.type_of_s                         :     11.815 sec     675989 count
Common.full_charpos_to_pos_large         :      9.507 sec       2769 count
fix_flow                                 :      8.685 sec      77269 count
module_pci                               :      8.459 sec       1329 count
rule starting on line 28                 :      8.400 sec       1329 count
C consistencycheck                       :      8.137 sec       1384 count
C parsing.lex_ident                      :      7.810 sec    5665983 count
C parsing.fix_define                     :      7.343 sec       2769 count
Pattern3.match_re_node                   :      6.827 sec    3046889 count
C parsing.mk_info_item                   :      5.787 sec      82287 count
show_xxx                                 :      4.825 sec     174022 count
Parsing: multi pass                      :      2.802 sec        679 count
TAC.lookup_env                           :      2.556 sec     858456 count
TAC.typedef_fix                          :      2.540 sec     976842 count
TAC.unwrap_unfold_env                    :      2.278 sec     587709 count
TAC.add_binding                          :      1.157 sec     204618 count
simple_dev_pm                            :      0.762 sec       1329 count
MACRO managment                          :      0.610 sec        394 count
Common.=~                                :      0.377 sec     253422 count
MACRO mgmt prep 1                        :      0.299 sec       1384 count
Main.result analysis                     :      0.200 sec          1 count
Common.info_from_charpos                 :      0.135 sec        248 count
C unparsing                              :      0.132 sec         41 count
pre_engine                               :      0.050 sec          1 count
parse cocci                              :      0.050 sec          1 count
C parsing                                :      0.016 sec       1384 count
check_duplicate                          :      0.012 sec          1 count
Common.group_assoc_bykey_eff             :      0.012 sec          1 count
TAC.lookup_typedef                       :      0.011 sec       1314 count
Main.infiles computation                 :      0.010 sec          1 count
ctl                                      :      0.009 sec         94 count
merge_env                                :      0.005 sec       2725 count
TOTAL                                    :      0.004 sec       1384 count
Transformation3.transform                :      0.003 sec         27 count
Common.full_charpos_to_pos               :      0.002 sec          2 count
C unparsing.new_tabbing                  :      0.000 sec        149 count
get_glimpse_constants                    :      0.000 sec          1 count
asttoctl2                                :      0.000 sec          1 count
post_engine                              :      0.000 sec          1 count

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index e16e297..8aaf11e 100755
--- a/gentree.py
+++ b/gentree.py
@@ -472,6 +472,8 @@ def _main():
                              'however run `kup ls` on the target paths so ' +
                              'at the very least we test your kup configuration. ' +
                              'If this is your first time uploading use this first!')
+    parser.add_argument('--profile-cocci', metavar='<sp_file>', type=str, default=None,
+                        help='Only use the cocci file passed and pass --profile  to Coccinelle.')
     args = parser.parse_args()
 
     def logwrite(msg):
@@ -486,19 +488,22 @@ def _main():
                    extra_driver=args.extra_driver,
                    kup=args.kup,
                    kup_test=args.kup_test,
+                   profile_cocci=args.profile_cocci,
                    logwrite=logwrite)
 
 def process(kerneldir, outdir, copy_list_file, git_revision=None,
             clean=False, refresh=False, base_name="Linux", gitdebug=False,
             verbose=False, extra_driver=[], kup=False,
             kup_test=False,
+            profile_cocci=None,
             logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
         def __init__(self, kerneldir, outdir, copy_list_file,
                      git_revision, clean, refresh, base_name,
                      gitdebug, verbose, extra_driver, kup,
-                     kup_test):
+                     kup_test,
+                     profile_cocci):
             self.kerneldir = kerneldir
             self.outdir = outdir
             self.copy_list = copy_list_file
@@ -511,6 +516,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.extra_driver = extra_driver
             self.kup = kup
             self.kup_test = kup_test
+            self.profile_cocci = profile_cocci
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
         if (data['r'] != 0):
@@ -522,7 +528,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     args = Args(kerneldir, outdir, copy_list_file,
                 git_revision, clean, refresh, base_name,
-                gitdebug, verbose, extra_driver, kup, kup_test)
+                gitdebug, verbose, extra_driver, kup, kup_test,
+                profile_cocci)
     rel_prep = None
 
     # start processing ...
@@ -592,14 +599,27 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
+    # Extend with other tests for Coccinelle
+    test_cocci = args.profile_cocci
+    if test_cocci:
+        test_cocci = test_cocci.split('/')[-1]
+        orig_dir = args.outdir + '.orig'
+        shutil.rmtree(orig_dir, ignore_errors=True)
+        copytree(args.outdir, orig_dir)
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
+                    if f != test_cocci:
+                        continue
+                    if args.profile_cocci:
+                        logwrite("Profiling Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
@@ -681,12 +701,16 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     sempatches.sort()
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
     for cocci_file in sempatches:
+        profile = ''
+        if args.profile_cocci:
+            profile = '--profile'
         print_name = cocci_file[prefix_len:]
         if args.verbose:
             logwrite("Applying patch %s" % print_name)
 
         process = subprocess.Popen(['spatch', '--sp-file', cocci_file, '--in-place',
-                                    '--backup-suffix', '.cocci_backup', '--dir', '.'],
+                                    '--backup-suffix', '.cocci_backup', profile,
+                                    '--dir', '.'],
                                    stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                    close_fds=True, universal_newlines=True,
                                    cwd=args.outdir)
@@ -711,6 +735,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                     os.unlink(os.path.join(root, f))
         git_debug_snapshot(args, "apply backport patch %s" % print_name)
 
+    if test_cocci:
+        logwrite('Done!')
+        return 0
+
     # some post-processing is required
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
     logwrite('Modify Kconfig tree ...')
-- 
1.8.4.3

