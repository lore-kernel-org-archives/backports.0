Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37196 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3DKXnD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:03 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC/WIP 09/24] backports: move eth_hw_addr_random
Date: Fri, 12 Apr 2013 01:42:36 +0200
Message-Id: <1365723771-10660-10-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014308_661681_068CDE9E)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Hauke Mehrtens <hauke@hauke-m.de>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.4.h  | 43 ---------------------------
 backport/backport-include/linux/etherdevice.h | 40 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 43 deletions(-)
 create mode 100644 backport/backport-include/linux/etherdevice.h

diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
index 51c058e..1faa5b9 100644
--- a/backport/backport-include/linux/compat-3.4.h
+++ b/backport/backport-include/linux/compat-3.4.h
@@ -102,49 +102,6 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 extern const struct i2c_algorithm i2c_bit_algo;
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12))
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-#error eth_hw_addr_random() needs to be implemented for < 2.6.12
-}
-#else  /* kernels >= 2.6.12 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	get_random_bytes(dev->dev_addr, ETH_ALEN);
-	dev->dev_addr[0] &= 0xfe;       /* clear multicast bit */
-	dev->dev_addr[0] |= 0x02;       /* set local assignment bit (IEEE802) */
-}
-#else /* kernels >= 2.6.31 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-/* So this is 2.6.31..2.6.35 */
-
-/* Just have the flags present, they won't really mean anything though */
-#define NET_ADDR_PERM          0       /* address is permanent (default) */
-#define NET_ADDR_RANDOM                1       /* address is generated randomly */
-#define NET_ADDR_STOLEN                2       /* address is stolen from other device */
-
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
-
-#else /* 2.6.36 and on */
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	dev_hw_addr_random(dev, dev->dev_addr);
-}
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)) */
-
 /*
  * Getting something that works in C and CPP for an arg that may or may
  * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
new file mode 100644
index 0000000..9f31ab2
--- /dev/null
+++ b/backport/backport-include/linux/etherdevice.h
@@ -0,0 +1,40 @@
+#ifndef _BACKPORT_LINUX_ETHERDEVICE_H
+#define _BACKPORT_LINUX_ETHERDEVICE_H
+
+#include_next <linux/etherdevice.h>
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12))
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+#error eth_hw_addr_random() needs to be implemented for < 2.6.12
+}
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	get_random_bytes(dev->dev_addr, ETH_ALEN);
+	dev->dev_addr[0] &= 0xfe;       /* clear multicast bit */
+	dev->dev_addr[0] |= 0x02;       /* set local assignment bit (IEEE802) */
+}
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
+/* So this is 2.6.31..2.6.35 */
+
+/* Just have the flags present, they won't really mean anything though */
+#define NET_ADDR_PERM		0	/* address is permanent (default) */
+#define NET_ADDR_RANDOM		1	/* address is generated randomly */
+#define NET_ADDR_STOLEN		2	/* address is stolen from other device */
+
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	random_ether_addr(dev->dev_addr);
+}
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	dev_hw_addr_random(dev, dev->dev_addr);
+}
+#endif
+
+#endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.8.0

