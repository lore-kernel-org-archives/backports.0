Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36211 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3JUJIt (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:49 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so4338385wgh.3
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:48 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 5/8] lib/bpgit.py: add support for git paranoia
Date: Mon, 21 Oct 2013 11:08:29 +0200
Message-Id: <1382346512-18694-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110852_569484_EA691DF4)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This cleans sanitizes a source tree and ensures
no content is present from what was intended.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 02f6d8a..6540336 100644
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
1.8.4.rc3

