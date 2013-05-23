Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:64464 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQc (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:32 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so2380194pbb.41
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 5/8] lib/bpgit.py: add support for git paranoia
Date: Wed, 22 May 2013 20:15:53 -0700
Message-Id: <1369278956-17550-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051633_273591_85C99E10)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This cleans sanitizes a source tree and ensures
no content is present from what was intended.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index da5453c..44d22ad 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -119,6 +119,13 @@ def verify(git_tree):
 
     return dict(r=process.returncode, output=stdout)
 
+def paranoia(tree):
+    clean(tree)
+    poo = status(tree)
+    if (poo):
+        return dict(r=-1, output=poo)
+    return verify(tree)
+
 def init(tree=None):
     process = subprocess.Popen(['git', 'init'],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-- 
1.7.10.4

