Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC456440
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009042; cv=none; b=s4/Z2sEgtndeNPtFRFRe6+O1HSOZbQoNdNfPpkxi5zlcl4B9gW4BOo9wcVOHl2bgt5Cu+pN/k0wU50h7ppinK/R1/mxHBFw0oPbf/N9t3t7UU+SwWLJ/xVipgO5WF8ay5SoxmS7H9bKvNhxbUHr1qNtQHKwW1Rw2H9xyAYu16R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009042; c=relaxed/simple;
	bh=Q+qHfeaQ29yLX0msOGmgyqie15fmQm3rJNU1JebYG6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrDa4+vIeBAy34JKyE2bqRyz/S0pKLmnmlL/WM3nEWt5WJMFbuRMwZO4lgd9bzhACaKKm9g4Bsq2dll5LjczXb2o2TKeVIC3dft97rSTbfyEOJZLMH/dDQdvfTXkM0sltXaFmj5VkCcN2ykEsZUiBUkMkPSUVOgxpaIwdFVT/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ORzxueYb; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ORzxueYb"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V7lQY06KCz9sqS;
	Tue,  2 Apr 2024 00:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuFuTy8nELrT6qzBZz5PNDgdTpgfh04J5CKb6gl5xxU=;
	b=ORzxueYboHB3B1l7nKE6RL2fVAyYfA4z4KRsdhGS1wE09Dr8h0vXjFQ9lRlftUkbjJrzKG
	J56LZtgf40I5ZwaGgxpDPhVlOWa0/lPl6fwEMFiuoSkFY4uB4QSjoy0O/F+00wt932qzCV
	Rbg95WpaifBZb+qqGRw8l/nqRHNCS1T1l/VDuA7RlV4xj7andRMM8o4iktJUJXodc2SiHp
	0wQuxheOm/IOuRTlwpVpXt1l2fiLnMmyUZktUXe1BL/hWiWCaBge9vUn4myWf5/38y3jZo
	cr+za7XHCGJCLTiKB+exIJBS5KDLFEDZ0UTnKa5xmUbZv03EZUxBqnzraQxLTw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] backports: Remove support for kernel smaller than 4.10
Date: Tue,  2 Apr 2024 00:03:10 +0200
Message-ID: <20240401220314.2434455-7-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQY06KCz9sqS

This removes all the code which is needed to support kernel 4.9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |   1 -
 README                                        |   2 +-
 backport/backport-include/linux/bits.h        |   3 +-
 backport/backport-include/linux/gfp.h         |  25 --
 backport/backport-include/linux/interrupt.h   |  40 ---
 backport/backport-include/linux/mii.h         |  14 -
 backport/backport-include/linux/netdevice.h   |  22 --
 backport/backport-include/linux/nospec.h      |   3 +-
 backport/backport-include/linux/skbuff.h      |   3 +-
 .../backport-include/linux/virtio_config.h    |   4 -
 backport/backport-include/net/genetlink.h     |   6 -
 backport/backport-include/net/netlink.h       |  13 -
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.10.c               | 241 ------------------
 patches/0073-netdevice-mtu-range.cocci        | 100 --------
 patches/0074-netdevice-mtu-range-ifdefs.cocci |  26 --
 patches/0077-genl-ro-after-init/hwsim.patch   |  11 -
 patches/0077-genl-ro-after-init/nl80211.patch |  11 -
 patches/0080-i2c-proble-new.cocci             |  25 --
 19 files changed, 4 insertions(+), 547 deletions(-)
 delete mode 100644 backport/backport-include/linux/gfp.h
 delete mode 100644 backport/backport-include/linux/mii.h
 delete mode 100644 backport/compat/backport-4.10.c
 delete mode 100644 patches/0073-netdevice-mtu-range.cocci
 delete mode 100644 patches/0074-netdevice-mtu-range-ifdefs.cocci
 delete mode 100644 patches/0077-genl-ro-after-init/hwsim.patch
 delete mode 100644 patches/0077-genl-ro-after-init/nl80211.patch
 delete mode 100644 patches/0080-i2c-proble-new.cocci

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index fb85a0e9..f2f778ad 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.9",
            "4.10",
            "4.11",
            "4.12",
