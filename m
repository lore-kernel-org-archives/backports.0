Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C355C1A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009034; cv=none; b=rVERB/T5hqvMDVF8rLAZrG4ywOyGXWTkO2kW5y6rY/ilHaksv98n9LV3dIv5qhaiStPEWAYrWS/Cl9n/dyBt6KXL33YubUWLP+LN40gf4mCoNq/evOVGCyGNfQ3DLPRoBAxr9gIn2g1tghUGXRzV9uXwIxbFozUubXVBX9+qyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009034; c=relaxed/simple;
	bh=/DVLTzRz++WclnUoeUc9Ocx1fYbXlABho63ib/jYU4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG8LIEth94i8CVV1TRfd/i+wvgrMLBa7OEKKhjy3fO9hcfHH7otnRj6h3aGKv12V+jVxdHF2Akcl0jrrZKeQUJdpLWZV/y+eylSDNPzlf/Gi8KYMm8/5aLIvt8qlVpMAFwfpLyWMqkO9PWIjOtxAOtmn5yEru7s1VzhprIzuuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=uaGilMzg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="uaGilMzg"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V7lQW6Mzcz9slj;
	Tue,  2 Apr 2024 00:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiSs/fw/Tp+BS0990+GVCZMutmBLJf/ZfM0wjCm0NO0=;
	b=uaGilMzg5eAkbuVdljTrxz+c+v6Lwxx6ezQV2E0k56s74+42rWNo3MUjpcnVi+o8NnVXNu
	IXfekvDqKtG5gzbQfTWQkB1bpa4NK7PlXB4xWNmEmAX9dD8j3quSEb5D8/941R/g4/ZNN1
	EkqvLPBgAhwkAgQj5XJ/fWBec4o7goegpV0DxrTKZKRvMN0ao9JMdJXPTWJ5I6G0KDG0E8
	vgqg37TcQb/A5vCKMoqRvMRUxLOoj7rOvVjXkz8i52LEPjTA3oAiOemRpBpS6ljYvdDYx3
	8Jm1npXJVSn70GCU4gLw6fJ28MkrRuIEDJqNTBsPKtUlXptnvb5jygfo8zMsaw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] backports: Remove support for kernel smaller than 4.7
Date: Tue,  2 Apr 2024 00:03:07 +0200
Message-ID: <20240401220314.2434455-4-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQW6Mzcz9slj

This removes all the code which is needed to support kernel 4.6.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |   1 -
 README                                        |   2 +-
 backport/backport-include/linux/devcoredump.h |  30 ---
 backport/backport-include/linux/netdevice.h   |   8 -
 .../backport-include/linux/verification.h     |   4 +-
 backport/backport-include/net/netlink.h       |  98 ----------
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.10.c               |  31 ---
 backport/compat/backport-4.7.c                | 176 ------------------
 dependencies                                  |   8 -
 10 files changed, 3 insertions(+), 356 deletions(-)
 delete mode 100644 backport/backport-include/linux/devcoredump.h
 delete mode 100644 backport/compat/backport-4.7.c

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index f181da62..9d5873b2 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.6",
            "4.7",
            "4.8",
            "4.9",
diff --git a/README b/README
index 31add70f..46c734d3 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.6 and above.
+for kernels 4.7 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/devcoredump.h b/backport/backport-include/linux/devcoredump.h
deleted file mode 100644
index 49b7c30d..00000000
--- a/backport/backport-include/linux/devcoredump.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __BACKPORT_LINUX_DEVCOREDUMP_H
-#define __BACKPORT_LINUX_DEVCOREDUMP_H
-#include_next <linux/devcoredump.h>
-#include <linux/version.h>
-#include <linux/scatterlist.h>
-
-/* We only need to add our wrapper inside the range from 3.18 until
- * 4.6, outside that we can let our BPAUTO mechanism handle it.
- */
-#if LINUX_VERSION_IS_LESS(4,7,0)
-static inline
-void backport_dev_coredumpm(struct device *dev, struct module *owner,
-			    void *data, size_t datalen, gfp_t gfp,
-			    ssize_t (*read_fn)(char *buffer, loff_t offset,
-					    size_t count, void *data,
-					    size_t datalen),
-			    void (*free_fn)(void *data))
-{
-	dev_coredumpm(dev, owner, (const void *)data, datalen, gfp,
-		      (void *)read_fn, (void *)free_fn);
-}
-#define dev_coredumpm LINUX_BACKPORT(dev_coredumpm)
-
-#define dev_coredumpsg LINUX_BACKPORT(dev_coredumpsg)
-void dev_coredumpsg(struct device *dev, struct scatterlist *table,
-		    size_t datalen, gfp_t gfp);
-
-#endif /* LINUX_VERSION_IS_LESS(4,7,0) */
-
-#endif /* __BACKPORT_LINUX_DEVCOREDUMP_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 71961625..156bcade 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -27,14 +27,6 @@ static inline bool backport_napi_complete(struct napi_struct *n)
 #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,7,0)
