Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37683 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaKPUti (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/20] headers: add skb_copy_datagram_msg()
Date: Sun, 16 Nov 2014 21:49:03 +0100
Message-Id: <1416170960-12868-4-git-send-email-hauke@hauke-m.de> (sfid-20141116_214940_978399_2DD0810B)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used in some places.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index df0eb62..4cab6e1 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -256,4 +256,13 @@ static inline struct page *dev_alloc_page(void)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define skb_copy_datagram_msg LINUX_BACKPORT(skb_copy_datagram_msg)
+static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
+					struct msghdr *msg, int size)
+{
+	return skb_copy_datagram_iovec(from, offset, msg->msg_iov, size);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.9.1

