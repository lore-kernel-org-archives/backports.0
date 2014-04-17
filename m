Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63665 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbaDQSF3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:29 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so610464pdj.41
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:28 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 4/8] backports: Use Coccinelle --relax-include-path
Date: Thu, 17 Apr 2014 11:04:52 -0700
Message-Id: <1397757896-32558-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200813_984378_FCD20ECA)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This will provide wider coverage on include paths for our Coccinelle
rule interpretation, at a very lower cost incurred, about 1 second,
for code generation. Coccinelle makes an effort to infer types but
with a wider coverage of header files it can do a better job at that.
You want to use both --recursive-includes (which we already enable) and
--relax-include-path to get the most possible type information.

You will want at least Coccinelle 1.0.0-rc20 which had an increase
of performance of over 30% when using both  --recursive-includes and
--relax-include path.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
/home/mcgrof/linux-next /home/mcgrof/build/next-20140411
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m15.370s
user    10m47.232s
sys     0m36.980s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpcoccinelle.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index bd276c7..75a0b37 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -33,6 +33,7 @@ def spatch(cocci_file, outdir,
            max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
     cmd = ['spatch', '--sp-file', cocci_file, '--in-place',
             '--recursive-includes',
+            '--relax-include-path',
             '--use-coccigrep',
             '--backup-suffix', '.cocci_backup', '--dir', '.']
 
-- 
1.9.1

