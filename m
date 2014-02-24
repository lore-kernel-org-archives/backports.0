Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35040 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbaBXArG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:47:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id BD1E07E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:47:05 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/12] backports: add NLA_S{9,16,32,64}
Date: Mon, 24 Feb 2014 01:45:52 +0100
Message-Id: <1393202754-12919-11-git-send-email-hauke@hauke-m.de> (sfid-20140224_014708_683005_22455CFA)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by net/ieee802154/nl_policy.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/netlink.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 3cf6231..4f8308a 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -130,4 +130,15 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 }
 #endif /* < 3.5 */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#define NLA_S8 (NLA_BINARY + 1)
+#define NLA_S16 (NLA_BINARY + 2)
+#define NLA_S32 (NLA_BINARY + 3)
+#define NLA_S64 (NLA_BINARY + 4)
+#define __NLA_TYPE_MAX (NLA_BINARY + 5)
+
+#undef NLA_TYPE_MAX
+#define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
+#endif
+
 #endif /* __BACKPORT_NET_NETLINK_H */
-- 
1.7.10.4