diff --git a/README b/README
index 994baa4d..7d90c543 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.9 and above.
+for kernels 4.10 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/bits.h b/backport/backport-include/linux/bits.h
index 7c66169f..387c9884 100644
--- a/backport/backport-include/linux/bits.h
+++ b/backport/backport-include/linux/bits.h
@@ -3,8 +3,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_IS_GEQ(4,19,0) || \
-    LINUX_VERSION_IN_RANGE(4,14,119, 4,15,0) || \
-    LINUX_VERSION_IN_RANGE(4,9,176, 4,10,0)
+    LINUX_VERSION_IN_RANGE(4,14,119, 4,15,0)
 #include_next <linux/bits.h>
 #else
 #include <linux/bitops.h>
diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
deleted file mode 100644
index bfc8cbca..00000000
--- a/backport/backport-include/linux/gfp.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __BACKPORT_LINUX_GFP_H
-#define __BACKPORT_LINUX_GFP_H
-#include_next <linux/gfp.h>
-
-#ifndef ___GFP_KSWAPD_RECLAIM
-#define ___GFP_KSWAPD_RECLAIM	0x0u
-#endif
-
-#ifndef __GFP_KSWAPD_RECLAIM
-#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,10,0)
-#define page_frag_alloc LINUX_BACKPORT(page_frag_alloc)
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-				    unsigned int fragsz, gfp_t gfp_mask)
-{
-	return __alloc_page_frag(nc, fragsz, gfp_mask);
-}
-
-#define __page_frag_cache_drain LINUX_BACKPORT(__page_frag_cache_drain)
-void __page_frag_cache_drain(struct page *page, unsigned int count);
-#endif /* < 4.10*/
-
-#endif /* __BACKPORT_LINUX_GFP_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index f42f2ddd..4629fb18 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -2,46 +2,6 @@
 #define _BP_LINUX_INTERRUPT_H
 #include <linux/version.h>
 #include_next <linux/interrupt.h>
-#include <linux/ktime.h>
-
-#if LINUX_VERSION_IS_LESS(4,10,0)
-
-/* Forward a hrtimer so it expires after now: */
-static inline u64
-backport_hrtimer_forward(struct hrtimer *timer, ktime_t now, s64 interval)
-{
-	ktime_t _interval = { .tv64 = interval };
-
-	return hrtimer_forward(timer, now, _interval);
-}
-#define hrtimer_forward LINUX_BACKPORT(hrtimer_forward)
-
-static inline u64
-backport_hrtimer_forward_now(struct hrtimer *timer, s64 interval)
-{
-	ktime_t _interval = { .tv64 = interval };
-
-	return hrtimer_forward_now(timer, _interval);
-}
-#define hrtimer_forward_now LINUX_BACKPORT(hrtimer_forward_now)
-
-static inline s64 backport_ns_to_ktime(u64 ns)
-{
-	ktime_t _time = ns_to_ktime(ns);
-
-	return _time.tv64;
-}
-#define ns_to_ktime LINUX_BACKPORT(ns_to_ktime)
-
-static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
-					  const enum hrtimer_mode mode)
-{
-	ktime_t _time = { .tv64 = time };
-	hrtimer_start(timer, _time, mode);
-}
-#define hrtimer_start LINUX_BACKPORT(hrtimer_start)
-
-#endif
 
 #if LINUX_VERSION_IS_LESS(5,9,0)
 
diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
deleted file mode 100644
index dcabbcc8..00000000
--- a/backport/backport-include/linux/mii.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __BACKPORT_LINUX_MII_H
-#define __BACKPORT_LINUX_MII_H
-#include_next <linux/mii.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,11,0)
-extern int mii_ethtool_get_link_ksettings(
-	struct mii_if_info *mii, struct ethtool_link_ksettings *cmd);
-extern int mii_ethtool_set_link_ksettings(
-	struct mii_if_info *mii, const struct ethtool_link_ksettings *cmd);
-#endif /* < 4,11,0 */
-
-#endif /* __BACKPORT_LINUX_MII_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 156bcade..f692b425 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -5,28 +5,6 @@
 #include <backport/magic.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,10,0)
