Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58023 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbaJTVeR (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add eth_get_headlen()
Date: Mon, 20 Oct 2014 23:33:44 +0200
Message-Id: <1413840827-9142-3-git-send-email-hauke@hauke-m.de> (sfid-20141020_233421_538794_6E756A6D)
In-Reply-To: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
References: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of using the code from a recent kernel, I used the old code
from the igb driver to calculate the header length. The new code in the
kernel makes use of some __skb_flow_dissect() functions and headers not
available in 3.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |   5 ++
 backport/compat/Makefile                      |   1 +
 backport/compat/backport-3.18.c               | 123 ++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 backport/compat/backport-3.18.c

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index cc2ee0a..70decd2 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -173,4 +173,9 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#define eth_get_headlen LINUX_BACKPORT(eth_get_headlen)
+int eth_get_headlen(unsigned char *data, unsigned int max_len);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index d648982..6d210b0 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -19,6 +19,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_17) += backport-3.17.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_18) += backport-3.18.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
new file mode 100644
index 0000000..8352fe0
--- /dev/null
+++ b/backport/compat/backport-3.18.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.18.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <scsi/fc/fc_fcoe.h>
+
+/**
+ * eth_get_headlen - determine the the length of header for an ethernet frame
+ * @data: pointer to start of frame
+ * @len: total length of frame
+ *
+ * Make a best effort attempt to pull the length for all of the headers for
+ * a given frame in a linear buffer.
+ */
+int eth_get_headlen(unsigned char *data, unsigned int max_len)
+{
+	union {
+		unsigned char *network;
+		/* l2 headers */
+		struct ethhdr *eth;
+		struct vlan_hdr *vlan;
+		/* l3 headers */
+		struct iphdr *ipv4;
+		struct ipv6hdr *ipv6;
+	} hdr;
+	__be16 protocol;
+	u8 nexthdr = 0;	/* default to not TCP */
+	u8 hlen;
+
+	/* this should never happen, but better safe than sorry */
+	if (max_len < ETH_HLEN)
+		return max_len;
+
+	/* initialize network frame pointer */
+	hdr.network = data;
+
+	/* set first protocol and move network header forward */
+	protocol = hdr.eth->h_proto;
+	hdr.network += ETH_HLEN;
+
+	/* handle any vlan tag if present */
+	if (protocol == htons(ETH_P_8021Q)) {
+		if ((hdr.network - data) > (max_len - VLAN_HLEN))
+			return max_len;
+
+		protocol = hdr.vlan->h_vlan_encapsulated_proto;
+		hdr.network += VLAN_HLEN;
+	}
+
+	/* handle L3 protocols */
+	if (protocol == htons(ETH_P_IP)) {
+		if ((hdr.network - data) > (max_len - sizeof(struct iphdr)))
+			return max_len;
+
+		/* access ihl as a u8 to avoid unaligned access on ia64 */
+		hlen = (hdr.network[0] & 0x0F) << 2;
+
+		/* verify hlen meets minimum size requirements */
+		if (hlen < sizeof(struct iphdr))
+			return hdr.network - data;
+
+		/* record next protocol if header is present */
+		if (!(hdr.ipv4->frag_off & htons(IP_OFFSET)))
+			nexthdr = hdr.ipv4->protocol;
+	} else if (protocol == htons(ETH_P_IPV6)) {
+		if ((hdr.network - data) > (max_len - sizeof(struct ipv6hdr)))
+			return max_len;
+
+		/* record next protocol */
+		nexthdr = hdr.ipv6->nexthdr;
+		hlen = sizeof(struct ipv6hdr);
+	} else if (protocol == htons(ETH_P_FCOE)) {
+		if ((hdr.network - data) > (max_len - FCOE_HEADER_LEN))
+			return max_len;
+		hlen = FCOE_HEADER_LEN;
+	} else {
+		return hdr.network - data;
+	}
+
+	/* relocate pointer to start of L4 header */
+	hdr.network += hlen;
+
+	/* finally sort out TCP/UDP */
+	if (nexthdr == IPPROTO_TCP) {
+		if ((hdr.network - data) > (max_len - sizeof(struct tcphdr)))
+			return max_len;
+
+		/* access doff as a u8 to avoid unaligned access on ia64 */
+		hlen = (hdr.network[12] & 0xF0) >> 2;
+
+		/* verify hlen meets minimum size requirements */
+		if (hlen < sizeof(struct tcphdr))
+			return hdr.network - data;
+
+		hdr.network += hlen;
+	} else if (nexthdr == IPPROTO_UDP) {
+		if ((hdr.network - data) > (max_len - sizeof(struct udphdr)))
+			return max_len;
+
+		hdr.network += sizeof(struct udphdr);
+	}
+
+	/*
+	 * If everything has gone correctly hdr.network should be the
+	 * data section of the packet and will be the end of the header.
+	 * If not then it probably represents the end of the last recognized
+	 * header.
+	 */
+	if ((hdr.network - data) < max_len)
+		return hdr.network - data;
+	else
+		return max_len;
+}
+EXPORT_SYMBOL_GPL(eth_get_headlen);
-- 
1.9.1

