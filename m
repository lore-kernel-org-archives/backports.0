Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33188 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQ1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:27 -0400
Received: by mail-pd0-f178.google.com with SMTP id w16so2364584pde.23
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 4/8] lib/bpgit.py: add git tree verification support
Date: Wed, 22 May 2013 20:15:52 -0700
Message-Id: <1369278956-17550-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051629_011701_D4F9F8F3)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This verifies that the tree provided has its last commit
both tagged and also digitally signed. In short it does:

  git tag -v $(git describe --dirty)

This will be used later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 8ce8568..da5453c 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -107,6 +107,18 @@ def describe(rev='HEAD', tree=None, extra_args=[]):
 
     return stdout.strip()
 
+def verify(git_tree):
+    tag = describe(rev=None, tree=git_tree, extra_args=['--dirty'])
+    cmd = ['git', 'tag', '-v', tag]
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=git_tree)
+    stdout = process.communicate()[0]
+    process.wait()
+
+    return dict(r=process.returncode, output=stdout)
+
 def init(tree=None):
     process = subprocess.Popen(['git', 'init'],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-- 
1.7.10.4

