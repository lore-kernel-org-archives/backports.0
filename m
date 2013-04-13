Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38324 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab3DMONz (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:13:55 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so1828968pdi.22
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:13:54 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/7] backports: add support for backport_srctree
Date: Sat, 13 Apr 2013 07:13:38 -0700
Message-Id: <1365862424-6530-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161357_026385_98011E0E)
In-Reply-To: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
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
 backport/Makefile.kernel |    2 ++
 gentree.py               |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 91e7dd6..59e95ef 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -15,6 +15,8 @@ NOSTDINC_FLAGS := \
 	$(BACKPORTS_GIT_TRACKER_DEF) \
 	$(CFLAGS)
 
+export backport_srctree = $(M)
+
 obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
diff --git a/gentree.py b/gentree.py
index 476a3fc..c0838ea 100755
--- a/gentree.py
+++ b/gentree.py
@@ -478,11 +478,13 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             data = open(os.path.join(root, f), 'r').read()
             for r in regexes:
                 data = r.sub(r'CPTCFG_\1', data)
+            data = re.sub(r'\$\(srctree\)', '$(backport_srctree)', data)
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

