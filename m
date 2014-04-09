Return-path: <backports-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4436 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932592AbaDIMGK (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Apr 2014 08:06:10 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: add napi_gro_flush()
Date: Wed,  9 Apr 2014 15:03:27 +0300
Message-Id: <1397045007-22505-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140409_140613_083203_17ACA130)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

napi_gro_flush() got a second argument in kernel 3.7, but it
can be ignored for prior kernel versions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/netdevice.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f99ea02..26640eb 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -481,6 +481,7 @@ struct net *dev_net(const struct net_device *dev)
 #define netdev_notify_peers(dev)
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define netdev_notify_peers(dev) netif_notify_peers(dev)
+#define napi_gro_flush(napi, old) napi_gro_flush(napi)
 #endif
 
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.8.3.2

