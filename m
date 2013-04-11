Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37230 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3DKXn7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:59 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 18/24] backports: remove support for < 2.6.24
Date: Fri, 12 Apr 2013 01:42:45 +0200
Message-Id: <1365723771-10660-19-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014409_040521_F30304A3)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This hasn't been tested in years, and those kernels
aren't getting more interesting, so just remove the
support for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h   |   3 -
 backport/backport-include/linux/compat-2.6.14.h |  13 --
 backport/backport-include/linux/compat-2.6.18.h |  13 --
 backport/backport-include/linux/compat-2.6.19.h |  24 ---
 backport/backport-include/linux/compat-2.6.20.h |  21 --
 backport/backport-include/linux/compat-2.6.21.h |  18 --
 backport/backport-include/linux/compat-2.6.22.h | 104 ----------
 backport/backport-include/linux/compat-2.6.23.h | 139 -------------
 backport/backport-include/linux/compat-2.6.24.h | 252 ------------------------
 backport/compat/Makefile                        |   7 -
 backport/compat/compat-2.6.14.c                 |  14 --
 backport/compat/compat-2.6.18.c                 |  14 --
 backport/compat/compat-2.6.19.c                 |  14 --
 backport/compat/compat-2.6.21.c                 |  14 --
 backport/compat/compat-2.6.22.c                 |  14 --
 backport/compat/compat-2.6.23.c                 | 241 ----------------------
 backport/compat/compat-2.6.24.c                 | 158 ---------------
 17 files changed, 1063 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.14.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.18.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.19.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.20.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.21.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.22.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.23.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.24.h
 delete mode 100644 backport/compat/compat-2.6.14.c
 delete mode 100644 backport/compat/compat-2.6.18.c
 delete mode 100644 backport/compat/compat-2.6.19.c
 delete mode 100644 backport/compat/compat-2.6.21.c
 delete mode 100644 backport/compat/compat-2.6.22.c
 delete mode 100644 backport/compat/compat-2.6.23.c
 delete mode 100644 backport/compat/compat-2.6.24.c

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index e2c44d1..a50e488 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -56,9 +56,6 @@ void backport_dependency_symbol(void);
  * code introduced for *that* kernel revision.
  */
 
-#include <linux/compat-2.6.22.h>
-#include <linux/compat-2.6.23.h>
-#include <linux/compat-2.6.24.h>
 #include <linux/compat-2.6.25.h>
 #include <linux/compat-2.6.26.h>
 #include <linux/compat-2.6.27.h>
