Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:49473 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3JUJIl (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:41 -0400
Received: by mail-we0-f182.google.com with SMTP id t61so6348148wes.27
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:39 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 1/8] lib/bpgit.py: enable extra arguments on git describe
Date: Mon, 21 Oct 2013 11:08:25 +0200
Message-Id: <1382346512-18694-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110850_015361_B94AFE30)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This lets us throw at it whatever extra stuff we want.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py   |  5 +++--
 lib/bpgit.py | 10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index c480c98..2451472 100755
--- a/gentree.py
+++ b/gentree.py
@@ -468,9 +468,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
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
1.8.4.rc3

