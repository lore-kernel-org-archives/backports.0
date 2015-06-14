Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41032 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbbFNO3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/21] header: fix rt6_nexthop() backport
Date: Sun, 14 Jun 2015 16:29:05 +0200
Message-Id: <1434292162-2261-5-git-send-email-hauke@hauke-m.de> (sfid-20150614_162943_262262_B415970E)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

rt6_nexthop() got an additional parameter in commit 2647a9b0. Instead
of only backporting it for kernel < 3.10 do it now for kernel version <
4.2.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/ip6_fib.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/net/ip6_fib.h b/backport/backport-include/net/ip6_fib.h
index 8c5d8ff..96b6759 100644
--- a/backport/backport-include/net/ip6_fib.h
+++ b/backport/backport-include/net/ip6_fib.h
@@ -4,12 +4,22 @@
 #include <net/ip6_route.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/*
+ * This function is avaliable with one argument since kernel 3.10, but the
+ * secound one was added in 4.2.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #define rt6_nexthop LINUX_BACKPORT(rt6_nexthop)
-static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt)
+static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt,
+					   struct in6_addr *daddr)
 {
-	return &rt->rt6i_gateway;
+	if (rt->rt6i_flags & RTF_GATEWAY)
+		return &rt->rt6i_gateway;
+	else if (rt->rt6i_flags & RTF_CACHE)
+		return &rt->rt6i_dst.addr;
+	else
+		return daddr;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) */
 
 #endif /* __BACKPORT_NET_IP6_ROUTE_H */
-- 
2.1.4

