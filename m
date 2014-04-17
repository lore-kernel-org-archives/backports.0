Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37498 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbaDQSFY (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:24 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so627804pad.16
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:24 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 3/8] backports: use --use-coccigrep for Coccinelle
Date: Thu, 17 Apr 2014 11:04:51 -0700
Message-Id: <1397757896-32558-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200647_639103_3E67644B)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This uses --use-coccigrep on our Cocccinelle library and removes
the CPU adjustments depending on whether we are testing or not.
The flag --use-coccigrep will tell Coccinelle to only kick off a
worker on a file until it has determined that a rule being
evaluated applies to a file. This does however mean that all files
on its bucket list will be evaluated first, but this yields better
CPU usage without having us to ramp up on the number of threads
depending on the situation. Without this patch we were kicking off
more threads to account for the fact that a Coccinelle thread will
stop working on a file if it had little or nothing to do on a file.

Possible work improvement: see how we can do away with tmp files
for Coccinelle output and just use memory to for the ouput, or
perhaps even disregard the stdout and only care for it if
--debug-cocci is provided.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
/home/mcgrof/linux-next /home/mcgrof/build/next-20140411
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m14.880s
user    10m47.824s
sys     0m36.796s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py          | 1 -
 lib/bpcoccinelle.py | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/gentree.py b/gentree.py
index 7789e52..b890d28 100755
--- a/gentree.py
+++ b/gentree.py
@@ -721,7 +721,6 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
         output = coccinelle.threaded_spatch(cocci_file, args.outdir,
                                             logwrite, print_name,
-                                            test_cocci,
                                             extra_args=extra_spatch_args)
         output = output.split('\n')
         if output[-1] == '':
diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index a71f425..bd276c7 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -33,6 +33,7 @@ def spatch(cocci_file, outdir,
            max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
     cmd = ['spatch', '--sp-file', cocci_file, '--in-place',
             '--recursive-includes',
+            '--use-coccigrep',
             '--backup-suffix', '.cocci_backup', '--dir', '.']
 
     if (max_threads > 1):
@@ -53,12 +54,8 @@ def spatch(cocci_file, outdir,
     outfile.close()
     ret_q.put((sprocess.returncode, fn))
 
-def threaded_spatch(cocci_file, outdir, logwrite, print_name,
-                    test_cocci, extra_args=[]):
-    num_cpus = cpu_count()
-    threads = num_cpus * 3
-    if test_cocci:
-        threads = num_cpus * 10
+def threaded_spatch(cocci_file, outdir, logwrite, print_name, extra_args=[]):
+    threads = cpu_count()
     jobs = list()
     output = ''
     ret_q = Queue()
-- 
1.9.1

