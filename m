Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39088 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmW (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:22 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so4539018pdb.0
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 15/27] backports: add git diff support to lib/bpgit.py
Date: Sat,  5 Apr 2014 05:40:49 -0700
Message-Id: <1396701662-15165-16-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_881567_814B8369)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This will be used later for proving SmPL patches against
legacy patch series.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index f56e377..f4b53c4 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -328,3 +328,15 @@ def reset(opts=[], tree=None):
                                close_fds=True, universal_newlines=True, cwd=tree)
     process.wait()
     _check(process)
+
+def diff(tree=None, extra_args=None):
+    cmd = ['git', 'diff', '--color=always'] + extra_args
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout
-- 
1.8.5.3

