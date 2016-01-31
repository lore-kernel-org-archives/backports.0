Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:56579 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbcAaQbX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 31 Jan 2016 11:31:23 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Subject: [PATCH 1/2] backports: add skb_free_frag()
Date: Sun, 31 Jan 2016 17:11:35 +0100
Message-Id: <1454256696-98530-1-git-send-email-nbd@openwrt.org> (sfid-20160131_173125_852003_235E7AD0)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/skbuff.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 888d2a0..6fd4249 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -300,4 +300,11 @@ int skb_ensure_writable(struct sk_buff *skb, int write_len);
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+static inline void skb_free_frag(void *data)
+{
+	put_page(virt_to_head_page(data));
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
