Return-path: <backports-owner@vger.kernel.org>
Received: from [192.19.211.62] ([192.19.211.62]:48746 "EHLO
        relay.smtp.broadcom.com" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S966902AbcKLUZg (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 12 Nov 2016 15:25:36 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/3] backports: add backport for nla_memdup()
Date: Sat, 12 Nov 2016 20:18:41 +0000
Message-Id: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161112_212539_916745_F427AF9B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

New helper function was introduced in netlink so a backport is needed.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/net/netlink.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 40160b5..b836a4b 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -189,4 +189,17 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
 }
 #endif /* < 4.4 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
+/**
+ * nla_memdup - duplicate attribute memory (kmemdup)
+ * @src: netlink attribute to duplicate from
+ * @gfp: GFP mask
+ */
+#define nla_memdump LINUX_BACKPORT(nla_memdup)
+static inline void *nla_memdup(const struct nlattr *src, gfp_t gfp)
+{
+	return kmemdup(nla_data(src), nla_len(src), gfp);
+}
+#endif /* < 4.9 */
+
 #endif /* __BACKPORT_NET_NETLINK_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
