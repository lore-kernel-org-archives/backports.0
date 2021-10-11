Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F714C433FE
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268E360EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhJKWZK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhJKWZC (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:02 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB8C06174E
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HStbQ5vGQzQl12;
        Tue, 12 Oct 2021 00:22:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjgQlOpYSB4DlKoF3QUeexVTYFSgcApnA6fP2SyfNuY=;
        b=MXLDBOxcVGDbO3OMfo+Bi/hfQYdro3yAahiYtNiOiMvoVNrt+5MUZ/vckoA599H1ZlZJLJ
        f6UTHgUS8l1orGdSStiuyPbfiYA5ekl5BttTG/JD6KX+WmN2OMxklStWTjfa2x0QE9Zo9a
        wiN0mUxqhNKAQKBieGTHDIiZrQ2P052UiK2LqyO6H+p9QcAwczpHrzI/44jj58G4KA0uLa
        ocPNmXm4W7NQhgjEz9brtxBlzjzR2Oh0KZqTZ2QJ8xcuaFoDLPhaxkytAEaj8wM/XkXGiK
        utweMP4G90NMsUuLBexqjmWDHzTXpyp5sDg1VYTPqX5eRy0CRyzcCWNab1T8kQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/14] backports: Remove support for kernel smaller than 4.1
Date:   Tue, 12 Oct 2021 00:22:24 +0200
Message-Id: <20211011222227.1189850-12-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EB5118B4
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the code which is needed to support kernel 4.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                        |   2 +-
 .../backport-include/linux/bcm47xx_nvram.h    |   5 -
 backport/backport-include/linux/device.h      |  19 --
 backport/backport-include/linux/netdevice.h   |  22 ---
 backport/backport-include/linux/of_device.h   |   4 +-
 backport/backport-include/linux/tty.h         |   5 -
 backport/backport-include/net/iw_handler.h    |  23 ---
 backport/backport-include/net/net_namespace.h |  34 ----
 backport/backport-include/net/netlink.h       |  30 ---
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.1.c                |  84 ---------
 patches/0053-possible_net_t.patch             |  19 --
 patches/0054-struct-proto_ops-sig.cocci       | 177 ------------------
 patches/0058-ptp_getsettime64/INFO            |  11 --
 .../ptp_getsettime64.cocci                    |  33 ----
 15 files changed, 2 insertions(+), 467 deletions(-)
 delete mode 100644 backport/backport-include/linux/device.h
 delete mode 100644 backport/backport-include/net/net_namespace.h
 delete mode 100644 backport/compat/backport-4.1.c
 delete mode 100644 patches/0053-possible_net_t.patch
 delete mode 100644 patches/0054-struct-proto_ops-sig.cocci
 delete mode 100644 patches/0058-ptp_getsettime64/INFO
 delete mode 100644 patches/0058-ptp_getsettime64/ptp_getsettime64.cocci

diff --git a/README b/README
index e283d766..2316fb99 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.0 and above.
+for kernels 4.1 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/bcm47xx_nvram.h b/backport/backport-include/linux/bcm47xx_nvram.h
index 5295a023..d79f7c52 100644
--- a/backport/backport-include/linux/bcm47xx_nvram.h
+++ b/backport/backport-include/linux/bcm47xx_nvram.h
@@ -2,12 +2,7 @@
 #define __BACKPORTS_BCM47XX_NVRAM_H
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_GEQ(4,1,0)
 #include_next <linux/bcm47xx_nvram.h>
-#else
-#include <linux/types.h>
-#include <linux/kernel.h>
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,2,0)
 #define bcm47xx_nvram_get_contents LINUX_BACKPORT(bcm47xx_nvram_get_contents)
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
deleted file mode 100644
index 72ef4ab9..00000000
--- a/backport/backport-include/linux/device.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __BACKPORT_DEVICE_H
-#define __BACKPORT_DEVICE_H
-#include_next <linux/device.h>
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4, 1, 0)
-#define dev_of_node LINUX_BACKPORT(dev_of_node)
-static inline struct device_node *dev_of_node(struct device *dev)
-{
-#ifndef CONFIG_OF
-	return NULL;
-#else
-	return dev->of_node;
-#endif
-}
-#endif
-
-#endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 496e2fb3..b653e0e9 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -5,12 +5,6 @@
 #include <backport/magic.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
