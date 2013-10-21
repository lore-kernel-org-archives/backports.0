Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:53025 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab3JUJIz (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:55 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so6314977wes.1
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:54 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 7/8] lib/bpkup.py: add or own kernel uploader helper lib
Date: Mon, 21 Oct 2013 11:08:31 +0200
Message-Id: <1382346512-18694-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110905_568651_3907C43A)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kup is written in perl, add some basic python interfaces
for it to allow us to upload to kernel.org backport
releases.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpkup.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
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
1.8.4.rc3

