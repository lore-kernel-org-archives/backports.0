Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45146 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab3LLJ3z (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:55 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 10/10] backports: igb fixes for linux-3.1
Date: Thu, 12 Dec 2013 10:28:02 +0100
Message-Id: <1386840482-585-11-git-send-email-sassmann@kpanic.de> (sfid-20131212_102957_767468_3820F978)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- backport struct ifla_vf_info
- backport enum pci_dev_flags
- add skb_frag_size_sub()
- add skb_frag_address()
- add patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/if.h                  |  4 ++++
 backport/backport-include/linux/if_link.h             | 17 +++++++++++++++++
 backport/backport-include/linux/pci.h                 |  8 ++++++++
 backport/backport-include/linux/skbuff.h              | 19 +++++++++++++++++++
 .../network/82-ethernet/igb_ndo_set_vf_spoofchk.patch | 14 ++++++++++++++
 5 files changed, 62 insertions(+)
 create mode 100644 backport/backport-include/linux/if_link.h
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch

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
diff --git a/backport/backport-include/linux/if_link.h b/backport/backport-include/linux/if_link.h
new file mode 100644
index 0000000..42d4c33
--- /dev/null
+++ b/backport/backport-include/linux/if_link.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_IF_LINK_H
+#define __BACKPORT_LINUX_IF_LINK_H
+#include_next <linux/if_link.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+struct backport_ifla_vf_info {
+	__u32 vf;
+	__u8 mac[32];
+	__u32 vlan;
+	__u32 qos;
+	__u32 tx_rate;
+	__u32 spoofchk;
+};
+#define ifla_vf_info LINUX_BACKPORT(ifla_vf_info)
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+
+#endif /* __BACKPORT_LINUX_IF_LINK_H */
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
index 31d882a..c3a259f 100644
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
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  *	__skb_alloc_pages - allocate pages for ps-rx on a skb and preserve pfmemalloc data
diff --git a/patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch
new file mode 100644
index 0000000..69ac88f
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch
@@ -0,0 +1,14 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 6bf0a88..d641e86 100644
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
-- 
1.8.3.1

