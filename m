Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52915 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbbKGQzW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:22 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] header: add nla_get_le32() and nla_get_le64()
Date: Sat,  7 Nov 2015 17:55:06 +0100
Message-Id: <1446915310-8278-7-git-send-email-hauke@hauke-m.de> (sfid-20151107_175526_445227_0BD5F757)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions were added in commit c648a0138 "netlink: add nla_get
for le32 and le64"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/netlink.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 35d9260..40160b5 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -167,4 +167,26 @@ static inline struct in6_addr nla_get_in6_addr(const struct nlattr *nla)
 }
 #endif /* < 4.1 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+/**
+ * nla_get_le32 - return payload of __le32 attribute
+ * @nla: __le32 netlink attribute
+ */
+#define nla_get_le32 LINUX_BACKPORT(nla_get_le32)
+static inline __le32 nla_get_le32(const struct nlattr *nla)
+{
+	return *(__le32 *) nla_data(nla);
+}
+
+/**
+ * nla_get_le64 - return payload of __le64 attribute
+ * @nla: __le64 netlink attribute
+ */
+#define nla_get_le64 LINUX_BACKPORT(nla_get_le64)
+static inline __le64 nla_get_le64(const struct nlattr *nla)
+{
+	return *(__le64 *) nla_data(nla);
+}
+#endif /* < 4.4 */
+
 #endif /* __BACKPORT_NET_NETLINK_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
