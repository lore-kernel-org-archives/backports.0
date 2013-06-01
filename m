Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33273 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab3FAQAy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] backports: do not backport struct watchdog_device in RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:17 +0200
Message-Id: <1370102417-6711-12-git-send-email-hauke@hauke-m.de> (sfid-20130601_182936_450764_3F767212)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is already included in the RHEL 6.4 kernel.

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
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/watchdog.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
index 4aae6bb..fb68535 100644
--- a/backport/backport-include/linux/watchdog.h
+++ b/backport/backport-include/linux/watchdog.h
@@ -2,9 +2,11 @@
 #define __BACKPORT_WATCHDOG_H
 #include_next <linux/watchdog.h>
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
 struct watchdog_device {
 };
 #endif
+#endif
 
 #endif /* __BACKPORT_WATCHDOG_H */
-- 
1.7.10.4

