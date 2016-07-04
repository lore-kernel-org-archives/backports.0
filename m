Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:32768 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753416AbcGDNZw (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 4 Jul 2016 09:25:52 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org, johannes@sipsolutions.net,
	mcgrof@do-no-panic.com
Date: Mon,  4 Jul 2016 16:25:45 +0300
Message-Id: <1467638745-10745-1-git-send-email-luca@coelho.fi> (sfid-20160704_152554_772817_06A43E06)
In-Reply-To: <1467624783.29577.1.camel@sipsolutions.net>
References: <1467624783.29577.1.camel@sipsolutions.net>
Subject: [PATCH] gentree: don't throw exceptions when applying patches fail
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

In commit 4e84c2d807d5 ("backports: move legacy and SmPL patch
application into helper"), the functionality was changed by raising
exceptions instead of return an error when applying patches fail.
This breaks git-tracker, because it expects errors to be returned in
such cases, to exit gracefully and print the error messages.

Fixes: 4e84c2d807d5 ("backports: move legacy and SmPL patch application into helper")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 gentree.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/gentree.py b/gentree.py
index 772095f..419b13b 100755
--- a/gentree.py
+++ b/gentree.py
@@ -549,7 +549,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                 logwrite("Failed to apply changes from %s" % print_name)
                 for line in output:
                     logwrite('> %s' % line)
-            raise Exception('Patch failed')
+            return 2
 
         if args.refresh:
             pfilef = open(pfile + '.tmp', 'a')
@@ -569,7 +569,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                     logwrite("Failed to diff to refresh %s" % print_name)
                     pfilef.close()
                     os.unlink(pfile + '.tmp')
-                    raise Exception('Refresh failed')
+                    return 2
             pfilef.close()
             os.rename(pfile + '.tmp', pfile)
 
@@ -602,7 +602,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
         sprocess.wait()
         if sprocess.returncode != 0:
             logwrite("Failed to process SmPL patch %s" % print_name)
-            raise Exception('SmPL patch failed')
+            return 2
         output = output.split('\n')
         if output[-1] == '':
             output = output[:-1]
@@ -903,7 +903,9 @@ def process(kerneldir, copy_list_file, git_revision=None,
         bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
-    apply_patches(args, "backport", source_dir, 'patches', bpid.target_dir, logwrite)
+    failure = apply_patches(args, "backport", source_dir, 'patches', bpid.target_dir, logwrite)
+    if failure:
+        return failure
 
     # Kernel integration requires Kconfig.versions already generated for you,
     # we cannot do this for a package as we have no idea what kernel folks
@@ -1074,8 +1076,10 @@ def process(kerneldir, copy_list_file, git_revision=None,
         f.close()
         git_debug_snapshot(args, "hooked backport to top level Kconfig")
 
-        apply_patches(args, "integration", source_dir, 'integration-patches/',
-                      bpid.project_dir, logwrite)
+        failure = apply_patches(args, "integration", source_dir, 'integration-patches/',
+                                bpid.project_dir, logwrite)
+        if failure:
+            return failure
 
     if (args.kup or args.kup_test):
         req = reqs.Req()
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
