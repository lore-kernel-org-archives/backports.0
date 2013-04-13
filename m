Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44235 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:16 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 22/42] backports: dissolve compat-2.6.38.h
Date: Sun, 14 Apr 2013 01:53:42 +0200
Message-Id: <1365897243-31214-23-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015518_994383_AF6F1641)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

While at it, fix the SDIO backport because the
max_hw_segs,max_phys_segs -> max_segs change
was really done in 2.6.37, not 2.6.38.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/bug.h           |  45 +++++++
 backport/backport-include/linux/compat-2.6.38.h | 165 ------------------------
 backport/backport-include/linux/etherdevice.h   |  17 +++
 backport/backport-include/linux/if_ether.h      |   4 +
 backport/backport-include/linux/lockdep.h       |  27 ++++
 backport/backport-include/linux/mmc/host.h      |  11 ++
 backport/backport-include/linux/netdevice.h     |   6 +
 backport/backport-include/linux/pci_regs.h      |  13 ++
 backport/backport-include/linux/printk.h        |  30 +++++
 backport/backport-include/linux/skbuff.h        |   7 +
 backport/backport-include/linux/workqueue.h     |   5 +
 backport/backport-include/net/sch_generic.h     |  32 +++++
 12 files changed, 197 insertions(+), 165 deletions(-)
 create mode 100644 backport/backport-include/linux/bug.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.38.h
 create mode 100644 backport/backport-include/linux/lockdep.h
 create mode 100644 backport/backport-include/linux/mmc/host.h

