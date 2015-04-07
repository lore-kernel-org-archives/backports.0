Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37593 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbbDGImY (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Apr 2015 04:42:24 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: deal better with possible_net_t
Date: Tue,  7 Apr 2015 10:42:18 +0200
Message-Id: <1428396138-11310-1-git-send-email-johannes@sipsolutions.net> (sfid-20150407_104227_350617_61D48723)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Instead of just assuming CONFIG_NET_NS is defined, deal with
this better. Sadly, it needs a header file patch (as an spatch
doesn't deal properly with header files.)

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/net_namespace.h      | 22 +++++++++++++++++++++-
 .../network/0053-possible_net_t.patch              | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 patches/collateral-evolutions/network/0053-possible_net_t.patch

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index b9f8b2ba7dba..90c044f1ba31 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -36,7 +36,27 @@ static inline struct net *get_net_ns_by_fd(int fd)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
-#define possible_net_t struct net *
+typedef struct {
+#ifdef CONFIG_NET_NS
+	struct net *net;
 #endif
+} possible_net_t;
+
+static inline void possible_write_pnet(possible_net_t *pnet, struct net *net)
+{
+#ifdef CONFIG_NET_NS
+	pnet->net = net;
+#endif
+}
+
+static inline struct net *possible_read_pnet(const possible_net_t *pnet)
+{
+#ifdef CONFIG_NET_NS
+	return pnet->net;
+#else
+	return &init_net;
+#endif
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
 
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
new file mode 100644
index 000000000000..c2217b5b9d42
--- /dev/null
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -0,0 +1,19 @@
+diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
+index 04e5785..a251da1 100644
+--- a/include/net/cfg80211.h
++++ b/include/net/cfg80211.h
+@@ -3239,12 +3239,12 @@ struct wiphy {
+ 
+ static inline struct net *wiphy_net(struct wiphy *wiphy)
+ {
+-	return read_pnet(&wiphy->_net);
++	return possible_read_pnet(&wiphy->_net);
+ }
+ 
+ static inline void wiphy_net_set(struct wiphy *wiphy, struct net *net)
+ {
+-	write_pnet(&wiphy->_net, net);
++	possible_write_pnet(&wiphy->_net, net);
+ }
+ 
+ /**
-- 
2.1.4

