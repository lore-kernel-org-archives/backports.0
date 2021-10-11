Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA83C43217
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7397C60EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhJKWZL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhJKWZC (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E21C061749
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbR28CWzQkhP;
        Tue, 12 Oct 2021 00:22:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak8k9NmnHwKLspMeZifUzgwPewNaLth3AddZAF4hl70=;
        b=Gxp1iKBs2pkDeNZ9x6GAWRBEjI/27yDKcgv/B57tgMbRoPU2llqwnK3IV2NApXGx/nq/vz
        Pew72tqOEvigXDkRbTY37KA7eWCKBgbzrgzD7NK598FIiQwDHOHPkRzsehWOnKTfeenAY4
        IT7DW7KyAF361a9EZuB4MXyqnzaXvuliRA19ufCzvpeCY2rWItE/QuLEPaTFUNHqdxWwNI
        AiEltXjGLSvUme+ekgViEM197ljykbnIZO8ksv1nubpZb849fMdCryTU7he01U/VGc86RA
        bcWQsNQCPDdZ7vHqLEVVwg+SJ4nn/nSZtOsNfuwiRCF9GksFyDZsd601f06FdQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/14] backports: Remove support for kernel smaller than 4.4
Date:   Tue, 12 Oct 2021 00:22:27 +0200
Message-Id: <20211011222227.1189850-15-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B74918B7
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the code which is needed to support kernel 4.3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                       |   2 +-
 backport/backport-include/linux/debugfs.h    |  30 -----
 backport/backport-include/linux/mei_cl_bus.h |  22 ----
 backport/backport-include/linux/netdevice.h  |   8 --
 backport/backport-include/linux/of_address.h |  18 ---
 backport/backport-include/net/netlink.h      |  22 ----
 backport/backport-include/net/tso.h          |  33 -----
 backport/compat/Makefile                     |   1 -
 backport/compat/backport-4.4.c               | 124 -------------------
 patches/0065-ndisc_send_na-argument.cocci    |   9 --
 10 files changed, 1 insertion(+), 268 deletions(-)
 delete mode 100644 backport/backport-include/linux/mei_cl_bus.h
 delete mode 100644 backport/backport-include/linux/of_address.h
 delete mode 100644 backport/backport-include/net/tso.h
 delete mode 100644 backport/compat/backport-4.4.c
 delete mode 100644 patches/0065-ndisc_send_na-argument.cocci

diff --git a/README b/README
index acc0d7cd..f9cf7248 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.3 and above.
+for kernels 4.4 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index e342a38a..af401cf5 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -3,22 +3,6 @@
 #include_next <linux/debugfs.h>
 #include <linux/version.h>
 #include <linux/device.h>
-#include <generated/utsrelease.h>
-
-#if LINUX_VERSION_IS_LESS(4,4,0)
-#define debugfs_create_bool LINUX_BACKPORT(debugfs_create_bool)
-#ifdef CONFIG_DEBUG_FS
-struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-				   struct dentry *parent, bool *value);
-#else
-static inline struct dentry *
-debugfs_create_bool(const char *name, umode_t mode,
-		    struct dentry *parent, bool *value)
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
-#endif /* LINUX_VERSION_IS_LESS(4,4,0) */
 
 #if LINUX_VERSION_IS_LESS(4,9,0) && \
     !LINUX_VERSION_IN_RANGE(4,8,4, 4,9,0) && \
