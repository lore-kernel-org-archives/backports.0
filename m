Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35236 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaFGT3k (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id C73657E6C
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:39 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] backports: add ether_addr_copy()
Date: Sat,  7 Jun 2014 21:29:13 +0200
Message-Id: <1402169356-1267-5-git-send-email-hauke@hauke-m.de> (sfid-20140607_212942_102255_8FD165C8)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by the rsi driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 8d09e1f..cc2ee0a 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -148,6 +148,29 @@ static inline bool ether_addr_equal_unaligned(const u8 *addr1, const u8 *addr2)
 	return memcmp(addr1, addr2, ETH_ALEN) == 0;
 #endif
 }
+
+/**
+ * ether_addr_copy - Copy an Ethernet address
+ * @dst: Pointer to a six-byte array Ethernet address destination
+ * @src: Pointer to a six-byte array Ethernet address source
+ *
+ * Please note: dst & src must both be aligned to u16.
+ */
+#define ether_addr_copy LINUX_BACKPORT(ether_addr_copy)
+static inline void ether_addr_copy(u8 *dst, const u8 *src)
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	*(u32 *)dst = *(const u32 *)src;
+	*(u16 *)(dst + 4) = *(const u16 *)(src + 4);
+#else
+	u16 *a = (u16 *)dst;
+	const u16 *b = (const u16 *)src;
+
+	a[0] = b[0];
+	a[1] = b[1];
+	a[2] = b[2];
+#endif
+}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
 
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.9.1

