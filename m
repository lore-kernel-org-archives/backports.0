Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41827 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbcEaOHo (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 31 May 2016 10:07:44 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add nla_put_u64_64bit()
Date: Tue, 31 May 2016 16:07:41 +0200
Message-Id: <1464703661-10164-1-git-send-email-johannes@sipsolutions.net> (sfid-20160531_160746_453586_EABC9ED6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Backport it simply using nla_put_u64(). This is fine for all the
current users, but probably should be fixed.

Change-Id: I0a48b90cdd081a7cba67ad592933ab266093c831
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 40160b57bc7a..570d440a9d2c 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -189,4 +189,13 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
 }
 #endif /* < 4.4 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
+#define nla_put_u64_64bit LINUX_BACKPORT(nla_put_u64_64bit)
+static inline int nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
+				    u64 value, int padattr)
+{
+	return nla_put_u64(skb, attrtype, value);
+}
+#endif /* < 4.7 */
+
 #endif /* __BACKPORT_NET_NETLINK_H */
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
