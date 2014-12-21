Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36629 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbaLURwB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:01 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] header: add skb_put_padto()
Date: Sun, 21 Dec 2014 18:51:48 +0100
Message-Id: <1419184314-1938-3-git-send-email-hauke@hauke-m.de> (sfid-20141221_185204_179871_E2A6BBD1)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

skb_put_padto() is used by the igb driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 53c1aa4..687297c 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -269,6 +269,30 @@ static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
 {
 	return memcpy_fromiovec(data, msg->msg_iov, len);
 }
+
+/**
+ *	skb_put_padto - increase size and pad an skbuff up to a minimal size
+ *	@skb: buffer to pad
+ *	@len: minimal length
+ *
+ *	Pads up a buffer to ensure the trailing bytes exist and are
+ *	blanked. If the buffer already contains sufficient data it
+ *	is untouched. Otherwise it is extended. Returns zero on
+ *	success. The skb is freed on error.
+ */
+#define skb_put_padto LINUX_BACKPORT(skb_put_padto)
+static inline int skb_put_padto(struct sk_buff *skb, unsigned int len)
+{
+	unsigned int size = skb->len;
+
+	if (unlikely(size < len)) {
+		len -= size;
+		if (skb_pad(skb, len))
+			return -ENOMEM;
+		__skb_put(skb, len);
+	}
+	return 0;
+}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.9.1

