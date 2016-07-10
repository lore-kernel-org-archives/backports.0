Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56143 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbcGJVO7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/19] header: add ipv6_addr_prefix_copy()
Date: Sun, 10 Jul 2016 23:14:32 +0200
Message-Id: <1468185285-28265-7-git-send-email-hauke@hauke-m.de> (sfid-20160710_231503_553135_EDE5333D)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in commit 818f1f3e7 "ipv6: add ipv6_addr_prefix_copy" to
mainline Linux kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/ipv6.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
index 9da13eb..762ad78 100644
--- a/backport/backport-include/net/ipv6.h
+++ b/backport/backport-include/net/ipv6.h
@@ -39,4 +39,22 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#define ipv6_addr_prefix_copy LINUX_BACKPORT(ipv6_addr_prefix_copy)
+static inline void ipv6_addr_prefix_copy(struct in6_addr *addr,
+					 const struct in6_addr *pfx,
+					 int plen)
+{
+	/* caller must guarantee 0 <= plen <= 128 */
+	int o = plen >> 3,
+	    b = plen & 0x7;
+
+	memcpy(addr->s6_addr, pfx, o);
+	if (b != 0) {
+		addr->s6_addr[o] &= ~(0xff00 >> b);
+		addr->s6_addr[o] |= (pfx->s6_addr[o] & (0xff00 >> b));
+	}
+}
+#endif
+
 #endif /* __BACKPORT_NET_IPV6_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
