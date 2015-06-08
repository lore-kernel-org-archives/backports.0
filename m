Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36406 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbbFHUD6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 16:03:58 -0400
Received: by qgep100 with SMTP id p100so51040320qge.3
        for <backports@vger.kernel.org>; Mon, 08 Jun 2015 13:03:57 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: cocci@systeme.lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] pycocci: sync pycocci with Coccinelle upstream
Date: Mon,  8 Jun 2015 13:01:42 -0700
Message-Id: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150608_220416_878803_1B3AED69)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

pycocci is now part of Coccinelle upstream. Coccinelle has a plan
to actually extend multithreaded support to enable us to not have
to script this out. Until then pyccoci is used and I'll sync both
solutions up as there is a bit of latency between a coccinelle release
and what we may need from pycocci.

Please send patches or report issues about pycocci to the coccinelle
mailing list.

This commit syncs pycocci with the upstream pycocci with just one
minor change introduced:

commit cf8ef1aee7d40cddfee0f8707b2f481eb8258b4d
Author: Luis R. Rodriguez <mcgrof@suse.com>
Date:   Fri May 29 15:15:57 2015 -0700

    pycocci: update Python script to print errors clearly

    When you run into errors with the pycocci script errors
    seem cryptic, fix this. While at it also spit out what the
    script will run, as typically when debugging you just want
    to runt he same commands on your own.

    For instance, when run on a 32 core machine you'll now see:

    mcgrof@drvbp1 ~/linux-next (git::master)$ time pycocci rename-dma.cocci ./
    spatch --sp-file rename-dma.cocci --in-place --recursive-includes --relax-include-path --use-coccigrep --timeout 120 --dir ./ -max 32 -index 0
    ...
    spatch --sp-file rename-dma.cocci --in-place --recursive-includes --relax-include-path --use-coccigrep --timeout 120 --dir ./ -max 32 -index 27

    real    0m50.074s
    user    14m50.168s
    sys     2m8.260s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/pycocci | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/devel/pycocci b/devel/pycocci
index b6bb78e..4aa1d36 100755
--- a/devel/pycocci
+++ b/devel/pycocci
@@ -45,22 +45,22 @@ class CoccinelleError(Exception):
 class ExecutionErrorThread(CoccinelleError):
     def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
         self.error_code = errcode
-        logwrite("Failed to apply changes from %s" % print_name)
+        logwrite("Failed to apply changes from %s\n" % print_name)
 
-        logwrite("Specific log output from change that failed using %s" % print_name)
+        logwrite("Specific log output from change that failed using %s\n" % print_name)
         tf = open(fn, 'r')
         for line in tf.read():
-            logwrite('> %s' % line)
+            logwrite(line)
         tf.close()
 
-        logwrite("Full log using %s" % print_name)
+        logwrite("Full log using %s\n" % print_name)
         for num in range(threads):
             fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
             if (not os.path.isfile(fn)):
                 continue
             tf = open(fn, 'r')
             for line in tf.read():
-                logwrite('> %s' % line)
+                logwrite(line)
             tf.close()
             os.unlink(fn)
 
@@ -82,6 +82,7 @@ def spatch(cocci_file, outdir,
 
     fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
     outfile = open(fn, 'w')
+    logwrite("%s\n" % " ".join(cmd))
 
     sprocess = subprocess.Popen(cmd,
                                stdout=outfile, stderr=subprocess.STDOUT,
-- 
2.1.0