-netdev_features_t passthru_features_check(struct sk_buff *skb,
-					  struct net_device *dev,
-					  netdev_features_t features);
-#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
 #if LINUX_VERSION_IS_LESS(4,2,0)
 #undef u64_stats_init
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
@@ -21,22 +15,6 @@ static inline void u64_stats_init(struct u64_stats_sync *syncp)
 }
 #endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
-#ifndef netdev_alloc_pcpu_stats
-#define netdev_alloc_pcpu_stats(type)				\
-({								\
-	typeof(type) __percpu *pcpu_stats = alloc_percpu(type); \
-	if (pcpu_stats)	{					\
-		int i;						\
-		for_each_possible_cpu(i) {			\
-			typeof(type) *stat;			\
-			stat = per_cpu_ptr(pcpu_stats, i);	\
-			u64_stats_init(&stat->syncp);		\
-		}						\
-	}							\
-	pcpu_stats;						\
-})
-#endif /* netdev_alloc_pcpu_stats */
-
 #if LINUX_VERSION_IS_LESS(4,10,0)
 static inline bool backport_napi_complete_done(struct napi_struct *n, int work_done)
 {
diff --git a/backport/backport-include/linux/of_device.h b/backport/backport-include/linux/of_device.h
index cdd366e3..2a4d02b8 100644
--- a/backport/backport-include/linux/of_device.h
+++ b/backport/backport-include/linux/of_device.h
@@ -13,10 +13,8 @@ static inline int backport_of_dma_configure(struct device *dev,
 	return of_dma_configure(dev, np);
 #elif LINUX_VERSION_IS_GEQ(4,12,0)
 	return of_dma_configure(dev, np);
-#elif LINUX_VERSION_IS_GEQ(4,1,0)
-	of_dma_configure(dev, np);
-	return 0;
 #else
+	of_dma_configure(dev, np);
 	return 0;
 #endif
 }
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 9de8ad1a..855f5c52 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -2,11 +2,6 @@
 #define __BACKPORT_LINUX_TTY_H
 #include_next <linux/tty.h>
 
-#if LINUX_VERSION_IS_LESS(4,1,0) && \
-    LINUX_VERSION_IS_GEQ(4,0,0)
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
 #ifndef N_NCI
 #define N_NCI		25	/* NFC NCI UART */
 #endif
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index 8b5f1c60..e0076d2c 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -2,29 +2,6 @@
 #define __BACKPORT_IW_HANDLER_H
 #include_next <net/iw_handler.h>
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
-static inline char *
-iwe_stream_add_event_check(struct iw_request_info *info, char *stream,
-			   char *ends, struct iw_event *iwe, int event_len)
-{
-	char *res = iwe_stream_add_event(info, stream, ends, iwe, event_len);
-
-	if (res == stream)
-		return ERR_PTR(-E2BIG);
-	return res;
-}
-
-static inline char *
-iwe_stream_add_point_check(struct iw_request_info *info, char *stream,
-			   char *ends, struct iw_event *iwe, char *extra)
-{
-	char *res = iwe_stream_add_point(info, stream, ends, iwe, extra);
-
-	if (res == stream)
-		return ERR_PTR(-E2BIG);
-	return res;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 /* this was added in v3.2.79, v3.18.30, v4.1.21, v4.4.6 and 4.5 */
 #if !(LINUX_VERSION_IS_GEQ(4,4,6) || \
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
deleted file mode 100644
index 47f6b3b5..00000000
--- a/backport/backport-include/net/net_namespace.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef _COMPAT_NET_NET_NAMESPACE_H
-#define _COMPAT_NET_NET_NAMESPACE_H 1
-
-#include_next <net/net_namespace.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,1,0)
-typedef struct {
-#ifdef CONFIG_NET_NS
-	struct net *net;
-#endif
-} possible_net_t;
-
-static inline void possible_write_pnet(possible_net_t *pnet, struct net *net)
-{
-#ifdef CONFIG_NET_NS
-	pnet->net = net;
-#endif
-}
-
-static inline struct net *possible_read_pnet(const possible_net_t *pnet)
-{
-#ifdef CONFIG_NET_NS
-	return pnet->net;
-#else
-	return &init_net;
-#endif
-}
-#else
-#define possible_write_pnet(pnet, net) write_pnet(pnet, net)
-#define possible_read_pnet(pnet) read_pnet(pnet)
-#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
-#endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index ba07a5ca..6f48fd71 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -435,36 +435,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-
-#if LINUX_VERSION_IS_LESS(4,1,0)
-#define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
-static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
-				  __be32 addr)
-{
-	return nla_put_be32(skb, attrtype, addr);
-}
-
-#define nla_put_in6_addr LINUX_BACKPORT(nla_put_in6_addr)
-static inline int nla_put_in6_addr(struct sk_buff *skb, int attrtype,
-				   const struct in6_addr *addr)
-{
-	return nla_put(skb, attrtype, sizeof(*addr), addr);
-}
-
-static inline __be32 nla_get_in_addr(const struct nlattr *nla)
-{
-	return *(__be32 *) nla_data(nla);
-}
-
-static inline struct in6_addr nla_get_in6_addr(const struct nlattr *nla)
-{
-	struct in6_addr tmp;
-
-	nla_memcpy(&tmp, nla, sizeof(tmp));
-	return tmp;
-}
-#endif /* < 4.1 */
-
 #if LINUX_VERSION_IS_LESS(4,4,0)
 /**
  * nla_get_le32 - return payload of __le32 attribute
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 2d7af92f..bc0d080d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
diff --git a/backport/compat/backport-4.1.c b/backport/compat/backport-4.1.c
deleted file mode 100644
index e0a3ec63..00000000
--- a/backport/compat/backport-4.1.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * Copyright (c) 2015  Stefan Assmann <sassmann@kpanic.de>
- * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.1.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/netdevice.h>
-#include <linux/tty.h>
-
-netdev_features_t passthru_features_check(struct sk_buff *skb,
-					  struct net_device *dev,
-					  netdev_features_t features)
-{
-	return features;
-}
-EXPORT_SYMBOL_GPL(passthru_features_check);
-
-#ifdef CONFIG_TTY
-#if LINUX_VERSION_IS_GEQ(4,0,0)
-static void unset_locked_termios(struct ktermios *termios,
-				 struct ktermios *old,
-				 struct ktermios *locked)
-{
-	int	i;
-
-#define NOSET_MASK(x, y, z) (x = ((x) & ~(z)) | ((y) & (z)))
-
-	if (!locked) {
-		printk(KERN_WARNING "Warning?!? termios_locked is NULL.\n");
-		return;
-	}
-
-	NOSET_MASK(termios->c_iflag, old->c_iflag, locked->c_iflag);
-	NOSET_MASK(termios->c_oflag, old->c_oflag, locked->c_oflag);
-	NOSET_MASK(termios->c_cflag, old->c_cflag, locked->c_cflag);
-	NOSET_MASK(termios->c_lflag, old->c_lflag, locked->c_lflag);
-	termios->c_line = locked->c_line ? old->c_line : termios->c_line;
-	for (i = 0; i < NCCS; i++)
-		termios->c_cc[i] = locked->c_cc[i] ?
-			old->c_cc[i] : termios->c_cc[i];
-	/* FIXME: What should we do for i/ospeed */
-}
-
-int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
-{
-	struct ktermios old_termios;
-	struct tty_ldisc *ld;
-
-	WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
-		tty->driver->subtype == PTY_TYPE_MASTER);
-	/*
-	 *	Perform the actual termios internal changes under lock.
-	 */
-
-
-	/* FIXME: we need to decide on some locking/ordering semantics
-	   for the set_termios notification eventually */
-	down_write(&tty->termios_rwsem);
-	old_termios = tty->termios;
-	tty->termios = *new_termios;
-	unset_locked_termios(&tty->termios, &old_termios, &tty->termios_locked);
-
-	if (tty->ops->set_termios)
-		tty->ops->set_termios(tty, &old_termios);
-	else
-		tty_termios_copy_hw(&tty->termios, &old_termios);
-
-	ld = tty_ldisc_ref(tty);
-	if (ld != NULL) {
-		if (ld->ops->set_termios)
-			ld->ops->set_termios(tty, &old_termios);
-		tty_ldisc_deref(ld);
-	}
-	up_write(&tty->termios_rwsem);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tty_set_termios);
-#endif /* LINUX_VERSION_IS_GEQ(4,0,0) */
-#endif /* CONFIG_TTY */
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
deleted file mode 100644
index 6ee009bd..00000000
--- a/patches/0053-possible_net_t.patch
+++ /dev/null
@@ -1,19 +0,0 @@
-diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
-index 04e5785..a251da1 100644
---- a/include/net/cfg80211.h
-+++ b/include/net/cfg80211.h
-@@ -5026,12 +5026,12 @@ struct wiphy {
- 
- static inline struct net *wiphy_net(struct wiphy *wiphy)
- {
--	return read_pnet(&wiphy->_net);
-+	return possible_read_pnet(&wiphy->_net);
- }
- 
- static inline void wiphy_net_set(struct wiphy *wiphy, struct net *net)
- {
--	write_pnet(&wiphy->_net, net);
-+	possible_write_pnet(&wiphy->_net, net);
- }
- 
- /**
diff --git a/patches/0054-struct-proto_ops-sig.cocci b/patches/0054-struct-proto_ops-sig.cocci
deleted file mode 100644
index 1d190dcd..00000000
--- a/patches/0054-struct-proto_ops-sig.cocci
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
-This provides the backport for the collateral evolution introduced
-via commit 1b784140474e4fc94281a49e96c67d29df0efbde, titled
-"net: Remove iocb argument from sendmsg and recvmsg".
-
-The net/tipc/ subsystem (Transparent Inter Process Communication (TIPC))
-relied historically on using an argument passed on the struct proto_ops
-and struct proto sendmsg and recvmsg callbacks to determine if it needed
-to perform a lock within its own code. Commit 1b784140474e4 removed replaced
-the locking functionality to require the argument and instead moved all
-the necessary heuristics into net/tipc. Other subsystems just passed NULL.
-After the net/tipc code was cleaned up from the locking (see commmit
-39a0295f901423e260a034ac7c3211ecaa9c2745 titled "tipc: Don't use iocb
-argument in socket layer") we no longer needed the extra argument on the
-struct proto_ops and struct proto callbacks.
-
-To backport non-tipc subsystems we then just need to modify the upstream
-code which declares these callbacks and add the extra argument again, but
-the same routine can be used from upstream code. The grammar we use below
-declares routines which can be pegged to struct proto_ops and struct proto
-callbacks that simply call the same upstream code, the extra argument is
-ignored. The argument can be ignored as it was only used within the
-net/tipc subsystem for locking purposes.
-*/
-
-@ proto_ops @
-identifier s, send_func, recv_func;
-@@
-
- struct proto_ops s = {
- 	.sendmsg = send_func,
- 	.recvmsg = recv_func,
-};
-
-@ mod_send depends on proto_ops @
-identifier proto_ops.send_func;
-fresh identifier backport_send = "backport_" ## send_func;
-@@
-
-send_func(...)
-{
-	...
-}
-
-+#if LINUX_VERSION_IS_LESS(4,1,0)
-+static int backport_send(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
-+{
-+	return send_func(sock, msg, len);
-+}
-+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
-@ mod_recv depends on proto_ops @
-identifier proto_ops.recv_func;
-fresh identifier backport_recv = "backport_" ## recv_func;
-@@
-
-recv_func(...)
-{
-	...
-}
-
-+#if LINUX_VERSION_IS_LESS(4,1,0)
-+static int backport_recv(struct kiocb *iocb, struct socket *sock,
-+			  struct msghdr *msg, size_t len, int flags)
-+{
-+	return recv_func(sock, msg, len, flags);
-+}
-+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
-@ mod_proto_ops_tx depends on proto_ops && mod_send @
-identifier s, proto_ops.send_func, mod_send.backport_send;
-@@
-
- struct proto_ops s = {
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- 	.sendmsg = send_func,
-+#else
-+	.sendmsg = backport_send,
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-};
-
-@ mod_proto_ops_rx depends on proto_ops && mod_recv @
-identifier s, proto_ops.recv_func, mod_recv.backport_recv;
-@@
-
- struct proto_ops s = {
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- 	.recvmsg = recv_func,
-+#else
-+	.recvmsg = backport_recv,
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-};
-
-@ mod_sock_send_callers depends on proto_ops@
-identifier proto_ops.send_func;
-identifier sock, msg, len, sk;
-@@
-
-send_func(struct socket *sock, struct msghdr *msg, size_t len)
-{
-	...
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
-	return sk->sk_prot->sendmsg(sk, msg, len);
-+#else
-+	return sk->sk_prot->sendmsg(NULL, sk, msg, len);
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-}
-
-@ proto @
-identifier s, send_func, recv_func;
-@@
-
- struct proto s = {
- 	.sendmsg = send_func,
- 	.recvmsg = recv_func,
-};
-
-@ proto_mod_send depends on proto @
-identifier proto.send_func;
-fresh identifier backport_send = "backport_" ## send_func;
-@@
-
-send_func(...)
-{
-	...
-}
-
-+#if LINUX_VERSION_IS_LESS(4,1,0)
-+static int backport_send(struct kiocb *iocb, struct sock *sk,
-+			  struct msghdr *msg, size_t len)
-+{
-+	return send_func(sk, msg, len);
-+}
-+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
-@ proto_mod_recv depends on proto @
-identifier proto.recv_func;
-fresh identifier backport_recv = "backport_" ## recv_func;
-@@
-
-recv_func(...)
-{
-	...
-}
-
-+#if LINUX_VERSION_IS_LESS(4,1,0)
-+static int backport_recv(struct kiocb *iocb, struct sock *sk,
-+			  struct msghdr *msg, size_t len,
-+			  int noblock, int flags, int *addr_len)
-+{
-+	return recv_func(sk, msg, len, noblock, flags, addr_len);
-+}
-+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
-
-@ mod_proto_tx depends on proto && proto_mod_send @
-identifier s, proto.send_func, proto_mod_send.backport_send;
-@@
-
- struct proto s = {
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- 	.sendmsg = send_func,
-+#else
-+	.sendmsg = backport_send,
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-};
-
-@ mod_proto_rx depends on proto && proto_mod_recv @
-identifier s, proto.recv_func, proto_mod_recv.backport_recv;
-@@
-
- struct proto s = {
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- 	.recvmsg = recv_func,
-+#else
-+	.recvmsg = backport_recv,
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-};
diff --git a/patches/0058-ptp_getsettime64/INFO b/patches/0058-ptp_getsettime64/INFO
deleted file mode 100644
index 9679d318..00000000
--- a/patches/0058-ptp_getsettime64/INFO
+++ /dev/null
@@ -1,11 +0,0 @@
-In kernel 4.1 struct ptp_clock_info changes function pointers gettime,
-settime to gettime64, settime64.
-
-commit 92f1719407b90475b3be0b7b9c983dec2ff8351e
-Author: Richard Cochran <richardcochran@gmail.com>
-Date:   Sun Mar 29 23:11:51 2015 +0200
-
-    ptp: introduce get/set time methods with explicit 64 bit seconds.
-
-git describe --contains 92f1719407b90475b3be0b7b9c983dec2ff8351e
-next-20150401~92^2~18^2~22
diff --git a/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci b/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
deleted file mode 100644
index ff17ebde..00000000
--- a/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
+++ /dev/null
@@ -1,33 +0,0 @@
-// ----------------------------------------------------------------------------
-// handle gettime64 to gettime function assignments
-@r1@
-expression E1, E2;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- E1.gettime64 = E2;
-+#else
-+E1.gettime = E2;
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-
-// ----------------------------------------------------------------------------
-// handle calls to gettime64 as calls to gettime
-@r2@
-expression E1, E2, E3;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- E1.gettime64(E2, E3);
-+#else
-+E1.gettime(E2, E3);
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-
-// ----------------------------------------------------------------------------
-// handle settime64 to settime function assignments
-@r3@
-expression E1, E2;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,1,0)
- E1.settime64 = E2;
-+#else
-+E1.settime = E2;
-+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
-
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
