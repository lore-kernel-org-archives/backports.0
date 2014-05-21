Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39890 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaEUHo4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 21 May 2014 03:44:56 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] git-tracker: remove shortlog for empty changes
Date: Wed, 21 May 2014 09:44:43 +0200
Message-Id: <1400658283-28439-1-git-send-email-johannes@sipsolutions.net> (sfid-20140521_094458_510085_8BFAB9C8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

When the input tree had changes but the output doesn't get
any changes at all, then the shortlog was being generated
over all commits since no files were specified.

Catch this special case and instead of generating a shortlog
just add a note that no commits changed generated code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 05e915021c96..2820c61efae0 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -93,8 +93,12 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
                 files = []
                 for d in git.status(tree=wdir):
                     files.extend(d[1:])
-                msg += git.shortlog(append_shortlog[0], append_shortlog[1],
-                                    tree=kernelobjdir, files=files)
+                if files:
+                    msg += '\n' + append_shortlog[2] + '\n\n'
+                    msg += git.shortlog(append_shortlog[0], append_shortlog[1],
+                                        tree=kernelobjdir, files=files)
+                else:
+                    msg += "\nNo commits changed the generated code.\n\n"
 
             msg += '''%(newline)s
 %(PREFIX)sbackport: %(bprev)s
@@ -242,16 +246,16 @@ if __name__ == '__main__':
                             try:
                                 # add information about commits that went into this
                                 git.rev_parse('%s^2' % commit, tree=kernelobjdir)
-                                msg += "\nCommits in this merge:\n\n"
-                                append_shortlog = (prev, '%s^2' % commit)
+                                append_shortlog = (prev, '%s^2' % commit,
+                                                   "Commits in this merge:")
                             except git.ExecutionError as e:
                                 # will fail if it wasn't a merge commit
                                 pass
                         else:
                             # multiple commits
                             env = backport_author_env
-                            msg = "update multiple kernel commits\n\nCommits taken:\n\n"
-                            append_shortlog = (prev, commit)
+                            msg = "update multiple kernel commits\n"
+                            append_shortlog = (prev, commit, "Commits taken:")
                         failure = handle_commit(args, msg, branch, tree, kernelobjdir, branch_tmpdir,
                                                 wgitdir, backport_rev, commit, env=env,
                                                 prev_kernel_rev=prev, defconfig=defconfig,
-- 
2.0.0.rc0

