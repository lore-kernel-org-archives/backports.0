Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:51062 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmS (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:18 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so4646488pbc.21
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 14/27] backports: use --ignore-removal for git add
Date: Sat,  5 Apr 2014 05:40:48 -0700
Message-Id: <1396701662-15165-15-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_522302_5F58E05F)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

As of git 2.0 --ignore-removal is no longer default so just
make it default tool, without which git will warn us about
this change.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 15089d7..f56e377 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -142,7 +142,7 @@ def init(tree=None):
     _check(process)
 
 def add(path, tree=None):
-    process = subprocess.Popen(['git', 'add', path],
+    process = subprocess.Popen(['git', 'add', '--ignore-removal', path],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
@@ -266,7 +266,7 @@ def ls_remote(branch, tree=None, remote='origin'):
     return sha
 
 def add(fn, tree=None):
-    process = subprocess.Popen(['git', 'add', fn], cwd=tree,
+    process = subprocess.Popen(['git', 'add', '--ignore-removal', fn], cwd=tree,
                                close_fds=True, universal_newlines=True)
     process.wait()
     _check(process)
-- 
1.8.5.3

