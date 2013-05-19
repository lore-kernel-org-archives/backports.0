Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59150 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3ESWVG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:21:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backport: do not add the vlan backports for kernel 3.10
Date: Mon, 20 May 2013 00:20:49 +0200
Message-Id: <1369002051-4002-2-git-send-email-hauke@hauke-m.de> (sfid-20130520_002110_213519_32DE8B08)
In-Reply-To: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
References: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The kernel 3.10 already includes the new versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This should also go into the 3.10 branch

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

