Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:49548 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab3EVLfX (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:23 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so1604753pbb.34
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:23 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 8/9] lib/bpkup.py: add or own kernel uploader helper lib
Date: Wed, 22 May 2013 04:34:37 -0700
Message-Id: <1369222478-30577-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133524_991548_92C698F7)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

kup is written in perl, add some basicpython interfaces
for it to upload to kernel.org.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpkup.py |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 lib/bpkup.py

diff --git a/lib/bpkup.py b/lib/bpkup.py
new file mode 100644
index 0000000..20e9ef5
--- /dev/null
+++ b/lib/bpkup.py
@@ -0,0 +1,38 @@
+import subprocess, os
+
+def _check(process):
+    if process.returncode != 0:
+        raise ExecutionError(process.returncode)
+
+def mkdir(path=None):
+    cmd = ['kup', 'mkdir', path]
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout
+
+def ls(path=None):
+    cmd = ['kup', 'ls', path]
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout
+
+def put(tar_bz2=None, signed_tar=None, path=None):
+    cmd = ['kup', 'put', tar_bz2, signed_tar, path]
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout
-- 
1.7.10.4

