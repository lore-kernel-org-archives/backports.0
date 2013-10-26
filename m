Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47106 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab3JZKNV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Oct 2013 06:13:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] backports: add VLAN_PRIO_MASK and VLAN_PRIO_SHIFT
Date: Sat, 26 Oct 2013 12:13:06 +0200
Message-Id: <1382782389-4859-2-git-send-email-hauke@hauke-m.de> (sfid-20131026_121323_310509_A5E90A66)
In-Reply-To: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
References: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It should be safe to add them for older kernel versions, there these
values were hard coded in other places.

This was added in linux-2.6.33.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_vlan.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index fea0acc..2d996fa 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -17,4 +17,12 @@ static inline bool vlan_hw_offload_capable(netdev_features_t features,
 }
 #endif 
 
+#ifndef VLAN_PRIO_MASK
+#define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
+#endif
+
+#ifndef VLAN_PRIO_SHIFT
+#define VLAN_PRIO_SHIFT		13
+#endif
+
 #endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
-- 
1.7.10.4

