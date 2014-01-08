Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbaAHKoo (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:44:44 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 06/11] backports: igb fixes for linux-3.5
Date: Wed,  8 Jan 2014 11:44:09 +0100
Message-Id: <1389177854-24292-7-git-send-email-sassmann@kpanic.de> (sfid-20140108_114446_331967_9119384D)
In-Reply-To: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add EEE defines
- add struct ethtool_eee
- backport __skb_alloc_page and __skb_alloc_pages
- add patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h          | 31 +++++++++++++++
 backport/backport-include/linux/gfp.h              | 10 +++++
 backport/backport-include/linux/mdio.h             | 23 ++++++++++-
 backport/backport-include/linux/skbuff.h           | 46 ++++++++++++++++++++++
 .../network/82-ethernet/0006-igb_eee.patch         | 31 +++++++++++++++
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 backport/backport-include/linux/gfp.h
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 647fbf6..4f13cb9 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -42,4 +42,35 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
 }
 #endif
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+/**
+ * struct ethtool_eee - Energy Efficient Ethernet information
+ * @cmd: ETHTOOL_{G,S}EEE
+ * @supported: Mask of %SUPPORTED_* flags for the speed/duplex combinations
+ *	for which there is EEE support.
+ * @advertised: Mask of %ADVERTISED_* flags for the speed/duplex combinations
+ *	advertised as eee capable.
+ * @lp_advertised: Mask of %ADVERTISED_* flags for the speed/duplex
+ *	combinations advertised by the link partner as eee capable.
+ * @eee_active: Result of the eee auto negotiation.
+ * @eee_enabled: EEE configured mode (enabled/disabled).
+ * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
+ *	that eee was negotiated.
+ * @tx_lpi_timer: Time in microseconds the interface delays prior to asserting
+ *	its tx lpi (after reaching 'idle' state). Effective only when eee
+ *	was negotiated and tx_lpi_enabled was set.
+ */
+struct ethtool_eee {
+	__u32	cmd;
+	__u32	supported;
+	__u32	advertised;
+	__u32	lp_advertised;
+	__u32	eee_active;
+	__u32	eee_enabled;
+	__u32	tx_lpi_enabled;
+	__u32	tx_lpi_timer;
+	__u32	reserved[2];
+};
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+
 #endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
new file mode 100644
index 0000000..2962290
--- /dev/null
+++ b/backport/backport-include/linux/gfp.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_GFP_H
+#define __BACKPORT_LINUX_GFP_H
+#include_next <linux/gfp.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
+#define ___GFP_MEMALLOC		0x2000u
+#define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)/* Allow access to emergency reserves */
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)) */
+
+#endif /* __BACKPORT_LINUX_GFP_H */
diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
index 2a38121..838958a 100644
--- a/backport/backport-include/linux/mdio.h
+++ b/backport/backport-include/linux/mdio.h
@@ -2,6 +2,28 @@
 #define __BACKPORT_LINUX_MDIO_H
 #include_next <linux/mdio.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+/* EEE Supported/Advertisement/LP Advertisement registers.
+ *
+ * EEE capability Register (3.20), Advertisement (7.60) and
+ * Link partner ability (7.61) registers have and can use the same identical
+ * bit masks.
+ */
+#define MDIO_AN_EEE_ADV_100TX	0x0002	/* Advertise 100TX EEE cap */
+#define MDIO_AN_EEE_ADV_1000T	0x0004	/* Advertise 1000T EEE cap */
+/* Note: the two defines above can be potentially used by the user-land
+ * and cannot remove them now.
+ * So, we define the new generic MDIO_EEE_100TX and MDIO_EEE_1000T macros
+ * using the previous ones (that can be considered obsolete).
+ */
+#define MDIO_EEE_100TX		MDIO_AN_EEE_ADV_100TX	/* 100TX EEE cap */
+#define MDIO_EEE_1000T		MDIO_AN_EEE_ADV_1000T	/* 1000T EEE cap */
+#define MDIO_EEE_10GT		0x0008	/* 10GT EEE cap */
+#define MDIO_EEE_1000KX		0x0010	/* 1000KX EEE cap */
+#define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
+#define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /**
  * mmd_eee_adv_to_ethtool_adv_t
@@ -31,5 +53,4 @@ static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
 	return adv;
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
-
 #endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 7d04b54..c1b2753 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -224,6 +224,52 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 		     skb = skb->next)
 #endif /* < 2.6.28 */
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+/**
+ *	__skb_alloc_pages - allocate pages for ps-rx on a skb and preserve pfmemalloc data
+ *	@gfp_mask: alloc_pages_node mask. Set __GFP_NOMEMALLOC if not for network packet RX
+ *	@skb: skb to set pfmemalloc on if __GFP_MEMALLOC is used
+ *	@order: size of the allocation
+ *
+ * 	Allocate a new page.
+ *
+ * 	%NULL is returned if there is no free memory.
+*/
+static inline struct page *__skb_alloc_pages(gfp_t gfp_mask,
+					      struct sk_buff *skb,
+					      unsigned int order)
+{
+	struct page *page;
+
+	gfp_mask |= __GFP_COLD;
+#if 0
+	if (!(gfp_mask & __GFP_NOMEMALLOC))
+		gfp_mask |= __GFP_MEMALLOC;
+#endif
+	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
+#if 0
+	if (skb && page && page->pfmemalloc)
+		skb->pfmemalloc = true;
+#endif
+	return page;
+}
+
+/**
+ *	__skb_alloc_page - allocate a page for ps-rx for a given skb and preserve pfmemalloc data
+ *	@gfp_mask: alloc_pages_node mask. Set __GFP_NOMEMALLOC if not for network packet RX
+ *	@skb: skb to set pfmemalloc on if __GFP_MEMALLOC is used
+ *
+ * 	Allocate a new page.
+ *
+ * 	%NULL is returned if there is no free memory.
+ */
+static inline struct page *__skb_alloc_page(gfp_t gfp_mask,
+					     struct sk_buff *skb)
+{
+	return __skb_alloc_pages(gfp_mask, skb, 0);
+}
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #ifndef NETDEV_FRAG_PAGE_MAX_ORDER
 #define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
diff --git a/patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch b/patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch
new file mode 100644
index 0000000..f9927bf
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch
@@ -0,0 +1,31 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 9b15820..9767f11 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2585,6 +2585,7 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+@@ -2713,6 +2714,7 @@ static int igb_set_eee(struct net_device *netdev,
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ 
+ static int igb_get_module_info(struct net_device *netdev,
+ 			       struct ethtool_modinfo *modinfo)
+@@ -3001,8 +3003,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_ts_info		= igb_get_ts_info,
+ 	.get_rxnfc		= igb_get_rxnfc,
+ 	.set_rxnfc		= igb_set_rxnfc,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.get_eee		= igb_get_eee,
+ 	.set_eee		= igb_set_eee,
++#endif
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
-- 
1.8.4.2

