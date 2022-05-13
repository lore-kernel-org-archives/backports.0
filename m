Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB7C4321E
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382323AbiEMQGQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381678AbiEMQGP (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:15 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A96FD0B
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 61A8F6E3A7D;
        Fri, 13 May 2022 16:06:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 7ZEwLOOGk3KW; Fri, 13 May 2022 16:06:08 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id F36606E3A7C;
        Fri, 13 May 2022 16:05:27 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 07/15] gentree: try to make patch operation idempotent in case of --clean
Date:   Fri, 13 May 2022 09:05:15 -0700
Message-Id: <20220513160523.2944694-8-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The patch utility will not just skip a patch if it has
already been applied. In the case of --integrate --clean
we may need to repatch the kernel Makefile, which wasn't
removed along with backports/. To support reapplying
patches without error, revert a failed patch with -R, then
reapply it.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 gentree.py | 56 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/gentree.py b/gentree.py
index 4705ffa08fc4..0576e14d6fe5 100755
--- a/gentree.py
+++ b/gentree.py
@@ -484,6 +484,31 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
         kup_cmd = "kup put /\n\t\t%s /\n\t\t%s /\n\t\t%s" % (gzip_name, tar_name + '.asc', korg_path)
         logwrite("kup-test: skipping cmd: %s" % kup_cmd)
 
+def do_patch(args, logwrite, pfile, target_dir, reverse=False):
+    cmd = 'patch -p1'.split()
+
+    if reverse:
+        cmd.append('-R')
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE,
+                               stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
+                               close_fds=True, universal_newlines=True,
+                               cwd=target_dir)
+    output = process.communicate(input=open(pfile, 'r').read())[0]
+    output = output.split('\n')
+    if output[-1] == '':
+        output = output[:-1]
+    if args.verbose:
+        for line in output:
+            logwrite('> %s' % line)
+    else:
+        logwrite("Failed to apply changes from %s" % print_name)
+        if not args.verbose:
+            for line in output:
+                logwrite('> %s' % line)
+
+    return process.returncode
+
+
 def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda x:None):
     """
     Given a path of a directories of patches and SmPL patches apply
@@ -539,23 +564,20 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                 fullfn = os.path.join(target_dir, patched_file)
                 shutil.copyfile(fullfn, fullfn + '.orig_file')
 
-        process = subprocess.Popen(['patch', '-p1'], stdout=subprocess.PIPE,
-                                   stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
-                                   close_fds=True, universal_newlines=True,
-                                   cwd=target_dir)
-        output = process.communicate(input=open(pfile, 'r').read())[0]
-        output = output.split('\n')
-        if output[-1] == '':
-            output = output[:-1]
-        if args.verbose:
-            for line in output:
-                logwrite('> %s' % line)
-        if process.returncode != 0:
-            if not args.verbose:
-                logwrite("Failed to apply changes from %s" % print_name)
-                for line in output:
-                    logwrite('> %s' % line)
-            return 2
+        err = do_patch(args, logwrite, pfile, target_dir)
+        if err > 0:
+            if not args.clean or err == 2:
+                return 2
+
+            # in case of clean, try to make patch idempotent
+            # try the reverse
+            err = do_patch(args, logwrite, pfile, target_dir, reverse=True)
+            if err != 0:
+                return 2
+            # that worked, now reapply..
+            err = do_patch(args, logwrite, pfile, target_dir)
+            if err != 0:
+                return 2
 
         if args.refresh:
             pfilef = open(pfile + '.tmp', 'a')
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
