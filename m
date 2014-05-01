Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37602 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1e (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so4443966pad.29
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:27:33 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 7/8] backports: devel/backports-update-manager: fix for older shutil.move
Date: Thu,  1 May 2014 16:26:50 -0700
Message-Id: <1398986811-25649-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012735_327217_B99F7ACD)
In-Reply-To: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Older shutil.move does not seem to like it when there are
symlinks on a target, to account for this and to make things
clearer just split up the work on the lib/modules and usr/src
directory.

This fixes running devel/backports-update-manager on OpenSUSE 13.1
base install.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 devel/backports-update-manager | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index fc146c6..0676421 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -429,7 +429,7 @@ class backport_kernel_updater:
             self.increase_kver_count(url)
             self.all_new_kernels.append(url)
         sys.stdout.write("\n")
-    def fix_and_install_header_lib_modules(self, dir_path):
+    def fix_header_lib_modules(self, dir_path):
         """
         Relink lib/modules/*/build/ directories relatively to make it work
         for regular user based workflows
@@ -438,16 +438,22 @@ class backport_kernel_updater:
             if "generic" not in kernel:
                 continue
             kver = self.get_kver(kernel)
-            sys.stdout.write("%s - adjusting build symlink for non-root installation ...\n" % (kver.get('ver')))
-            build_target = os.path.join(dir_path, kernel + '/build')
+            sys.stdout.write("%s - creating lib/modules/$kernel/build symlink for non-root installation ...\n" % (kver.get('ver')))
+            src = os.path.join(dir_path, kernel)
+            dst = os.path.join(self.ksrc_prefix, 'lib/modules/' + kernel)
+            build_target = os.path.join(src, 'build')
             usr_src_sym = "../../../usr/src/linux-headers-" + kernel
             os.unlink(build_target)
             os.symlink(usr_src_sym, build_target)
+            shutil.move(src, dst)
+    def install_headers(self, dir_path):
         for kernel in os.listdir(dir_path):
             src = os.path.join(dir_path, kernel)
-            dst = os.path.join(self.ksrc_prefix, 'lib/modules/' + kernel)
+            dst = os.path.join(self.ksrc_prefix, 'usr/src/' + kernel)
             kver = self.get_kver(kernel)
-            sys.stdout.write("%s - installing lib/modules/ ...\n" % (kver.get('ver')))
+            sys.stdout.write("%s - installing usr/src/ ...\n" % (kver.get('ver')))
+            sys.stdout.write("src: %s\n" % src)
+            sys.stdout.write("dst: %s\n" % dst)
             self.rm_clean_dir(dst)
             shutil.move(src, dst)
     def fix_makefile_old_kernels(self, makefile):
@@ -463,8 +469,10 @@ class backport_kernel_updater:
     def sanitize_and_install_kernel_dirs(self, dir_path):
         d_lib_modules = os.path.join(dir_path, "lib/modules")
         d_usr_src     = os.path.join(dir_path, "usr/src")
+        if os.path.isdir(d_usr_src):
+            self.install_headers(d_usr_src)
         if os.path.isdir(d_lib_modules):
-            self.fix_and_install_header_lib_modules(d_lib_modules)
+            self.fix_header_lib_modules(d_lib_modules)
     def extract_backport_pkgs(self):
         tmp_prefix = BACKPORTS_KSRC_DIR + '_'
         tmpdir_path = tempfile.mkdtemp(prefix=tmp_prefix)
-- 
1.9.1

