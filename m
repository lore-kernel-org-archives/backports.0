Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:55639 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3LLMik (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 12 Dec 2013 07:38:40 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so681281wib.0
        for <backports@vger.kernel.org>; Thu, 12 Dec 2013 04:38:39 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 2/2] backports: add support for testing only a single Coccinelle SmPL patch
Date: Thu, 12 Dec 2013 13:38:34 +0100
Message-Id: <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20131212_133841_815792_5A408BF3)
In-Reply-To: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

You can just pass now one cocci file with the --test-cocci to test
only that single Coccinelle SmPL patch.

On my Chromebook Pixel:

$ time ./gentree.py --clean --verbose --test-cocci \
	patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/backports-20131206

real    5m39.361s
user    5m24.148s
sys     0m7.772s

Note run time with --profile-cocci on the same system:

real    6m25.778s
user    6m4.912s
sys     0m8.060s

The an original copy of the souce directory will be kept under the
target directory, renamed with .orig.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index 8aaf11e..cacb58a 100755
--- a/gentree.py
+++ b/gentree.py
@@ -472,6 +472,8 @@ def _main():
                              'however run `kup ls` on the target paths so ' +
                              'at the very least we test your kup configuration. ' +
                              'If this is your first time uploading use this first!')
+    parser.add_argument('--test-cocci', metavar='<sp_file>', type=str, default=None,
+                        help='Only use the cocci file passed for Coccinelle, don\'t do anything else')
     parser.add_argument('--profile-cocci', metavar='<sp_file>', type=str, default=None,
                         help='Only use the cocci file passed and pass --profile  to Coccinelle.')
     args = parser.parse_args()
@@ -488,6 +490,7 @@ def _main():
                    extra_driver=args.extra_driver,
                    kup=args.kup,
                    kup_test=args.kup_test,
+                   test_cocci=args.test_cocci,
                    profile_cocci=args.profile_cocci,
                    logwrite=logwrite)
 
@@ -495,6 +498,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             clean=False, refresh=False, base_name="Linux", gitdebug=False,
             verbose=False, extra_driver=[], kup=False,
             kup_test=False,
+            test_cocci=None,
             profile_cocci=None,
             logwrite=lambda x:None,
             git_tracked_version=False):
@@ -503,6 +507,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                      git_revision, clean, refresh, base_name,
                      gitdebug, verbose, extra_driver, kup,
                      kup_test,
+                     test_cocci,
                      profile_cocci):
             self.kerneldir = kerneldir
             self.outdir = outdir
@@ -516,6 +521,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.extra_driver = extra_driver
             self.kup = kup
             self.kup_test = kup_test
+            self.test_cocci = test_cocci
             self.profile_cocci = profile_cocci
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
@@ -529,7 +535,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     args = Args(kerneldir, outdir, copy_list_file,
                 git_revision, clean, refresh, base_name,
                 gitdebug, verbose, extra_driver, kup, kup_test,
-                profile_cocci)
+                test_cocci, profile_cocci)
     rel_prep = None
 
     # start processing ...
@@ -599,8 +605,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
-    # Extend with other tests for Coccinelle
-    test_cocci = args.profile_cocci
+    test_cocci = args.profile_cocci or \
+                 args.test_cocci
     if test_cocci:
         test_cocci = test_cocci.split('/')[-1]
         orig_dir = args.outdir + '.orig'
@@ -618,7 +624,9 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                 if test_cocci:
                     if f != test_cocci:
                         continue
-                    if args.profile_cocci:
+                    if args.test_cocci:
+                        logwrite("Testing Coccinelle SmPL patch: %s" % test_cocci)
+                    elif args.profile_cocci:
                         logwrite("Profiling Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
     patches.sort()
-- 
1.8.4.3

