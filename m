Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37218 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3DKXnq (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:46 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 20/24] backports: move netdev_attach_ops/ndo_do_ioctl
Date: Fri, 12 Apr 2013 01:42:47 +0200
Message-Id: <1365723771-10660-21-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014408_125128_369747A7)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.29.h | 31 ------------------------
 backport/backport-include/linux/netdevice.h     | 32 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/backport/backport-include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
index 41f8233..3104a23 100644
--- a/backport/backport-include/linux/compat-2.6.29.h
+++ b/backport/backport-include/linux/compat-2.6.29.h
@@ -236,20 +236,6 @@ struct net_device_ops {
 #endif
 };
 
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->do_ioctl)
-		return dev->do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-
-
-#define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
-void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops);
-
 /**
  *	skb_queue_is_first - check if skb is the first entry in the queue
  *	@list: queue head
@@ -340,23 +326,6 @@ extern int		init_dummy_netdev(struct net_device *dev);
 
 /* Kernels >= 2.6.29 follows */
 
-/* XXX: this can probably just go upstream ! */
-static inline void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops)
-{
-	dev->netdev_ops = ops;
-}
-
-/* XXX: this can probably just go upstream! */
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->netdev_ops && dev->netdev_ops->ndo_do_ioctl)
-		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)) */
 
 #define  PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 5922f81..2ec1497 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -10,4 +10,36 @@ extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_
 extern void __dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
+void netdev_attach_ops(struct net_device *dev,
+		       const struct net_device_ops *ops);
+
+static inline int ndo_do_ioctl(struct net_device *dev,
+			       struct ifreq *ifr,
+			       int cmd)
+{
+	if (dev->do_ioctl)
+		return dev->do_ioctl(dev, ifr, cmd);
+	return -EOPNOTSUPP;
+}
+#else
+/* XXX: this can probably just go upstream ! */
+static inline void netdev_attach_ops(struct net_device *dev,
+		       const struct net_device_ops *ops)
+{
+	dev->netdev_ops = ops;
+}
+
+/* XXX: this can probably just go upstream! */
+static inline int ndo_do_ioctl(struct net_device *dev,
+			       struct ifreq *ifr,
+			       int cmd)
+{
+	if (dev->netdev_ops && dev->netdev_ops->ndo_do_ioctl)
+		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.8.0

