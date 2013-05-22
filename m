Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57148 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab3EVLfG (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:06 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so1596837pdj.24
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:06 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/9] lib/bpgit.py: add git clean support
Date: Wed, 22 May 2013 04:34:33 -0700
Message-Id: <1369222478-30577-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133508_690811_8F433DA8)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We'll use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 335cc9c..51ba72e 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
+def clean(tree=None):
+    cmd = ['git', 'clean', '-f', '-x', '-d']
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
 def status(tree=None):
     cmd = ['git', 'status', '--porcelain']
 
-- 
1.7.10.4

