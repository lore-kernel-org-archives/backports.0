Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37694 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/20] backports: add genl_notify()
Date: Sun, 16 Nov 2014 21:49:13 +0100
Message-Id: <1416170960-12868-14-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_348461_96405E67)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by mac80211_hwsim.
The code was copied from kernel 3.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h |  5 +++++
 backport/compat/compat-3.3.c              | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index fc7eff4..0535b0f 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_NET_GENETLINK_H
 #define __BACKPORT_NET_GENETLINK_H
 #include_next <net/genetlink.h>
+#include <linux/version.h>
 
 /* this is for patches we apply */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
@@ -85,6 +86,10 @@ _genl_register_family_with_ops_grps(struct genl_family *family,
 #define genl_unregister_family backport_genl_unregister_family
 int genl_unregister_family(struct genl_family *family);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
+			u32 group, struct nlmsghdr *nlh, gfp_t flags);
+#endif
 #define genl_notify(_fam, _skb, _net, _portid, _group, _nlh, _flags)	\
 	genl_notify(_skb, _net, _portid, (_fam)->mcgrps[_group].id,	\
 		    _nlh, _flags)
diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
index 7ddc2bd..490c29b 100644
--- a/backport/compat/compat-3.3.c
+++ b/backport/compat/compat-3.3.c
@@ -224,3 +224,16 @@ void backport_destroy_workqueue(struct workqueue_struct *wq)
 	spin_unlock(&wq_name_lock);
 }
 EXPORT_SYMBOL_GPL(backport_destroy_workqueue);
+
+void genl_notify(struct sk_buff *skb, struct net *net, u32 pid, u32 group,
+		 struct nlmsghdr *nlh, gfp_t flags)
+{
+	struct sock *sk = net->genl_sock;
+	int report = 0;
+
+	if (nlh)
+		report = nlmsg_report(nlh);
+
+	nlmsg_notify(sk, skb, pid, group, report, flags);
+}
+EXPORT_SYMBOL_GPL(genl_notify);
-- 
1.9.1

