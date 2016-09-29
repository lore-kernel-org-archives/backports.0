Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33896 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbcI2JF0 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 29 Sep 2016 05:05:26 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] git-tracker: add an option to add a Change-Id to commits
Date: Thu, 29 Sep 2016 11:05:20 +0200
Message-Id: <1475139920-671-1-git-send-email-johannes@sipsolutions.net> (sfid-20160929_110530_010866_866EB269)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

When the resulting output trees are used with gerrit, it can be
useful for patches to have a Change-Id. Add an option to let the
script generate them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 766267dfb4b8..c86906b9eaa7 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -12,7 +12,7 @@ problem to occur (although this is less useful since lots of commits
 need to be squashed in the output tree.)
 """
 
-import sys, re, os, argparse, shutil
+import sys, re, os, argparse, shutil, hashlib
 try:
     import configparser as ConfigParser
 except:
@@ -56,7 +56,7 @@ def update_cache_objects(gittree, objdir, input):
 
 def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, backport_rev, kernel_rev,
                   prev_kernel_rev=None, defconfig=None, env={}, commit_failure=True,
-                  append_shortlog=None):
+                  append_shortlog=None, add_changeid=False):
     log = []
     def logwrite(l):
         log.append(l)
@@ -127,6 +127,15 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
             'krev': kernel_rev,
           }
 
+            if add_changeid:
+                have_changeid = False
+                for line in msg.split('\n'):
+                    if line.lower().startswith('change-id: I'):
+                        have_changeid = True
+                        break
+                if not have_changeid:
+                    msg += 'Change-Id: I%s\n' % hashlib.sha1(msg).hexdigest()
+
             git.commit(msg, tree=wdir, env=env, opts=['-q', '--allow-empty'])
             git.push(opts=['-f', '-q', 'origin', branch], tree=wdir)
         os.rename(os.path.join(wdir, '.git'), wgitdir)
@@ -162,6 +171,10 @@ if __name__ == '__main__':
         if not config.has_option(tree, 'output'):
             print("No output defined in section %s" % tree)
             sys.exit(3)
+        if config.has_option(tree, 'changeid'):
+            if config.get(tree, 'changeid') != 'true':
+                print("changeid option can only take the value 'true'")
+                sys.exit(3)
 
     with tempdir.tempdir() as kernel_tmpdir:
         # get cachedir, or use temporary directory
@@ -182,6 +195,7 @@ if __name__ == '__main__':
             defconfig = None
             if config.has_option(tree, 'defconfig'):
                 defconfig = config.get(tree, 'defconfig')
+            add_changeid = config.has_option(tree, 'changeid')
             branches = [r.strip() for r in config.get(tree, 'branches').split(',')]
 
             update_cache_objects(input, kernelobjdir, input=True)
@@ -277,7 +291,8 @@ if __name__ == '__main__':
                                                 wgitdir, backport_rev, commit, env=env,
                                                 prev_kernel_rev=prev, defconfig=defconfig,
                                                 commit_failure=not catch_up_from_failure,
-                                                append_shortlog=append_shortlog)
+                                                append_shortlog=append_shortlog,
+                                                add_changeid=add_changeid)
                         if not failure:
                             prev = commit
                             catch_up_from_failure = False
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
