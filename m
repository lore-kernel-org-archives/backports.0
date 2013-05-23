Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61561 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab3EWDQk (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so2498453pac.14
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:40 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 7/8] lib/bpkup.py: add or own kernel uploader helper lib
Date: Wed, 22 May 2013 20:15:55 -0700
Message-Id: <1369278956-17550-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051641_794455_5F166853)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

kup is written in perl, add some basic python interfaces
for it to allow us to upload to kernel.org backport
releases.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpkup.py |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 lib/bpkup.py

diff --git a/lib/bpkup.py b/lib/bpkup.py
new file mode 100644
index 0000000..03504bb
--- /dev/null
+++ b/lib/bpkup.py
@@ -0,0 +1,44 @@
+import subprocess, os
+
+class KupError(Exception):
+    pass
+class ExecutionError(KupError):
+    def __init__(self, errcode):
+        self.error_code = errcode
+
+def _check(process):
+    if process.returncode != 0:
+        raise ExecutionError(process.returncode)
+
+def mkdir(path):
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
+def put(tar_bz2, signed_tar, path):
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

