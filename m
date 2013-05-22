Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36697 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3EVLfD (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:03 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so1701387pab.34
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/9] lib/bpgit.py: add git status support
Date: Wed, 22 May 2013 04:34:32 -0700
Message-Id: <1369222478-30577-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133505_156212_DDCE0432)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We use --porcelain given that this spits out the results
in an easy-to-parse format for scripts and will remain stable
across git versions and regardless of user configuration.

We will use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 40523f2..335cc9c 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
+def status(tree=None):
+    cmd = ['git', 'status', '--porcelain']
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout.strip()
+
 def describe(rev='HEAD', tree=None, get_long=False, dirty=False):
     cmd = ['git', 'describe', '--always']
 
-- 
1.7.10.4