diff --git a/backport/backport-include/linux/bug.h b/backport/backport-include/linux/bug.h
new file mode 100644
index 0000000..22c91aa
--- /dev/null
+++ b/backport/backport-include/linux/bug.h
@@ -0,0 +1,45 @@
+#ifndef __BACKPORT_LINUX_BUG_H
+#define __BACKPORT_LINUX_BUG_H
+#include_next <linux/bug.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+/* is defined there for older kernels */
+#include <linux/kernel.h>
+/* Backport of:
+ *
+ * commit 7ef88ad561457c0346355dfd1f53e503ddfde719
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * Date:   Mon Jan 24 14:45:10 2011 -0600
+ *
+ *     BUILD_BUG_ON: make it handle more cases
+ */
+#undef BUILD_BUG_ON
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ *
+ * The implementation uses gcc's reluctance to create a negative array, but
+ * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
+ * to inline functions).  So as a fallback we use the optimizer; if it can't
+ * prove the condition is false, it will cause a link error on the undefined
+ * "__build_bug_on_failed".  This error message can be harder to track down
+ * though, hence the two different methods.
+ */
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+#else
+extern int __build_bug_on_failed;
+#define BUILD_BUG_ON(condition)					\
+	do {							\
+		((void)sizeof(char[1 - 2*!!(condition)]));	\
+		if (condition) __build_bug_on_failed = 1;	\
+	} while(0)
+#endif
+#endif /* < 2.6.38 */
+
+#endif /* __BACKPORT_LINUX_BUG_H */
diff --git a/backport/backport-include/linux/compat-2.6.38.h b/backport/backport-include/linux/compat-2.6.38.h
deleted file mode 100644
index 4a82310..0000000
--- a/backport/backport-include/linux/compat-2.6.38.h
+++ /dev/null
@@ -1,165 +0,0 @@
-#ifndef LINUX_26_38_COMPAT_H
-#define LINUX_26_38_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
-
-#include <linux/kernel.h>
-#include <linux/skbuff.h>
-#include <linux/etherdevice.h>
-#include <net/sch_generic.h>
-
-#define   PCI_MSIX_ENTRY_CTRL_MASKBIT  1
-
-#define alloc_etherdev_mqs(sizeof_priv, tx_q, rx_q) alloc_etherdev_mq(sizeof_priv, tx_q)
-
-/* MSI-X entry's format */
-#define PCI_MSIX_ENTRY_SIZE            16
-#define  PCI_MSIX_ENTRY_LOWER_ADDR     0
-#define  PCI_MSIX_ENTRY_UPPER_ADDR     4
-#define  PCI_MSIX_ENTRY_DATA           8
-#define  PCI_MSIX_ENTRY_VECTOR_CTRL    12
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30))
-static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
-				 const struct sk_buff *skb)
-{
-	bstats->bytes += qdisc_pkt_len((struct sk_buff *) skb);
-	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-}
-static inline void qdisc_bstats_update(struct Qdisc *sch,
-				       const struct sk_buff *skb)
-{
-	bstats_update(&sch->bstats, skb);
-}
-#else
-/*
- * kernels <= 2.6.30 do not pass a const skb to qdisc_pkt_len, and
- * gnet_stats_basic_packed did not exist (see c1a8f1f1c8)
- */
-static inline void bstats_update(struct gnet_stats_basic *bstats,
-				 struct sk_buff *skb)
-{
-	bstats->bytes += qdisc_pkt_len(skb);
-	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-}
-static inline void qdisc_bstats_update(struct Qdisc *sch,
-				       struct sk_buff *skb)
-{
-	bstats_update(&sch->bstats, skb);
-}
-#endif
-
-
-/* rename member in struct mmc_host in include/linux/mmc/host.h */
-#define max_segs	max_hw_segs
-
-
-#define pr_warn pr_warning
-#define create_freezable_workqueue create_freezeable_workqueue
-
-static inline int skb_checksum_start_offset(const struct sk_buff *skb)
-{
-	return skb->csum_start - skb_headroom(skb);
-}
-
-/* from include/linux/printk.h */ 
-#define pr_emerg_once(fmt, ...)					\
-	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_alert_once(fmt, ...)					\
-	printk_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_crit_once(fmt, ...)					\
-	printk_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_err_once(fmt, ...)					\
-	printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warn_once(fmt, ...)					\
-	printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_notice_once(fmt, ...)				\
-	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_info_once(fmt, ...)					\
-	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_cont_once(fmt, ...)					\
-	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
-#if defined(DEBUG)
-#define pr_debug_once(fmt, ...)					\
-	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#else
-#define pr_debug_once(fmt, ...)					\
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#endif
-
-/* include/linux/netdevice.h */
-#define alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs) \
-	alloc_netdev_mq(sizeof_priv, name, setup, \
-			max_t(unsigned int, txqs, rxqs))
-
-#define ETH_P_LINK_CTL	0x886c		/* HPNA, wlan link local tunnel */
-
-/**
- * is_unicast_ether_addr - Determine if the Ethernet address is unicast
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Return true if the address is a unicast address.
- */
-static inline int is_unicast_ether_addr(const u8 *addr)
-{
-	return !is_multicast_ether_addr(addr);
-}
-
-/* Backport of:
- *
- * commit 7ef88ad561457c0346355dfd1f53e503ddfde719
- * Author: Rusty Russell <rusty@rustcorp.com.au>
- * Date:   Mon Jan 24 14:45:10 2011 -0600
- *
- *     BUILD_BUG_ON: make it handle more cases
- */
-#undef BUILD_BUG_ON
-/**
- * BUILD_BUG_ON - break compile if a condition is true.
- * @condition: the condition which the compiler should know is false.
- *
- * If you have some code which relies on certain constants being equal, or
- * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
- * detect if someone changes it.
- *
- * The implementation uses gcc's reluctance to create a negative array, but
- * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
- * to inline functions).  So as a fallback we use the optimizer; if it can't
- * prove the condition is false, it will cause a link error on the undefined
- * "__build_bug_on_failed".  This error message can be harder to track down
- * though, hence the two different methods.
- */
-#ifndef __OPTIMIZE__
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#else
-extern int __build_bug_on_failed;
-#define BUILD_BUG_ON(condition)					\
-	do {							\
-		((void)sizeof(char[1 - 2*!!(condition)]));	\
-		if (condition) __build_bug_on_failed = 1;	\
-	} while(0)
-#endif
-
-/* Backport of:
- *
- * commit e159489baa717dbae70f9903770a6a4990865887
- * Author: Tejun Heo <tj@kernel.org>
- * Date:   Sun Jan 9 23:32:15 2011 +0100
- *
- *     workqueue: relax lockdep annotation on flush_work()
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# ifdef CONFIG_PROVE_LOCKING
-#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 2, NULL, _THIS_IP_)
-# else
-#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 1, NULL, _THIS_IP_)
-# endif
-#else
-# define lock_map_acquire_read(l)		do { } while (0)
-#endif
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)) */
-
-#endif /* LINUX_26_38_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index bbabfbd..43dcba0 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -86,4 +86,21 @@ static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+#define alloc_etherdev_mqs(sizeof_priv, tx_q, rx_q) alloc_etherdev_mq(sizeof_priv, tx_q)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+/**
+ * is_unicast_ether_addr - Determine if the Ethernet address is unicast
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Return true if the address is a unicast address.
+ */
+static inline int is_unicast_ether_addr(const u8 *addr)
+{
+	return !is_multicast_ether_addr(addr);
+}
+#endif
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index b47722c..dd1bae4 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -18,6 +18,10 @@
 #define ETH_P_TDLS	0x890D          /* TDLS */
 #endif
 
