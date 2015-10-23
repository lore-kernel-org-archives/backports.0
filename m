Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36782 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbbJWHXh (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Oct 2015 03:23:37 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] bpgit: ignore stderr
Date: Fri, 23 Oct 2015 09:23:32 +0200
Message-Id: <1445585012-11300-1-git-send-email-johannes@sipsolutions.net> (sfid-20151023_092338_858072_88B9267E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

In order to make it possible to use GIT_TRACE, ignore stderr
in the bpgit scripting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 lib/bpgit.py | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index fa4f4cd94315..35bb80702fbe 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -15,8 +15,7 @@ def _check(process):
 _sha_re = re.compile('^[0-9a-fA-F]*$')
 
 def rev_parse(rev='HEAD', tree=None):
-    process = subprocess.Popen(['git', 'rev-parse', rev],
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(['git', 'rev-parse', rev], stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -30,8 +29,7 @@ def rev_parse(rev='HEAD', tree=None):
 def clean(tree=None):
     cmd = ['git', 'clean', '-f', '-x', '-d', '-q']
 
-    process = subprocess.Popen(cmd,
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -56,8 +54,7 @@ def status(tree=None):
     '''
     cmd = ['git', 'status', '--porcelain', '-z']
 
-    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
-                               stderr=subprocess.STDOUT, close_fds=True,
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, close_fds=True,
                                universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -89,8 +86,7 @@ def describe(rev='HEAD', tree=None, extra_args=[]):
     if rev is not None:
         cmd.append(rev)
 
-    process = subprocess.Popen(cmd,
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -102,8 +98,7 @@ def verify(git_tree):
     tag = describe(rev=None, tree=git_tree, extra_args=['--dirty'])
     cmd = ['git', 'tag', '-v', tag]
 
-    process = subprocess.Popen(cmd,
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=git_tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -118,16 +113,14 @@ def paranoia(tree):
     return verify(tree)
 
 def init(tree=None):
-    process = subprocess.Popen(['git', 'init'],
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(['git', 'init'], stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
     _check(process)
 
 def add(path, tree=None):
-    process = subprocess.Popen(['git', 'add', path],
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(['git', 'add', path], stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -136,7 +129,7 @@ def add(path, tree=None):
 def commit_all(message, tree=None):
     add('.', tree=tree)
     process = subprocess.Popen(['git', 'commit', '--allow-empty', '-a', '-m', message],
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
@@ -144,7 +137,7 @@ def commit_all(message, tree=None):
 
 def ls_tree(rev, files, tree=None):
     process = subprocess.Popen(['git', 'ls-tree', '-z', '-r', rev, '--', ] + list(files),
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     files = stdout.split('\0')
@@ -201,7 +194,7 @@ def shortlog(from_commit, to_commit, tree=None, files=None):
     else:
         fargs = []
     process = subprocess.Popen(['git', 'shortlog', from_commit + '..' + to_commit] + fargs,
-                               stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                               stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True,
                                cwd=tree)
     stdout = process.communicate()[0]
@@ -213,7 +206,7 @@ def commit_env_vars(commitid, tree=None):
     process = subprocess.Popen(['git', 'show', '--name-only',
                                 '--format=format:GIT_AUTHOR_NAME=%an%nGIT_AUTHOR_EMAIL=%ae%nGIT_AUTHOR_DATE=%aD%x00',
                                 commitid],
-                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                stdout=subprocess.PIPE,
                                 close_fds=True, universal_newlines=True,
                                 cwd=tree)
     stdout = process.communicate()[0]
@@ -229,7 +222,7 @@ def commit_env_vars(commitid, tree=None):
 def commit_message(commitid, tree=None):
     process = subprocess.Popen(['git', 'show', '--name-only',
                                 '--format=format:%s%n%n%b%x00', commitid],
-                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                stdout=subprocess.PIPE,
                                 close_fds=True, universal_newlines=True,
                                 cwd=tree)
     stdout = process.communicate()[0]
@@ -294,7 +287,7 @@ def commit_env_vars(commitid, tree=None):
     process = subprocess.Popen(['git', 'show', '--name-only',
                                 '--format=format:GIT_AUTHOR_NAME=%an%nGIT_AUTHOR_EMAIL=%ae%nGIT_AUTHOR_DATE=%aD%x00',
                                 commitid],
-                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                stdout=subprocess.PIPE,
                                 close_fds=True, universal_newlines=True,
                                 cwd=tree)
     stdout = process.communicate()[0]
@@ -322,8 +315,7 @@ def reset(opts=[], tree=None):
 def diff(tree=None, extra_args=None):
     cmd = ['git', 'diff', '--color=always'] + extra_args
 
-    process = subprocess.Popen(cmd,
-                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
