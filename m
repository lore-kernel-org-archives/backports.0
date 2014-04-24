Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52794 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaDXTT6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 24 Apr 2014 15:19:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WdPBc-0000Sr-CI
	for backports@vger.kernel.org; Thu, 24 Apr 2014 21:19:56 +0200
Message-ID: <1398367178.4154.3.camel@jlt4.sipsolutions.net> (sfid-20140424_212000_546309_FD8DCAB2)
Subject: [PATCH] git-tracker: restrict shortlog to existing files
From: Johannes Berg <johannes@sipsolutions.net>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 24 Apr 2014 21:19:38 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

When the git-tracker updates through a merge commit or
otherwise multiple kernel commits, it appends a shortlog
of all the changes. That's fine, but is often unhelpful
since it's so large - restrict it to the files that are
actually backported to make it more readable.

While at it, rewrite the bpgit.status() helper function
to actually do something useful.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 39 ++++++++++++++++---------
 lib/bpgit.py         | 82 ++++++++++++++++++++++------------------------------
 2 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index a480b389430c..05e915021c96 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -46,7 +46,8 @@ def update_cache_objects(gittree, objdir):
         git.remote_update(objdir)
 
 def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, backport_rev, kernel_rev,
-                  prev_kernel_rev=None, defconfig=None, env={}, commit_failure=True):
+                  prev_kernel_rev=None, defconfig=None, env={}, commit_failure=True,
+                  append_shortlog=None):
     log = []
     def logwrite(l):
         log.append(l)
@@ -73,6 +74,7 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
             for l in log:
                 print(l)
             newline=''
+            append_shortlog=None
             if prev_kernel_rev:
                 msg += '\n%s%s-last-success: %s' % (PREFIX, tree, prev_kernel_rev)
 
@@ -86,18 +88,25 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
         else:
             git.reset(opts=['-q'], tree=wdir)
 
-        msg += '''%(newline)s
+        if not failure or commit_failure:
+            if append_shortlog:
+                files = []
+                for d in git.status(tree=wdir):
+                    files.extend(d[1:])
+                msg += git.shortlog(append_shortlog[0], append_shortlog[1],
+                                    tree=kernelobjdir, files=files)
+
+            msg += '''%(newline)s
 %(PREFIX)sbackport: %(bprev)s
 %(PREFIX)s%(tree)s: %(krev)s
 ''' % {
-        'newline': newline,
-        'PREFIX': PREFIX,
-        'bprev': backport_rev,
-        'tree': treename,
-        'krev': kernel_rev,
-      }
+            'newline': newline,
+            'PREFIX': PREFIX,
+            'bprev': backport_rev,
+            'tree': treename,
+            'krev': kernel_rev,
+          }
 
-        if not failure or commit_failure:
             git.commit(msg, tree=wdir, env=env, opts=['-q', '--allow-empty'])
             git.push(opts=['-f', '-q', 'origin', branch], tree=wdir)
         os.rename(os.path.join(wdir, '.git'), wgitdir)
@@ -226,14 +235,15 @@ if __name__ == '__main__':
                     for commit in commits:
                         print('updating to commit %s' % commit)
                         env = git.commit_env_vars(commit, tree=kernelobjdir)
+                        append_shortlog = None
                         if prev_commits[commit] == prev:
                             # committing multiple commits
                             msg = git.commit_message(commit, kernelobjdir)
                             try:
                                 # add information about commits that went into this
-                                shortlog = git.shortlog(prev, '%s^2' % commit,
-                                                        tree=kernelobjdir)
-                                msg += "\nCommits in this merge:\n\n" + shortlog
+                                git.rev_parse('%s^2' % commit, tree=kernelobjdir)
+                                msg += "\nCommits in this merge:\n\n"
+                                append_shortlog = (prev, '%s^2' % commit)
                             except git.ExecutionError as e:
                                 # will fail if it wasn't a merge commit
                                 pass
@@ -241,11 +251,12 @@ if __name__ == '__main__':
                             # multiple commits
                             env = backport_author_env
                             msg = "update multiple kernel commits\n\nCommits taken:\n\n"
-                            msg += git.shortlog(prev, commit, tree=kernelobjdir)
+                            append_shortlog = (prev, commit)
                         failure = handle_commit(args, msg, branch, tree, kernelobjdir, branch_tmpdir,
                                                 wgitdir, backport_rev, commit, env=env,
                                                 prev_kernel_rev=prev, defconfig=defconfig,
-                                                commit_failure=not catch_up_from_failure)
+                                                commit_failure=not catch_up_from_failure,
+                                                append_shortlog=append_shortlog)
                         if not failure:
                             prev = commit
                             catch_up_from_failure = False
diff --git a/lib/bpgit.py b/lib/bpgit.py
index 01d83acaa82b..8f1ad8223863 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -46,57 +46,41 @@ def fetch(tree=None):
 
 def status(tree=None):
     '''
