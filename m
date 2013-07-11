Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44143 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829Ab3GKWME (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/19] backport: do not add the vlan backports for kernel 3.10
Date: Fri, 12 Jul 2013 00:11:23 +0200
Message-Id: <1373580702-24752-2-git-send-email-hauke@hauke-m.de> (sfid-20130712_001209_127925_635FDAC8)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 3fc43d6f57044d0cf8003dc8bc30749931b6a727

The kernel 3.10 already includes the new versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/if_vlan.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index a5839e8..fea0acc 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_LINUX_IF_VLAN_H_
 #include_next <linux/if_vlan.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 #define vlan_insert_tag(__skb, __vlan_proto, __vlan_tci)	vlan_insert_tag(__skb, __vlan_tci)
 #define __vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		__vlan_put_tag(__skb, __vlan_tci)
 #define vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		vlan_put_tag(__skb, __vlan_tci)
@@ -14,5 +15,6 @@ static inline bool vlan_hw_offload_capable(netdev_features_t features,
 		return true;
 	return false;
 }
+#endif 
 
 #endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
-- 
1.7.10.4

