Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0900C35640
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B46206E2
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBUJDZ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:03:25 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54824 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgBUJDY (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:03:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546s-00EncU-1t; Fri, 21 Feb 2020 09:56:34 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] gentree: add a --list-files option
Date:   Fri, 21 Feb 2020 09:56:20 +0100
Message-Id: <20200221095437.fe83a3330649.I5151aae11023725a5c6e626c2fef46393ec4ebab@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This can be used to understand what will go into a backport,
but currently excludes some uninteresting files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/gentree.py b/gentree.py
index 8fdf34c60f7e..bf2965f2a8c6 100755
--- a/gentree.py
+++ b/gentree.py
@@ -649,6 +649,8 @@ def _main():
                              'and we use git ls-tree to get the files.')
     parser.add_argument('--clean', const=True, default=False, action="store_const",
                         help='Clean output directory instead of erroring if it isn\'t empty')
+    parser.add_argument('--list-files', const=True, default=False, action="store_const",
+                        help='Only list files to copy')
     parser.add_argument('--integrate', const=True, default=False, action="store_const",
                         help='Integrate a future backported kernel solution into ' +
                              'an older kernel tree source directory.')
@@ -715,7 +717,7 @@ def _main():
         sys.stdout.write('\n')
         sys.stdout.flush()
 
-    return process(args.kerneldir, args.copy_list,
+    retv = process(args.kerneldir, args.copy_list,
                    git_revision=args.git_revision,
                    bpid=bpid,
                    clean=args.clean,
@@ -726,7 +728,12 @@ def _main():
                    kup_test=args.kup_test,
                    test_cocci=args.test_cocci,
                    profile_cocci=args.profile_cocci,
-                   logwrite=logwrite)
+                   logwrite=logwrite,
+                   list_files=args.list_files)
+    if args.list_files:
+        print('\n'.join(retv))
+    else:
+        return retv
 
 def process(kerneldir, copy_list_file, git_revision=None,
             bpid=None,
@@ -736,14 +743,15 @@ def process(kerneldir, copy_list_file, git_revision=None,
             test_cocci=None,
             profile_cocci=None,
             logwrite=lambda x:None,
-            git_tracked_version=False):
+            git_tracked_version=False,
+            list_files=False):
     class Args(object):
         def __init__(self, kerneldir, copy_list_file,
                      git_revision, bpid, clean, refresh, base_name,
                      gitdebug, verbose, extra_driver, kup,
                      kup_test,
                      test_cocci,
-                     profile_cocci):
+                     profile_cocci, list_files):
             self.kerneldir = kerneldir
             self.copy_list = copy_list_file
             self.git_revision = git_revision
@@ -760,6 +768,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
             self.profile_cocci = profile_cocci
             if self.test_cocci or self.profile_cocci:
                 self.gitdebug = True
+            self.list_files = list_files
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
         if (data['r'] != 0):
@@ -772,7 +781,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
     args = Args(kerneldir, copy_list_file,
                 git_revision, bpid, clean, refresh, base_name,
                 gitdebug, verbose, extra_driver, kup, kup_test,
-                test_cocci, profile_cocci)
+                test_cocci, profile_cocci, list_files)
     rel_prep = None
 
     if bpid.integrate:
@@ -810,9 +819,6 @@ def process(kerneldir, copy_list_file, git_revision=None,
     copy_list = read_copy_list(args.copy_list)
     deplist = read_dependencies(os.path.join(source_dir, 'dependencies'))
 
-    # validate output directory
-    check_output_dir(bpid.target_dir, args.clean)
-
     # do the copy
     backport_integrate_files = [
             ('Makefile.kernel', 'Makefile'),
@@ -842,6 +848,20 @@ def process(kerneldir, copy_list_file, git_revision=None,
     else:
         backport_files += backport_integrate_files
 
+    if args.list_files:
+        ret = []
+        for f in copy_list:
+            # FIXME: make these exclusions configurable
+            if f[0] in ['COPYING', 'MAINTAINERS']:
+                continue
+            if f[0].startswith('scripts/'):
+                continue
+            ret.append(f[0])
+        return ret
+
+    # validate output directory
+    check_output_dir(bpid.target_dir, args.clean)
+
     if not args.git_revision:
         logwrite('Copy original source files ...')
     else:
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
