Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64845 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:20 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so4539643pdb.0
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:20 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 27/27] backports: enhance 0001-netdev_ops.cocci with data structure specifics
Date: Sat,  5 Apr 2014 05:41:01 -0700
Message-Id: <1396701662-15165-28-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_145708_D16248BC)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The 0001-netdev_ops.cocci is fine but is uses Expression which
makes the interpretation loose. We can reduce the namespace of
the change by using struct. We have to keep expression on the
right hand side as that can even be macros.

For a full example test coverage of this change see the test netdev-ops
github tree and run:

make test1

git checkout -f

make test2

The benefits should be clear, we are *not* modifying data structures
that have similar names. This increases accuracy and security of our
changes. The added run time penalty however is 50 seconds since we had
to use --recursive-includes. The time penatly is worth it for the
accuracy provided and since we'll likley need this flag elsewhere for
other rules.

mcgrof@drvbp1 ~/backports (git::master)$ time \
	./gentree.py --clean --refresh \
	/home/mcgrof/linux-next \
	/home/mcgrof/build/next-20140311
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m56.339s
user    19m31.428s
sys     0m50.100s

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

[0] https://github.com/mcgrof/netdev-ops

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpcoccinelle.py                                         | 1 +
 patches/collateral-evolutions/network/0001-netdev_ops.cocci | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index 37307d2..a71f425 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -32,6 +32,7 @@ class ExecutionErrorThread(CoccinelleError):
 def spatch(cocci_file, outdir,
            max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
     cmd = ['spatch', '--sp-file', cocci_file, '--in-place',
+            '--recursive-includes',
             '--backup-suffix', '.cocci_backup', '--dir', '.']
 
     if (max_threads > 1):
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.cocci b/patches/collateral-evolutions/network/0001-netdev_ops.cocci
index f3d2e63..7c3d03a 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.cocci
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.cocci
@@ -1,6 +1,6 @@
 @@
-expression dev;
-expression ops;
+struct net_device *dev;
+struct net_device_ops ops;
 @@
--dev->netdev_ops = ops;
-+netdev_attach_ops(dev, ops);
+-dev->netdev_ops = &ops;
++netdev_attach_ops(dev, &ops);
-- 
1.8.5.3

