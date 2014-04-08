Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38261 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDcn (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so400235pab.27
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Tom Herbert <therbert@google.com>
Subject: [PATCH 03/12] backports: backport skb_set_hash()
Date: Mon,  7 Apr 2014 20:32:14 -0700
Message-Id: <1396927943-25589-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053254_371349_79761EFD)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports skb_set_hash(). Two skb data structures are used
introduced at different points in time, so ifdef around that as well.
For older kernels this is a nop.

mcgrof@ergon ~/linux (git::master)$ git describe --contains bdeab99191
v3.2-rc1~129^2~458
mcgrof@ergon ~/linux (git::master)$ git describe --contains 4031ae6edb
v3.4-rc1~177^2~333^2
mcgrof@ergon ~/linux (git::master)$ git describe --contains 09323cc479
v3.14-rc1~94^2~474^2~1

Cc: Tom Herbert <therbert@google.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/skbuff.h | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index a7eca13..bc67f45 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -470,4 +470,50 @@ static inline void skb_frag_set_page(struct sk_buff *skb, int f,
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+/*
+ * Packet hash types specify the type of hash in skb_set_hash.
+ *
+ * Hash types refer to the protocol layer addresses which are used to
+ * construct a packet's hash. The hashes are used to differentiate or identify
+ * flows of the protocol layer for the hash type. Hash types are either
+ * layer-2 (L2), layer-3 (L3), or layer-4 (L4).
+ *
+ * Properties of hashes:
+ *
+ * 1) Two packets in different flows have different hash values
+ * 2) Two packets in the same flow should have the same hash value
+ *
+ * A hash at a higher layer is considered to be more specific. A driver should
+ * set the most specific hash possible.
+ *
+ * A driver cannot indicate a more specific hash than the layer at which a hash
+ * was computed. For instance an L3 hash cannot be set as an L4 hash.
+ *
+ * A driver may indicate a hash level which is less specific than the
+ * actual layer the hash was computed on. For instance, a hash computed
+ * at L4 may be considered an L3 hash. This should only be done if the
+ * driver can't unambiguously determine that the HW computed the hash at
+ * the higher layer. Note that the "should" in the second property above
+ * permits this.
+ */
+enum pkt_hash_types {
+	PKT_HASH_TYPE_NONE,	/* Undefined type */
+	PKT_HASH_TYPE_L2,	/* Input: src_MAC, dest_MAC */
+	PKT_HASH_TYPE_L3,	/* Input: src_IP, dst_IP */
+	PKT_HASH_TYPE_L4,	/* Input: src_IP, dst_IP, src_port, dst_port */
+};
+
+static inline void
+skb_set_hash(struct sk_buff *skb, __u32 hash, enum pkt_hash_types type)
+{
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) /* 4031ae6edb */
+	skb->l4_rxhash = (type == PKT_HASH_TYPE_L4);
+#endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) /* bdeab99191 */
+	skb->rxhash = hash;
+#endif
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.5.3

