Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF583C4321E
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8F960EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhJKWZK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbhJKWZC (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0CC061745
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbQ26HdzQk3F;
        Tue, 12 Oct 2021 00:22:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7lxUc/ylm53uc5zqZI3bnR+kWjDlaLeCrR8Xw7wkmM=;
        b=BFVfFYKPwAraEZ+0pKIE7khRlYG7rCzlRcght2SZsw2SLz5Y0qJTeuIkq4iLRy5KwdwNHo
        xC0u+DHDgP9mA/mYiyCEa/QgRx5+HzojVEgiss+7VF+rCTFGlyv1EzIQL7g1XiLG30DUKc
        yLnidb3gPsUhvw2pJbSSxhWfkxUL1+hFRD7AcLMkzFVKubMsLi1VIsYqe/xvS6KpWvsR7U
        azkiTBTCm4kqFra7ftue0KMM7lSHsuykkcHsMu7KZ4E6mN9B8dEM05Mh/4uXh/JO0RY4mv
        yyZkw8luCSn7xu/oHTDs9rLnRF3hEvOsMhVBYt1sqT9gyBN5zLAAvdv2tKxHVw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/14] backports: Remove support for kernel smaller than 4.2
Date:   Tue, 12 Oct 2021 00:22:25 +0200
Message-Id: <20211011222227.1189850-13-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82C411898
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the code which is needed to support kernel 4.1.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                        |  2 +-
 backport/backport-include/crypto/aead.h       | 33 --------
 .../backport-include/linux/bcm47xx_nvram.h    | 20 -----
 backport/backport-include/linux/gfp.h         |  4 +-
 backport/backport-include/linux/leds.h        | 12 ---
 backport/backport-include/linux/moduleparam.h | 13 ----
 backport/backport-include/linux/net.h         |  5 --
 backport/backport-include/linux/netdevice.h   | 10 ---
 backport/backport-include/linux/skbuff.h      | 21 -----
 backport/backport-include/linux/string.h      |  4 -
 backport/backport-include/net/addrconf.h      |  9 +--
 backport/backport-include/net/genetlink.h     |  6 +-
 backport/backport-include/net/ip6_fib.h       | 26 -------
 backport/backport-include/net/iw_handler.h    |  4 +-
 backport/backport-include/net/sock.h          |  4 -
 backport/compat/Makefile                      |  1 -
 backport/compat/backport-4.10.c               |  2 -
 backport/compat/backport-4.2.c                | 76 -------------------
 dependencies                                  | 18 -----
 19 files changed, 7 insertions(+), 263 deletions(-)
 delete mode 100644 backport/backport-include/crypto/aead.h
 delete mode 100644 backport/backport-include/linux/bcm47xx_nvram.h
 delete mode 100644 backport/backport-include/net/ip6_fib.h
 delete mode 100644 backport/compat/backport-4.2.c