-#define netif_trans_update LINUX_BACKPORT(netif_trans_update)
-static inline void netif_trans_update(struct net_device *dev)
-{
-	dev->trans_start = jiffies;
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,11,9)
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->destructor = __ ## _destructor
diff --git a/backport/backport-include/linux/verification.h b/backport/backport-include/linux/verification.h
index 908d1a26..ce5811e2 100644
--- a/backport/backport-include/linux/verification.h
+++ b/backport/backport-include/linux/verification.h
@@ -1,7 +1,7 @@
 #ifndef __BP_VERIFICATION_H
 #define __BP_VERIFICATION_H
 #include <linux/version.h>
-#if (LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION)) && \
+#if !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) && \
 	defined(CONFIG_CRYPTO_HASH_INFO)
 #include_next <linux/verification.h>
 #else
@@ -25,5 +25,5 @@ extern int verify_pkcs7_signature(const void *data, size_t len,
 						      const void *data, size_t len,
 						      size_t asn1hdrlen),
 				  void *ctx);
-#endif /* LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) */
+#endif /* !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) */
 #endif /* __BP_VERIFICATION_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 3c7fdc7e..c8ea6af3 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -435,104 +435,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-#if LINUX_VERSION_IS_LESS(4,7,0)
-/**
- * nla_need_padding_for_64bit - test 64-bit alignment of the next attribute
- * @skb: socket buffer the message is stored in
- *
- * Return true if padding is needed to align the next attribute (nla_data()) to
- * a 64-bit aligned area.
- */
-#define nla_need_padding_for_64bit LINUX_BACKPORT(nla_need_padding_for_64bit)
-static inline bool nla_need_padding_for_64bit(struct sk_buff *skb)
-{
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-       /* The nlattr header is 4 bytes in size, that's why we test
-        * if the skb->data _is_ aligned.  A NOP attribute, plus
-        * nlattr header for next attribute, will make nla_data()
-        * 8-byte aligned.
-        */
-       if (IS_ALIGNED((unsigned long)skb_tail_pointer(skb), 8))
-               return true;
-#endif
-       return false;
-}
-/**
- * nla_align_64bit - 64-bit align the nla_data() of next attribute
- * @skb: socket buffer the message is stored in
- * @padattr: attribute type for the padding
- *
- * Conditionally emit a padding netlink attribute in order to make
- * the next attribute we emit have a 64-bit aligned nla_data() area.
- * This will only be done in architectures which do not have
- * HAVE_EFFICIENT_UNALIGNED_ACCESS defined.
- *
- * Returns zero on success or a negative error code.
- */
-#define nla_align_64bit LINUX_BACKPORT(nla_align_64bit)
-static inline int nla_align_64bit(struct sk_buff *skb, int padattr)
-{
-       if (nla_need_padding_for_64bit(skb) &&
-            !nla_reserve(skb, padattr, 0))
-                return -EMSGSIZE;
-       return 0;
-}
-
-/**
- * nla_total_size_64bit - total length of attribute including padding
- * @payload: length of payload
- */
-#define nla_total_size_64bit LINUX_BACKPORT(nla_total_size_64bit)
-static inline int nla_total_size_64bit(int payload)
-{
-       return NLA_ALIGN(nla_attr_size(payload))
-#ifndef HAVE_EFFICIENT_UNALIGNED_ACCESS
-               + NLA_ALIGN(nla_attr_size(0))
-#endif
-               ;
-}
-#define __nla_reserve_64bit LINUX_BACKPORT(__nla_reserve_64bit)
-struct nlattr *__nla_reserve_64bit(struct sk_buff *skb, int attrtype,
-				   int attrlen, int padattr);
-#define nla_reserve_64bit LINUX_BACKPORT(nla_reserve_64bit)
-struct nlattr *nla_reserve_64bit(struct sk_buff *skb, int attrtype,
-				 int attrlen, int padattr);
-#define __nla_put_64bit LINUX_BACKPORT(__nla_put_64bit)
-void __nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
-		     const void *data, int padattr);
-#define nla_put_64bit LINUX_BACKPORT(nla_put_64bit)
-int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
-		  const void *data, int padattr);
-/**
- * nla_put_u64_64bit - Add a u64 netlink attribute to a skb and align it
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- * @padattr: attribute type for the padding
- */
-#define nla_put_u64_64bit LINUX_BACKPORT(nla_put_u64_64bit)
-static inline int nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
-                                    u64 value, int padattr)
-{
-        return nla_put_64bit(skb, attrtype, sizeof(u64), &value, padattr);
-}
-
-
-/**
- * nla_put_s64 - Add a s64 netlink attribute to a socket buffer and align it
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- * @padattr: attribute type for the padding
- */
-#define nla_put_s64 LINUX_BACKPORT(nla_put_s64)
-static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
-			      int padattr)
-{
-	return nla_put_64bit(skb, attrtype, sizeof(s64), &value, padattr);
-}
-#endif /* < 4.7 */
-
 #if LINUX_VERSION_IS_LESS(4,10,0)
 /**
  * nla_memdup - duplicate attribute memory (kmemdup)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 87238c70..e5ec7092 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_11) += backport-4.11.o
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
index 497d51ab..565dc3aa 100644
--- a/backport/compat/backport-4.10.c
+++ b/backport/compat/backport-4.10.c
@@ -15,37 +15,6 @@
 #include <linux/page_ref.h>
 #include <linux/gfp.h>
 
-#if LINUX_VERSION_IS_LESS(4,7,0)
-static bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
-						    const unsigned long *src)
-{
-	bool retval = true;
-
-	/* TODO: following test will soon always be true */
-	if (__ETHTOOL_LINK_MODE_MASK_NBITS > 32) {
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(ext);
-
-		bitmap_zero(ext, __ETHTOOL_LINK_MODE_MASK_NBITS);
-		bitmap_fill(ext, 32);
-		bitmap_complement(ext, ext, __ETHTOOL_LINK_MODE_MASK_NBITS);
-		if (bitmap_intersects(ext, src,
-				      __ETHTOOL_LINK_MODE_MASK_NBITS)) {
-			/* src mask goes beyond bit 31 */
-			retval = false;
-		}
-	}
-	*legacy_u32 = src[0];
-	return retval;
-}
-
-static void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
-						    u32 legacy_u32)
-{
-	bitmap_zero(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
-	dst[0] = legacy_u32;
-}
-#endif
-
 static u32 mii_get_an(struct mii_if_info *mii, u16 addr)
 {
 	int advert;
diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
deleted file mode 100644
index d261abe6..00000000
--- a/backport/compat/backport-4.7.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * Copyright(c) 2016 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.7.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/devcoredump.h>
-#include <linux/export.h>
-#include <linux/list.h>
-#include <linux/rcupdate.h>
-#include <linux/scatterlist.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <net/netlink.h>
-
-/**
- * __nla_reserve_64bit - reserve room for attribute on the skb and align it
- * @skb: socket buffer to reserve room on
- * @attrtype: attribute type
- * @attrlen: length of attribute payload
- *
- * Adds a netlink attribute header to a socket buffer and reserves
- * room for the payload but does not copy it. It also ensure that this
- * attribute will be 64-bit aign.
- *
- * The caller is responsible to ensure that the skb provides enough
- * tailroom for the attribute header and payload.
- */
-struct nlattr *__nla_reserve_64bit(struct sk_buff *skb, int attrtype,
-                                  int attrlen, int padattr)
-{
-       if (nla_need_padding_for_64bit(skb))
-               nla_align_64bit(skb, padattr);
-
-       return __nla_reserve(skb, attrtype, attrlen);
-}
-EXPORT_SYMBOL_GPL(__nla_reserve_64bit);
-
-/**
- * nla_reserve_64bit - reserve room for attribute on the skb and align it
- * @skb: socket buffer to reserve room on
- * @attrtype: attribute type
- * @attrlen: length of attribute payload
- *
- * Adds a netlink attribute header to a socket buffer and reserves
- * room for the payload but does not copy it. It also ensure that this
- * attribute will be 64-bit aign.
- *
- * Returns NULL if the tailroom of the skb is insufficient to store
- * the attribute header and payload.
- */
-struct nlattr *nla_reserve_64bit(struct sk_buff *skb, int attrtype, int attrlen,
-				 int padattr)
-{
-       size_t len;
-
-       if (nla_need_padding_for_64bit(skb))
-               len = nla_total_size_64bit(attrlen);
-       else
-               len = nla_total_size(attrlen);
-       if (unlikely(skb_tailroom(skb) < len))
-               return NULL;
-
-       return __nla_reserve_64bit(skb, attrtype, attrlen, padattr);
-}
-EXPORT_SYMBOL_GPL(nla_reserve_64bit);
-
-/**
- * __nla_put_64bit - Add a netlink attribute to a socket buffer and align it
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @attrlen: length of attribute payload
- * @data: head of attribute payload
- *
- * The caller is responsible to ensure that the skb provides enough
- * tailroom for the attribute header and payload.
- */
-void __nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
-                    const void *data, int padattr)
-{
-       struct nlattr *nla;
-
-       nla = __nla_reserve_64bit(skb, attrtype, attrlen, padattr);
-       memcpy(nla_data(nla), data, attrlen);
-}
-EXPORT_SYMBOL_GPL(__nla_put_64bit);
-
-/**
- * nla_put_64bit - Add a netlink attribute to a socket buffer and align it
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @attrtype: attribute type
- * @attrlen: length of attribute payload
- * @data: head of attribute payload
- *
- * Returns -EMSGSIZE if the tailroom of the skb is insufficient to store
- * the attribute header and payload.
- */
-int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
-                 const void *data, int padattr)
-{
-       size_t len;
-
-       if (nla_need_padding_for_64bit(skb))
-               len = nla_total_size_64bit(attrlen);
-       else
-               len = nla_total_size(attrlen);
-       if (unlikely(skb_tailroom(skb) < len))
-               return -EMSGSIZE;
-
-       __nla_put_64bit(skb, attrtype, attrlen, data, padattr);
-       return 0;
-}
-EXPORT_SYMBOL_GPL(nla_put_64bit);
-
-static void devcd_free_sgtable(void *data)
-{
-	struct scatterlist *table = data;
-	int i;
-	struct page *page;
-	struct scatterlist *iter;
-	struct scatterlist *delete_iter;
-
-	/* free pages */
-	iter = table;
-	for_each_sg(table, iter, sg_nents(table), i) {
-		page = sg_page(iter);
-		if (page)
-			__free_page(page);
-	}
-
-	/* then free all chained tables */
-	iter = table;
-	delete_iter = table;	/* always points on a head of a table */
-	while (!sg_is_last(iter)) {
-		iter++;
-		if (sg_is_chain(iter)) {
-			iter = sg_chain_ptr(iter);
-			kfree(delete_iter);
-			delete_iter = iter;
-		}
-	}
-
-	/* free the last table */
-	kfree(delete_iter);
-}
-
-static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
-				       size_t buf_len, void *data,
-				       size_t data_len)
-{
-	struct scatterlist *table = data;
-
-	if (offset > data_len)
-		return -EINVAL;
-
-	if (offset + buf_len > data_len)
-		buf_len = data_len - offset;
-	return sg_pcopy_to_buffer(table, sg_nents(table), buffer, buf_len,
-				  offset);
-}
-
-void dev_coredumpsg(struct device *dev, struct scatterlist *table,
-		    size_t datalen, gfp_t gfp)
-{
-	dev_coredumpm(dev, THIS_MODULE, table, datalen, gfp,
-		      /* cast away some const problems */
-		      (void *)devcd_read_from_sgtable,
-		      (void *)devcd_free_sgtable);
-}
-EXPORT_SYMBOL_GPL(dev_coredumpsg);
diff --git a/dependencies b/dependencies
index e25d08e9..1377b1b6 100644
--- a/dependencies
+++ b/dependencies
@@ -11,17 +11,9 @@ ATMEL 4.18
 QTNFMAC 5.1
 QTNFMAC_PCIE 5.1
 
-# struct ethtool_link_ksettings is missing, I'm lazy
-USB_USBNET 4.6
-USB_NET_RNDIS_WLAN 4.6
-
 # For Coexsitence the BT driver has to export rsi_bt_ops
 RSI_COEX 4.17
 
-# needs napi_consume_skb()
-MT7915E 4.6
-MT7921E 4.6
-
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
-- 
2.44.0

