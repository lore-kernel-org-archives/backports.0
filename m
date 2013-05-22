Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:46543 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3EVLey (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:34:54 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so1490136pdj.1
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:34:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/9] lib/bpgit.py: make git describe --long optional
Date: Wed, 22 May 2013 04:34:30 -0700
Message-Id: <1369222478-30577-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133455_410970_C278E6E9)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

When calling git describe through our Python library
the long option is always used. Make this optional
but keep the existing behaviour.

This will be used later without the long option and
using an argument saves us from having to parse it.
We need to use get_long over long given that long
is a Python type.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py   |    5 +++--
 lib/bpgit.py |   11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index 86b3f3c..f25db52 100755
--- a/gentree.py
+++ b/gentree.py
@@ -447,9 +447,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         backports_version = "(see git)"
         kernel_version = "(see git)"
     else:
-        backports_version = git.describe(tree=source_dir)
+        backports_version = git.describe(tree=source_dir, get_long=True)
         kernel_version = git.describe(rev=args.git_revision or 'HEAD',
-                                      tree=args.kerneldir)
+                                      tree=args.kerneldir,
+                                      get_long=True)
     f = open(os.path.join(args.outdir, 'versions'), 'w')
     f.write('BACKPORTS_VERSION="%s"\n' % backports_version)
     f.write('BACKPORTED_KERNEL_VERSION="%s"\n' % kernel_version)
diff --git a/lib/bpgit.py b/lib/bpgit.py
index 31b7de3..142b9b5 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,8 +27,15 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
-def describe(rev='HEAD', tree=None):
-    process = subprocess.Popen(['git', 'describe', '--always', '--long', rev],
+def describe(rev='HEAD', tree=None, get_long=False):
+    cmd = ['git', 'describe', '--always']
+
+    if (get_long):
+        cmd.append('--long')
+
+    cmd.append(rev)
+
+    process = subprocess.Popen(cmd,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
-- 
1.7.10.4

