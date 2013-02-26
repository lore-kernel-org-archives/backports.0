Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Felix Fietkau <nbd@openwrt.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 2/8] compat: fix compile errors when assembly is built into modules
Date: Tue, 26 Feb 2013 22:05:39 +0100
Message-Id: <1361912745-29665-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

From: Felix Fietkau <nbd@openwrt.org>

Upstream commit a04996415774e7bfe7bd95ef0013b13fd12eb6b2

On powerpc, modules can be compiled and linked with an assembly file, adding
missing symbols that the compiler references when using -Os.

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.50              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.33              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.17              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.5               [  OK  ]
24  3.7.0               [  OK  ]

real    0m33.803s
user    11m24.519s
sys     3m39.690s

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index f26489c..7a8409f 100644
--- a/include/linux/compat-2.6.h
+++ b/include/linux/compat-2.6.h
@@ -1,6 +1,8 @@
 #ifndef LINUX_26_COMPAT_H
 #define LINUX_26_COMPAT_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/version.h>
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
 #include <linux/kconfig.h>
@@ -67,4 +69,6 @@ void compat_dependency_symbol(void);
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* LINUX_26_COMPAT_H */
-- 
1.7.10.4
