Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:36476 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQO (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:14 -0400
Received: by mail-da0-f53.google.com with SMTP id t11so1391477daj.40
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:14 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 1/8] lib/bpgit.py: enable extra arguments on git describe
Date: Wed, 22 May 2013 20:15:49 -0700
Message-Id: <1369278956-17550-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051615_872629_D47B720B)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This lets us throw at it whatever extra stuff we want.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py   |    5 +++--
 lib/bpgit.py |   10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index 86b3f3c..2810415 100755
--- a/gentree.py
+++ b/gentree.py
@@ -447,9 +447,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         backports_version = "(see git)"
         kernel_version = "(see git)"
     else:
-        backports_version = git.describe(tree=source_dir)
+        backports_version = git.describe(tree=source_dir, extra_args=['--long'])
         kernel_version = git.describe(rev=args.git_revision or 'HEAD',
-                                      tree=args.kerneldir)
+                                      tree=args.kerneldir,
+                                      extra_args=['--long'])
     f = open(os.path.join(args.outdir, 'versions'), 'w')
     f.write('BACKPORTS_VERSION="%s"\n' % backports_version)
     f.write('BACKPORTED_KERNEL_VERSION="%s"\n' % kernel_version)
diff --git a/lib/bpgit.py b/lib/bpgit.py
index 31b7de3..9a3f430 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,8 +27,14 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
-def describe(rev='HEAD', tree=None):
-    process = subprocess.Popen(['git', 'describe', '--always', '--long', rev],
+def describe(rev='HEAD', tree=None, extra_args=[]):
+    cmd = ['git', 'describe', '--always']
+
+    cmd.extend(extra_args)
+    if rev is not None:
+        cmd.append(rev)
+
+    process = subprocess.Popen(cmd,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
-- 
1.7.10.4

