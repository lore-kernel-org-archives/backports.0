Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36592 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbaLURgl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 02/16] header: add memcpy_from_msg()
Date: Sun, 21 Dec 2014 18:36:16 +0100
Message-Id: <1419183390-22169-3-git-send-email-hauke@hauke-m.de> (sfid-20141221_183645_375721_9A627E5B)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in kernel 3.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 4cab6e1..53c1aa4 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -263,6 +263,12 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 {
 	return skb_copy_datagram_iovec(from, offset, msg->msg_iov, size);
 }
+
+#define memcpy_from_msg LINUX_BACKPORT(memcpy_from_msg)
+static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
+{
+	return memcpy_fromiovec(data, msg->msg_iov, len);
+}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.9.1

