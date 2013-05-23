Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34944 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQX (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:23 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so2471514pab.35
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 3/8] lib/bpgit.py: add git clean support
Date: Wed, 22 May 2013 20:15:51 -0700
Message-Id: <1369278956-17550-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051624_800329_F6B04AD4)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We'll use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 3f7eb1b..8ce8568 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,6 +27,16 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
+def clean(tree=None):
+    cmd = ['git', 'clean', '-f', '-x', '-d', '-q']
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
 def status(tree=None):
     '''
     For interpretation of the porcelain output refer to
-- 
1.7.10.4

