Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60036 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab3LLJ3I (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:08 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 06/10] backports: igb fixes for linux-3.5
Date: Thu, 12 Dec 2013 10:27:58 +0100
Message-Id: <1386840482-585-7-git-send-email-sassmann@kpanic.de> (sfid-20131212_102910_775166_B0A42617)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add EEE defines
- add struct ethtool_eee
- backport __skb_alloc_page and __skb_alloc_pages

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h | 32 +++++++++++++++++++++
 backport/backport-include/linux/gfp.h     | 10 +++++++
 backport/backport-include/linux/mdio.h    | 23 +++++++++++++++-
 backport/backport-include/linux/skbuff.h  | 46 +++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 backport/backport-include/linux/gfp.h

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index ccbec11..e375ee9 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -42,6 +42,37 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
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
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define ETH_TP_MDI_AUTO		0x03 /*                  control: auto-select */
 
@@ -86,6 +117,7 @@ static inline __u32 backport_ethtool_cmd_speed(const struct ethtool_cmd *ep)
 }
 #define ethtool_cmd_speed LINUX_BACKPORT(ethtool_cmd_speed)
 
+struct ethtool_eee;
 struct backport_ethtool_ops {
 	int	(*get_settings)(struct net_device *, struct ethtool_cmd *);
 	int	(*set_settings)(struct net_device *, struct ethtool_cmd *);
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
index 7d04b54..31d882a 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -224,6 +224,52 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 		     skb = skb->next)
 #endif /* < 2.6.28 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
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
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #ifndef NETDEV_FRAG_PAGE_MAX_ORDER
 #define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
-- 
1.8.3.1

