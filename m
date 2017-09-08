Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35872 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755916AbdIHNTA (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 09:19:00 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports-update-manager: split --force into --yes and --no-keep
Date: Fri,  8 Sep 2017 15:18:57 +0200
Message-Id: <20170908131857.11429-1-johannes@sipsolutions.net> (sfid-20170908_152122_340794_CFE7943E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

--yes allows skipping the question
--no-keep allows removing all installed data and reinstalling
--force does both (as before)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/backports-update-manager | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index e22ba3463135..64df29bcea26 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -103,8 +103,7 @@ class backport_kernel_updater:
         result.sort(key = lambda x: make_version_tuple(x[0][1:]))
         return [x[1] for x in result]
 
-    def __init__(self,
-                 force=False,
+    def __init__(self, yes=False, no_keep=False,
                  git_trees_only=False,
                  reference=None):
         self.ksrc_base = ""
@@ -121,7 +120,8 @@ class backport_kernel_updater:
         self.kernel_vers = list()
         self.kernel_vers_count = list()
         self.root = os.geteuid() == 0
-        self.force = force
+        self.yes = yes
+        self.no_keep = no_keep
         self.git_trees_only = git_trees_only
         self.reference = reference
         self.reference_git = None
@@ -209,7 +209,7 @@ class backport_kernel_updater:
                          self.ksrc_prefix + "/usr/src"))
         sys.stdout.write("** This is a terrible idea. Consider running " \
                          "as a non root.\n")
-        if not self.force:
+        if not self.yes:
             answer = input("Do you still want to continue (y/N)? ")
             if answer != "y":
                 sys.exit(1)
@@ -271,7 +271,7 @@ class backport_kernel_updater:
             sys.exit(1)
         sys.stdout.write("\n")
     def warn_size_reqs(self):
-        if self.force:
+        if self.yes:
             return
         if not self.git_trees_only:
             self.warn_size_reqs_about()
@@ -447,7 +447,7 @@ class backport_kernel_updater:
         if kver['count'] >= 2:
             sys.stdout.write("%s - up to date!\n" % kver.get('ver'))
     def is_new_kernel(self, string):
-        if self.force:
+        if self.no_keep:
             return True
         for kernel in self.all_new_kernels:
             if string in kernel:
@@ -586,7 +586,11 @@ def _main():
 
     parser = argparse.ArgumentParser(description='Linux kernel backports update manager')
     parser.add_argument('--force', const=True, default=False, action="store_const",
-                        help='Force run without sanity or careful user checks')
+                        help='Alias for --yes --no-keep')
+    parser.add_argument('--yes', const=True, default=False, action="store_const",
+                        help='Assume yes on all questions')
+    parser.add_argument('--no-keep', const=True, default=False, action="store_const",
+                        help='Don\'t keep existing installs, overwrite all again')
     parser.add_argument('--git-trees-only', const=True, default=False, action="store_const",
                         help='Only download or update the required git trees')
     parser.add_argument('--reference', metavar='<path-to-git-obj-dir>', type=str,
@@ -594,7 +598,8 @@ def _main():
                         help='Override what argument to use to git clone --reference')
     args = parser.parse_args()
 
-    bk_updater = backport_kernel_updater(force=args.force,
+    bk_updater = backport_kernel_updater(yes=args.yes or args.force,
+                                         no_keep=args.no_keep or args.force,
                                          git_trees_only=args.git_trees_only,
                                          reference=args.reference)
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