+#ifndef ETH_P_LINK_CTL
+#define ETH_P_LINK_CTL	0x886c
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
 #define mac_pton LINUX_BACKPORT(mac_pton)
 int mac_pton(const char *s, u8 *mac);
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
new file mode 100644
index 0000000..25706b9
--- /dev/null
+++ b/backport/backport-include/linux/lockdep.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_LINUX_LOCKDEP_H
+#define __BACKPORT_LINUX_LOCKDEP_H
+#include_next <linux/lockdep.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+/* Backport of:
+ *
+ * commit e159489baa717dbae70f9903770a6a4990865887
+ * Author: Tejun Heo <tj@kernel.org>
+ * Date:   Sun Jan 9 23:32:15 2011 +0100
+ *
+ *     workqueue: relax lockdep annotation on flush_work()
+ */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# ifdef CONFIG_PROVE_LOCKING
+#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 2, NULL, _THIS_IP_)
+# else
+#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 1, NULL, _THIS_IP_)
+# endif
+#else
+# define lock_map_acquire_read(l)		do { } while (0)
+#endif
+
+#endif /* < 2.6.38 */
+
+#endif /* __BACKPORT_LINUX_LOCKDEP_H */
diff --git a/backport/backport-include/linux/mmc/host.h b/backport/backport-include/linux/mmc/host.h
new file mode 100644
index 0000000..49ca5c2
--- /dev/null
+++ b/backport/backport-include/linux/mmc/host.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_MMC_HOST_H
+#define __BACKPORT_MMC_HOST_H
+#include <linux/version.h>
+#include_next <linux/mmc/host.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+/* rename member in struct mmc_host */
+#define max_segs	max_hw_segs
+#endif
+
+#endif /* __BACKPORT_MMC_HOST_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 4b2a1ea..4f13782 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -87,4 +87,10 @@ static inline int register_netdevice_name(struct net_device *dev)
 #define register_netdevice(dev) register_netdevice_name(dev)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+#define alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs) \
+	alloc_netdev_mq(sizeof_priv, name, setup, \
+			max_t(unsigned int, txqs, rxqs))
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index 6d7f1e1..d97e57f 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -82,4 +82,17 @@
 #undef PCI_EXP_TYPE_RC_EC
 #define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
 
+#ifndef PCI_MSIX_ENTRY_CTRL_MASKBIT
+#define PCI_MSIX_ENTRY_CTRL_MASKBIT  1
+#endif
+
+/* MSI-X entry's format */
+#ifndef PCI_MSIX_ENTRY_SIZE
+#define PCI_MSIX_ENTRY_SIZE            16
+#define  PCI_MSIX_ENTRY_LOWER_ADDR     0
+#define  PCI_MSIX_ENTRY_UPPER_ADDR     4
+#define  PCI_MSIX_ENTRY_DATA           8
+#define  PCI_MSIX_ENTRY_VECTOR_CTRL    12
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index a255045..43429cf 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -35,4 +35,34 @@ do {                                                           \
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
 
+#ifndef pr_warn
+#define pr_warn pr_warning
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+#define pr_emerg_once(fmt, ...)					\
+	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_alert_once(fmt, ...)					\
+	printk_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_crit_once(fmt, ...)					\
+	printk_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_err_once(fmt, ...)					\
+	printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warn_once(fmt, ...)					\
+	printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_notice_once(fmt, ...)				\
+	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_info_once(fmt, ...)					\
+	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_cont_once(fmt, ...)					\
+	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#if defined(DEBUG)
+#define pr_debug_once(fmt, ...)					\
+	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#else
+#define pr_debug_once(fmt, ...)					\
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+#endif
+
 #endif	/* _COMPAT_LINUX_PRINTK_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index fcddd17..2ad3612 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -68,4 +68,11 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+static inline int skb_checksum_start_offset(const struct sk_buff *skb)
+{
+	return skb->csum_start - skb_headroom(skb);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 6e9796f..f908afb 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -9,4 +9,9 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay);
 #endif
 
+#ifndef create_freezable_workqueue
+/* note freez_a_ble -> freez_ea_able */
+#define create_freezable_workqueue create_freezeable_workqueue
+#endif
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index 9c7207d..0e4a2be 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -22,4 +22,36 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 #endif
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30)
+static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
+				 const struct sk_buff *skb)
+{
+	bstats->bytes += qdisc_pkt_len((struct sk_buff *) skb);
+	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+}
+static inline void qdisc_bstats_update(struct Qdisc *sch,
+				       const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+#else
+/*
+ * kernels <= 2.6.30 do not pass a const skb to qdisc_pkt_len, and
+ * gnet_stats_basic_packed did not exist (see c1a8f1f1c8)
+ */
+static inline void bstats_update(struct gnet_stats_basic *bstats,
+				 struct sk_buff *skb)
+{
+	bstats->bytes += qdisc_pkt_len(skb);
+	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+}
+static inline void qdisc_bstats_update(struct Qdisc *sch,
+				       struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+#endif
+#endif /* < 2.6.38 */
+
 #endif /* __BACKPORT_NET_SCH_GENERIC_H */
-- 
1.8.0

