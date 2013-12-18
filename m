Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849Ab3LRQJI (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 18 Dec 2013 11:09:08 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC v2 10/11] backports: igb fixes for linux-3.1
Date: Wed, 18 Dec 2013 17:08:24 +0100
Message-Id: <1387382905-14274-11-git-send-email-sassmann@kpanic.de> (sfid-20131218_170912_278937_001C2258)
In-Reply-To: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add IFF_UNICAST_FLT define
- add PCI_DEV_FLAGS_ASSIGNED define
- add skb_frag_size_sub()
- add skb_frag_address()
- add patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch
- add patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/if.h               |  4 ++++
 backport/backport-include/linux/pci.h              |  8 ++++++++
 backport/backport-include/linux/skbuff.h           | 19 +++++++++++++++++
 .../network/82-ethernet/0011-igb_ethtool_ops.patch | 15 ++++++++++++++
 .../82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch | 24 ++++++++++++++++++++++
 5 files changed, 70 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch

diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index f23d2b8..a072579 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -37,4 +37,8 @@
 #define IFF_SUPP_NOFCS	0x80000		/* device supports sending custom FCS */
 #endif
 
+#ifndef IFF_UNICAST_FLT
+#define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
+#endif
+
 #endif	/* _BACKPORT_LINUX_IF_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index c3360f1..511e015 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -178,6 +178,14 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 	.subvendor = (subvend), .subdevice = (subdev)
 #endif /* PCI_DEVICE_SUB */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+enum backport_pci_dev_flags {
+	/* Provide indication device is assigned by a Virtual Machine Manager */
+	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
+};
+#define pci_dev_flags LINUX_BACKPORT(pci_dev_flags);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index c1b2753..2207e7e 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -224,6 +224,25 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 		     skb = skb->next)
 #endif /* < 2.6.28 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+static inline void skb_frag_size_sub(skb_frag_t *frag, int delta)
+{
+	frag->size -= delta;
+}
+
+/**
+ * skb_frag_address - gets the address of the data contained in a paged fragment
+ * @frag: the paged fragment buffer
+ *
+ * Returns the address of the data within @frag. The page must already
+ * be mapped.
+ */
+static inline void *skb_frag_address(const skb_frag_t *frag)
+{
+	return page_address(skb_frag_page(frag)) + frag->page_offset;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  *	__skb_alloc_pages - allocate pages for ps-rx on a skb and preserve pfmemalloc data
diff --git a/patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch
new file mode 100644
index 0000000..293405d
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch
@@ -0,0 +1,15 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index fcc7eb1..5989862 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -3002,8 +3002,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_ts_info		= igb_get_ts_info,
+ #endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	.get_rxnfc		= igb_get_rxnfc,
+ 	.set_rxnfc		= igb_set_rxnfc,
++#endif
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.get_eee		= igb_get_eee,
+ 	.set_eee		= igb_set_eee,
diff --git a/patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
new file mode 100644
index 0000000..84b7fe2
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
@@ -0,0 +1,24 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 6bf0a88..90fd4d6 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -1932,7 +1932,9 @@ static const struct net_device_ops igb_netdev_ops = {
+ 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
+ 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
+ 	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 	.ndo_get_vf_config	= igb_ndo_get_vf_config,
+ #ifdef CONFIG_NET_POLL_CONTROLLER
+ 	.ndo_poll_controller	= igb_netpoll,
+@@ -7676,7 +7678,9 @@ static int igb_ndo_get_vf_config(struct net_device *netdev,
+ 	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
+ 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
+ 	ivi->qos = adapter->vf_data[vf].pf_qos;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	ivi->spoofchk = adapter->vf_data[vf].spoofchk_enabled;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 	return 0;
+ }
+ 
-- 
1.8.3.1

