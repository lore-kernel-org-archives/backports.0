Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36778 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbbJWHXK (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Oct 2015 03:23:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: handle "genetlink: simplify genl_notify"
Date: Fri, 23 Oct 2015 09:22:56 +0200
Message-Id: <1445584976-11197-1-git-send-email-johannes@sipsolutions.net> (sfid-20151023_092321_981801_0881B0DB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Handle the recent genl_notify() prototype change.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/genetlink.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 5761268f05d9..6c6d3e4692ef 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -90,9 +90,10 @@ int genl_unregister_family(struct genl_family *family);
 extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
 			u32 group, struct nlmsghdr *nlh, gfp_t flags);
 #endif
-#define genl_notify(_fam, _skb, _net, _portid, _group, _nlh, _flags)	\
-	genl_notify(_skb, _net, _portid, (_fam)->mcgrps[_group].id,	\
-		    _nlh, _flags)
+#define genl_notify(_fam, _skb, _info, _group, _flags)			\
+	genl_notify(_skb, genl_info_net(_info),				\
+		    genl_info_snd_portid(_info),			\
+		    (_fam)->mcgrps[_group].id, _info->nlhdr, _flags)
 #define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd)		\
 	genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
 #define genlmsg_nlhdr(_hdr, _fam)					\
@@ -145,6 +146,10 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #define __genl_const
 #else /* < 3.13 */
 #define __genl_const const
+#define genl_notify(_fam, _skb, _info, _group, _flags)			\
+	genl_notify(_fam, _skb, genl_info_net(_info),			\
+		    genl_info_snd_portid(_info),			\
+		    _group, _info->nlhdr, _flags)
 #endif /* < 3.13 */
 
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
