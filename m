Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:56760 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbbHSJow (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 19 Aug 2015 05:44:52 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ZRzvO-0003S8-Ts
	for backports@vger.kernel.org; Wed, 19 Aug 2015 11:44:51 +0200
Message-ID: <1439977490.2089.5.camel@sipsolutions.net> (sfid-20150819_114454_196639_D21FAE5D)
Subject: [PATCH v2] git-tracker: read INPUT_HTTP[S]_PROXY environment
 variable
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 19 Aug 2015 11:44:50 +0200
In-Reply-To: <1439976363.2089.2.camel@sipsolutions.net> (sfid-20150819_112609_092507_D1F11647)
References: <1439976363.2089.2.camel@sipsolutions.net>
	 (sfid-20150819_112609_092507_D1F11647)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This allows using a different HTTP[S] proxy for input and output
trees, if necessary.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 22 ++++++++++++++++------
 lib/bpgit.py         | 14 ++++++++------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 9ce6ce455f95..7962cf03ce88 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -37,13 +37,22 @@ FAIL = 'failed'
 SCRIPT_GIT_NAME = 'backports git tracker'
 SCRIPT_GIT_EMAIL = ''
 
+def make_proxy_env(input):
+    env = os.environ.copy()
+    if input:
+        if 'INPUT_HTTP_PROXY' in env:
+            env['http_proxy'] = env['INPUT_HTTP_PROXY']
+        if 'INPUT_HTTPS_PROXY' in env:
+            env['https_proxy'] = env['INPUT_HTTPS_PROXY']
+    return env
 
-def update_cache_objects(gittree, objdir):
+def update_cache_objects(gittree, objdir, input):
+    env = make_proxy_env(input)
     if not os.path.isdir(objdir):
-        git.clone(gittree, objdir, options=['--bare'])
+        git.clone(gittree, objdir, options=['--bare'], env=env)
     else:
         git.set_origin(gittree, objdir)
-        git.remote_update(objdir)
+        git.remote_update(objdir, env=env)
 
 def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, backport_rev, kernel_rev,
                   prev_kernel_rev=None, defconfig=None, env={}, commit_failure=True,
@@ -175,11 +184,11 @@ if __name__ == '__main__':
                 defconfig = config.get(tree, 'defconfig')
             branches = [r.strip() for r in config.get(tree, 'branches').split(',')]
 
-            update_cache_objects(input, kernelobjdir)
+            update_cache_objects(input, kernelobjdir, input=True)
 
             wgitref = os.path.join(cachedir, 'backport-' + tree)
 
-            update_cache_objects(output, wgitref)
+            update_cache_objects(output, wgitref, input=False)
 
             for branch in branches:
                 with tempdir.tempdir() as branch_tmpdir:
@@ -189,7 +198,8 @@ if __name__ == '__main__':
                     git.remove_config('core.bare', tree=wgitdir)
                     git.set_origin(output, wgitdir)
 
-                    kernel_head = git.ls_remote(branch, tree=kernelobjdir)
+                    env = make_proxy_env(True)
+                    kernel_head = git.ls_remote(branch, tree=kernelobjdir, env=env)
 
                     backport_author_env = {
                         'GIT_AUTHOR_NAME': SCRIPT_GIT_NAME,
diff --git a/lib/bpgit.py b/lib/bpgit.py
index dc7d689550b1..35bb80702fbe 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -165,8 +165,9 @@ def get_blob(blob, outf, tree=None):
         process.wait()
         _check(process)
 
-def clone(gittree, outputdir, options=[]):
-    process = subprocess.Popen(['git', 'clone'] + options + [gittree, outputdir])
+def clone(gittree, outputdir, options=[], env=None):
+    process = subprocess.Popen(['git', 'clone'] + options + [gittree, outputdir],
+                               env=env)
     process.wait()
     _check(process)
 
@@ -180,9 +181,10 @@ def set_origin(giturl, gitdir):
     process.wait()
     _check(process)
 
-def remote_update(gitdir):
+def remote_update(gitdir, env=None):
     process = subprocess.Popen(['git', 'remote', 'update'],
-                               close_fds=True, universal_newlines=True, cwd=gitdir)
+                               close_fds=True, universal_newlines=True, cwd=gitdir,
+                               env=env)
     process.wait()
     _check(process)
 
@@ -234,9 +236,9 @@ def remove_config(cfg, tree=None):
     process.wait()
     _check(process)
 
-def ls_remote(branch, tree=None, remote='origin'):
+def ls_remote(branch, tree=None, remote='origin', env=None):
     process = subprocess.Popen(['git', 'ls-remote', remote, 'refs/heads/' + branch],
-                               stdout=subprocess.PIPE,
+                               stdout=subprocess.PIPE, env=env,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()


--
To unsubscribe from this list: send the line "unsubscribe backports" in
