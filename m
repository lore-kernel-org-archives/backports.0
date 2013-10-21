Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46664 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3JUJIv (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:51 -0400
Received: by mail-wi0-f171.google.com with SMTP id h11so3575688wiv.16
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:50 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 6/8] lib/bpgpg.py: add simple gpg helper for gpg signing
Date: Mon, 21 Oct 2013 11:08:30 +0200
Message-Id: <1382346512-18694-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110907_182774_21907D7C)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Note that kup expects --armor --detach-sign, we'll pass that
as part of our extra_args. The python gpg lib doesn't provide
support for random arguments as this one, so just add our
own little helper and carry it over.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgpg.py | 22 ++++++++++++++++++++++
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
1.8.4.rc3

