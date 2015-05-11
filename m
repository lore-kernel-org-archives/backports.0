Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49115 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbbEKVq6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:46:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/4] header: add possible_{write,read}_pnet() on kernel >= 4.1
Date: Mon, 11 May 2015 23:46:45 +0200
Message-Id: <1431380808-28885-1-git-send-email-hauke@hauke-m.de> (sfid-20150511_234700_661165_B7B38521)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

backports only adds the possible_{write,read}_pnet() functions for
kernel < 4.1. This results in a compile error on kernel 4.1. This patch
make it use the original functions on these kernel versions. This fixes
a problem introduced in 3d418885971.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/net/net_namespace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 90c044f..4d0b721 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -57,6 +57,9 @@ static inline struct net *possible_read_pnet(const possible_net_t *pnet)
 	return &init_net;
 #endif
 }
+#else
+#define possible_write_pnet(pnet, net) write_pnet(pnet, net)
+#define possible_read_pnet(pnet) read_pnet(pnet)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
 
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
-- 
2.1.4

