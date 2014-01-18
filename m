Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54670 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUId (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:08:33 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add ether_addr_equal_64bits()
Date: Sat, 18 Jan 2014 21:05:20 +0100
Message-Id: <1390075524-6924-2-git-send-email-hauke@hauke-m.de> (sfid-20140118_210834_502437_71496DD8)
In-Reply-To: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
References: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by some drivers now

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |   32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 5a6096d..cf02852 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -158,4 +158,36 @@ static inline void eth_hw_addr_inherit(struct net_device *dst,
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+/**
+ * ether_addr_equal_64bits - Compare two Ethernet addresses
+ * @addr1: Pointer to an array of 8 bytes
+ * @addr2: Pointer to an other array of 8 bytes
+ *
+ * Compare two Ethernet addresses, returns true if equal, false otherwise.
+ *
+ * The function doesn't need any conditional branches and possibly uses
+ * word memory accesses on CPU allowing cheap unaligned memory reads.
+ * arrays = { byte1, byte2, byte3, byte4, byte5, byte6, pad1, pad2 }
+ *
+ * Please note that alignment of addr1 & addr2 are only guaranteed to be 16 bits.
+ */
+
+static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
+					   const u8 addr2[6+2])
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
+	u64 fold = (*(const u64 *)addr1) ^ (*(const u64 *)addr2);
+
+#ifdef __BIG_ENDIAN
+	return (fold >> 16) == 0;
+#else
+	return (fold << 16) == 0;
+#endif
+#else
+	return ether_addr_equal(addr1, addr2);
+#endif
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.7.10.4

