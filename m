Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34502 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210AbaKRUmG (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 18 Nov 2014 15:42:06 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix breakage from integration patchset
Date: Tue, 18 Nov 2014 21:41:59 +0100
Message-Id: <1416343319-9395-1-git-send-email-johannes@sipsolutions.net> (sfid-20141118_214208_966915_FD54C942)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Various small things broken in the integration patchset, fix
them to actually make backports useful again.

For example, a driver using devcoredump wouldn't have worked
without these changes as it would depend on devcoredump, and
that wasn't backported due to the bugs, despite being in the
backport Kconfig file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 11 +++++++++--
 gentree.py           |  2 +-
 lib/kconfig.py       |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 2820c61efae0..7a89ba051f6f 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -59,8 +59,15 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
         'GIT_COMMITTER_EMAIL': SCRIPT_GIT_EMAIL,
     })
     try:
-        failure = gentree.process(kernelobjdir, wdir, open(args.copy_list, 'r'),
-                                  git_revision=kernel_rev,
+        bpid = gentree.Bp_Identity(integrate = False,
+                                   kconfig_prefix = 'CPTCFG_',
+                                   project_prefix = '',
+                                   project_dir = wdir,
+                                   target_dir = wdir,
+                                   target_dir_name = '',
+                                   kconfig_source_var = '$BACKPORT_DIR')
+        failure = gentree.process(kernelobjdir, open(args.copy_list, 'r'),
+                                  bpid=bpid, git_revision=kernel_rev,
                                   base_name=tree, logwrite=logwrite,
                                   git_tracked_version=True)
 
diff --git a/gentree.py b/gentree.py
index 00e2d46f7ba0..8df390636e34 100755
--- a/gentree.py
+++ b/gentree.py
@@ -240,7 +240,7 @@ def add_automatic_backports(args):
     all_selects = configtree.all_selects()
     for sym, vals in bpi.items():
         if sym.startswith('BPAUTO_BUILD_'):
-            if not sym[15:] in all_selects:
+            if not sym[13:] in all_selects:
                 disable_list.append(sym)
                 continue
         symtype, module_name, c_files, h_files = vals
diff --git a/lib/kconfig.py b/lib/kconfig.py
index ea9c121c797c..a77f8a54eea7 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -229,8 +229,8 @@ class ConfigTree(object):
             for l in open(os.path.join(self.bpid.target_dir, nf), 'r'):
                 m = sel_line.match(l)
                 if m and not m.group('sym') in syms:
-                    if 'BACKPORT_' + m.group('sym') in syms:
-                        out += m.group('spc') + "select BACKPORT_" + m.group('sym') + '\n'
+                    if 'BPAUTO_' + m.group('sym') in syms:
+                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + '\n'
                     else:
                         out += m.group('spc') + "depends on " + m.group('sym') + '\n'
                 else:
-- 
2.1.1

