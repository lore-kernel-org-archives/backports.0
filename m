Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37688 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbaKPUtj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/20] headers: add rt6_nexthop()
Date: Sun, 16 Nov 2014 21:49:08 +0100
Message-Id: <1416170960-12868-9-git-send-email-hauke@hauke-m.de> (sfid-20141116_214944_583962_02547962)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

this is needed by bluetooth.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/ip6_fib.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 backport/backport-include/net/ip6_fib.h

diff --git a/backport/backport-include/net/ip6_fib.h b/backport/backport-include/net/ip6_fib.h
new file mode 100644
index 0000000..8c5d8ff
--- /dev/null
+++ b/backport/backport-include/net/ip6_fib.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_NET_IP6_ROUTE_H
+#define __BACKPORT_NET_IP6_ROUTE_H
+#include_next <net/ip6_fib.h>
+#include <net/ip6_route.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define rt6_nexthop LINUX_BACKPORT(rt6_nexthop)
+static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt)
+{
+	return &rt->rt6i_gateway;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
+#endif /* __BACKPORT_NET_IP6_ROUTE_H */
-- 
1.9.1

