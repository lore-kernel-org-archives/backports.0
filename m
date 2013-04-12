Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:34615 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3DLJgc (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 05:36:32 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so1072261dad.1
        for <backports@vger.kernel.org>; Fri, 12 Apr 2013 02:36:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] gentree.py: add support to explicitly disable a config
Date: Fri, 12 Apr 2013 02:36:25 -0700
Message-Id: <1365759385-5793-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130412_113639_448865_B5DA3C4D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

At times we may want to disable a config option completely.
Add support for this. All you have to is list the config
on the depdependencies file with DISABLE instead of a kernel
version.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---

Lets play a game. I'm testing this right now with ckmake so you can either wait
for that result or apply it if you know for sure this should work (tm).

 gentree.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 476a3fc..a80db69 100755
--- a/gentree.py
+++ b/gentree.py
@@ -500,7 +500,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     for sym in tuple(deplist.keys()):
         new = []
         for dep in deplist[sym]:
-            new.append('!BACKPORT_KERNEL_%s' % dep.replace('.', '_'))
+            if (dep == "DISABLE"):
+		    new.append('BACKPORT_KERNEL_%s' % dep.replace('.', '_'))
+            else:
+                    new.append('!BACKPORT_KERNEL_%s' % dep.replace('.', '_'))
         deplist[sym] = new
     configtree.add_dependencies(deplist)
     git_debug_snapshot(args, "add kernel version dependencies")
-- 
1.7.10.4

