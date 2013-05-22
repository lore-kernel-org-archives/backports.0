Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52823 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab3EVLfT (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id um15so1603330pbc.39
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:19 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 7/9] lib/bpgpg.py: add simple gpg helpers for --armor --detach-sign
Date: Wed, 22 May 2013 04:34:36 -0700
Message-Id: <1369222478-30577-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133520_934539_422BDE62)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The python gpg lib doesn't provide this, so just add our
own little helper.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgpg.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 lib/bpgpg.py

diff --git a/lib/bpgpg.py b/lib/bpgpg.py
new file mode 100644
index 0000000..1afd58c
--- /dev/null
+++ b/lib/bpgpg.py
@@ -0,0 +1,12 @@
+import subprocess, os
+
+def sign(tar=None):
+    cmd = ['gpg', '--armor', '--detach-sign', tar]
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

