Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55842 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab3KGU2Y (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:24 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] backports: fix signature of __vlan_find_dev_deep()
Date: Thu,  7 Nov 2013 21:27:53 +0100
Message-Id: <1383856078-19823-7-git-send-email-hauke@hauke-m.de> (sfid-20131107_212836_068161_9D277011)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

__vlan_find_dev_deep() got an extra parameter in recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_vlan.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index 2d996fa..e2d77ef 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -8,6 +8,8 @@
 #define vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		vlan_put_tag(__skb, __vlan_tci)
 #define __vlan_hwaccel_put_tag(__skb, __vlan_proto, __vlan_tag)	__vlan_hwaccel_put_tag(__skb, __vlan_tag)
 
+#define __vlan_find_dev_deep(__real_dev, __vlan_proto, __vlan_id) __vlan_find_dev_deep(__real_dev, __vlan_id) 
+
 static inline bool vlan_hw_offload_capable(netdev_features_t features,
 					   __be16 proto)
 {
-- 
1.7.10.4

