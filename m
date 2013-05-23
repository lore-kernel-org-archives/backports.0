Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:34777 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758960Ab3EWOMc (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 May 2013 10:12:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backport: move kconfig code to "kconf" directory
Date: Thu, 23 May 2013 16:12:27 +0200
Message-Id: <1369318347-18097-1-git-send-email-johannes@sipsolutions.net> (sfid-20130523_161234_679657_CBAAA5F2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Having the kconfig code in a directory called "kconfig"
and having a file called "Kconfig" causes issues if the
code is ever stored on a case-insensitive filesystem.
Avoid these by just calling the kconfig directory kconf
instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.real                                 | 16 ++++++++--------
 backport/{kconfig => kconf}/Makefile                   |  0
 backport/{kconfig => kconf}/conf.c                     |  0
 backport/{kconfig => kconf}/confdata.c                 |  0
 backport/{kconfig => kconf}/expr.c                     |  0
 backport/{kconfig => kconf}/expr.h                     |  0
 backport/{kconfig => kconf}/list.h                     |  0
 backport/{kconfig => kconf}/lkc.h                      |  0
 backport/{kconfig => kconf}/lkc_proto.h                |  0
 backport/{kconfig => kconf}/lxdialog/check-lxdialog.sh |  0
 backport/{kconfig => kconf}/lxdialog/checklist.c       |  0
 backport/{kconfig => kconf}/lxdialog/dialog.h          |  0
 backport/{kconfig => kconf}/lxdialog/inputbox.c        |  0
 backport/{kconfig => kconf}/lxdialog/menubox.c         |  0
 backport/{kconfig => kconf}/lxdialog/textbox.c         |  0
 backport/{kconfig => kconf}/lxdialog/util.c            |  0
 backport/{kconfig => kconf}/lxdialog/yesno.c           |  0
 backport/{kconfig => kconf}/mconf.c                    |  0
 backport/{kconfig => kconf}/menu.c                     |  0
 backport/{kconfig => kconf}/symbol.c                   |  0
 backport/{kconfig => kconf}/util.c                     |  0
 backport/{kconfig => kconf}/zconf.hash.c               |  0
 backport/{kconfig => kconf}/zconf.lex.c                |  0
 backport/{kconfig => kconf}/zconf.tab.c                |  0
 gentree.py                                             |  2 +-
 25 files changed, 9 insertions(+), 9 deletions(-)
 rename backport/{kconfig => kconf}/Makefile (100%)
 rename backport/{kconfig => kconf}/conf.c (100%)
 rename backport/{kconfig => kconf}/confdata.c (100%)
 rename backport/{kconfig => kconf}/expr.c (100%)
 rename backport/{kconfig => kconf}/expr.h (100%)
 rename backport/{kconfig => kconf}/list.h (100%)
 rename backport/{kconfig => kconf}/lkc.h (100%)
 rename backport/{kconfig => kconf}/lkc_proto.h (100%)
 rename backport/{kconfig => kconf}/lxdialog/check-lxdialog.sh (100%)
 rename backport/{kconfig => kconf}/lxdialog/checklist.c (100%)
 rename backport/{kconfig => kconf}/lxdialog/dialog.h (100%)
 rename backport/{kconfig => kconf}/lxdialog/inputbox.c (100%)
 rename backport/{kconfig => kconf}/lxdialog/menubox.c (100%)
 rename backport/{kconfig => kconf}/lxdialog/textbox.c (100%)
 rename backport/{kconfig => kconf}/lxdialog/util.c (100%)
 rename backport/{kconfig => kconf}/lxdialog/yesno.c (100%)
 rename backport/{kconfig => kconf}/mconf.c (100%)
 rename backport/{kconfig => kconf}/menu.c (100%)
 rename backport/{kconfig => kconf}/symbol.c (100%)
 rename backport/{kconfig => kconf}/util.c (100%)
 rename backport/{kconfig => kconf}/zconf.hash.c (100%)
 rename backport/{kconfig => kconf}/zconf.lex.c (100%)
 rename backport/{kconfig => kconf}/zconf.tab.c (100%)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 22a1373..2a1f640 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -13,8 +13,8 @@ export CONFIG_=CPTCFG_
 
 .PHONY: menuconfig
 menuconfig:
-	@$(MAKE) -C kconfig mconf
-	@./kconfig/mconf Kconfig
+	@$(MAKE) -C kconf mconf
+	@./kconf/mconf Kconfig
 
 .PHONY: listnewconfig oldaskconfig oldconfig \
 	silentoldconfig olddefconfig oldnoconfig \
@@ -24,17 +24,17 @@ listnewconfig oldaskconfig oldconfig \
 silentoldconfig olddefconfig oldnoconfig \
 allnoconfig allyesconfig allmodconfig \
 alldefconfig randconfig:
-	@$(MAKE) -C kconfig conf
-	@./kconfig/conf --$@ Kconfig
+	@$(MAKE) -C kconf conf
+	@./kconf/conf --$@ Kconfig
 
 .PHONY: usedefconfig
 usedefconfig:
-	@$(MAKE) -C kconfig conf
-	@./kconfig/conf --defconfig=defconfig Kconfig
+	@$(MAKE) -C kconf conf
+	@./kconf/conf --defconfig=defconfig Kconfig
 
 defconfig-%::
-	@$(MAKE) -C kconfig conf
-	@./kconfig/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
+	@$(MAKE) -C kconf conf
+	@./kconf/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
 
 .config:
 	@test -f defconfig && $(MAKE) usedefconfig || (			\
diff --git a/backport/kconfig/Makefile b/backport/kconf/Makefile
similarity index 100%
rename from backport/kconfig/Makefile
rename to backport/kconf/Makefile
diff --git a/backport/kconfig/conf.c b/backport/kconf/conf.c
similarity index 100%
rename from backport/kconfig/conf.c
rename to backport/kconf/conf.c
diff --git a/backport/kconfig/confdata.c b/backport/kconf/confdata.c
similarity index 100%
rename from backport/kconfig/confdata.c
rename to backport/kconf/confdata.c
diff --git a/backport/kconfig/expr.c b/backport/kconf/expr.c
similarity index 100%
rename from backport/kconfig/expr.c
rename to backport/kconf/expr.c
diff --git a/backport/kconfig/expr.h b/backport/kconf/expr.h
similarity index 100%
rename from backport/kconfig/expr.h
rename to backport/kconf/expr.h
diff --git a/backport/kconfig/list.h b/backport/kconf/list.h
similarity index 100%
rename from backport/kconfig/list.h
rename to backport/kconf/list.h
diff --git a/backport/kconfig/lkc.h b/backport/kconf/lkc.h
similarity index 100%
rename from backport/kconfig/lkc.h
rename to backport/kconf/lkc.h
diff --git a/backport/kconfig/lkc_proto.h b/backport/kconf/lkc_proto.h
similarity index 100%
rename from backport/kconfig/lkc_proto.h
rename to backport/kconf/lkc_proto.h
diff --git a/backport/kconfig/lxdialog/check-lxdialog.sh b/backport/kconf/lxdialog/check-lxdialog.sh
similarity index 100%
rename from backport/kconfig/lxdialog/check-lxdialog.sh
rename to backport/kconf/lxdialog/check-lxdialog.sh
diff --git a/backport/kconfig/lxdialog/checklist.c b/backport/kconf/lxdialog/checklist.c
similarity index 100%
rename from backport/kconfig/lxdialog/checklist.c
rename to backport/kconf/lxdialog/checklist.c
diff --git a/backport/kconfig/lxdialog/dialog.h b/backport/kconf/lxdialog/dialog.h
similarity index 100%
rename from backport/kconfig/lxdialog/dialog.h
rename to backport/kconf/lxdialog/dialog.h
diff --git a/backport/kconfig/lxdialog/inputbox.c b/backport/kconf/lxdialog/inputbox.c
similarity index 100%
rename from backport/kconfig/lxdialog/inputbox.c
rename to backport/kconf/lxdialog/inputbox.c
diff --git a/backport/kconfig/lxdialog/menubox.c b/backport/kconf/lxdialog/menubox.c
similarity index 100%
rename from backport/kconfig/lxdialog/menubox.c
rename to backport/kconf/lxdialog/menubox.c
diff --git a/backport/kconfig/lxdialog/textbox.c b/backport/kconf/lxdialog/textbox.c
similarity index 100%
rename from backport/kconfig/lxdialog/textbox.c
rename to backport/kconf/lxdialog/textbox.c
diff --git a/backport/kconfig/lxdialog/util.c b/backport/kconf/lxdialog/util.c
similarity index 100%
rename from backport/kconfig/lxdialog/util.c
rename to backport/kconf/lxdialog/util.c
diff --git a/backport/kconfig/lxdialog/yesno.c b/backport/kconf/lxdialog/yesno.c
similarity index 100%
rename from backport/kconfig/lxdialog/yesno.c
rename to backport/kconf/lxdialog/yesno.c
diff --git a/backport/kconfig/mconf.c b/backport/kconf/mconf.c
similarity index 100%
rename from backport/kconfig/mconf.c
rename to backport/kconf/mconf.c
diff --git a/backport/kconfig/menu.c b/backport/kconf/menu.c
similarity index 100%
rename from backport/kconfig/menu.c
rename to backport/kconf/menu.c
diff --git a/backport/kconfig/symbol.c b/backport/kconf/symbol.c
similarity index 100%
rename from backport/kconfig/symbol.c
rename to backport/kconf/symbol.c
diff --git a/backport/kconfig/util.c b/backport/kconf/util.c
similarity index 100%
rename from backport/kconfig/util.c
rename to backport/kconf/util.c
diff --git a/backport/kconfig/zconf.hash.c b/backport/kconf/zconf.hash.c
similarity index 100%
rename from backport/kconfig/zconf.hash.c
rename to backport/kconf/zconf.hash.c
diff --git a/backport/kconfig/zconf.lex.c b/backport/kconf/zconf.lex.c
similarity index 100%
rename from backport/kconfig/zconf.lex.c
rename to backport/kconf/zconf.lex.c
diff --git a/backport/kconfig/zconf.tab.c b/backport/kconf/zconf.tab.c
similarity index 100%
rename from backport/kconfig/zconf.tab.c
rename to backport/kconf/zconf.tab.c
diff --git a/gentree.py b/gentree.py
index 86b3f3c..fef2faf 100755
--- a/gentree.py
+++ b/gentree.py
@@ -323,7 +323,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     # do the copy
     backport_files = [(x, x) for x in [
         'Kconfig', 'Makefile', 'Makefile.build', 'Makefile.kernel', '.gitignore',
-        'Makefile.real', 'compat/', 'backport-include/', 'kconfig/', 'defconfigs/',
+        'Makefile.real', 'compat/', 'backport-include/', 'kconf/', 'defconfigs/',
         'scripts/', '.blacklist.map', 'udev/',
     ]]
     if not args.git_revision:
-- 
1.8.0