diff --git a/backport/backport-include/linux/compat-2.6.14.h b/backport/backport-include/linux/compat-2.6.14.h
deleted file mode 100644
index 1f19f7f..0000000
--- a/backport/backport-include/linux/compat-2.6.14.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef LINUX_26_14_COMPAT_H
-#define LINUX_26_14_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.14 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,14))
-
-typedef unsigned int gfp_t;
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,14)) */
-
-#endif /* LINUX_26_14_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.18.h b/backport/backport-include/linux/compat-2.6.18.h
deleted file mode 100644
index 5e0182b..0000000
--- a/backport/backport-include/linux/compat-2.6.18.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef LINUX_26_18_COMPAT_H
-#define LINUX_26_18_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.18 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18))
-
-#define roundup(x, y)	((((x) + ((y) - 1)) / (y)) * (y))
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)) */
-
-#endif /* LINUX_26_18_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.19.h b/backport/backport-include/linux/compat-2.6.19.h
deleted file mode 100644
index 1e648c0..0000000
--- a/backport/backport-include/linux/compat-2.6.19.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef LINUX_26_19_COMPAT_H
-#define LINUX_26_19_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.19 */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,19))
-
-#include <linux/slab.h>
-
-static inline int
-compat_kmem_cache_destroy(struct kmem_cache *cachep)
-{
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19))
-	return kmem_cache_destroy(cachep);
-#else
-	kmem_cache_destroy(cachep);
-	return 0;
-#endif
-}
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)) */
-
-#endif /* LINUX_26_19_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.20.h b/backport/backport-include/linux/compat-2.6.20.h
deleted file mode 100644
index 14579e2..0000000
--- a/backport/backport-include/linux/compat-2.6.20.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef LINUX_26_20_COMPAT_H
-#define LINUX_26_20_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.20 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,20))
-
-#include <linux/workqueue.h>
-
-typedef void (*work_func_t)(struct work_struct *work);
-typedef void (*compat_work_func_t)(void *work);
-static inline void (INIT_WORK)(struct work_struct *work, work_func_t func)
-{
-	INIT_WORK(work, (compat_work_func_t)func, work);
-}
-#undef INIT_WORK
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,20)) */
-
-#endif /* LINUX_26_20_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.21.h b/backport/backport-include/linux/compat-2.6.21.h
deleted file mode 100644
index 89ed6d9..0000000
--- a/backport/backport-include/linux/compat-2.6.21.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef LINUX_26_21_COMPAT_H
-#define LINUX_26_21_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.21 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,21))
-
-#include <linux/sysctl.h>
-
-#define register_sysctl_table(table)				\
-	({							\
-		register_sysctl_table((table), 0);		\
-	})
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,21)) */
-
-#endif /* LINUX_26_21_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.22.h b/backport/backport-include/linux/compat-2.6.22.h
deleted file mode 100644
index 7ca1b18..0000000
--- a/backport/backport-include/linux/compat-2.6.22.h
+++ /dev/null
@@ -1,104 +0,0 @@
-#ifndef LINUX_26_22_COMPAT_H
-#define LINUX_26_22_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.21 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22))
-
-#include <linux/pci.h>
-#include <linux/skbuff.h>
-
-/* reuse ax25_ptr */
-#define ieee80211_ptr ax25_ptr
-
-#ifdef CONFIG_AX25
-#error Compat reuses the AX.25 pointer so that may not be enabled!
-#endif
-
-static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
-{
-	return skb->mac.raw;
-}
-
-static inline void skb_set_mac_header(struct sk_buff *skb, int offset)
-{
-	skb->mac.raw = skb->data + offset;
-}
-
-static inline void skb_reset_mac_header(struct sk_buff *skb)
-{
-	skb->mac.raw = skb->data;
-}
-
-static inline void skb_reset_network_header(struct sk_buff *skb)
-{
-	skb->nh.raw = skb->data;
-}
-
-static inline void skb_set_network_header(struct sk_buff *skb, int offset)
-{
-	skb->nh.raw = skb->data + offset;
-}
-
-static inline void skb_set_transport_header(struct sk_buff *skb, int offset)
-{
-	skb->h.raw = skb->data + offset;
-}
-
-static inline unsigned char *skb_transport_header(struct sk_buff *skb)
-{
-	return skb->h.raw;
-}
-
-static inline unsigned char *skb_network_header(const struct sk_buff *skb)
-{
-	return skb->nh.raw;
-}
-
-static inline unsigned char *skb_tail_pointer(const struct sk_buff *skb)
-{
-	return skb->tail;
-}
-
-static inline struct iphdr *ip_hdr(const struct sk_buff *skb)
-{
-	return (struct iphdr *)skb_network_header(skb);
-}
-
-static inline void skb_copy_from_linear_data(const struct sk_buff *skb,
-					     void *to,
-					     const unsigned int len)
-{
-	memcpy(to, skb->data, len);
-}
-
-static inline void skb_copy_from_linear_data_offset(const struct sk_buff *skb,
-						    const int offset, void *to,
-						    const unsigned int len)
-{
-	memcpy(to, skb->data + offset, len);
-}
-
-#define __maybe_unused	__attribute__((unused))
-
-#define uninitialized_var(x) x = x
-
-/* This will lead to very weird behaviour... */
-#define NLA_BINARY NLA_STRING
-
-static inline int pci_set_mwi(struct pci_dev *dev)
-{
-	return -ENOSYS;
-}
-
-static inline void pci_clear_mwi(struct pci_dev *dev)
-{
-}
-
-#define list_first_entry(ptr, type, member) \
-        list_entry((ptr)->next, type, member)
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22)) */
-
-#endif /* LINUX_26_22_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.23.h b/backport/backport-include/linux/compat-2.6.23.h
deleted file mode 100644
index 37cbc22..0000000
--- a/backport/backport-include/linux/compat-2.6.23.h
+++ /dev/null
@@ -1,139 +0,0 @@
-#ifndef LINUX_26_23_COMPAT_H
-#define LINUX_26_23_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for < 2.6.23 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,23))
-
-#include <linux/netdevice.h>
-#include <linux/sched.h>
-#include <linux/workqueue.h>
-#include <linux/genetlink.h>
-#include <net/sch_generic.h>
-
-/*
- * Tell gcc if a function is cold. The compiler will assume any path
- * directly leading to the call is unlikely.
- */
-
-#if !(__GNUC__ == 4 && __GNUC_MINOR__ < 3)
-/* Mark functions as cold. gcc will assume any path leading to a call
- * to them will be unlikely.  This means a lot of manual unlikely()s
- * are unnecessary now for any paths leading to the usual suspects
- * like BUG(), printk(), panic() etc. [but let's keep them for now for
- * older compilers]
- *
- * Early snapshots of gcc 4.3 don't support this and we can't detect this
- * in the preprocessor, but we can live with this because they're unreleased.
- * Maketime probing would be overkill here.
- *
- * gcc also has a __attribute__((__hot__)) to move hot functions into
- * a special section, but I don't see any sense in this right now in
- * the kernel context */
-#define __cold                  __attribute__((__cold__))
-#endif /* gcc 4.3 check */
-
-#ifndef __cold
-#define __cold
-#endif
-
-/* Added as of 2.6.23 in include/linux/netdevice.h */
-#define alloc_netdev_mq(sizeof_priv, name, setup, queue) \
-	alloc_netdev(sizeof_priv, name, setup)
-#define NETIF_F_MULTI_QUEUE 16384
-
-/* Added as of 2.6.23 on include/linux/netdevice.h */
-static inline int netif_is_multiqueue(const struct net_device *dev)
-{
-	return (!!(NETIF_F_MULTI_QUEUE & dev->features));
-}
-
-/* 2.6.23 fixed a bug in tcf_destroy_chain and the parameter changed */
-static inline void tcf_destroy_chain_compat(struct tcf_proto **fl)
-{
-	struct tcf_proto *tp;
-
-	while ((tp = *fl) != NULL) {
-		*fl = tp->next;
-		tp->ops->destroy(tp);
-		module_put(tp->ops->owner);
-		kfree(tp);
-	}
-}
-
-/* dev_mc_list was replaced with dev_addr_list as of 2.6.23,
- * only new member added is da_synced. */
-#define dev_addr_list	dev_mc_list
-#define da_addr		dmi_addr
-#define da_addrlen	dmi_addrlen
-#define da_users	dmi_users
-#define da_gusers	dmi_gusers
-
-/* dev_set_promiscuity() was moved to __dev_set_promiscuity() on 2.6.23 and
- * dev_set_promiscuity() became a wrapper. */
-#define __dev_set_promiscuity dev_set_promiscuity
-
-/* Our own 2.6.22 port on compat.c */
-#define dev_mc_unsync LINUX_BACKPORT(dev_mc_unsync)
-#define dev_mc_sync LINUX_BACKPORT(dev_mc_sync)
-extern void	dev_mc_unsync(struct net_device *to, struct net_device *from);
-extern int	dev_mc_sync(struct net_device *to, struct net_device *from);
-
-/* Our own 2.6.22 port on compat.c */
-extern void	__dev_set_rx_mode(struct net_device *dev);
-
-/* Simple to add this */
-extern int cancel_delayed_work_sync(struct delayed_work *work);
-
-#define cancel_delayed_work_sync cancel_rearming_delayed_work
-
-#define debugfs_rename(a, b, c, d) 1
-
-/* nl80211 requires multicast group support which is new and added on
- * 2.6.23. We can't add support for it for older kernels to support it
- * genl_family structure was changed. Lets just let through the
- * genl_register_mc_group call. This means no multicast group suppport */
-
-#define genl_register_mc_group(a, b) 0
-
-/**
- * struct genl_multicast_group - generic netlink multicast group
- * @name: name of the multicast group, names are per-family
- * @id: multicast group ID, assigned by the core, to use with
- * 	genlmsg_multicast().
- * @list: list entry for linking
- * @family: pointer to family, need not be set before registering
- */
-struct genl_multicast_group
-{
-	struct genl_family      *family;        /* private */
-	struct list_head        list;           /* private */
-	char                    name[GENL_NAMSIZ];
-	u32                     id;
-};
-
-
-/* Added as of 2.6.23 */
-#define pci_try_set_mwi LINUX_BACKPORT(pci_try_set_mwi)
-int pci_try_set_mwi(struct pci_dev *dev);
-
-/* Added as of 2.6.23 */
-#ifdef CONFIG_PM_SLEEP
-/*
- * Tell the freezer that the current task should be frozen by it
- */
-static inline void set_freezable(void)
-{
-	current->flags &= ~PF_NOFREEZE;
-}
-
-#else
-static inline void set_freezable(void) {}
-#endif /* CONFIG_PM_SLEEP */
-
-#else
-#define tcf_destroy_chain_compat tcf_destroy_chain
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,23)) */
-
-#endif /* LINUX_26_23_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.24.h b/backport/backport-include/linux/compat-2.6.24.h
deleted file mode 100644
index 5448604..0000000
--- a/backport/backport-include/linux/compat-2.6.24.h
+++ /dev/null
@@ -1,252 +0,0 @@
-#ifndef LINUX_26_24_COMPAT_H
-#define LINUX_26_24_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.21, 2.6.22 and 2.6.23 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24))
-
-#include <asm/atomic.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/usb.h>
-#include <linux/types.h>
-#include <linux/list.h>
-#include <linux/scatterlist.h>
-
-#define KEY_BLUETOOTH	237
-#define KEY_WLAN	238
-#define KEY_UWB		239
-
-#define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
-
-struct proc_dir_entry;
-struct net_device;
-struct net {
-	atomic_t		count;		/* To decided when the network
-						 *  namespace should be freed.
-						 */
-	atomic_t		use_count;	/* To track references we
-						 * destroy on demand
-						 */
-	struct list_head	list;		/* list of network namespaces */
-	struct work_struct	work;		/* work struct for freeing */
-
-	struct proc_dir_entry 	*proc_net;
-	struct proc_dir_entry 	*proc_net_stat;
-	struct proc_dir_entry 	*proc_net_root;
-
-	struct net_device       *loopback_dev;          /* The loopback */
-
-	struct list_head 	dev_base_head;
-	struct hlist_head 	*dev_name_head;
-	struct hlist_head	*dev_index_head;
-};
-
-#ifdef CONFIG_NET
-/* Init's network namespace */
-#define init_net LINUX_BACKPORT(init_net)
-extern struct net init_net;
-#define INIT_NET_NS(net_ns) .net_ns = &init_net,
-#else
-#define INIT_NET_NS(net_ns)
-#endif
-
-/* Added on 2.6.24 in include/linux/types.h by Al viro on commit 142956af */
-typedef unsigned long               uintptr_t;
-
-/* From include/linux/net.h */
-enum sock_shutdown_cmd {
-	SHUT_RD		= 0,
-	SHUT_WR		= 1,
-	SHUT_RDWR	= 2,
-};
-
-#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,23)) /* Local check */
-/* Added as of 2.6.24 in include/linux/skbuff.h.
- *
- * Although 2.6.23 does support for CONFIG_NETDEVICES_MULTIQUEUE
- * this helper was not added until 2.6.24. This implementation
- * is exactly as it is on newer kernels.
- *
- * For older kernels we use the an internal mac80211 hack.
- * For details see changes to include/net/mac80211.h through
- * compat.diff and compat/mq_compat.h */
-static inline u16 skb_get_queue_mapping(struct sk_buff *skb)
-{
-#ifdef CONFIG_NETDEVICES_MULTIQUEUE
-	return skb->queue_mapping;
-#else
-	return 0;
-#endif
-}
-#endif /* Local 2.6.23 check */
-
-/* On older kernels we handle this a bit differently, so we yield to that
- * code for its implementation in mq_compat.h as we want to make
- * use of the internal mac80211 __ieee80211_queue_stopped() which itself
- * uses internal mac80211 data structure hacks. */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)) /* Local check */
-/**
- * netif_subqueue_stopped - test status of subqueue
- * @dev: network device
- * @queue_index: sub queue index
- *
- * Check individual transmit queue of a device with multiple transmit queues.
- */
-static inline int __netif_subqueue_stopped(const struct net_device *dev,
-					u16 queue_index)
-{
-#ifdef CONFIG_NETDEVICES_MULTIQUEUE
-	return test_bit(__LINK_STATE_XOFF,
-	&dev->egress_subqueue[queue_index].state);
-#else
-	return 0;
-#endif
-}
-
-/* Note: although the backport implementation for netif_subqueue_stopped
- * on older kernels is identical to upstream __netif_subqueue_stopped()
- * (except for a const qualifier) we implement netif_subqueue_stopped()
- * as part of mac80211 as it relies on internal mac80211 structures we
- * use for MQ support. We this implement it in mq_compat.h */
-
-#endif /* Local 2.6.23 check */
-
-/*
- * Force link bug if constructor is used, can't be done compatibly
- * because constructor arguments were swapped since then!
- */
-extern void __incompatible_kmem_cache_create(void);
-
-/* 2.6.21 and 2.6.22 kmem_cache_create() takes 6 arguments */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,23))
-#define kmem_cache_create(name, objsize, align, flags, ctor) 	\
-	({							\
-		if (ctor) __incompatible_kmem_cache_create();	\
-		kmem_cache_create((name), (objsize), (align),	\
-				  (flags), NULL, NULL);		\
-	})
-#endif
-
-/* 2.6.23 kmem_cache_create() takes 5 arguments */
-#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,23))
-#define kmem_cache_create(name, objsize, align, flags, ctor) 	\
-	({							\
-		if (ctor) __incompatible_kmem_cache_create();	\
-		kmem_cache_create((name), (objsize), (align),	\
-				  (flags), NULL);		\
-	})
-#endif
-
-/* From include/linux/mod_devicetable.h */
-
-/* SSB core, see drivers/ssb/ */
-#ifndef SSB_DEVICE
-struct ssb_device_id {
-	__u16   vendor;
-	__u16   coreid;
-	__u8    revision;
-};
-#define SSB_DEVICE(_vendor, _coreid, _revision)  \
-	{ .vendor = _vendor, .coreid = _coreid, .revision = _revision, }
-#define SSB_DEVTABLE_END  \
-	{ 0, },
-
-#define SSB_ANY_VENDOR          0xFFFF
-#define SSB_ANY_ID              0xFFFF
-#define SSB_ANY_REV             0xFF
-#endif
-
-
-/* Namespace stuff, introduced on 2.6.24 */
-#define dev_get_by_index(a, b)		dev_get_by_index(b)
-#define __dev_get_by_index(a, b)	__dev_get_by_index(b)
-
-#define eth_header LINUX_BACKPORT(eth_header)
-extern int		eth_header(struct sk_buff *skb, struct net_device *dev,
-				unsigned short type, void *daddr,
-				void *saddr, unsigned len);
-#define eth_rebuild_header LINUX_BACKPORT(eth_rebuild_header)
-extern int		eth_rebuild_header(struct sk_buff *skb);
-#define eth_header_cache_update LINUX_BACKPORT(eth_header_cache_update)
-extern void		eth_header_cache_update(struct hh_cache *hh, struct net_device *dev,
-				unsigned char * haddr);
-#define eth_header_cache LINUX_BACKPORT(eth_header_cache)
-extern int		eth_header_cache(struct neighbour *neigh,
-			struct hh_cache *hh);
-
-/* This structure is simply not present on 2.6.22 and 2.6.23 */
-struct header_ops {
-	int     (*create) (struct sk_buff *skb, struct net_device *dev,
-		unsigned short type, void *daddr,
-		void *saddr, unsigned len);
-	int     (*parse)(const struct sk_buff *skb, unsigned char *haddr);
-	int     (*rebuild)(struct sk_buff *skb);
-	#define HAVE_HEADER_CACHE
-	int     (*cache)(struct neighbour *neigh, struct hh_cache *hh);
-	void    (*cache_update)(struct hh_cache *hh,
-		struct net_device *dev,
-		unsigned char *haddr);
-};
-
-/* net/ieee80211/ieee80211_crypt_tkip uses sg_init_table. This was added on
- * 2.6.24. CONFIG_DEBUG_SG was added in 2.6.24 as well, so lets just ignore
- * the debug stuff. Note that adding this required changes to the struct
- * scatterlist on include/asm/scatterlist*, so the right way to port this
- * is to simply ignore the new structure changes and zero the scatterlist
- * array. We lave the kdoc intact for reference.
- */
-
-/**
- * sg_mark_end - Mark the end of the scatterlist
- * @sg:          SG entryScatterlist
- *
- * Description:
- *   Marks the passed in sg entry as the termination point for the sg
- *   table. A call to sg_next() on this entry will return NULL.
- *
- **/
-static inline void sg_mark_end(struct scatterlist *sg)
-{
-#ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-	/*
-	 * Set termination bit, clear potential chain bit
-	*/
-	sg->page_link |= 0x02;
-	sg->page_link &= ~0x01;
-#endif
-}
-
-/**
- * sg_init_table - Initialize SG table
- * @sgl:           The SG table
- * @nents:         Number of entries in table
- *
- * Notes:
- *   If this is part of a chained sg table, sg_mark_end() should be
- *   used only on the last table part.
- *
- **/
-static inline void sg_init_table(struct scatterlist *sgl, unsigned int nents)
-{
-	memset(sgl, 0, sizeof(*sgl) * nents);
-}
-
-/**
- * usb_endpoint_num - get the endpoint's number
- * @epd: endpoint to be checked
- *
- * Returns @epd's number: 0 to 15.
- */
-static inline int usb_endpoint_num(const struct usb_endpoint_descriptor *epd)
-{
-	return epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-}
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)) */
-
-#endif /* LINUX_26_24_COMPAT_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 499d4c0..8c62cbb 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -13,13 +13,6 @@ obj-$(CPTCFG_BACKPORT_BUILD_CORDIC) += cordic.o
 obj-$(CPTCFG_BACKPORT_BUILD_CRC8) += crc8.o
 
 # Compat kernel compatibility code
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_14) += compat-2.6.14.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_18) += compat-2.6.18.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_19) += compat-2.6.19.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_21) += compat-2.6.21.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_22) += compat-2.6.22.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_23) += compat-2.6.23.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_24) += compat-2.6.24.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_25) += compat-2.6.25.o pm_qos_params.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_27) += compat-2.6.27.o
diff --git a/backport/compat/compat-2.6.14.c b/backport/compat/compat-2.6.14.c
deleted file mode 100644
index 3de847d..0000000
--- a/backport/compat/compat-2.6.14.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.14.
- */
-
-#include <net/compat.h>
-
-/* 2.6.14 compat code goes here */
-
diff --git a/backport/compat/compat-2.6.18.c b/backport/compat/compat-2.6.18.c
deleted file mode 100644
index c7961ee..0000000
--- a/backport/compat/compat-2.6.18.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.18.
- */
-
-#include <net/compat.h>
-
-/* 2.6.18 compat code goes here */
-
diff --git a/backport/compat/compat-2.6.19.c b/backport/compat/compat-2.6.19.c
deleted file mode 100644
index 60c3404..0000000
--- a/backport/compat/compat-2.6.19.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.19.
- */
-
-#include <net/compat.h>
-
-/* 2.6.19 compat code goes here */
-
diff --git a/backport/compat/compat-2.6.21.c b/backport/compat/compat-2.6.21.c
deleted file mode 100644
index 7cf8861..0000000
--- a/backport/compat/compat-2.6.21.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.21.
- */
-
-#include <net/compat.h>
-
-/* 2.6.21 compat code goes here */
-
diff --git a/backport/compat/compat-2.6.22.c b/backport/compat/compat-2.6.22.c
deleted file mode 100644
index d4df7b7..0000000
--- a/backport/compat/compat-2.6.22.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.22.
- */
-
-#include <net/compat.h>
-
-/* 2.6.22 compat code goes here */
-
diff --git a/backport/compat/compat-2.6.23.c b/backport/compat/compat-2.6.23.c
deleted file mode 100644
index 1a76957..0000000
--- a/backport/compat/compat-2.6.23.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.23.
- */
-
-#include <net/compat.h>
-
-/* On net/core/dev.c as of 2.6.24 */
-#define __dev_addr_delete LINUX_BACKPORT(__dev_addr_delete)
-int __dev_addr_delete(struct dev_addr_list **list, int *count,
-                      void *addr, int alen, int glbl)
-{
-	struct dev_addr_list *da;
-
-	for (; (da = *list) != NULL; list = &da->next) {
-		if (memcmp(da->da_addr, addr, da->da_addrlen) == 0 &&
-			alen == da->da_addrlen) {
-			if (glbl) {
-				int old_glbl = da->da_gusers;
-				da->da_gusers = 0;
-				if (old_glbl == 0)
-					break;
-			}
-			if (--da->da_users)
-				return 0;
-
-			*list = da->next;
-			kfree(da);
-			(*count)--;
-			return 0;
-		}
-	}
-	return -ENOENT;
-}
-EXPORT_SYMBOL_GPL(__dev_addr_delete);
-
-/* On net/core/dev.c as of 2.6.24. This is not yet used by mac80211 but
- * might as well add it */
-#define __dev_addr_add LINUX_BACKPORT(__dev_addr_add)
-int __dev_addr_add(struct dev_addr_list **list, int *count,
-                   void *addr, int alen, int glbl)
-{
-	struct dev_addr_list *da;
-
-	for (da = *list; da != NULL; da = da->next) {
-		if (memcmp(da->da_addr, addr, da->da_addrlen) == 0 &&
-			da->da_addrlen == alen) {
-			if (glbl) {
-				int old_glbl = da->da_gusers;
-				da->da_gusers = 1;
-				if (old_glbl)
-					return 0;
-			}
-			da->da_users++;
-			return 0;
-		}
-	}
-
-	da = kmalloc(sizeof(*da), GFP_ATOMIC);
-	if (da == NULL)
-		return -ENOMEM;
-	memcpy(da->da_addr, addr, alen);
-	da->da_addrlen = alen;
-	da->da_users = 1;
-	da->da_gusers = glbl ? 1 : 0;
-	da->next = *list;
-	*list = da;
-	(*count)++;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__dev_addr_add);
-
-
-/* Part of net/core/dev_mcast.c as of 2.6.23. This is a slightly different version.
- * Since da->da_synced is not part of 2.6.22 we need to take longer route when
- * syncing */
-
-/**
- *	dev_mc_sync	- Synchronize device's multicast list to another device
- *	@to: destination device
- *	@from: source device
- *
- * 	Add newly added addresses to the destination device and release
- * 	addresses that have no users left. The source device must be
- * 	locked by netif_tx_lock_bh.
- *
- *	This function is intended to be called from the dev->set_multicast_list
- *	function of layered software devices.
- */
-int dev_mc_sync(struct net_device *to, struct net_device *from)
-{
-	struct dev_addr_list *da, *next, *da_to;
-	int err = 0;
-
-	netif_tx_lock_bh(to);
-	da = from->mc_list;
-	while (da != NULL) {
-		int synced = 0;
-		next = da->next;
-		da_to = to->mc_list;
-		/* 2.6.22 does not have da->da_synced so lets take the long route */
-		while (da_to != NULL) {
-			if (memcmp(da_to->da_addr, da->da_addr, da_to->da_addrlen) == 0 &&
-				da->da_addrlen == da_to->da_addrlen)
-				synced = 1;
-				break;
-		}
-		if (!synced) {
-			err = __dev_addr_add(&to->mc_list, &to->mc_count,
-					     da->da_addr, da->da_addrlen, 0);
-			if (err < 0)
-				break;
-			da->da_users++;
-		} else if (da->da_users == 1) {
-			__dev_addr_delete(&to->mc_list, &to->mc_count,
-					  da->da_addr, da->da_addrlen, 0);
-			__dev_addr_delete(&from->mc_list, &from->mc_count,
-					  da->da_addr, da->da_addrlen, 0);
-		}
-		da = next;
-	}
-	if (!err)
-		__dev_set_rx_mode(to);
-	netif_tx_unlock_bh(to);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(dev_mc_sync);
-
-
-/* Part of net/core/dev_mcast.c as of 2.6.23. This is a slighty different version.
- * Since da->da_synced is not part of 2.6.22 we need to take longer route when
- * unsyncing */
-
-/**
- *      dev_mc_unsync   - Remove synchronized addresses from the destination
- *			  device
- *	@to: destination device
- *	@from: source device
- *
- *	Remove all addresses that were added to the destination device by
- *	dev_mc_sync(). This function is intended to be called from the
- *	dev->stop function of layered software devices.
- */
-void dev_mc_unsync(struct net_device *to, struct net_device *from)
-{
-	struct dev_addr_list *da, *next, *da_to;
-
-	netif_tx_lock_bh(from);
-	netif_tx_lock_bh(to);
-
-	da = from->mc_list;
-	while (da != NULL) {
-		bool synced = false;
-		next = da->next;
-		da_to = to->mc_list;
-		/* 2.6.22 does not have da->da_synced so lets take the long route */
-		while (da_to != NULL) {
-			if (memcmp(da_to->da_addr, da->da_addr, da_to->da_addrlen) == 0 &&
-				da->da_addrlen == da_to->da_addrlen)
-				synced = true;
-				break;
-		}
-		if (!synced) {
-			da = next;
-			continue;
-		}
-		__dev_addr_delete(&to->mc_list, &to->mc_count,
-			da->da_addr, da->da_addrlen, 0);
-		__dev_addr_delete(&from->mc_list, &from->mc_count,
-			da->da_addr, da->da_addrlen, 0);
-		da = next;
-	}
-	__dev_set_rx_mode(to);
-
-	netif_tx_unlock_bh(to);
-	netif_tx_unlock_bh(from);
-}
-EXPORT_SYMBOL_GPL(dev_mc_unsync);
-
-/* Added as of 2.6.23 on net/core/dev.c. Slightly modifed, no dev->set_rx_mode on
- * 2.6.22 so ignore that. */
-
-/*
- *	Upload unicast and multicast address lists to device and
- *	configure RX filtering. When the device doesn't support unicast
- *	filtering it is put in promiscous mode while unicast addresses
- *	are present.
- */
-void __dev_set_rx_mode(struct net_device *dev)
-{
-	/* dev_open will call this function so the list will stay sane. */
-	if (!(dev->flags&IFF_UP))
-		return;
-
-	if (!netif_device_present(dev))
-		return;
-
-/* This needs to be ported to 2.6.22 framework */
-#if 0
-	/* Unicast addresses changes may only happen under the rtnl,
-	 * therefore calling __dev_set_promiscuity here is safe.
-	 */
-	if (dev->uc_count > 0 && !dev->uc_promisc) {
-		__dev_set_promiscuity(dev, 1);
-		dev->uc_promisc = 1;
-	} else if (dev->uc_count == 0 && dev->uc_promisc) {
-		__dev_set_promiscuity(dev, -1);
-		dev->uc_promisc = 0;
-	}
-#endif
-
-	if (dev->set_multicast_list)
-		dev->set_multicast_list(dev);
-}
-
-/**
- * pci_try_set_mwi - enables memory-write-invalidate PCI transaction
- * @dev: the PCI device for which MWI is enabled
- *
- * Enables the Memory-Write-Invalidate transaction in %PCI_COMMAND.
- * Callers are not required to check the return value.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int pci_try_set_mwi(struct pci_dev *dev)
-{
-	int rc = 0;
-#ifdef HAVE_PCI_SET_MWI
-	rc = pci_set_mwi(dev);
-#endif
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_try_set_mwi);
-#endif
-
diff --git a/backport/compat/compat-2.6.24.c b/backport/compat/compat-2.6.24.c
deleted file mode 100644
index 977db0c..0000000
--- a/backport/compat/compat-2.6.24.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.24.
- */
-
-#include <net/compat.h>
-#include <net/arp.h>
-
-/*
- * We simply won't use it though, just declare it for our wrappers and
- * for usage with tons of code that makes mention to it.
- */
-struct net init_net;
-EXPORT_SYMBOL_GPL(init_net);
-
-/* 2.6.22 and 2.6.23 have eth_header_cache_update defined as extern in include/linux/etherdevice.h
- * and actually defined in net/ethernet/eth.c but 2.6.24 exports it. Lets export it here */
-
-/**
- * eth_header_cache_update - update cache entry
- * @hh: destination cache entry
- * @dev: network device
- * @haddr: new hardware address
- *
- * Called by Address Resolution module to notify changes in address.
- */
-void eth_header_cache_update(struct hh_cache *hh,
-                             struct net_device *dev,
-                             unsigned char *haddr)
-{
-	memcpy(((u8 *) hh->hh_data) + HH_DATA_OFF(sizeof(struct ethhdr)),
-		haddr, ETH_ALEN);
-}
-EXPORT_SYMBOL_GPL(eth_header_cache_update);
-
-/* 2.6.22 and 2.6.23 have eth_header_cache defined as extern in include/linux/etherdevice.h
- * and actually defined in net/ethernet/eth.c but 2.6.24 exports it. Lets export it here */
-
-/**
- * eth_header_cache - fill cache entry from neighbour
- * @neigh: source neighbour
- * @hh: destination cache entry
- * Create an Ethernet header template from the neighbour.
- */
-int eth_header_cache(struct neighbour *neigh, struct hh_cache *hh)
-{
-	__be16 type = hh->hh_type;
-	struct ethhdr *eth;
-	const struct net_device *dev = neigh->dev;
-
-	eth = (struct ethhdr *)
-	    (((u8 *) hh->hh_data) + (HH_DATA_OFF(sizeof(*eth))));
-
-	if (type == htons(ETH_P_802_3))
-		return -1;
-
-	eth->h_proto = type;
-	memcpy(eth->h_source, dev->dev_addr, ETH_ALEN);
-	memcpy(eth->h_dest, neigh->ha, ETH_ALEN);
-	hh->hh_len = ETH_HLEN;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_header_cache);
-
-/* 2.6.22 and 2.6.23 have eth_header() defined as extern in include/linux/etherdevice.h
- * and actually defined in net/ethernet/eth.c but 2.6.24 exports it. Lets export it here */
-
-/**
- * eth_header - create the Ethernet header
- * @skb:	buffer to alter
- * @dev:	source device
- * @type:	Ethernet type field
- * @daddr: destination address (NULL leave destination address)
- * @saddr: source address (NULL use device source address)
- * @len:   packet length (<= skb->len)
- *
- *
- * Set the protocol type. For a packet of type ETH_P_802_3 we put the length
- * in here instead. It is up to the 802.2 layer to carry protocol information.
- */
-int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
-	       void *daddr, void *saddr, unsigned len)
-{
-	struct ethhdr *eth = (struct ethhdr *)skb_push(skb, ETH_HLEN);
-
-	if (type != ETH_P_802_3)
-		eth->h_proto = htons(type);
-	else
-		eth->h_proto = htons(len);
-
-	/*
-	 *      Set the source hardware address.
-	 */
-
-	if (!saddr)
-		saddr = dev->dev_addr;
-	memcpy(eth->h_source, saddr, dev->addr_len);
-
-	if (daddr) {
-		memcpy(eth->h_dest, daddr, dev->addr_len);
-		return ETH_HLEN;
-	}
-
-	/*
-	 *      Anyway, the loopback-device should never use this function...
-	 */
-
-	if (dev->flags & (IFF_LOOPBACK | IFF_NOARP)) {
-		memset(eth->h_dest, 0, dev->addr_len);
-		return ETH_HLEN;
-	}
-
-	return -ETH_HLEN;
-}
-
-EXPORT_SYMBOL_GPL(eth_header);
-
-/* 2.6.22 and 2.6.23 have eth_rebuild_header defined as extern in include/linux/etherdevice.h
- * and actually defined in net/ethernet/eth.c but 2.6.24 exports it. Lets export it here */
-
-/**
- * eth_rebuild_header- rebuild the Ethernet MAC header.
- * @skb: socket buffer to update
- *
- * This is called after an ARP or IPV6 ndisc it's resolution on this
- * sk_buff. We now let protocol (ARP) fill in the other fields.
- *
- * This routine CANNOT use cached dst->neigh!
- * Really, it is used only when dst->neigh is wrong.
- */
-int eth_rebuild_header(struct sk_buff *skb)
-{
-	struct ethhdr *eth = (struct ethhdr *)skb->data;
-	struct net_device *dev = skb->dev;
-
-	switch (eth->h_proto) {
-#ifdef CONFIG_INET
-	case __constant_htons(ETH_P_IP):
-		return arp_find(eth->h_dest, skb);
-#endif
-	default:
-		printk(KERN_DEBUG
-		       "%s: unable to resolve type %X addresses.\n",
-		       dev->name, (int)eth->h_proto);
-
-		memcpy(eth->h_source, dev->dev_addr, ETH_ALEN);
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_rebuild_header);
-
-- 
1.8.0