diff --git a/README b/README
index 2316fb99..01961249 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.1 and above.
+for kernels 4.2 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/crypto/aead.h b/backport/backport-include/crypto/aead.h
deleted file mode 100644
index 26b13551..00000000
--- a/backport/backport-include/crypto/aead.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef __BACKPORT_CRYPTO_AEAD_H
-#define __BACKPORT_CRYPTO_AEAD_H
-#include_next <crypto/aead.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define aead_request_set_ad LINUX_BACKPORT(aead_request_set_ad)
-static inline void aead_request_set_ad(struct aead_request *req,
-				       unsigned int assoclen)
-{
-	req->assoclen = assoclen;
-}
-
-#define crypto_aead_reqsize LINUX_BACKPORT(crypto_aead_reqsize)
-unsigned int crypto_aead_reqsize(struct crypto_aead *tfm);
-
-struct aead_request *crypto_backport_convert(struct aead_request *req);
-
-static inline int backport_crypto_aead_encrypt(struct aead_request *req)
-{
-	return crypto_aead_encrypt(crypto_backport_convert(req));
-}
-#define crypto_aead_encrypt LINUX_BACKPORT(crypto_aead_encrypt)
-
-static inline int backport_crypto_aead_decrypt(struct aead_request *req)
-{
-	return crypto_aead_decrypt(crypto_backport_convert(req));
-}
-#define crypto_aead_decrypt LINUX_BACKPORT(crypto_aead_decrypt)
-
-#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
-
-#endif /* __BACKPORT_CRYPTO_AEAD_H */
diff --git a/backport/backport-include/linux/bcm47xx_nvram.h b/backport/backport-include/linux/bcm47xx_nvram.h
deleted file mode 100644
index d79f7c52..00000000
--- a/backport/backport-include/linux/bcm47xx_nvram.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef __BACKPORTS_BCM47XX_NVRAM_H
-#define __BACKPORTS_BCM47XX_NVRAM_H
-#include <linux/version.h>
-
-#include_next <linux/bcm47xx_nvram.h>
-
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define bcm47xx_nvram_get_contents LINUX_BACKPORT(bcm47xx_nvram_get_contents)
-static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
-{
-	return NULL;
-}
-
-#define bcm47xx_nvram_release_contents LINUX_BACKPORT(bcm47xx_nvram_release_contents)
-static inline void bcm47xx_nvram_release_contents(char *nvram)
-{
-}
-#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-
-#endif /* __BACKPORTS_BCM47XX_NVRAM_H */
diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
index d41d4277..bfc8cbca 100644
--- a/backport/backport-include/linux/gfp.h
+++ b/backport/backport-include/linux/gfp.h
@@ -10,7 +10,7 @@
 #define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,10,0) && LINUX_VERSION_IS_GEQ(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,10,0)
 #define page_frag_alloc LINUX_BACKPORT(page_frag_alloc)
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 				    unsigned int fragsz, gfp_t gfp_mask)
@@ -20,6 +20,6 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
 
 #define __page_frag_cache_drain LINUX_BACKPORT(__page_frag_cache_drain)
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-#endif /* < 4.10 && >= 4.2 */
+#endif /* < 4.10*/
 
 #endif /* __BACKPORT_LINUX_GFP_H */
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index afd6c550..dbafd413 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -3,18 +3,6 @@
 #include_next <linux/leds.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-/*
- * There is no LINUX_BACKPORT() guard here because we want it to point to
- * the original function which is exported normally.
- */
-#ifdef CONFIG_LEDS_TRIGGERS
-extern void led_trigger_remove(struct led_classdev *led_cdev);
-#else
-static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
-#endif
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define led_set_brightness_sync LINUX_BACKPORT(led_set_brightness_sync)
 /**
diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 0c358609..c9306486 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -2,19 +2,6 @@
 #define __BACKPORT_LINUX_MODULEPARAM_H
 #include_next <linux/moduleparam.h>
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define kernel_param_lock LINUX_BACKPORT(kernel_param_lock)
-static inline void kernel_param_lock(struct module *mod)
-{
-	__kernel_param_lock();
-}
-#define kernel_param_unlock LINUX_BACKPORT(kernel_param_unlock)
-static inline void kernel_param_unlock(struct module *mod)
-{
-	__kernel_param_unlock();
-}
-#endif
-
 #ifndef module_param_hw_array
 #define module_param_hw_array(name, type, hwtype, nump, perm) \
 	module_param_array(name, type, nump, perm)
diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 3107a938..04953286 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -4,11 +4,6 @@
 #include <linux/static_key.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define sock_create_kern(net, family, type, proto, res) \
-	__sock_create(net, family, type, proto, res, 1)
-#endif
-
 #ifndef SOCKWQ_ASYNC_NOSPACE
 #define SOCKWQ_ASYNC_NOSPACE   SOCK_ASYNC_NOSPACE
 #endif
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index b653e0e9..a271c37a 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -5,16 +5,6 @@
 #include <backport/magic.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#undef u64_stats_init
-static inline void u64_stats_init(struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-	seqcount_init(&syncp->seq);
-#endif
-}
-#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
-
 #if LINUX_VERSION_IS_LESS(4,10,0)
 static inline bool backport_napi_complete_done(struct napi_struct *n, int work_done)
 {
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index c039e810..6b02c857 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -4,27 +4,6 @@
 #include <linux/version.h>
 
 
-
-#if LINUX_VERSION_IS_LESS(4,2,0)
-static inline void skb_free_frag(void *data)
-{
-	put_page(virt_to_head_page(data));
-}
-
-#include <net/flow_keys.h>
-#include <linux/jhash.h>
-
-static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
-{
-	struct flow_keys keys;
-
-	skb_flow_dissect(skb, &keys);
-	return jhash_3words((__force u32)keys.dst,
-			    (__force u32)keys.src ^ keys.ip_proto,
-			    (__force u32)keys.ports, key);
-}
-#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
-
 #if LINUX_VERSION_IS_LESS(4,13,0)
 static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
 {
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index f8efd9ed..9a6b420e 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -12,10 +12,6 @@ extern void *memdup_user_nul(const void __user *, size_t);
 ssize_t strscpy(char *dest, const char *src, size_t count);
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-char *strreplace(char *s, char old, char new);
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,6,0)
 int match_string(const char * const *array, size_t n, const char *string);
 #endif /* LINUX_VERSION_IS_LESS(4,5,0) */
diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
index daf79a4b..abc15d76 100644
--- a/backport/backport-include/net/addrconf.h
+++ b/backport/backport-include/net/addrconf.h
@@ -5,14 +5,7 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-static inline int ipv6_mc_check_mld(struct sk_buff *skb)
-{
-	WARN_ON(1);
-
-	return -1;
-}
-#elif LINUX_VERSION_IS_LESS(5,1,0)
+#if LINUX_VERSION_IS_LESS(5,1,0)
 static inline int backport_ipv6_mc_check_mld(struct sk_buff *skb)
 {
 	return ipv6_mc_check_mld(skb, NULL);
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 75f1eced..3b75b47d 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -92,8 +92,7 @@ struct backport_genl_ops {
 	int		       (*doit)(struct sk_buff *skb,
 				       struct genl_info *info);
 #if LINUX_VERSION_IS_GEQ(4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0)
+    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0)
 	int		       (*start)(struct netlink_callback *cb);
 #endif
 	int		       (*dumpit)(struct sk_buff *skb,
@@ -113,8 +112,7 @@ __real_backport_genl_register_family(struct genl_family *family)
 		     offsetof(struct backport_genl_ops, f))
 	OPS_VALIDATE(doit);
 #if LINUX_VERSION_IS_GEQ(4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0)
+    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0)
 	OPS_VALIDATE(start);
 #endif
 	OPS_VALIDATE(dumpit);
diff --git a/backport/backport-include/net/ip6_fib.h b/backport/backport-include/net/ip6_fib.h
deleted file mode 100644
index 2f21163d..00000000
--- a/backport/backport-include/net/ip6_fib.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef __BACKPORT_NET_IP6_ROUTE_H
-#define __BACKPORT_NET_IP6_ROUTE_H
-#include_next <net/ip6_fib.h>
-#include <net/ip6_route.h>
-#include <linux/route.h>
-#include <linux/version.h>
-
-/*
- * This function is avaliable with one argument since kernel 3.10, but the
- * secound one was added in 4.2.
- */
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define rt6_nexthop LINUX_BACKPORT(rt6_nexthop)
-static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt,
-					   struct in6_addr *daddr)
-{
-	if (rt->rt6i_flags & RTF_GATEWAY)
-		return &rt->rt6i_gateway;
-	else if (rt->rt6i_flags & RTF_CACHE)
-		return &rt->rt6i_dst.addr;
-	else
-		return daddr;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
-
-#endif /* __BACKPORT_NET_IP6_ROUTE_H */
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index e0076d2c..7deca730 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -4,9 +4,7 @@
 
 
 /* this was added in v3.2.79, v3.18.30, v4.1.21, v4.4.6 and 4.5 */
-#if !(LINUX_VERSION_IS_GEQ(4,4,6) || \
-      (LINUX_VERSION_IS_GEQ(4,1,21) && \
-       LINUX_VERSION_IS_LESS(4,2,0)))
+#if !LINUX_VERSION_IS_GEQ(4,4,6)
 #define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
 static inline void wireless_nlevent_flush(void) {}
 #endif
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 10c978fb..d99ef794 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -4,10 +4,6 @@
 #include <linux/version.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
