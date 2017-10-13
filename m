Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49172 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757709AbdJMJmd (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:33 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 07/11] backports: add netdev_upper_dev_link() extack argument
Date: Fri, 13 Oct 2017 11:42:22 +0200
Message-Id: <20171013094226.10021-7-johannes@sipsolutions.net> (sfid-20171013_114235_507862_8A1C8AE8)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 9c912285368e..10d37b804b96 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -333,4 +333,9 @@ static inline void netif_trans_update(struct net_device *dev)
 	(_dev)->needs_free_netdev = true;
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,14,0)
+#define netdev_upper_dev_link(dev, upper, extack) \
+	netdev_upper_dev_link(dev, upper)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