-static inline bool backport_napi_complete_done(struct napi_struct *n, int work_done)
-{
-	if (unlikely(test_bit(NAPI_STATE_NPSVC, &n->state)))
-		return false;
-
-	napi_complete_done(n, work_done);
-	return true;
-}
-
-static inline bool backport_napi_complete(struct napi_struct *n)
-{
-	return backport_napi_complete_done(n, 0);
-}
-#define napi_complete_done LINUX_BACKPORT(napi_complete_done)
-#define napi_complete LINUX_BACKPORT(napi_complete)
-#endif /* < 4.10 */
-
-#ifndef NETIF_F_CSUM_MASK
-#define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,11,9)
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->destructor = __ ## _destructor
diff --git a/backport/backport-include/linux/nospec.h b/backport/backport-include/linux/nospec.h
index d4de80a4..f5ba8980 100644
--- a/backport/backport-include/linux/nospec.h
+++ b/backport/backport-include/linux/nospec.h
@@ -2,8 +2,7 @@
 #define _BACKPORT_LINUX_NOSPEC_H
 
 #if LINUX_VERSION_IS_GEQ(4,15,2) || \
-    LINUX_VERSION_IN_RANGE(4,14,18, 4,15,0) || \
-    LINUX_VERSION_IN_RANGE(4,9,81, 4,10,0)
+    LINUX_VERSION_IN_RANGE(4,14,18, 4,15,0)
 #include_next <linux/nospec.h>
 #else
 #define array_index_nospec(index, size)	(index)
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index b8a16ed3..09bf33fd 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -107,8 +107,7 @@ static inline void nf_reset_ct(struct sk_buff *skb)
 #if LINUX_VERSION_IS_LESS(5,6,0) &&			\
 	!LINUX_VERSION_IN_RANGE(5,4,69, 5,5,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,19,149, 4,20,0) &&	\
-	!LINUX_VERSION_IN_RANGE(4,14,200, 4,15,0) &&	\
-	!LINUX_VERSION_IN_RANGE(4,9,238, 4,10,0)
+	!LINUX_VERSION_IN_RANGE(4,14,200, 4,15,0)
 /**
  *	skb_queue_len_lockless	- get queue length
  *	@list_: list to measure
diff --git a/backport/backport-include/linux/virtio_config.h b/backport/backport-include/linux/virtio_config.h
index aeb1ba10..fadac0d2 100644
--- a/backport/backport-include/linux/virtio_config.h
+++ b/backport/backport-include/linux/virtio_config.h
@@ -12,11 +12,7 @@ struct irq_affinity;
 static inline
 int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-#if LINUX_VERSION_IS_LESS(4,10,0)
-			const char * const names[],
-#else
 			const char *names[],
-#endif
 			struct irq_affinity *desc)
 {
 #if LINUX_VERSION_IS_LESS(4,11,0)
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 3ad8ebe8..9a9bfcd4 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -50,12 +50,6 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 	return (u8 *)info->genlhdr + GENL_HDRLEN;
 }
 
-#if LINUX_VERSION_IS_LESS(4,10,0)
-#define __genl_ro_after_init
-#else
-#define __genl_ro_after_init __ro_after_init
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,15,0)
 #define genlmsg_nlhdr LINUX_BACKPORT(genlmsg_nlhdr)
 static inline struct nlmsghdr *genlmsg_nlhdr(void *user_hdr)
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index c8ea6af3..8fa76676 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -435,19 +435,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-#if LINUX_VERSION_IS_LESS(4,10,0)
-/**
- * nla_memdup - duplicate attribute memory (kmemdup)
- * @src: netlink attribute to duplicate from
- * @gfp: GFP mask
- */
-#define nla_memdump LINUX_BACKPORT(nla_memdup)
-static inline void *nla_memdup(const struct nlattr *src, gfp_t gfp)
-{
-	return kmemdup(nla_data(src), nla_len(src), gfp);
-}
-#endif /* < 4.9 */
-
 #ifndef NLA_POLICY_MIN_LEN
 #define NLA_POLICY_MIN_LEN(_len) {		\
 	.type = NLA_BINARY			\
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 7bc66fb1..795b5267 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_11) += backport-4.11.o
 compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
