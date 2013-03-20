Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: ben@decadent.org.uk,
	noelamac@gmail.com,
	linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au,
	andi@firstfloor.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 05/30] compat: embrace LINUX_BACKPORT() for v2.6.26
Date: Wed, 20 Mar 2013 02:22:30 -0700
Message-Id: <1363771375-31715-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
References: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/compat-2.6.26.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compat-2.6.26.h b/include/linux/compat-2.6.26.h
index 177792a..b8d9dc6 100644
--- a/include/linux/compat-2.6.26.h
+++ b/include/linux/compat-2.6.26.h
@@ -45,6 +45,7 @@
 #define SHORT_MAX       ((s16)(USHORT_MAX>>1))
 #define SHORT_MIN       (-SHORT_MAX - 1)
 
+#define dev_set_name LINUX_BACKPORT(dev_set_name)
 extern int dev_set_name(struct device *dev, const char *name, ...)
 			__attribute__((format(printf, 2, 3)));
 
-- 
1.7.10.4
