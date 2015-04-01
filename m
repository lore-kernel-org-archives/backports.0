Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59176 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbbDAPbq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Apr 2015 11:31:46 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] backports: backport NET_NAME_* definitions
Date: Wed,  1 Apr 2015 17:31:37 +0200
Message-Id: <1427902299-24079-3-git-send-email-johannes@sipsolutions.net> (sfid-20150401_173150_008530_1F542182)
In-Reply-To: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
References: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

These were added upstream a long time ago in commit 685343fc3ba61,
but not needed until implemented in the wireless stack recently.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 27bce84c468a..abbfe1d43b7e 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -163,6 +163,22 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#ifndef NET_NAME_UNKNOWN
+#define NET_NAME_UNKNOWN	0
+#endif
+#ifndef NET_NAME_ENUM
+#define NET_NAME_ENUM		1
+#endif
+#ifndef NET_NAME_PREDICTABLE
+#define NET_NAME_PREDICTABLE	2
+#endif
+#ifndef NET_NAME_USER
+#define NET_NAME_USER		3
+#endif
+#ifndef NET_NAME_RENAMED
+#define NET_NAME_RENAMED	4
+#endif
+
 #define alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, txqs, rxqs) \
 	alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs)
 
-- 
2.1.4

