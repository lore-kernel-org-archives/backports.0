Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59530 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNzv (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:51 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:53 +0200
Message-Id: <20180218132459.11011-5-luca@coelho.fi> (sfid-20180218_145553_082409_396B04D4)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 04/10] backport: update genl_dump_check_consistent() backport
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The genl_dump_check_consistent() function was changed in v4.15 to use
only two arguments.  The family is not needed anymore, because we were
erroneously subtracting the header size and that was fixed in v4.15.

Since the family was only used to check the header size, we can create
a dummy with hdrsize = 0, which will allow us to call the old version
of the function.  There is a good side-effect to doing this: the bug
is going to be fixed, because with hdrsize = 0 we will not subtract
anything and it will have the same effect as the fix.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/net/genetlink.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index f620b99da280..dfbacbf40723 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -56,9 +56,25 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 #endif
 
 #if LINUX_VERSION_IS_LESS(3,1,0)
-#define genl_dump_check_consistent(cb, user_hdr, family)
+#define genl_dump_check_consistent(cb, user_hdr)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,15,0)
+#ifndef genl_dump_check_consistent
+static inline
+void backport_genl_dump_check_consistent(struct netlink_callback *cb,
+					 void *user_hdr)
+{
+	struct genl_family dummy_family = {
+		.hdrsize = 0,
+	};
+
+	genl_dump_check_consistent(cb, user_hdr, &dummy_family);
+}
+#define genl_dump_check_consistent LINUX_BACKPORT(genl_dump_check_consistent)
+#endif
+#endif /* LINUX_VERSION_IS_LESS(4,15,0) */
+
 #if LINUX_VERSION_IS_LESS(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 static inline int __real_genl_register_family(struct genl_family *family)
 {
@@ -139,10 +155,7 @@ extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
 	genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
 #define genlmsg_nlhdr(_hdr, _fam)					\
 	genlmsg_nlhdr(_hdr, &(_fam)->family)
-#ifndef genl_dump_check_consistent
-#define genl_dump_check_consistent(_cb, _hdr, _fam)			\
-	genl_dump_check_consistent(_cb, _hdr, &(_fam)->family)
-#endif
+
 #ifndef genlmsg_put_reply /* might already be there from _info override above */
 #define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
 	genlmsg_put_reply(_skb, _info, &(_fam)->family, _flags, _cmd)
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
