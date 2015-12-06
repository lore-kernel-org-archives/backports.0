Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37433 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbbLFNSf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/12] backport: import TSO helpers with support for IPv6
Date: Sun,  6 Dec 2015 14:18:17 +0100
Message-Id: <1449407908-15547-2-git-send-email-hauke@hauke-m.de> (sfid-20151206_141838_171377_36BFF1FF)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Note that TSO core helpers have been implemented in 3.19,
but support for IPv6 was added in 4.4 only.
iwlwifi will soon need this.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
[use skb_frag_page(frag), move the includes to the top and add missing ones.]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/tso.h | 33 ++++++++++++++
 backport/compat/backport-4.4.c      | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 backport/backport-include/net/tso.h

diff --git a/backport/backport-include/net/tso.h b/backport/backport-include/net/tso.h
new file mode 100644
index 0000000..816928c
--- /dev/null
+++ b/backport/backport-include/net/tso.h
@@ -0,0 +1,33 @@
+#ifndef BACKPORT_TSO_H
+#define BACKPORT_TSO_H
+
+#include <net/ip.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+
+#define tso_t LINUX_BACKPORT(tso_t)
+struct tso_t {
+	int next_frag_idx;
+	void *data;
+	size_t size;
+	u16 ip_id;
+	bool ipv6;
+	u32 tcp_seq;
+};
+
+#define tso_count_descs LINUX_BACKPORT(tso_count_descs)
+int tso_count_descs(struct sk_buff *skb);
+
+#define tso_build_hdr LINUX_BACKPORT(tso_build_hdr)
+void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
+		   int size, bool is_last);
+#define tso_build_data LINUX_BACKPORT(tso_build_data)
+void tso_build_data(struct sk_buff *skb, struct tso_t *tso, int size);
+#define tso_start LINUX_BACKPORT(tso_start)
+void tso_start(struct sk_buff *skb, struct tso_t *tso);
+
+#else
+#include_next <net/tso.h>
+#endif
+
+#endif	/* BACKPORT_TSO_H */
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
index 43e26e5..8854385 100644
--- a/backport/compat/backport-4.4.c
+++ b/backport/compat/backport-4.4.c
@@ -9,8 +9,15 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/fs.h>
+#include <linux/if_vlan.h>
+#include <linux/mm.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+#include <net/tso.h>
+#include <asm/unaligned.h>
 
 #ifdef CONFIG_DEBUG_FS
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
@@ -64,3 +71,84 @@ struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
 #endif /* CONFIG_DEBUG_FS */
+
+/* Calculate expected number of TX descriptors */
+int tso_count_descs(struct sk_buff *skb)
+{
+	/* The Marvell Way */
+	return skb_shinfo(skb)->gso_segs * 2 + skb_shinfo(skb)->nr_frags;
+}
+EXPORT_SYMBOL(tso_count_descs);
+
+void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
+		   int size, bool is_last)
+{
+	struct tcphdr *tcph;
+	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	int mac_hdr_len = skb_network_offset(skb);
+
+	memcpy(hdr, skb->data, hdr_len);
+	if (!tso->ipv6) {
+		struct iphdr *iph = (void *)(hdr + mac_hdr_len);
+
+		iph->id = htons(tso->ip_id);
+		iph->tot_len = htons(size + hdr_len - mac_hdr_len);
+		tso->ip_id++;
+	} else {
+		struct ipv6hdr *iph = (void *)(hdr + mac_hdr_len);
+
+		iph->payload_len = htons(size + tcp_hdrlen(skb));
+	}
+	tcph = (struct tcphdr *)(hdr + skb_transport_offset(skb));
+	put_unaligned_be32(tso->tcp_seq, &tcph->seq);
+
+	if (!is_last) {
+		/* Clear all special flags for not last packet */
+		tcph->psh = 0;
+		tcph->fin = 0;
+		tcph->rst = 0;
+	}
+}
+EXPORT_SYMBOL(tso_build_hdr);
+
+void tso_build_data(struct sk_buff *skb, struct tso_t *tso, int size)
+{
+	tso->tcp_seq += size;
+	tso->size -= size;
+	tso->data += size;
+
+	if ((tso->size == 0) &&
+	    (tso->next_frag_idx < skb_shinfo(skb)->nr_frags)) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[tso->next_frag_idx];
+
+		/* Move to next segment */
+		tso->size = frag->size;
+		tso->data = page_address(skb_frag_page(frag)) + frag->page_offset;
+		tso->next_frag_idx++;
+	}
+}
+EXPORT_SYMBOL(tso_build_data);
+
+void tso_start(struct sk_buff *skb, struct tso_t *tso)
+{
+	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+
+	tso->ip_id = ntohs(ip_hdr(skb)->id);
+	tso->tcp_seq = ntohl(tcp_hdr(skb)->seq);
+	tso->next_frag_idx = 0;
+	tso->ipv6 = vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+
+	/* Build first data */
+	tso->size = skb_headlen(skb) - hdr_len;
+	tso->data = skb->data + hdr_len;
+	if ((tso->size == 0) &&
+	    (tso->next_frag_idx < skb_shinfo(skb)->nr_frags)) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[tso->next_frag_idx];
+
+		/* Move to next segment */
+		tso->size = frag->size;
+		tso->data = page_address(skb_frag_page(frag)) + frag->page_offset;
+		tso->next_frag_idx++;
+	}
+}
+EXPORT_SYMBOL(tso_start);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
