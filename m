Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34628 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab3EWDQg (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:36 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so2386231pbc.35
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:36 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 6/8] lib/bpgpg.py: add simple gpg helper for gpg signing
Date: Wed, 22 May 2013 20:15:54 -0700
Message-Id: <1369278956-17550-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051638_323083_0B7B3BB0)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Note that kup expects --armor --detach-sign, we'll pass that
as part of our extra_args. The python gpg lib doesn't provide
support for random arguments as this one, so just add our
own little helper and carry it over.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgpg.py |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 lib/bpgpg.py

diff --git a/lib/bpgpg.py b/lib/bpgpg.py
new file mode 100644
index 0000000..3b5ec78
--- /dev/null
+++ b/lib/bpgpg.py
@@ -0,0 +1,22 @@
+import subprocess, os
+
+class GpgError(Exception):
+    pass
+class ExecutionError(GpgError):
+    def __init__(self, errcode):
+        self.error_code = errcode
+
+def sign(input_file, extra_args=[]):
+    cmd = ['gpg', '--sign']
+
+    cmd.extend(extra_args)
+    cmd.append(input_file)
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True)
+    stdout = process.communicate()[0]
+    process.wait()
+    if process.returncode != 0:
+        raise ExecutionError(process.returncode)
+    return stdout
-- 
1.7.10.4

