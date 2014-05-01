Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56391 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1O (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so4410643pab.41
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:27:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 3/8] backports: add gentree.py binary requirements
Date: Thu,  1 May 2014 16:26:46 -0700
Message-Id: <1398986811-25649-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012715_433283_ED719584)
In-Reply-To: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 gentree.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gentree.py b/gentree.py
index 1058884..8a8f6b6 100755
--- a/gentree.py
+++ b/gentree.py
@@ -15,6 +15,7 @@ from lib import bpgit as git
 from lib import bpgpg as gpg
 from lib import bpkup as kup
 from lib.tempdir import tempdir
+from lib import bpreqs as reqs
 
 def read_copy_list(copyfile):
     """
@@ -438,6 +439,13 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
         logwrite("kup-test: skipping cmd: %s" % kup_cmd)
 
 def _main():
+    # Our binary requirements go here
+    req = reqs.Req()
+    req.require('git')
+    req.coccinelle('1.0.0-rc21')
+    if not req.reqs_match():
+        sys.exit(1)
+
     # set up and parse arguments
     parser = argparse.ArgumentParser(description='generate backport tree')
     parser.add_argument('kerneldir', metavar='<kernel tree>', type=str,
@@ -880,6 +888,10 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     git_debug_snapshot(args, "disable unsatisfied Makefile parts")
 
     if (args.kup or args.kup_test):
+        req = reqs.Req()
+        req.kup()
+        if not req.reqs_match():
+            sys.exit(1)
         upload_release(args, rel_prep, logwrite=logwrite)
 
     logwrite('Done!')
-- 
1.9.1

