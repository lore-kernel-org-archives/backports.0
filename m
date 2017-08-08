Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34333 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdHHNGs (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Aug 2017 09:06:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id y192so2933228pgd.1
        for <backports@vger.kernel.org>; Tue, 08 Aug 2017 06:06:48 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH] backports: remove 802.15.4 entirely
Date: Tue,  8 Aug 2017 21:06:43 +0800
Message-Id: <1502197603-22790-1-git-send-email-acelan.kao@canonical.com> (sfid-20170808_150651_131075_5CF82FA1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

802.15.4 has been removed by this commit,
   15a3df8 backports: remove 802.15.4 entirely
but there are some files left behind.
Remove them all.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 backport/Kconfig.sources                           |  5 --
 backport/Makefile.kernel                           |  5 --
 backport/compat/Kconfig                            |  1 -
 dependencies                                       | 10 ----
 patches/0006-ieee802154-6lowpan-namespace.patch    | 63 ----------------------
 patches/0007-lowpan-inet_frag_lru_move.patch       | 59 --------------------
 patches/0008-net-user-ns.patch                     | 17 ------
 patches/0013-fix-makefile-includes/6lowpan.patch   | 10 ----
 patches/0013-fix-makefile-includes/cfg802154.patch | 10 ----
 patches/0030-qdisc_tx_busylock/ieee802154.patch    | 22 --------
 patches/0044-no_user_ns_in_net/ieee802154.patch    | 30 -----------
 .../cfg802154.patch                                | 18 -------
 patches/0068-proto-hash/ieee802154.patch           | 62 ---------------------
 13 files changed, 312 deletions(-)
 delete mode 100644 patches/0006-ieee802154-6lowpan-namespace.patch
 delete mode 100644 patches/0007-lowpan-inet_frag_lru_move.patch
 delete mode 100644 patches/0008-net-user-ns.patch
 delete mode 100644 patches/0013-fix-makefile-includes/6lowpan.patch
 delete mode 100644 patches/0013-fix-makefile-includes/cfg802154.patch
 delete mode 100644 patches/0030-qdisc_tx_busylock/ieee802154.patch
 delete mode 100644 patches/0044-no_user_ns_in_net/ieee802154.patch
 delete mode 100644 patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
 delete mode 100644 patches/0068-proto-hash/ieee802154.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 5711433..d1d8834 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -16,9 +16,4 @@ source "$BACKPORT_DIR/net/nfc/Kconfig"
 
 source "$BACKPORT_DIR/drivers/media/Kconfig"
 
-source "$BACKPORT_DIR/net/6lowpan/Kconfig"
-source "$BACKPORT_DIR/net/ieee802154/Kconfig"
-source "$BACKPORT_DIR/net/mac802154/Kconfig"
-source "$BACKPORT_DIR/drivers/net/ieee802154/Kconfig"
-
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 01fe733..9f5dde0 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -47,10 +47,5 @@ obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
-obj-$(CPTCFG_6LOWPAN) += net/6lowpan/
-obj-$(CPTCFG_IEEE802154) += net/ieee802154/
-obj-$(CPTCFG_MAC802154) += net/mac802154/
-obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
-
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
 obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f66d5f7..f350217 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -116,7 +116,6 @@ config BPAUTO_BUILD_CRYPTO_CCM
 config BPAUTO_CRYPTO_SKCIPHER
 	tristate
 	depends on KERNEL_4_3
-	default y if BACKPORTED_MAC802154
 	default y if BACKPORTED_LIB80211_CRYPT_WEP
 	default y if BACKPORTED_LIB80211_CRYPT_TKIP
 	default y if BACKPORTED_BT
diff --git a/dependencies b/dependencies
index 43afe48..4a0d9ec 100644
--- a/dependencies
+++ b/dependencies
@@ -112,16 +112,6 @@ NFC_MEI_PHY 4.10
 NFC_PN544_I2C 3.13
 NFC_FDP 3.13
 
-# can not backport ieee802154_ptr in struct net_device wich was added in
-# 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
-IEEE802154 3.19
-IEEE802154_MRF24J40 3.5
-IEEE802154_6LOWPAN 3.5
-# needs devm_regmap_init_spi()
-IEEE802154_AT86RF230 3.4
-# CC2520 needes devm_pinctrl_get_select_default()
-IEEE802154_CC2520 3.5
-
 IR_IMG 3.5
 
 # missing include/linux/mfd/syscon.h file
diff --git a/patches/0006-ieee802154-6lowpan-namespace.patch b/patches/0006-ieee802154-6lowpan-namespace.patch
deleted file mode 100644
index 2412a45..0000000
--- a/patches/0006-ieee802154-6lowpan-namespace.patch
+++ /dev/null
@@ -1,63 +0,0 @@
-This is required unless we add some macro wrappers for this
-type of static work upstream but not sure if that is a good
-idea yet.
-
---- a/net/ieee802154/reassembly.c
-+++ b/net/ieee802154/reassembly.c
-@@ -97,7 +97,11 @@ static void lowpan_frag_expire(unsigned
- 	struct net *net;
- 
- 	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
-+#else
-+	net = &init_net;
-+#endif
- 
- 	spin_lock(&fq->q.lock);
- 
-@@ -395,24 +399,44 @@ static int zero;
- static struct ctl_table lowpan_frags_ns_ctl_table[] = {
- 	{
- 		.procname	= "6lowpanfrag_high_thresh",
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 		.data		= &init_net.ieee802154_lowpan.frags.high_thresh,
-+#else
-+		.data		= &ieee802154_lowpan.frags.high_thresh,
-+#endif
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec_minmax,
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 		.extra1		= &init_net.ieee802154_lowpan.frags.low_thresh
-+#else
-+		.extra1		= &ieee802154_lowpan.frags.low_thresh
-+#endif
- 	},
- 	{
- 		.procname	= "6lowpanfrag_low_thresh",
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 		.data		= &init_net.ieee802154_lowpan.frags.low_thresh,
-+#else
-+		.data		= &ieee802154_lowpan.frags.low_thresh,
-+#endif
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec_minmax,
- 		.extra1		= &zero,
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
-+#else
-+		.extra2		= &ieee802154_lowpan.frags.high_thresh
-+#endif
- 	},
- 	{
- 		.procname	= "6lowpanfrag_time",
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 		.data		= &init_net.ieee802154_lowpan.frags.timeout,
-+#else
-+		.data		= &ieee802154_lowpan.frags.timeout,
-+#endif
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec_jiffies,
diff --git a/patches/0007-lowpan-inet_frag_lru_move.patch b/patches/0007-lowpan-inet_frag_lru_move.patch
deleted file mode 100644
index ef52414..0000000
--- a/patches/0007-lowpan-inet_frag_lru_move.patch
+++ /dev/null
@@ -1,59 +0,0 @@
-Domain specific backport for inet_frag_lru_move()
-This requires two parts, the data structure changes
-and then domain specific inet_frag_lru_move() define.
-
---- a/net/ieee802154/reassembly.c
-+++ b/net/ieee802154/reassembly.c
-@@ -89,6 +89,9 @@ static void lowpan_frag_init(struct inet
- 	fq->d_size = arg->d_size;
- 	fq->saddr = *arg->src;
- 	fq->daddr = *arg->dst;
-+#if LINUX_VERSION_IS_LESS(3,9,0)
-+	spin_lock_init(&fq->lru_lock);
-+#endif
- }
- 
- static void lowpan_frag_expire(unsigned long data)
---- a/net/ieee802154/reassembly.h
-+++ b/net/ieee802154/reassembly.h
-@@ -2,6 +2,7 @@
- #define __IEEE802154_6LOWPAN_REASSEMBLY_H__
- 
- #include <net/inet_frag.h>
-+#include <linux/spinlock.h>
- 
- struct lowpan_create_arg {
- 	u16 tag;
-@@ -19,8 +20,32 @@ struct lowpan_frag_queue {
- 	u16			d_size;
- 	struct ieee802154_addr	saddr;
- 	struct ieee802154_addr	daddr;
-+#if LINUX_VERSION_IS_LESS(3,9,0)
-+	spinlock_t		lru_lock;
-+#endif
- };
- 
-+#if LINUX_VERSION_IS_LESS(3,9,0)
-+/*
-+ * XXX: this is a *domain* specific inet_frag_lru_move backport,
-+ * note the added lowpan_ prefix, this requires a respective patch
-+ * which extends struct lowpan_frag_queue with an lru_lock and
-+ * initializes it. We add this helper here to reduce the backport.
-+ * There is no way to generalize the other changes in the patch.
-+ */
-+#define inet_frag_lru_move LINUX_BACKPORT(lowpan_inet_frag_lru_move)
-+static inline void inet_frag_lru_move(struct inet_frag_queue *q)
-+{
-+	struct lowpan_frag_queue *fq;
-+
-+	fq = container_of(q, struct lowpan_frag_queue, q);
-+
-+	spin_lock(&fq->lru_lock);
-+	list_move_tail(&q->lru_list, &q->net->lru_list);
-+	spin_unlock(&fq->lru_lock);
-+}
-+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-+
- static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
- {
- 	switch (a->mode) {
diff --git a/patches/0008-net-user-ns.patch b/patches/0008-net-user-ns.patch
deleted file mode 100644
index 79605c0..0000000
--- a/patches/0008-net-user-ns.patch
+++ /dev/null
@@ -1,17 +0,0 @@
-network namespaces didn't get usernamespaces pegged until 3.8
-via commit 038e7332b8.
-
---- a/net/ieee802154/reassembly.c
-+++ b/net/ieee802154/reassembly.c
-@@ -481,9 +481,11 @@ static int __net_init lowpan_frags_ns_sy
- 		table[1].extra2 = &ieee802154_lowpan->frags.high_thresh;
- 		table[2].data = &ieee802154_lowpan->frags.timeout;
- 
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
- 		/* Don't export sysctls to unprivileged users */
- 		if (net->user_ns != &init_user_ns)
- 			table[0].procname = NULL;
-+#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
- 	}
- 
- 	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
diff --git a/patches/0013-fix-makefile-includes/6lowpan.patch b/patches/0013-fix-makefile-includes/6lowpan.patch
deleted file mode 100644
index 70d0dd5..0000000
--- a/patches/0013-fix-makefile-includes/6lowpan.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/6lowpan/core.c
-+++ b/net/6lowpan/core.c
-@@ -14,6 +14,7 @@
- #include <linux/module.h>
- 
- #include <net/6lowpan.h>
-+#include <linux/if_arp.h>
- 
- #include "6lowpan_i.h"
- 
diff --git a/patches/0013-fix-makefile-includes/cfg802154.patch b/patches/0013-fix-makefile-includes/cfg802154.patch
deleted file mode 100644
index 93caa14..0000000
--- a/patches/0013-fix-makefile-includes/cfg802154.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/include/net/cfg802154.h
-+++ b/include/net/cfg802154.h
-@@ -26,6 +26,7 @@
- 
- struct wpan_phy;
- struct wpan_phy_cca;
-+struct wpan_dev;
- 
- #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
- struct ieee802154_llsec_device_key;
diff --git a/patches/0030-qdisc_tx_busylock/ieee802154.patch b/patches/0030-qdisc_tx_busylock/ieee802154.patch
deleted file mode 100644
index 3794a02..0000000
--- a/patches/0030-qdisc_tx_busylock/ieee802154.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/net/ieee802154/6lowpan_rtnl.c
-+++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -428,7 +428,9 @@ static struct header_ops lowpan_header_o
- 	.create	= lowpan_header_create,
- };
- 
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- static struct lock_class_key lowpan_tx_busylock;
-+#endif
- static struct lock_class_key lowpan_netdev_xmit_lock_key;
- 
- static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -442,7 +444,9 @@ static void lowpan_set_lockdep_class_one
- static int lowpan_dev_init(struct net_device *dev)
- {
- 	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 	dev->qdisc_tx_busylock = &lowpan_tx_busylock;
-+#endif
- 	return 0;
- }
- 
diff --git a/patches/0044-no_user_ns_in_net/ieee802154.patch b/patches/0044-no_user_ns_in_net/ieee802154.patch
deleted file mode 100644
index 6c3cd21..0000000
--- a/patches/0044-no_user_ns_in_net/ieee802154.patch
+++ /dev/null
@@ -1,30 +0,0 @@
---- a/net/ieee802154/dgram.c
-+++ b/net/ieee802154/dgram.c
-@@ -480,8 +480,13 @@ static int dgram_setsockopt(struct sock
- 		ro->want_ack = !!val;
- 		break;
- 	case WPAN_SECURITY:
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
- 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
- 		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
-+#else
-+		if (!capable(CAP_NET_ADMIN) &&
-+		    !capable(CAP_NET_RAW)) {
-+#endif
- 			err = -EPERM;
- 			break;
- 		}
-@@ -504,8 +509,13 @@ static int dgram_setsockopt(struct sock
- 		}
- 		break;
- 	case WPAN_SECURITY_LEVEL:
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
- 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
- 		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
-+#else
-+		if (!capable(CAP_NET_ADMIN) &&
-+		    !capable(CAP_NET_RAW)) {
-+#endif
- 			err = -EPERM;
- 			break;
- 		}
diff --git a/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch b/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
deleted file mode 100644
index 04fd239..0000000
--- a/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/include/net/cfg802154.h
-+++ b/include/net/cfg802154.h
-@@ -359,6 +359,7 @@ struct wpan_dev {
- 
- #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- static inline int
- wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
- 		     const struct ieee802154_addr *daddr,
-@@ -369,6 +370,7 @@ wpan_dev_hard_header(struct sk_buff *skb
- 
- 	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
- }
-+#endif /* >= 3.19 */
- 
- struct wpan_phy *
- wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size);
diff --git a/patches/0068-proto-hash/ieee802154.patch b/patches/0068-proto-hash/ieee802154.patch
deleted file mode 100644
index 9b5a971..0000000
--- a/patches/0068-proto-hash/ieee802154.patch
+++ /dev/null
@@ -1,62 +0,0 @@
-diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
-index e0bd013..9e78921 100644
---- a/net/ieee802154/socket.c
-+++ b/net/ieee802154/socket.c
-@@ -182,14 +182,20 @@ static int ieee802154_sock_ioctl(struct
- static HLIST_HEAD(raw_head);
- static DEFINE_RWLOCK(raw_lock);
- 
-+#if LINUX_VERSION_IS_GEQ(4,6,0)
- static int raw_hash(struct sock *sk)
-+#else
-+static void raw_hash(struct sock *sk)
-+#endif
- {
- 	write_lock_bh(&raw_lock);
- 	sk_add_node(sk, &raw_head);
- 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
- 	write_unlock_bh(&raw_lock);
- 
-+#if LINUX_VERSION_IS_GEQ(4,6,0)
- 	return 0;
-+#endif
- }
- 
- static void raw_unhash(struct sock *sk)
-@@ -464,14 +470,20 @@ static inline struct dgram_sock *dgram_s
- 	return container_of(sk, struct dgram_sock, sk);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(4,6,0)
- static int dgram_hash(struct sock *sk)
-+#else
-+static void dgram_hash(struct sock *sk)
-+#endif
- {
- 	write_lock_bh(&dgram_lock);
- 	sk_add_node(sk, &dgram_head);
- 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
- 	write_unlock_bh(&dgram_lock);
- 
-+#if LINUX_VERSION_IS_GEQ(4,6,0)
- 	return 0;
-+#endif
- }
- 
- static void dgram_unhash(struct sock *sk)
-@@ -1031,11 +1043,15 @@ static int ieee802154_create(struct net
- 	sock_set_flag(sk, SOCK_ZAPPED);
- 
- 	if (sk->sk_prot->hash) {
-+#if LINUX_VERSION_IS_GEQ(4,6,0)
- 		rc = sk->sk_prot->hash(sk);
- 		if (rc) {
- 			sk_common_release(sk);
- 			goto out;
- 		}
-+#else
-+		sk->sk_prot->hash(sk);
-+#endif
- 	}
- 
- 	if (sk->sk_prot->init) {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
