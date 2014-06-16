Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52123 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbaFPWcT (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Jun 2014 18:32:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 7CE217E57
	for <backports@vger.kernel.org>; Tue, 17 Jun 2014 00:32:17 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add __pskb_copy_fclone()
Date: Tue, 17 Jun 2014 00:31:55 +0200
Message-Id: <1402957919-31374-2-git-send-email-hauke@hauke-m.de> (sfid-20140617_003236_291873_B0D3E7AB)
In-Reply-To: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
References: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

__pskb_copy() was renamed to __pskb_copy_fclone() in most places and
got an extra parameter, it should be safe to just ignore this extra
parameter.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2576faf..a707663 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -373,4 +373,14 @@ skb_set_hash(struct sk_buff *skb, __u32 hash, enum pkt_hash_types type)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#define __pskb_copy_fclone LINUX_BACKPORT(__pskb_copy_fclone)
+static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
+						 int headroom, gfp_t gfp_mask,
+						 bool fclone)
+{
+	return __pskb_copy(skb, headroom, gfp_mask);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.9.1

