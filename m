Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:50496 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab3DMOOI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:14:08 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so1499761dad.18
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:14:07 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/7] gentree.py: add support to explicitly disable a config
Date: Sat, 13 Apr 2013 07:13:41 -0700
Message-Id: <1365862424-6530-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161409_937133_E0DD782D)
In-Reply-To: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

At times we may want to disable a config option completely.
Add support for this. All you have to is list the config
on the depdependencies file with DISABLE instead of a kernel
version.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index c0838ea..6dccaa9 100755
--- a/gentree.py
+++ b/gentree.py
@@ -502,7 +502,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
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