-#define sk_alloc(net, family, priority, prot, kern) sk_alloc(net, family, priority, prot)
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define sk_set_bit LINUX_BACKPORT(sk_set_bit)
 static inline void sk_set_bit(int nr, struct sock *sk)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index bc0d080d..45edb8da 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
index a35c699e..d1d69115 100644
--- a/backport/compat/backport-4.10.c
+++ b/backport/compat/backport-4.10.c
@@ -255,7 +255,6 @@ int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 EXPORT_SYMBOL(mii_ethtool_get_link_ksettings);
 #endif /* LINUX_VERSION_IS_GEQ(4,6,0) */
 
-#if LINUX_VERSION_IS_GEQ(4,2,0)
 void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
@@ -273,4 +272,3 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	}
 }
 EXPORT_SYMBOL_GPL(__page_frag_cache_drain);
-#endif
diff --git a/backport/compat/backport-4.2.c b/backport/compat/backport-4.2.c
deleted file mode 100644
index b275d349..00000000
--- a/backport/compat/backport-4.2.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.2.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <crypto/scatterwalk.h>
-#include <crypto/aead.h>
-
-static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
-					    struct scatterlist *src,
-					    unsigned int len)
-{
-	for (;;) {
-		if (!len)
-			return src;
-
-		if (src->length > len)
-			break;
-
-		len -= src->length;
-		src = sg_next(src);
-	}
-
-	sg_init_table(dst, 2);
-	sg_set_page(dst, sg_page(src), src->length - len, src->offset + len);
-	scatterwalk_crypto_chain(dst, sg_next(src), 0, 2);
-
-	return dst;
-}
-
-struct aead_old_request {
-	struct scatterlist srcbuf[2];
-	struct scatterlist dstbuf[2];
-	struct aead_request subreq;
-};
-
-unsigned int crypto_aead_reqsize(struct crypto_aead *tfm)
-{
-	return crypto_aead_crt(tfm)->reqsize + sizeof(struct aead_old_request);
-}
-EXPORT_SYMBOL_GPL(crypto_aead_reqsize);
-
-struct aead_request *crypto_backport_convert(struct aead_request *req)
-{
-	struct aead_old_request *nreq = aead_request_ctx(req);
-	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct scatterlist *src, *dst;
-
-	src = scatterwalk_ffwd(nreq->srcbuf, req->src, req->assoclen);
-	dst = req->src == req->dst ?
-	      src : scatterwalk_ffwd(nreq->dstbuf, req->dst, req->assoclen);
-
-	aead_request_set_tfm(&nreq->subreq, aead);
-	aead_request_set_callback(&nreq->subreq, aead_request_flags(req),
-				  req->base.complete, req->base.data);
-	aead_request_set_crypt(&nreq->subreq, src, dst, req->cryptlen,
-			       req->iv);
-	aead_request_set_assoc(&nreq->subreq, req->src, req->assoclen);
-
-	return &nreq->subreq;
-}
-EXPORT_SYMBOL_GPL(crypto_backport_convert);
-
-char *strreplace(char *s, char old, char new)
-{
-	for (; *s; ++s)
-		if (*s == old)
-			*s = new;
-	return s;
-}
-EXPORT_SYMBOL_GPL(strreplace);
diff --git a/dependencies b/dependencies
index 20c9666f..fed4a3b8 100644
--- a/dependencies
+++ b/dependencies
@@ -3,11 +3,6 @@
 
 WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
 
-# This needs linux/pm_wakeirq.h
-WLCORE 4.2
-WL12XX 4.2
-WL18XX 4.2
-
 # hostapd uses proc_create_single_data()
 HOSTAP 4.18
 ATMEL 4.18
@@ -29,19 +24,6 @@ USB_NET_RNDIS_WLAN 4.6
 # For Coexsitence the BT driver has to export rsi_bt_ops
 RSI_COEX 4.17
 
-# depends on devm_led_classdev_register() and struct page_frag_cache
-# (can't use MT76_CORE for this as it's selected)
-MT76x0U 4.2
-MT76x0E 4.2
-MT76x2E 4.2
-MT76x2U 4.2
-MT7603E 4.2
-MT7615E 4.2
-MT7663U 4.2
-MT7663S 4.2
-MT7915E 4.2
-MT7622_WMAC 4.2
-
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
