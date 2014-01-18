Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54713 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUJX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:09:23 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add ether_addr_equal_unaligned()
Date: Sat, 18 Jan 2014 21:05:21 +0100
Message-Id: <1390075524-6924-3-git-send-email-hauke@hauke-m.de> (sfid-20140118_210925_629064_34C46800)
In-Reply-To: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
References: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ether_addr_equal_unaligned() is used by some drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index cf02852..cf1e31f 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -190,4 +190,24 @@ static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+/**
+ * ether_addr_equal_unaligned - Compare two not u16 aligned Ethernet addresses
+ * @addr1: Pointer to a six-byte array containing the Ethernet address
+ * @addr2: Pointer other six-byte array containing the Ethernet address
+ *
+ * Compare two Ethernet addresses, returns true if equal
+ *
+ * Please note: Use only when any Ethernet address may not be u16 aligned.
+ */
+static inline bool ether_addr_equal_unaligned(const u8 *addr1, const u8 *addr2)
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	return ether_addr_equal(addr1, addr2);
+#else
+	return memcmp(addr1, addr2, ETH_ALEN) == 0;
+#endif
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.7.10.4

