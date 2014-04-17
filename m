Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63226 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaDQSFd (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:33 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so632749pbb.3
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:33 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 5/8] backports: add a 120 second timeout rule to Coccinelle
Date: Thu, 17 Apr 2014 11:04:53 -0700
Message-Id: <1397757896-32558-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200656_766705_AEDF191C)
In-Reply-To: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Our current overall run time is less than 120 seconds so lets
add a trigger to fail if we have a rule taking longer. Adding
this has no extra incurred overhead cost.

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
/home/mcgrof/linux-next /home/mcgrof/build/next-20140411
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m15.463s
user    10m49.100s
sys     0m37.100s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpcoccinelle.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index 75a0b37..2e0153e 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -35,6 +35,7 @@ def spatch(cocci_file, outdir,
             '--recursive-includes',
             '--relax-include-path',
             '--use-coccigrep',
+            '--timeout', '120',
             '--backup-suffix', '.cocci_backup', '--dir', '.']
 
     if (max_threads > 1):
-- 
1.9.1

