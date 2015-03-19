Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:44941 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbCSN6y (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 19 Mar 2015 09:58:54 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backport-include: map possible_net_t to struct net *
Date: Thu, 19 Mar 2015 14:58:50 +0100
Message-ID: <1426773530-21723-1-git-send-email-arend@broadcom.com> (sfid-20150319_145900_526307_6F546B4E)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

commit 0c5c9fb55106 (net: Introduce possible_net_t) changed
use of write_pnet and read_pnet. This patch will map possible_net_t
back to struct net * to use old api.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/backport-include/net/net_namespace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 8927af7..085bce7 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -30,4 +30,8 @@ static inline struct net *get_net_ns_by_fd(int fd)
 	return ERR_PTR(-EINVAL);
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#define possible_net_t struct net *
+#endif
+
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
-- 
1.9.1

