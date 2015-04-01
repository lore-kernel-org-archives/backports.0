Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59174 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbbDAPbq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Apr 2015 11:31:46 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] backports: backport netlink IP/IPv6 address accessors
Date: Wed,  1 Apr 2015 17:31:36 +0200
Message-Id: <1427902299-24079-2-git-send-email-johannes@sipsolutions.net> (sfid-20150401_173148_834404_66B0D88E)
In-Reply-To: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
References: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

These were introduced upstream in commits 67b61f6c130a
and 930345ea6304.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 9324d02d2c86..35d9260ff29b 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_NET_NETLINK_H
 #include_next <net/netlink.h>
 #include <linux/version.h>
+#include <linux/in6.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /**
@@ -137,4 +138,33 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 #define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
+static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
+				  __be32 addr)
+{
+	return nla_put_be32(skb, attrtype, addr);
+}
+
+#define nla_put_in6_addr LINUX_BACKPORT(nla_put_in6_addr)
+static inline int nla_put_in6_addr(struct sk_buff *skb, int attrtype,
+				   const struct in6_addr *addr)
+{
+	return nla_put(skb, attrtype, sizeof(*addr), addr);
+}
+
+static inline __be32 nla_get_in_addr(const struct nlattr *nla)
+{
+	return *(__be32 *) nla_data(nla);
+}
+
+static inline struct in6_addr nla_get_in6_addr(const struct nlattr *nla)
+{
+	struct in6_addr tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+	return tmp;
+}
+#endif /* < 4.1 */
+
 #endif /* __BACKPORT_NET_NETLINK_H */
-- 
2.1.4

