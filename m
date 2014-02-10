Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47164 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbaBJWrw (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:47:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] backports: add ipv6_addr_hash()
Date: Mon, 10 Feb 2014 23:47:30 +0100
Message-Id: <1392072454-18538-3-git-send-email-hauke@hauke-m.de> (sfid-20140210_234754_326577_7EE01662)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by net-core-flow_dissector.c Kernel < 2.6.25 and kernel
> 3.6 have this function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/ipv6.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 backport/backport-include/net/ipv6.h

diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
new file mode 100644
index 0000000..9a370a0
--- /dev/null
+++ b/backport/backport-include/net/ipv6.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT_NET_IPV6_H
+#define __BACKPORT_NET_IPV6_H
+#include_next <net/ipv6.h>
+#include <linux/version.h>
+#include <net/addrconf.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)) && (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
+#define ipv6_addr_hash LINUX_BACKPORT(ipv6_addr_hash)
+static inline u32 ipv6_addr_hash(const struct in6_addr *a)
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
+	const unsigned long *ul = (const unsigned long *)a;
+	unsigned long x = ul[0] ^ ul[1];
+
+	return (u32)(x ^ (x >> 32));
+#else
+	return (__force u32)(a->s6_addr32[0] ^ a->s6_addr32[1] ^
+			     a->s6_addr32[2] ^ a->s6_addr32[3]);
+#endif
+}
+#endif
+
+#endif /* __BACKPORT_NET_IPV6_H */
-- 
1.7.10.4

