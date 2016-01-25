Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58603 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932395AbcAYOzE (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 Jan 2016 09:55:04 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: define NETIF_F_CSUM_MASK
Date: Mon, 25 Jan 2016 16:54:52 +0200
Message-Id: <1453733692-13338-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20160125_155508_500839_FA8E70DE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports:

commit a188222b6ed29404ac2d4232d35d1fe0e77af370
Author: Tom Herbert <tom@herbertland.com>
Date:   Mon Dec 14 11:19:43 2015 -0800

    net: Rename NETIF_F_ALL_CSUM to NETIF_F_CSUM_MASK

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 66405df..b9eb9c6 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -322,4 +322,8 @@ static inline void netif_tx_napi_add(struct net_device *dev,
 }
 #endif /* < 4.5 */
 
+#ifndef NETIF_F_CSUM_MASK
+#define NETIF_F_CSUM_MASK (NETIF_F_V4_CSUM | NETIF_F_V6_CSUM)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
