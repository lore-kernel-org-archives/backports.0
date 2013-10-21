Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43227 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3JUJIq (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:46 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so6140032wes.5
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 4/8] lib/bpgit.py: add git tree verification support
Date: Mon, 21 Oct 2013 11:08:28 +0200
Message-Id: <1382346512-18694-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110851_944910_D4DB5CC3)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This verifies that the tree provided has its last commit
both tagged and also digitally signed. In short it does:

  git tag -v $(git describe --dirty)

This will be used later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index f4af314..02f6d8a 100644
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
1.8.4.rc3

