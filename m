Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36118 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab3JWVhA (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: add eth_hw_addr_inherit()
Date: Wed, 23 Oct 2013 23:36:43 +0200
Message-Id: <1382564210-15230-2-git-send-email-hauke@hauke-m.de> (sfid-20131023_233706_788192_CB57DE6F)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/net/wireless/libertas/mesh.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 6aff244..bbdee10 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -135,4 +135,23 @@ extern int eth_validate_addr(struct net_device *dev);
 #define netdev_hw_addr dev_mc_list
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+/**
+ * eth_hw_addr_inherit - Copy dev_addr from another net_device
+ * @dst: pointer to net_device to copy dev_addr to
+ * @src: pointer to net_device to copy dev_addr from
+ *
+ * Copy the Ethernet address from one net_device to another along with
+ * the address attributes (addr_assign_type).
+ */
+static inline void eth_hw_addr_inherit(struct net_device *dst,
+				       struct net_device *src)
+{
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
+	dst->addr_assign_type = src->addr_assign_type;
+#endif
+	memcpy(dst->dev_addr, src->dev_addr, ETH_ALEN);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
1.7.10.4

