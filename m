Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:43874 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbaD2Jvk (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 29 Apr 2014 05:51:40 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] gentree: strip useless defconfig files
Date: Tue, 29 Apr 2014 11:31:28 +0200
Message-Id: <1398763888-20688-2-git-send-email-johannes@sipsolutions.net> (sfid-20140429_115142_198852_F1188375)
In-Reply-To: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net>
References: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

If a defconfig file has symbols that can't be satisfied
with the given copy-list file, then there's no point in
shipping it, so just copy selectively the ones needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 44acb9a1250e..10588842fdfa 100755
--- a/gentree.py
+++ b/gentree.py
@@ -581,7 +581,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     # do the copy
     backport_files = [(x, x) for x in [
         'Kconfig', 'Makefile', 'Makefile.build', 'Makefile.kernel', '.gitignore',
-        'Makefile.real', 'compat/', 'backport-include/', 'kconf/', 'defconfigs/',
+        'Makefile.real', 'compat/', 'backport-include/', 'kconf/',
         'scripts/', '.blacklist.map',
     ]]
     if not args.git_revision:
@@ -785,6 +785,29 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     git_debug_snapshot(args, "add versions/symbols files")
 
+    # add defconfigs that we want
+    defconfigs_dir = os.path.join(source_dir, 'backport', 'defconfigs')
+    os.mkdir(os.path.join(args.outdir, 'defconfigs'))
+    for dfbase in os.listdir(defconfigs_dir):
+        copy_defconfig = True
+        dfsrc = os.path.join(defconfigs_dir, dfbase)
+        for line in open(dfsrc, 'r'):
+            if not '=' in line:
+                continue
+            line_ok = False
+            for sym in symbols:
+                if sym + '=' in line:
+                    line_ok = True
+                    break
+            if not line_ok:
+                print dfbase, line
+                copy_defconfig = False
+                break
+        if copy_defconfig:
+            shutil.copy(dfsrc, os.path.join(args.outdir, 'defconfigs', dfbase))
+
+    git_debug_snapshot(args, "add (useful) defconfig files")
+
     logwrite('Rewrite Makefiles and Kconfig files ...')
 
     # rewrite Makefile and source symbols
-- 
1.9.0

