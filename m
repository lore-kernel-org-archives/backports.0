Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41125 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758473Ab3G3J0f (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:35 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so6684442pab.41
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:35 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 07/14] backports: enable kconfig language on dependencies file
Date: Tue, 30 Jul 2013 02:25:52 -0700
Message-Id: <1375176359-1331-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112648_152135_F6785B8D)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Certain complex features that are backported may be be
limitted to a certain target build configuration. An example
can be if a backported feature is not yet backported with
support for lockdep. In order to avoid build failures with
these types of restrictions allow for specifying build
configuration dependencies on backported upstream kconfig
symbols other than just kernel versioning contstraints.

This adds support for specifying upstream kconfig constaints
other than kernel versioning by adding kconfig language
extensions on the dependencies file. This will update the
copied over upstream Kconfig file for the symbol specified
with the kconfig constraints specified.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/gentree.py b/gentree.py
index b6c98e8..c480c98 100755
--- a/gentree.py
+++ b/gentree.py
@@ -41,20 +41,35 @@ def read_dependencies(depfilename):
     """
     Read a (the) dependency file and return the list of
     dependencies as a dictionary, mapping a Kconfig symbol
-    to a list of kernel version dependencies. While reading
-    ignore blank/commented lines.
+    to a list of kernel version dependencies.
+    
+    If a backported feature that an upstream backported driver
+    depends on had kconfig limitations (ie, debugging feature not
+    available) a built constaint restriction can be expressed
+    by using a kconfig expression. The kconfig expressions can
+    be specified by using the "kconfig: " prefix.
+    
+    While reading ignore blank or commented lines.
     """
     ret = {}
     depfile = open(depfilename, 'r')
     for item in depfile:
+        kconfig_exp = ""
         item = item.strip()
         if not item or item[0] == '#':
             continue
-        sym, dep = item.split()
-        if not sym in ret:
-            ret[sym] = [dep, ]
+        if "kconfig:" in item:
+            sym, kconfig_exp = item.split(" ", 1)
+            if not sym in ret:
+                ret[sym] = [kconfig_exp, ]
+            else:
+                ret[sym].append(kconfig_exp)
         else:
-            ret[sym].append(dep)
+            sym, dep = item.split()
+            if not sym in ret:
+                ret[sym] = [dep, ]
+            else:
+                ret[sym].append(dep)
     return ret
 
 
@@ -513,7 +528,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     for sym in tuple(deplist.keys()):
         new = []
         for dep in deplist[sym]:
-            if dep == "DISABLE":
+            if "kconfig:" in dep:
+                    kconfig_expr = dep.replace('kconfig: ', '')
+                    new.append(kconfig_expr)
+            elif (dep == "DISABLE"):
                     new.append('BACKPORT_DISABLED_KCONFIG_OPTION')
             else:
                     new.append('!BACKPORT_KERNEL_%s' % dep.replace('.', '_'))
-- 
1.7.10.4

