Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37205 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3DKXnH (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:07 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 10/24] backports: move kernel 3.3 SKB functions
Date: Fri, 12 Apr 2013 01:42:37 +0200
Message-Id: <1365723771-10660-11-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014353_372929_C1F91B0E)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.3.h |  8 --------
 backport/backport-include/linux/skbuff.h     | 11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/backport/backport-include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
index ce7e776..72686da 100644
--- a/backport/backport-include/linux/compat-3.3.h
+++ b/backport/backport-include/linux/compat-3.3.h
@@ -305,14 +305,6 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 #endif
 #endif
 
-#define __pskb_copy LINUX_BACKPORT(__pskb_copy)
-extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
-				   int headroom, gfp_t gfp_mask);
-
-static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
-{
-	WARN_ON(1);
-}
 #define NL80211_FEATURE_SK_TX_STATUS 0
 
 typedef u32 netdev_features_t;
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 0c09f9b..0a2e4cf 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -13,4 +13,15 @@ extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
 	skb_add_rx_frag(skb, i, page, off, size)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#define __pskb_copy LINUX_BACKPORT(__pskb_copy)
+extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
+				   int headroom, gfp_t gfp_mask);
+
+static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
+{
+	WARN_ON(1);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.0

