Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57758 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab3DLKCO (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 06:02:14 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so1322759pbc.8
        for <backports@vger.kernel.org>; Fri, 12 Apr 2013 03:02:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: add support for backport_srctree
Date: Fri, 12 Apr 2013 03:02:07 -0700
Message-Id: <1365760927-7379-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130412_120219_429163_C2C2C83B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The Linux kernel uses srctree to help prefix header files
and scripts. When backporting we want to be able to override
driver's Makefiles' usage of srctree with our own. Since we
can't easily and sanely override the srctree itself without
causing a lot of issues just use the python generator to
do the change for us on the target Makefiles. This addresses
the srctree usage case and where ccflags was used without
prefixing any parent directory when used with drivers, the
kernel tends to fix that with addtree command.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---

Running ckmake now too so you can either apply or wait.

 backport/Makefile.kernel |    2 ++
 gentree.py               |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 91e7dd6..76202f8 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -15,6 +15,8 @@ NOSTDINC_FLAGS := \
 	$(BACKPORTS_GIT_TRACKER_DEF) \
 	$(CFLAGS)
 
+backport_srctree = $(M)
+
 obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
diff --git a/gentree.py b/gentree.py
index 476a3fc..cd44db4 100755
--- a/gentree.py
+++ b/gentree.py
@@ -478,11 +478,13 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             data = open(os.path.join(root, f), 'r').read()
             for r in regexes:
                 data = r.sub(r'CPTCFG_\1', data)
+            data = re.sub(r'srctree', 'backport_srctree', data)
+            data = re.sub(r'-Idrivers', '-I$(backport_srctree)/drivers', data)
             fo = open(os.path.join(root, f), 'w')
             fo.write(data)
             fo.close()
 
-    git_debug_snapshot(args, "rename config symbol usage")
+    git_debug_snapshot(args, "rename config symbol / srctree usage")
 
     # disable unbuildable Kconfig symbols and stuff Makefiles that doesn't exist
     maketree = make.MakeTree(os.path.join(args.outdir, 'Makefile.kernel'))
-- 
1.7.10.4

