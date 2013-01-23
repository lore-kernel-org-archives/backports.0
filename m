Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	Felix Fietkau <nbd@openwrt.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/1] compat: fix compile errors when assembly is built into modules
Date: Wed, 23 Jan 2013 13:22:44 -0800
Message-Id: <1358976165-22389-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1358976165-22389-1-git-send-email-mcgrof@do-not-panic.com>
References: <1358976165-22389-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: Felix Fietkau <nbd@openwrt.org>

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
---
 include/linux/compat-2.6.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index 00a5eda..34c49e6 100644
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
@@ -68,4 +70,6 @@ void compat_dependency_symbol(void);
 #include <linux/compat-3.7.h>
 #include <linux/compat-3.8.h>
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* LINUX_26_COMPAT_H */
-- 
1.7.10.4
