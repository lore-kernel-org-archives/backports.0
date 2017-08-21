Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48910 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbdHUW2m (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/21] header: skbuff: add skb_put_zero(), skb_put_data() and skb_put_u8()
Date: Tue, 22 Aug 2017 00:27:59 +0200
Message-Id: <20170821222817.17376-4-hauke@hauke-m.de> (sfid-20170822_002844_227398_62E1A776)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions were added in kernel 4.13 and are used by many driver
now.

This was added in the following upsteram comits:
e45a79da863c19 ("skbuff/mac80211: introduce and use skb_put_zero()")
59ae1d127ac0ae ("networking: introduce and use skb_put_data()")
634fef61076d64 ("networking: add and use skb_put_u8()")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index dc957487..09894a96 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -315,4 +315,30 @@ __u32 skb_get_hash_perturb(const struct sk_buff *skb, u32 perturb)
 
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,13,0)
+static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
+{
+	void *tmp = skb_put(skb, len);
+
+	memset(tmp, 0, len);
+
+	return tmp;
+}
+
+static inline void *skb_put_data(struct sk_buff *skb, const void *data,
+				 unsigned int len)
+{
+	void *tmp = skb_put(skb, len);
+
+	memcpy(tmp, data, len);
+
+	return tmp;
+}
+
+static inline void skb_put_u8(struct sk_buff *skb, u8 val)
+{
+	*(u8 *)skb_put(skb, 1) = val;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
