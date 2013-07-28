Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64769 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3G1BRJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:17:09 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so4561289pad.18
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:17:08 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 4/9] backport: disable unused automatic backports
Date: Sat, 27 Jul 2013 18:16:25 -0700
Message-Id: <1374974190-31561-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031711_195733_9D296F79)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
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
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |    8 +++++++-
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
1.7.10.4

