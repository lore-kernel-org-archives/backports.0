Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8701 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbaIBH2A (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 2 Sep 2014 03:28:00 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backport: add support for kernel 3.17
Date: Tue,  2 Sep 2014 10:24:04 +0300
Message-Id: <1409642644-13313-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140902_092802_287731_7D218781)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

backport upstream's

commit c835a677331495cf137a7f8a023463afd9f032f8
Author: Tom Gundersen <teg@jklm.no>
Date:   Mon Jul 14 16:37:24 2014 +0200

    net: set name_assign_type in alloc_netdev()

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/netdevice.h | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 6979758..1935f78 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -157,4 +157,36 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+
+/* interface name assignment types (sysfs name_assign_type attribute) */
+#define NET_NAME_UNKNOWN	0	/* unknown origin (not exposed to userspace) */
+#define NET_NAME_ENUM		1	/* enumerated by kernel */
+#define NET_NAME_PREDICTABLE	2	/* predictably named by the kernel */
+#define NET_NAME_USER		3	/* provided by user-space */
+#define NET_NAME_RENAMED	4	/* renamed by user-space */
+
+static inline struct net_device *
+backport_alloc_netdev_mqs(int sizeof_priv, const char *name,
+			  unsigned char name_assign_type,
+			  void (*setup)(struct net_device *),
+			  unsigned int txqs, unsigned int rxqs)
+{
+	return alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs);
+}
+
+#define alloc_netdev_mqs LINUX_BACKPORT(alloc_netdev_mqs)
+
+#undef alloc_netdev
+static inline struct net_device *
+backport_alloc_netdev(int sizeof_priv, const char *name,
+		      unsigned char name_assign_type,
+		      void (*setup)(struct net_device *))
+{
+	return backport_alloc_netdev_mqs(sizeof_priv, name, name_assign_type,
+					 setup, 1, 1);
+}
+#define alloc_netdev LINUX_BACKPORT(alloc_netdev)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

