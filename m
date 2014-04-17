Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:65214 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaDQSFO (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:14 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so625955pbc.21
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 1/8] backports: revert unification of cocci files
Date: Thu, 17 Apr 2014 11:04:49 -0700
Message-Id: <1397757896-32558-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200530_826372_B51ED628)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This optimization was introduced by Johannes to help with
performance before we had parallelism. With parallelism
we get better results by splitting rules up. Also some
feedback from Julia on this:

===
I don't think this is a good idea.  You would have to be careful about
naming.  And You may lose on some performance benefits of the prefiltering.
Suppose you have an easy semantic patch that references function A and a
hard semantic patch that references function B.  The hard semantic patch
specifically contains one rule that is very complicated but that does not
use B.  That very complicated rule will now be applied to the 5000 files
that use A as well as to the 3 files that use B.  So you get a big
performance slowdown.
===

The performance before this change:

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
--refresh \
/home/mcgrof/linux-next /home/mcgrof/build/next-20140409
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m30.186s
user    9m25.180s
sys     0m24.428s

After:

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
/home/mcgrof/linux-next /home/mcgrof/build/next-20140411
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m3.071s
user    3m39.388s
sys     0m21.812s

commit 3c71184d3a2843c9a1d5a289c71bfbbc126d71fd
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Jan 1 20:37:13 2014 +0100

    gentree: combine spatches (unless using --gitdebug)

    Since spatch is rather slow, but can handle multiple spatches
    concatenated in a single file, just do that and run it only
    once rather than for each spatch. That shaves off some of the
    runtime (startup etc. and finding affected files.)

    On my system, I go from

    real    9m42.616s
    user    8m48.352s
    sys     0m22.884s

    to

    real    9m1.948s
    user    8m40.108s
    sys     0m12.088s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py | 64 +++++++++++++++++++++++++-------------------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/gentree.py b/gentree.py
index a90a425..7789e52 100755
--- a/gentree.py
+++ b/gentree.py
@@ -709,45 +709,33 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         git_debug_snapshot(args, "apply backport patch %s" % print_name)
 
     sempatches.sort()
-    with tempdir() as t:
-        if not args.gitdebug:
-            # combine all spatches
-            fn = os.path.join(t, 'combined.cocci')
-            f = open(fn, 'w')
-            for cocci_file in sempatches:
-                for l in open(cocci_file, 'r'):
-                    f.write(l)
-                f.write('\n')
-            f.close()
-            sempatches = [fn]
-            prefix_len = 0
-        else:
-            prefix_len = len(os.path.join(source_dir, 'patches')) + 1
-        for cocci_file in sempatches:
-            extra_spatch_args = []
-            if args.profile_cocci:
-                extra_spatch_args.append('--profile')
-            print_name = cocci_file[prefix_len:]
-            if args.verbose:
-                logwrite("Applying SmPL patch %s" % print_name)
-
-            output = coccinelle.threaded_spatch(cocci_file, args.outdir,
-                                                logwrite, print_name,
-                                                test_cocci,
-                                                extra_args=extra_spatch_args)
-            output = output.split('\n')
-            if output[-1] == '':
-                output = output[:-1]
-            if args.verbose:
-                for line in output:
-                    logwrite('> %s' % line)
+    prefix_len = len(os.path.join(source_dir, 'patches')) + 1
+
+    for cocci_file in sempatches:
+        extra_spatch_args = []
+        if args.profile_cocci:
+            extra_spatch_args.append('--profile')
+        print_name = cocci_file[prefix_len:]
+        if args.verbose:
+            logwrite("Applying SmPL patch %s" % print_name)
+
+        output = coccinelle.threaded_spatch(cocci_file, args.outdir,
+                                            logwrite, print_name,
+                                            test_cocci,
+                                            extra_args=extra_spatch_args)
+        output = output.split('\n')
+        if output[-1] == '':
+            output = output[:-1]
+        if args.verbose:
+            for line in output:
+                logwrite('> %s' % line)
 
-            # remove cocci_backup files
-            for root, dirs, files in os.walk(args.outdir):
-                for f in files:
-                    if f.endswith('.cocci_backup'):
-                        os.unlink(os.path.join(root, f))
-            git_debug_snapshot(args, "apply backport SmPL patch %s" % print_name)
+        # remove cocci_backup files
+        for root, dirs, files in os.walk(args.outdir):
+            for f in files:
+                if f.endswith('.cocci_backup'):
+                    os.unlink(os.path.join(root, f))
+        git_debug_snapshot(args, "apply backport SmPL patch %s" % print_name)
 
     if test_cocci:
         logwrite('Done!')
-- 
1.9.1

