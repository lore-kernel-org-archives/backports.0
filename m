Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42489 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab3JUJIp (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:45 -0400
Received: by mail-wi0-f171.google.com with SMTP id h11so3573941wiv.10
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:44 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 3/8] lib/bpgit.py: add git clean support
Date: Mon, 21 Oct 2013 11:08:27 +0200
Message-Id: <1382346512-18694-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110851_288328_AB4D8C6C)
In-Reply-To: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
References: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We'll use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index d2fb986..f4af314 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,6 +27,16 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
+def clean(tree=None):
+    cmd = ['git', 'clean', '-f', '-x', '-d', '-q']
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
 def status(tree=None):
     '''
     For interpretation of the porcelain output refer to
-- 
1.8.4.rc3