deleted file mode 100644
index 565dc3aa..00000000
--- a/backport/compat/backport-4.10.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/*
- * Copyright(c) 2017 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.10.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/ethtool.h>
-#include <linux/mii.h>
-#include <linux/page_ref.h>
-#include <linux/gfp.h>
-
-static u32 mii_get_an(struct mii_if_info *mii, u16 addr)
-{
-	int advert;
-
-	advert = mii->mdio_read(mii->dev, mii->phy_id, addr);
-
-	return mii_lpa_to_ethtool_lpa_t(advert);
-}
-
-/**
- * mii_ethtool_set_link_ksettings - set settings that are specified in @cmd
- * @mii: MII interfaces
- * @cmd: requested ethtool_link_ksettings
- *
- * Returns 0 for success, negative on error.
- */
-int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
-				   const struct ethtool_link_ksettings *cmd)
-{
-	struct net_device *dev = mii->dev;
-	u32 speed = cmd->base.speed;
-
-	if (speed != SPEED_10 &&
-	    speed != SPEED_100 &&
-	    speed != SPEED_1000)
-		return -EINVAL;
-	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
-		return -EINVAL;
-	if (cmd->base.port != PORT_MII)
-		return -EINVAL;
-	if (cmd->base.phy_address != mii->phy_id)
-		return -EINVAL;
-	if (cmd->base.autoneg != AUTONEG_DISABLE &&
-	    cmd->base.autoneg != AUTONEG_ENABLE)
-		return -EINVAL;
-	if ((speed == SPEED_1000) && (!mii->supports_gmii))
-		return -EINVAL;
-
-	/* ignore supported, maxtxpkt, maxrxpkt */
-
-	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		u32 bmcr, advert, tmp;
-		u32 advert2 = 0, tmp2 = 0;
-		u32 advertising;
-
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
-
-		if ((advertising & (ADVERTISED_10baseT_Half |
-				    ADVERTISED_10baseT_Full |
-				    ADVERTISED_100baseT_Half |
-				    ADVERTISED_100baseT_Full |
-				    ADVERTISED_1000baseT_Half |
-				    ADVERTISED_1000baseT_Full)) == 0)
-			return -EINVAL;
-
-		/* advertise only what has been requested */
-		advert = mii->mdio_read(dev, mii->phy_id, MII_ADVERTISE);
-		tmp = advert & ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
-		if (mii->supports_gmii) {
-			advert2 = mii->mdio_read(dev, mii->phy_id,
-						 MII_CTRL1000);
-			tmp2 = advert2 &
-				~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
-		}
-		tmp |= ethtool_adv_to_mii_adv_t(advertising);
-
-		if (mii->supports_gmii)
-			tmp2 |= ethtool_adv_to_mii_ctrl1000_t(advertising);
-		if (advert != tmp) {
-			mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, tmp);
-			mii->advertising = tmp;
-		}
-		if ((mii->supports_gmii) && (advert2 != tmp2))
-			mii->mdio_write(dev, mii->phy_id, MII_CTRL1000, tmp2);
-
-		/* turn on autonegotiation, and force a renegotiate */
-		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
-		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
-		mii->mdio_write(dev, mii->phy_id, MII_BMCR, bmcr);
-
-		mii->force_media = 0;
-	} else {
-		u32 bmcr, tmp;
-
-		/* turn off auto negotiation, set speed and duplexity */
-		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
-		tmp = bmcr & ~(BMCR_ANENABLE | BMCR_SPEED100 |
-			       BMCR_SPEED1000 | BMCR_FULLDPLX);
-		if (speed == SPEED_1000)
-			tmp |= BMCR_SPEED1000;
-		else if (speed == SPEED_100)
-			tmp |= BMCR_SPEED100;
-		if (cmd->base.duplex == DUPLEX_FULL) {
-			tmp |= BMCR_FULLDPLX;
-			mii->full_duplex = 1;
-		} else {
-			mii->full_duplex = 0;
-		}
-		if (bmcr != tmp)
-			mii->mdio_write(dev, mii->phy_id, MII_BMCR, tmp);
-
-		mii->force_media = 1;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(mii_ethtool_set_link_ksettings);
-
-
-/**
- * mii_ethtool_get_link_ksettings - get settings that are specified in @cmd
- * @mii: MII interface
- * @cmd: requested ethtool_link_ksettings
- *
- * The @cmd parameter is expected to have been cleared before calling
- * mii_ethtool_get_link_ksettings().
- *
- * Returns 0 for success, negative on error.
- */
-int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
-				   struct ethtool_link_ksettings *cmd)
-{
-	struct net_device *dev = mii->dev;
-	u16 bmcr, bmsr, ctrl1000 = 0, stat1000 = 0;
-	u32 nego, supported, advertising, lp_advertising;
-
-	supported = (SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
-		     SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
-		     SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII);
-	if (mii->supports_gmii)
-		supported |= SUPPORTED_1000baseT_Half |
-			SUPPORTED_1000baseT_Full;
-
-	/* only supports twisted-pair */
-	cmd->base.port = PORT_MII;
-
-	/* this isn't fully supported at higher layers */
-	cmd->base.phy_address = mii->phy_id;
-	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C22;
-
-	advertising = ADVERTISED_TP | ADVERTISED_MII;
-
-	bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
-	bmsr = mii->mdio_read(dev, mii->phy_id, MII_BMSR);
-	if (mii->supports_gmii) {
-		ctrl1000 = mii->mdio_read(dev, mii->phy_id, MII_CTRL1000);
-		stat1000 = mii->mdio_read(dev, mii->phy_id, MII_STAT1000);
-	}
-	if (bmcr & BMCR_ANENABLE) {
-		advertising |= ADVERTISED_Autoneg;
-		cmd->base.autoneg = AUTONEG_ENABLE;
-
-		advertising |= mii_get_an(mii, MII_ADVERTISE);
-		if (mii->supports_gmii)
-			advertising |= mii_ctrl1000_to_ethtool_adv_t(ctrl1000);
-
-		if (bmsr & BMSR_ANEGCOMPLETE) {
-			lp_advertising = mii_get_an(mii, MII_LPA);
-			lp_advertising |=
-					mii_stat1000_to_ethtool_lpa_t(stat1000);
-		} else {
-			lp_advertising = 0;
-		}
-
-		nego = advertising & lp_advertising;
-
-		if (nego & (ADVERTISED_1000baseT_Full |
-			    ADVERTISED_1000baseT_Half)) {
-			cmd->base.speed = SPEED_1000;
-			cmd->base.duplex = !!(nego & ADVERTISED_1000baseT_Full);
-		} else if (nego & (ADVERTISED_100baseT_Full |
-				   ADVERTISED_100baseT_Half)) {
-			cmd->base.speed = SPEED_100;
-			cmd->base.duplex = !!(nego & ADVERTISED_100baseT_Full);
-		} else {
-			cmd->base.speed = SPEED_10;
-			cmd->base.duplex = !!(nego & ADVERTISED_10baseT_Full);
-		}
-	} else {
-		cmd->base.autoneg = AUTONEG_DISABLE;
-
-		cmd->base.speed = ((bmcr & BMCR_SPEED1000 &&
-				    (bmcr & BMCR_SPEED100) == 0) ?
-				   SPEED_1000 :
-				   ((bmcr & BMCR_SPEED100) ?
-				    SPEED_100 : SPEED_10));
-		cmd->base.duplex = (bmcr & BMCR_FULLDPLX) ?
-			DUPLEX_FULL : DUPLEX_HALF;
-
-		lp_advertising = 0;
-	}
-
-	mii->full_duplex = cmd->base.duplex;
-
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
-
-	/* ignore maxtxpkt, maxrxpkt for now */
-
-	return 0;
-}
-EXPORT_SYMBOL(mii_ethtool_get_link_ksettings);
-
-void __page_frag_cache_drain(struct page *page, unsigned int count)
-{
-	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-
-	if (page_ref_sub_and_test(page, count)) {
-		unsigned int order = compound_order(page);
-
-		/*
-		 * __free_pages_ok() is not exported so call
-		 * __free_pages() which decrements the ref counter
-		 * and increment the ref counter before.
-		 */
-		page_ref_inc(page);
-		__free_pages(page, order);
-	}
-}
-EXPORT_SYMBOL_GPL(__page_frag_cache_drain);
diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netdevice-mtu-range.cocci
deleted file mode 100644
index 7afe900e..00000000
--- a/patches/0073-netdevice-mtu-range.cocci
+++ /dev/null
@@ -1,100 +0,0 @@
-@initialize:python@
-@@
-
-first_ops = 0
-
-@both@
-struct net_device *ndevexp;
-constant e1, e2;
-identifier func;
-position p;
-@@
-func(...) {
-	<+...
-	ndevexp->min_mtu = e1;
-	ndevexp->max_mtu@p = e2;
-	...+>
-}
-
-@@
-struct net_device *ndevexp;
-constant MAX;
-identifier func;
-position p != both.p;
-@@
-func(...) {
-	<+...
-+	ndevexp->min_mtu = 0;
-	ndevexp->max_mtu@p = MAX;
-	...+>
-}
-
-@r@
-identifier OPS;
-position p;
-@@
-
-struct net_device_ops OPS@p = { ... };
-
-@script:python depends on r@
-@@
-
-first_ops = 0
-
-@script:python@
-p << r.p;
-@@
-
-ln = int(p[0].line)
-if first_ops == 0 or ln < first_ops:
-  first_ops = ln
-
-@script:python@
-p << r.p;
-@@
-
-ln = int(p[0].line)
-if not(first_ops == ln):
-  cocci.include_match(False)
-
-@r1 exists@
-struct net_device *ndevexp;
-constant e1, e2;
-identifier func;
-@@
-func(...) {
-	<+...
-	ndevexp->min_mtu = e1;
-	ndevexp->max_mtu = e2;
-	...+>
-}
-
-@r2@
-constant r1.e1,r1.e2;
-identifier r.OPS;
-@@
-+#if LINUX_VERSION_IS_LESS(4,10,0)
-+ static int __change_mtu(struct net_device *ndev, int new_mtu)
-+ {
-+ if (new_mtu < e1 || new_mtu > e2)
-+             return -EINVAL;
-+             ndev->mtu = new_mtu;
-+             return 0;
-+ }
-+#endif
-+
-struct net_device_ops OPS = {
-       ...
-};
-
-@depends on r2@
-identifier OPS;
-@@
-
-struct net_device_ops OPS = {
-+#if LINUX_VERSION_IS_LESS(4,10,0)
-+      .ndo_change_mtu = __change_mtu,
-+#endif
-       ...
-};
-
diff --git a/patches/0074-netdevice-mtu-range-ifdefs.cocci b/patches/0074-netdevice-mtu-range-ifdefs.cocci
deleted file mode 100644
index bb1ca95c..00000000
--- a/patches/0074-netdevice-mtu-range-ifdefs.cocci
+++ /dev/null
@@ -1,26 +0,0 @@
-@@
-struct net_device *ndevexp;
-expression E;
-identifier func;
-@@
-func(...) {
-	<+...
-+#if LINUX_VERSION_IS_GEQ(4,10,0)
-	ndevexp->min_mtu = E;
-+#endif
-	...+>
-}
-
-@@
-struct net_device *ndevexp;
-expression E;
-identifier func;
-@@
-func(...) {
-	<+...
-+#if LINUX_VERSION_IS_GEQ(4,10,0)
-	ndevexp->max_mtu = E;
-+#endif
-	...+>
-}
-
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
deleted file mode 100644
index 9029a443..00000000
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/mac80211_hwsim.c
-+++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4129,7 +4129,7 @@ static const struct genl_small_ops hwsim
- 	},
- };
- 
--static struct genl_family hwsim_genl_family __ro_after_init = {
-+static struct genl_family hwsim_genl_family __genl_ro_after_init = {
- 	.name = "MAC80211_HWSIM",
- 	.version = 1,
- 	.maxattr = HWSIM_ATTR_MAX,
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
deleted file mode 100644
index 0bed66d3..00000000
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -15941,7 +15941,7 @@ static const struct genl_small_ops nl802
- 	},
- };
- 
--static struct genl_family nl80211_fam __ro_after_init = {
-+static struct genl_family nl80211_fam __genl_ro_after_init = {
- 	.name = NL80211_GENL_NAME,	/* have users key off the name instead */
- 	.hdrsize = 0,			/* no private header */
- 	.version = 1,			/* no particular meaning now */
diff --git a/patches/0080-i2c-proble-new.cocci b/patches/0080-i2c-proble-new.cocci
deleted file mode 100644
index 35580aca..00000000
--- a/patches/0080-i2c-proble-new.cocci
+++ /dev/null
@@ -1,25 +0,0 @@
-@r@
-identifier OPS;
-identifier i2c_probe;
-fresh identifier i2c_probe_wrap = "bp_" ## i2c_probe;
-position p;
-@@
-struct i2c_driver OPS@p = {
-+#if LINUX_VERSION_IS_GEQ(4,10,0)
-	.probe_new = i2c_probe,
-+#else
-+	.probe = i2c_probe_wrap,
-+#endif
-};
-
-@@
-identifier r.i2c_probe_wrap;
-identifier r.i2c_probe;
-@@
-int i2c_probe(...) {...}
-+#if LINUX_VERSION_IS_LESS(4,10,0)
-+static int i2c_probe_wrap(struct i2c_client *client, const struct i2c_device_id *id)
-+{
-+	return i2c_probe(client);
-+}
-+#endif
-- 
2.44.0

