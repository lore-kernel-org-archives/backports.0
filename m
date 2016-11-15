Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:46752 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935299AbcKOJJ1 (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 15 Nov 2016 04:09:27 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: rename .local-symbols to local-symbols
Date: Tue, 15 Nov 2016 10:09:21 +0100
Message-Id: <20161115090921.28871-1-johannes@sipsolutions.net> (sfid-20161115_100930_669208_073F894A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Remove the leading . in the file, which has tripped up people
a few times already because it's hidden, and not always copied.

Change-Id: I48729af712f01b56cf43c4982321b989e33259f3
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile            | 4 ++--
 backport/Makefile.real       | 2 +-
 devel/doc/kconfig-operation  | 2 +-
 devel/doc/makefile-operation | 2 +-
 gentree.py                   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index 11678f67adcd..0fd4cdb2f322 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -37,7 +37,7 @@ mrproper:
 	@rm -f backport-include/backport/autoconf.h
 
 .DEFAULT:
-	@set -e ; test -f .local-symbols || (						\
+	@set -e ; test -f local-symbols || (						\
 	echo "/--------------"								;\
 	echo "| You shouldn't run make in the backports tree, but only in"		;\
 	echo "| the generated output. This here is only the skeleton code"		;\
@@ -63,7 +63,7 @@ mrproper:
 	@set -e ; if [ "$$(cat .kernel_config_md5 2>/dev/null)" != "$(CONFIG_MD5)" ]	;\
 	then 										\
 		echo -n "Generating local configuration database from kernel ..."	;\
-		grep -v -f .local-symbols $(KERNEL_CONFIG) | grep = | (			\
+		grep -v -f local-symbols $(KERNEL_CONFIG) | grep = | (			\
 			while read l ; do						\
 				if [ "$${l:0:7}" != "CONFIG_" ] ; then			\
 					continue					;\
diff --git a/backport/Makefile.real b/backport/Makefile.real
index a0f491626f80..c874d318916c 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -60,7 +60,7 @@ defconfig-%::
 backport-include/backport/autoconf.h: .config Kconfig.versions Kconfig.kernel
 	@$(MAKE) oldconfig
 	@echo -n "Building backport-include/backport/autoconf.h ..."
-	@grep -f .local-symbols .config | (				\
+	@grep -f local-symbols .config | (				\
 		echo "#ifndef COMPAT_AUTOCONF_INCLUDED"			;\
 		echo "#define COMPAT_AUTOCONF_INCLUDED"			;\
 		echo "/*"						;\
diff --git a/devel/doc/kconfig-operation b/devel/doc/kconfig-operation
index 35e198c6ebe3..fffcc91bfefd 100644
--- a/devel/doc/kconfig-operation
+++ b/devel/doc/kconfig-operation
@@ -99,7 +99,7 @@ These are the problems and their solutions:
     To achieve this, all Kconfig files are walked during the backporting
     process, starting at the root "Kconfig", and any symbols defined in
     them collected. Later then, only those options are renamed. They are
-    also recorded for the build process in the output file .local-symbols.
+    also recorded for the build process in the output file local-symbols.
 
  2) Kconfig files may reference files that don't exist when they're copied
     but not all the drivers, e.g. drivers/net/wireless/Kconfig is copied
diff --git a/devel/doc/makefile-operation b/devel/doc/makefile-operation
index 38cf4e73eb3c..a3eecd6e6f7d 100644
--- a/devel/doc/makefile-operation
+++ b/devel/doc/makefile-operation
@@ -25,7 +25,7 @@ the tools -- menuconfig, defconfig-*, ...
 When the configuration is complete and exists in .config, the autoconf
 header (backport-include/backport/autoconf.h) must be generated. This step is
 also done in the make system (by a small embedded shell script) and needs
-the .local-symbols so it only includes the symbols from the backport.
+the local-symbols so it only includes the symbols from the backport.
 
 After this exists, all that's left to do is source the .config file and
 export everything in there into the environment for calling the kernel's
diff --git a/gentree.py b/gentree.py
index e97ead0790d6..186a41477b18 100755
--- a/gentree.py
+++ b/gentree.py
@@ -953,7 +953,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
 
     # write local symbol list -- needed during packaging build
     if not bpid.integrate:
-        f = open(os.path.join(bpid.target_dir, '.local-symbols'), 'w')
+        f = open(os.path.join(bpid.target_dir, 'local-symbols'), 'w')
         for sym in symbols:
             f.write('%s=\n' % sym)
         f.close()
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
