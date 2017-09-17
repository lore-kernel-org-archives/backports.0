Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:43334 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751619AbdIQQ6j (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 12:58:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] header: add ether_addr_to_u64() and u64_to_ether_addr()
Date: Sun, 17 Sep 2017 18:58:13 +0200
Message-Id: <20170917165813.17580-5-hauke@hauke-m.de> (sfid-20170917_185840_128108_E34A08D2)
In-Reply-To: <20170917165813.17580-1-hauke@hauke-m.de>
References: <20170917165813.17580-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These function were added in commit 5952758101 ("dsa: mv88e6xxx:
Optimise atu_get") and are now used by mwifiex.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 92256e00..a00e6660 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -193,4 +193,38 @@ static inline int eth_skb_pad(struct sk_buff *skb)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
+#if LINUX_VERSION_IS_LESS(4,11,0)
+/**
+ * ether_addr_to_u64 - Convert an Ethernet address into a u64 value.
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Return a u64 value of the address
+ */
+static inline u64 ether_addr_to_u64(const u8 *addr)
+{
+	u64 u = 0;
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		u = u << 8 | addr[i];
+
+	return u;
+}
+
+/**
+ * u64_to_ether_addr - Convert a u64 to an Ethernet address.
+ * @u: u64 to convert to an Ethernet MAC address
+ * @addr: Pointer to a six-byte array to contain the Ethernet address
+ */
+static inline void u64_to_ether_addr(u64 u, u8 *addr)
+{
+	int i;
+
+	for (i = ETH_ALEN - 1; i >= 0; i--) {
+		addr[i] = u & 0xff;
+		u = u >> 8;
+	}
+}
+#endif /* LINUX_VERSION_IS_LESS(4,11,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
