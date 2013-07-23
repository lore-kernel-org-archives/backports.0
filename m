Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:44702 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab3GWHPl (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Jul 2013 03:15:41 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: disable unused automatic backports
Date: Tue, 23 Jul 2013 09:15:32 +0200
Message-Id: <1374563732-18562-1-git-send-email-johannes@sipsolutions.net> (sfid-20130723_091543_472126_25738FCF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

When an automatic backport isn't included due to not
being used (see commit 6e0475b599217eceb8e01a1e572c,
"gentree: add automatic backports only if needed"),
selecting BACKPORT_USERSEL_BUILD_ALL will make the
build fail. Avoid this by disabling such symbols in
the Kconfig.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 356871d..b6c98e8 100755
--- a/gentree.py
+++ b/gentree.py
@@ -176,6 +176,7 @@ def automatic_backport_mangle_c_file(name):
 
 
 def add_automatic_backports(args):
+    disable_list = []
     export = re.compile(r'^EXPORT_SYMBOL(_GPL)?\((?P<sym>[^\)]*)\)')
     bpi = kconfig.get_backport_info(os.path.join(args.outdir, 'compat', 'Kconfig'))
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
@@ -183,6 +184,7 @@ def add_automatic_backports(args):
     for sym, vals in bpi.items():
         if sym.startswith('BACKPORT_BUILD_'):
             if not sym[15:] in all_selects:
+                disable_list.append(sym)
                 continue
         symtype, module_name, c_files, h_files = vals
 
@@ -229,6 +231,7 @@ def add_automatic_backports(args):
                 outf.write('#define %s LINUX_BACKPORT(%s)\n' % (s, s))
             outf.write('#include <%s>\n' % (os.path.dirname(f) + '/backport-' + os.path.basename(f), ))
             outf.write('#endif /* CPTCFG_%s */\n' % sym)
+    return disable_list
 
 def git_debug_init(args):
     """
@@ -346,7 +349,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     git_debug_snapshot(args, 'Add driver sources')
 
-    add_automatic_backports(args)
+    disable_list = add_automatic_backports(args)
+    if disable_list:
+        bpcfg = kconfig.ConfigTree(os.path.join(args.outdir, 'compat', 'Kconfig'))
+        bpcfg.disable_symbols(disable_list)
     git_debug_snapshot(args, 'Add automatic backports')
 
     logwrite('Apply patches ...')
-- 
1.8.0

