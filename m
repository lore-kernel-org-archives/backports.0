Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32819 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3EVLfL (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id w16so1594701pde.9
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:10 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 5/9] lib/bpgit.py: add git tree verification support
Date: Wed, 22 May 2013 04:34:34 -0700
Message-Id: <1369222478-30577-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133512_905469_847D48FF)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
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
index 51ba72e..fe68d8f 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -70,6 +70,18 @@ def describe(rev='HEAD', tree=None, get_long=False, dirty=False):
 
     return stdout.strip()
 
+def verify(tree=None):
+    tag = describe(tree=tree, dirty=True)
+    cmd = ['git', 'tag', '-v', tag]
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
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

