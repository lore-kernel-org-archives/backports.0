Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:43313 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab3EVLfP (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:15 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so1088708dak.35
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:14 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
Date: Wed, 22 May 2013 04:34:35 -0700
Message-Id: <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133517_032877_8CD5B8EE)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
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
index fe68d8f..1c3ccbf 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -82,6 +82,13 @@ def verify(tree=None):
 
     return dict(r=process.returncode, output=stdout)
 
+def paranoia(tree=None):
+    clean(tree)
+    extra = status(tree)
+    if (len(extra) != 0):
+        return dict(r=-1, output=extra)
+    return verify(tree)
+
 def init(tree=None):
     process = subprocess.Popen(['git', 'init'],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-- 
1.7.10.4

