Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48291 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab3KXVYD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:03 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/15] backports: remove vlan_hw_offload_capable()
Date: Sun, 24 Nov 2013 22:23:12 +0100
Message-Id: <1385328198-28520-10-git-send-email-hauke@hauke-m.de> (sfid-20131124_222404_325302_6A3FBE8D)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

vlan_hw_offload_capable() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_vlan.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index e2d77ef..6fae150 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -10,13 +10,6 @@
 
 #define __vlan_find_dev_deep(__real_dev, __vlan_proto, __vlan_id) __vlan_find_dev_deep(__real_dev, __vlan_id) 
 
-static inline bool vlan_hw_offload_capable(netdev_features_t features,
-					   __be16 proto)
-{
-	if (proto == htons(ETH_P_8021Q) && features & NETIF_F_HW_VLAN_CTAG_TX)
-		return true;
-	return false;
-}
 #endif 
 
 #ifndef VLAN_PRIO_MASK
-- 
1.7.10.4

