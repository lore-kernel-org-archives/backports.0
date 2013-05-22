Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51943 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3EVLe6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:34:58 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb11so317667pad.9
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:34:57 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/9] lib/bpgit.py: add git describe --dirty support
Date: Wed, 22 May 2013 04:34:31 -0700
Message-Id: <1369222478-30577-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133459_394592_20E33480)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

git describe --dirty pegs a "-dirty" at the end of
your tag if you haven't properly commited things.
When the the --dirty flag is used assume the current
state of the tree.

We will use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 142b9b5..40523f2 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,13 +27,15 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
-def describe(rev='HEAD', tree=None, get_long=False):
+def describe(rev='HEAD', tree=None, get_long=False, dirty=False):
     cmd = ['git', 'describe', '--always']
 
     if (get_long):
         cmd.append('--long')
-
-    cmd.append(rev)
+    if (dirty):
+        cmd.append('--dirty')
+    else:
+        cmd.append(rev)
 
     process = subprocess.Popen(cmd,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-- 
1.7.10.4