-    For interpretation of the porcelain output refer to
-    the git status(1) man page. In summary the first column is the
-    index state, the second represents the working tree state and
-    the third column are files in cases of renames. This gives back
-    None in case no changes are present, otherwise it returns a list
-    of dict entries with key values: index, work_tree, and files. The
-    files are a list of all files found on that entry, in case of a rename
-    this would consist of a list of 2 files.
-
-    As an example if you had this on your git status:
-
-    R  udev/foo.sh -> poo/foo.sh
-    D  scripts/bar.sh
-    ?? .poo.py.swp
-
-    This would be transposed into the following dict:
-
-        results = status(tree=your_git_tree_path)
-        if not results:
-            return 0
-        for entry in results:
-            print entry
-
-    {'files': [' udev/foo.sh', 'poo/foo.sh'], 'index': 'R', 'work_tree': ' '}
-    {'files': [' scripts/bar.sh'], 'index': 'D', 'work_tree': ' '}
-    {'files': [' .poo.py.swp'], 'index': '?', 'work_tree': '?'}
+    Return a list (that may be empty) of current changes. Each entry is a
+    tuple, just like returned from git status, with the difference that
+    the filename(s) are no longer space-separated but rather the tuple is
+    of the form
+    ('XY', 'filename')
+    or
+    ('XY', 'filename_to', 'filename_from')   [if X is 'R' for rename]
     '''
-    def split_status(entry):
-        if len(entry) == 0:
-            return None
-        if len(entry) == 1:
-            return dict(index=entry[0], work_tree=None, files=None)
-        if len(entry) == 2:
-            return dict(index=entry[0], work_tree=entry[1], files=None)
-        else:
-            return dict(index=entry[0], work_tree=entry[1],
-                        files=entry[2:].split(' -> '))
-
-    cmd = ['git', 'status', '--porcelain']
+    cmd = ['git', 'status', '--porcelain', '-z']
 
-    process = subprocess.Popen(cmd,
-            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, close_fds=True,
-            universal_newlines=True, cwd=tree)
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
+                               stderr=subprocess.STDOUT, close_fds=True,
+                               universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
     _check(process)
 
-    list_status = stdout.split('\n')
-    if (len(list_status) == 1 and list_status[0] == ''):
-        return None
-    return [split_status(entry) for entry in list_status]
+    l = stdout.split('\0')
+    result = []
+    cur = []
+    for i in l:
+        if not i:
+            continue
+        if not cur:
+            cur.append(i[:2])
+            assert i[2] == ' '
+            cur.append(i[3:])
+            if i[0] == 'R':
+                continue
+        else:
+            cur.append(i)
+        result.append(tuple(cur))
+        cur = []
+
+    return result
 
 def describe(rev='HEAD', tree=None, extra_args=[]):
     cmd = ['git', 'describe', '--always']
@@ -209,8 +193,12 @@ def remote_update(gitdir):
     process.wait()
     _check(process)
 
-def shortlog(from_commit, to_commit, tree=None):
-    process = subprocess.Popen(['git', 'shortlog', from_commit + '..' + to_commit],
+def shortlog(from_commit, to_commit, tree=None, files=None):
+    if files:
+        fargs = ['--'] + files
+    else:
+        fargs = []
+    process = subprocess.Popen(['git', 'shortlog', from_commit + '..' + to_commit] + fargs,
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                close_fds=True, universal_newlines=True,
                                cwd=tree)
-- 
1.9.0


