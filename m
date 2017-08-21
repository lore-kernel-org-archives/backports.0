Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42922 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754035AbdHUW2m (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/21] header: skbuff: fix signature of skb_put(), skb_push() and ()
Date: Tue, 22 Aug 2017 00:28:00 +0200
Message-Id: <20170821222817.17376-5-hauke@hauke-m.de> (sfid-20170822_002844_662042_580D0523)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In older kernel versions these functions returned a unsigned char*, now
they return a void *.

This change was done in upstream commit d58ff35122847a8 ("networking:
make skb_push & __skb_push return void pointers")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 09894a96..61f3b98f 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -316,6 +316,24 @@ __u32 skb_get_hash_perturb(const struct sk_buff *skb, u32 perturb)
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,13,0)
+static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
+{
+	return skb_put(skb, len);
+}
+#define skb_put LINUX_BACKPORT(skb_put)
+
+static inline void *backport_skb_push(struct sk_buff *skb, unsigned int len)
+{
+	return skb_push(skb, len);
+}
+#define skb_push LINUX_BACKPORT(skb_push)
+
+static inline void *backport___skb_push(struct sk_buff *skb, unsigned int len)
+{
+	return __skb_push(skb, len);
+}
+#define __skb_push LINUX_BACKPORT(__skb_push)
+
 static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
 {
 	void *tmp = skb_put(skb, len);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
