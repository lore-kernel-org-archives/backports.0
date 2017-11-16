Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:51824 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759158AbdKPOi6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 16 Nov 2017 09:38:58 -0500
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Subject: [PATCH 2/4] backport-include: backport skb_get_hash_perturb
Date: Thu, 16 Nov 2017 15:38:53 +0100
Message-Id: <20171116143855.12307-2-nbd@nbd.name> (sfid-20171116_153900_393259_55AD69CE)
In-Reply-To: <20171116143855.12307-1-nbd@nbd.name>
References: <20171116143855.12307-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/skbuff.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 61f3b98f..034206b6 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -306,14 +306,28 @@ static inline void skb_free_frag(void *data)
 	put_page(virt_to_head_page(data));
 }
 
-/* iwlwifi doesn't need this function, so it's safe to just return 0 */
-static inline
-__u32 skb_get_hash_perturb(const struct sk_buff *skb, u32 perturb)
+#if LINUX_VERSION_IS_LESS(3,3,0)
+
+static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
 {
 	return 0;
 }
 
-#endif
+#else
+#include <net/flow_keys.h>
+#include <linux/jhash.h>
+
+static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
+{
+	struct flow_keys keys;
+
+	skb_flow_dissect(skb, &keys);
+	return jhash_3words((__force u32)keys.dst,
+			    (__force u32)keys.src ^ keys.ip_proto,
+			    (__force u32)keys.ports, key);
+}
+#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
 #if LINUX_VERSION_IS_LESS(4,13,0)
 static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
