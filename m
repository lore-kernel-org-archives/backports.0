Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36630 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938AbaLURwB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:01 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] header: add eth_skb_pad()
Date: Sun, 21 Dec 2014 18:51:49 +0100
Message-Id: <1419184314-1938-4-git-send-email-hauke@hauke-m.de> (sfid-20141221_185204_793433_43958CE4)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

eth_skb_pad() is used by the igb driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 70decd2..34dbf65 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -178,4 +178,19 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 int eth_get_headlen(unsigned char *data, unsigned int max_len);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define eth_skb_pad LINUX_BACKPORT(eth_skb_pad)
+/**
+ * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
+ * @skb: Buffer to pad
+ *
+ * An Ethernet frame should have a minimum size of 60 bytes.  This function
+ * takes short frames and pads them with zeros up to the 60 byte limit.
+ */
+static inline int eth_skb_pad(struct sk_buff *skb)
+{
+	return skb_put_padto(skb, ETH_ZLEN);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.9.1

