Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:11004 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbA3XN5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 30 Jan 2015 18:13:57 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH V3] backport: add backport for get_net_ns_by_fd()
Date: Sat, 31 Jan 2015 00:13:52 +0100
Message-ID: <1422659632-8673-1-git-send-email-arend@broadcom.com> (sfid-20150131_001359_332403_A1083447)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In mac80211-next a call to get_net_ns_by_fd() has been added in cfg80211
which resides in networking core. This function has been backported
such that it will always fail, ie. as it would when CONFIG_NET_NS
is not defined. The call was added by:

   commit 4b681c82d2f9bef121c912ffcaac89a004af3f2c
   Author: Vadim Kochan <vadim4j@gmail.com>
   Date: Mon Jan 12 16:34:05 2015 +0200

     nl80211: Allow set network namespace by fd

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
This patch replaces the V2 commit which has
Message-ID: <1422651176-5433-1-git-send-email-arend@broadcom.com>

Changes:
 V2
  - solve backport using LINUX_BACKPORT macro (Johannes Berg)
 V3
  - make backport conditional for kernel before 3.20 (Hauke Mehrtens)
---
 backport/backport-include/net/net_namespace.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index e83b103..0ba7359 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -24,4 +24,15 @@ net_ieee802154_lowpan(struct net *net)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
 #endif /* CPTCFG_IEEE802154_6LOWPAN */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0)
+/*
+ * In older kernels we simply fail this function.
+ */
+#define get_net_ns_by_fd	LINUX_BACKPORT(get_net_ns_by_fd)
+static inline struct net *get_net_ns_by_fd(int fd)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
-- 
1.9.1