@@ -41,20 +25,6 @@ debugfs_real_fops(const struct file *filp)
 	debugfs_create_file(name, mode, parent, data, fops)
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,4,0)
-static inline struct dentry *
-debugfs_create_ulong(const char *name, umode_t mode,
-		     struct dentry *parent, unsigned long *value)
-{
-	if (sizeof(unsigned long) == sizeof(u64))
-		return debugfs_create_u64(name, mode, parent, (u64 *)value);
-	if (sizeof(unsigned long) == sizeof(u32))
-		return debugfs_create_u32(name, mode, parent, (u32 *)value);
-	WARN_ON(1);
-	return ERR_PTR(-EINVAL);
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(5,5,0)
 static inline void debugfs_create_xul(const char *name, umode_t mode,
 				      struct dentry *parent,
diff --git a/backport/backport-include/linux/mei_cl_bus.h b/backport/backport-include/linux/mei_cl_bus.h
deleted file mode 100644
index d6ef77e1..00000000
--- a/backport/backport-include/linux/mei_cl_bus.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef __BACKPORT_LINUX_MEI_CL_BUS_H
-#define __BACKPORT_LINUX_MEI_CL_BUS_H
-#include_next <linux/mei_cl_bus.h>
-
-#if LINUX_VERSION_IS_LESS(4,4,0)
-#define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
-	mei_cl_register_event_cb(cldev, event_mask, read_cb, context)
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,4,0)
-#define __mei_cldev_driver_register(cldrv, owner) __mei_cl_driver_register(cldrv, owner)
-#define mei_cldev_driver_register(cldrv) mei_cl_driver_register(cldrv)
-#define mei_cldev_driver_unregister(cldrv) mei_cl_driver_unregister(cldrv)
-#define mei_cldev_send(cldev, buf, length) mei_cl_send(cldev, buf, length)
-#define mei_cldev_recv(cldev, buf, length) mei_cl_recv(cldev, buf, length)
-#define mei_cldev_get_drvdata(cldev) mei_cl_get_drvdata(cldev)
-#define mei_cldev_set_drvdata(cldev, data) mei_cl_set_drvdata(cldev, data)
-#define mei_cldev_enable(cldev) mei_cl_enable_device(cldev)
-#define mei_cldev_disable(cldev) mei_cl_disable_device(cldev)
-#endif
-
-#endif /* __BACKPORT_LINUX_MEI_CL_BUS_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index a271c37a..e9c07a91 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -104,14 +104,6 @@ static inline int backport_dev_open(struct net_device *dev, struct netlink_ext_a
 #define dev_open LINUX_BACKPORT(dev_open)
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,4,0)
-#define netif_is_bridge_port LINUX_BACKPORT(netif_is_bridge_port)
-static inline bool netif_is_bridge_port(const struct net_device *dev)
-{
-	return dev->priv_flags & IFF_BRIDGE_PORT;
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(5,10,0)
 #define dev_fetch_sw_netstats LINUX_BACKPORT(dev_fetch_sw_netstats)
 void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
diff --git a/backport/backport-include/linux/of_address.h b/backport/backport-include/linux/of_address.h
deleted file mode 100644
index e3a5167a..00000000
--- a/backport/backport-include/linux/of_address.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __BACKPORT_OF_ADDRESS_H
-#define __BACKPORT_OF_ADDRESS_H
-#include_next <linux/of_address.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,4,0) && !defined(CONFIG_OF_ADDRESS)
-#ifndef OF_BAD_ADDR
-#define OF_BAD_ADDR     ((u64)-1)
-#endif
-#define of_translate_address LINUX_BACKPORT(of_translate_addres)
-static inline u64 of_translate_address(struct device_node *np,
-				       const __be32 *addr)
-{
-	return OF_BAD_ADDR;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,4,0) */
-
-#endif /* __BACKPORT_OF_IRQ_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 6f48fd71..3c7fdc7e 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -435,28 +435,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-#if LINUX_VERSION_IS_LESS(4,4,0)
-/**
- * nla_get_le32 - return payload of __le32 attribute
- * @nla: __le32 netlink attribute
- */
-#define nla_get_le32 LINUX_BACKPORT(nla_get_le32)
-static inline __le32 nla_get_le32(const struct nlattr *nla)
-{
-	return *(__le32 *) nla_data(nla);
-}
-
-/**
- * nla_get_le64 - return payload of __le64 attribute
- * @nla: __le64 netlink attribute
- */
-#define nla_get_le64 LINUX_BACKPORT(nla_get_le64)
-static inline __le64 nla_get_le64(const struct nlattr *nla)
-{
-	return *(__le64 *) nla_data(nla);
-}
-#endif /* < 4.4 */
-
 #if LINUX_VERSION_IS_LESS(4,7,0)
 /**
  * nla_need_padding_for_64bit - test 64-bit alignment of the next attribute
diff --git a/backport/backport-include/net/tso.h b/backport/backport-include/net/tso.h
deleted file mode 100644
index 3a3f50b3..00000000
--- a/backport/backport-include/net/tso.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef BACKPORT_TSO_H
-#define BACKPORT_TSO_H
-
-#include <net/ip.h>
-
-#if LINUX_VERSION_IS_LESS(4,4,0)
-
-#define tso_t LINUX_BACKPORT(tso_t)
-struct tso_t {
-	int next_frag_idx;
-	void *data;
-	size_t size;
-	u16 ip_id;
-	bool ipv6;
-	u32 tcp_seq;
-};
-
-#define tso_count_descs LINUX_BACKPORT(tso_count_descs)
-int tso_count_descs(struct sk_buff *skb);
-
-#define tso_build_hdr LINUX_BACKPORT(tso_build_hdr)
-void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
-		   int size, bool is_last);
-#define tso_build_data LINUX_BACKPORT(tso_build_data)
-void tso_build_data(struct sk_buff *skb, struct tso_t *tso, int size);
-#define tso_start LINUX_BACKPORT(tso_start)
-void tso_start(struct sk_buff *skb, struct tso_t *tso);
-
-#else
-#include_next <net/tso.h>
-#endif
-
-#endif	/* BACKPORT_TSO_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index bdb478bb..bbedd49c 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
deleted file mode 100644
index 71edc2be..00000000
--- a/backport/compat/backport-4.4.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * Copyright(c) 2015 Intel Deutschland GmbH
- *
- * Backport functionality introduced in Linux 4.4.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/debugfs.h>
-#include <linux/export.h>
-#include <linux/uaccess.h>
-#include <linux/fs.h>
-#include <linux/if_vlan.h>
-#include <linux/mm.h>
-#include <linux/skbuff.h>
-#include <linux/tcp.h>
-#include <net/ip.h>
-#include <net/tso.h>
-#include <asm/unaligned.h>
-
-#ifdef CONFIG_DEBUG_FS
-
-static const struct file_operations fops_bool = {
-	.read =		debugfs_read_file_bool,
-	.write =	debugfs_write_file_bool,
-	.open =		simple_open,
-	.llseek =	default_llseek,
-};
-
-struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-				   struct dentry *parent, bool *value)
-{
-	return debugfs_create_file(name, mode, parent, value, &fops_bool);
-}
-EXPORT_SYMBOL_GPL(debugfs_create_bool);
-#endif /* CONFIG_DEBUG_FS */
-
-/* Calculate expected number of TX descriptors */
-int tso_count_descs(struct sk_buff *skb)
-{
-	/* The Marvell Way */
-	return skb_shinfo(skb)->gso_segs * 2 + skb_shinfo(skb)->nr_frags;
-}
-EXPORT_SYMBOL(tso_count_descs);
-
-void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
-		   int size, bool is_last)
-{
-	struct tcphdr *tcph;
-	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
-	int mac_hdr_len = skb_network_offset(skb);
-
-	memcpy(hdr, skb->data, hdr_len);
-	if (!tso->ipv6) {
-		struct iphdr *iph = (void *)(hdr + mac_hdr_len);
-
-		iph->id = htons(tso->ip_id);
-		iph->tot_len = htons(size + hdr_len - mac_hdr_len);
-		tso->ip_id++;
-	} else {
-#ifdef CONFIG_IPV6
-		struct ipv6hdr *iph = (void *)(hdr + mac_hdr_len);
-
-		iph->payload_len = htons(size + tcp_hdrlen(skb));
-#else /* CONFIG_IPV6 */
-		/* tso->ipv6 should never be set if IPV6 is not enabeld */
-		WARN_ON(1);
-#endif /* CONFIG_IPV6 */
-	}
-	tcph = (struct tcphdr *)(hdr + skb_transport_offset(skb));
-	put_unaligned_be32(tso->tcp_seq, &tcph->seq);
-
-	if (!is_last) {
-		/* Clear all special flags for not last packet */
-		tcph->psh = 0;
-		tcph->fin = 0;
-		tcph->rst = 0;
-	}
-}
-EXPORT_SYMBOL(tso_build_hdr);
-
-void tso_build_data(struct sk_buff *skb, struct tso_t *tso, int size)
-{
-	tso->tcp_seq += size;
-	tso->size -= size;
-	tso->data += size;
-
-	if ((tso->size == 0) &&
-	    (tso->next_frag_idx < skb_shinfo(skb)->nr_frags)) {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[tso->next_frag_idx];
-
-		/* Move to next segment */
-		tso->size = frag->size;
-		tso->data = page_address(skb_frag_page(frag)) + frag->page_offset;
-		tso->next_frag_idx++;
-	}
-}
-EXPORT_SYMBOL(tso_build_data);
-
-void tso_start(struct sk_buff *skb, struct tso_t *tso)
-{
-	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
-
-	tso->ip_id = ntohs(ip_hdr(skb)->id);
-	tso->tcp_seq = ntohl(tcp_hdr(skb)->seq);
-	tso->next_frag_idx = 0;
-	tso->ipv6 = vlan_get_protocol(skb) == htons(ETH_P_IPV6);
-
-	/* Build first data */
-	tso->size = skb_headlen(skb) - hdr_len;
-	tso->data = skb->data + hdr_len;
-	if ((tso->size == 0) &&
-	    (tso->next_frag_idx < skb_shinfo(skb)->nr_frags)) {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[tso->next_frag_idx];
-
-		/* Move to next segment */
-		tso->size = frag->size;
-		tso->data = page_address(skb_frag_page(frag)) + frag->page_offset;
-		tso->next_frag_idx++;
-	}
-}
-EXPORT_SYMBOL(tso_start);
diff --git a/patches/0065-ndisc_send_na-argument.cocci b/patches/0065-ndisc_send_na-argument.cocci
deleted file mode 100644
index a3d00f3c..00000000
--- a/patches/0065-ndisc_send_na-argument.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@@
-identifier ndisc_send_na;
-expression netdev, saddr, target, router, solicited, override, inc_opt;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,4,0)
- ipv6_stub->ndisc_send_na(netdev, saddr, target, router, solicited, override, inc_opt);
-+#else
-+ipv6_stub->ndisc_send_na(netdev, NULL, saddr, target, router, solicited, override, inc_opt);
-+#endif
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
