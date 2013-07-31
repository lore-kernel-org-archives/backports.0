Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:51461 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759134Ab3GaIjX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 31 Jul 2013 04:39:23 -0400
Message-ID: <51F8CD36.8070602@fh-kl.de> (sfid-20130731_103925_370943_F7DB41FE)
Date: Wed, 31 Jul 2013 10:39:18 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v2 2/8] backports: add eth_prepare_mac_addr_change() and eth_commit_mac_addr_change()
References: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions are required by qmi_wwan device driver.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/etherdevice.h |  7 ++++++
 backport/backport-include/linux/if.h          |  4 ++++
 backport/compat/compat-3.9.c                  | 33 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 5c82fc4..b6617f0 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -114,6 +114,13 @@ static inline int is_unicast_ether_addr(const u8 *addr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define eth_prepare_mac_addr_change LINUX_BACKPORT(eth_prepare_mac_addr_change)
+extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
+#define eth_commit_mac_addr_change LINUX_BACKPORT(eth_commit_mac_addr_change)
+extern void eth_commit_mac_addr_change(struct net_device *dev, void *p);
+#endif /* < 3.9 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
 #define eth_mac_addr LINUX_BACKPORT(eth_mac_addr)
 extern int eth_mac_addr(struct net_device *dev, void *p);
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index 7926082..8f85b83 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -29,4 +29,8 @@
 #define IFF_TX_SKB_SHARING	0x10000
 #endif
 
+#ifndef IFF_LIVE_ADDR_CHANGE
+#define IFF_LIVE_ADDR_CHANGE 0x100000
+#endif
+
 #endif	/* _BACKPORT_LINUX_IF_H */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 03f3af8..1ce2dad 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -12,6 +12,9 @@
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/netdevice.h>
+#include <linux/if.h>
+#include <linux/if_ether.h>
 
 #ifdef __sg_page_iter_next
 
@@ -64,4 +67,34 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(devm_ioremap_resource);
 
+/**
+ * eth_prepare_mac_addr_change - prepare for mac change
+ * @dev: network device
+ * @p: socket address
+ */
+int eth_prepare_mac_addr_change(struct net_device *dev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	if (!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev))
+		return -EBUSY;
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	return 0;
+}
+EXPORT_SYMBOL(eth_prepare_mac_addr_change);
+
+/**
+ * eth_commit_mac_addr_change - commit mac change
+ * @dev: network device
+ * @p: socket address
+ */
+void eth_commit_mac_addr_change(struct net_device *dev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+}
+EXPORT_SYMBOL(eth_commit_mac_addr_change);
+
 #endif /* __sg_page_iter_next */
-- 
1.8.1.2



-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
