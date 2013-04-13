Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44265 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzn (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:43 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 29/42] backports: dissolve compat-2.6.31.h
Date: Sun, 14 Apr 2013 01:53:49 +0200
Message-Id: <1365897243-31214-30-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015639_617643_7379E769)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm/atomic.h          |  17 ++
 backport/backport-include/asm/errno.h           |  23 ++
 backport/backport-include/linux/compat-2.6.31.h | 273 ------------------------
 backport/backport-include/linux/ethtool.h       |  14 ++
 backport/backport-include/linux/interrupt.h     |  83 +++++++
 backport/backport-include/linux/kmemleak.h      |  21 +-
 backport/backport-include/linux/mdio.h          |  17 ++
 backport/backport-include/linux/mmc/sdio_ids.h  |   4 +
 backport/backport-include/linux/netdevice.h     |   4 +
 backport/backport-include/linux/rculist.h       |   5 +
 backport/backport-include/linux/rfkill.h        |  16 ++
 backport/backport-include/linux/skbuff.h        |   5 +
 backport/backport-include/linux/usb.h           |   5 +
 backport/backport-include/net/dst.h             |  35 +++
 backport/backport-include/net/sock.h            |  17 ++
 15 files changed, 265 insertions(+), 274 deletions(-)
 create mode 100644 backport/backport-include/asm/errno.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.31.h
 create mode 100644 backport/backport-include/linux/mdio.h
 create mode 100644 backport/backport-include/net/dst.h

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index f8c9fa7..cabdcfd 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -17,4 +17,21 @@
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#ifndef CONFIG_64BIT
+
+typedef struct {
+	long long counter;
+} atomic64_t;
+
+#define atomic64_read LINUX_BACKPORT(atomic64_read)
+extern long long atomic64_read(const atomic64_t *v);
+#define atomic64_add_return LINUX_BACKPORT(atomic64_add_return)
+extern long long atomic64_add_return(long long a, atomic64_t *v);
+
+#define atomic64_inc_return(v)          atomic64_add_return(1LL, (v))
+
+#endif
+#endif
+
 #endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/asm/errno.h b/backport/backport-include/asm/errno.h
new file mode 100644
index 0000000..0a730b7
--- /dev/null
+++ b/backport/backport-include/asm/errno.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT_ASM_ERRNO_H
+#define __BACKPORT_ASM_ERRNO_H
+#include_next <asm/errno.h>
+
+#ifndef ERFKILL
+#if !defined(CONFIG_ALPHA) && !defined(CONFIG_MIPS) && !defined(CONFIG_PARISC) && !defined(CONFIG_SPARC)
+#define ERFKILL		132	/* Operation not possible due to RF-kill */
+#endif
+#ifdef CONFIG_ALPHA
+#define ERFKILL		138	/* Operation not possible due to RF-kill */
+#endif
+#ifdef CONFIG_MIPS
+#define ERFKILL		167	/* Operation not possible due to RF-kill */
+#endif
+#ifdef CONFIG_PARISC
+#define ERFKILL		256	/* Operation not possible due to RF-kill */
+#endif
+#ifdef CONFIG_SPARC
+#define ERFKILL		134	/* Operation not possible due to RF-kill */
+#endif
+#endif
+
+#endif /* __BACKPORT_ASM_ERRNO_H */
diff --git a/backport/backport-include/linux/compat-2.6.31.h b/backport/backport-include/linux/compat-2.6.31.h
deleted file mode 100644
index 096c131..0000000
--- a/backport/backport-include/linux/compat-2.6.31.h
+++ /dev/null
@@ -1,273 +0,0 @@
-#ifndef LINUX_26_31_COMPAT_H
-#define LINUX_26_31_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
-
-#include <linux/skbuff.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-#include <net/dst.h>
-#include <net/genetlink.h>
-#include <linux/ethtool.h>
-#include <net/sock.h>
-
-#define SUPPORTED_Backplane            (1 << 16)
-#define SUPPORTED_1000baseKX_Full      (1 << 17)
-#define SUPPORTED_10000baseKX4_Full    (1 << 18)
-#define SUPPORTED_10000baseKR_Full     (1 << 19)
-#define SUPPORTED_10000baseR_FEC       (1 << 20)
-
-#define ADVERTISED_Backplane           (1 << 16)
-#define ADVERTISED_1000baseKX_Full     (1 << 17)
-#define ADVERTISED_10000baseKX4_Full   (1 << 18)
-#define ADVERTISED_10000baseKR_Full    (1 << 19)
-#define ADVERTISED_10000baseR_FEC      (1 << 20)
-
-#define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)
-#define rfkill_set_led_trigger_name LINUX_BACKPORT(rfkill_set_led_trigger_name)
-#define rfkill_set_hw_state LINUX_BACKPORT(rfkill_set_hw_state)
-#define rfkill_set_sw_state LINUX_BACKPORT(rfkill_set_sw_state)
-#define rfkill_init_sw_state LINUX_BACKPORT(rfkill_init_sw_state)
-#define rfkill_set_states LINUX_BACKPORT(rfkill_set_states)
-#define rfkill_pause_polling LINUX_BACKPORT(rfkill_pause_polling)
-#define rfkill_resume_polling LINUX_BACKPORT(rfkill_resume_polling)
-#define rfkill_blocked LINUX_BACKPORT(rfkill_blocked)
-#define rfkill_alloc LINUX_BACKPORT(rfkill_alloc)
-#define rfkill_register LINUX_BACKPORT(rfkill_register)
-#define rfkill_unregister LINUX_BACKPORT(rfkill_unregister)
-#define rfkill_destroy LINUX_BACKPORT(rfkill_destroy)
-
-#ifndef ERFKILL
-#if !defined(CONFIG_ALPHA) && !defined(CONFIG_MIPS) && !defined(CONFIG_PARISC) && !defined(CONFIG_SPARC)
-#define ERFKILL		132	/* Operation not possible due to RF-kill */
-#endif
-#ifdef CONFIG_ALPHA
-#define ERFKILL		138	/* Operation not possible due to RF-kill */
-#endif
-#ifdef CONFIG_MIPS
-#define ERFKILL		167	/* Operation not possible due to RF-kill */
-#endif
-#ifdef CONFIG_PARISC
-#define ERFKILL		256	/* Operation not possible due to RF-kill */
-#endif
-#ifdef CONFIG_SPARC
-#define ERFKILL		134	/* Operation not possible due to RF-kill */
-#endif
-#endif
-
-#define mdio45_probe LINUX_BACKPORT(mdio45_probe)
-#define mdio_set_flag LINUX_BACKPORT(mdio_set_flag)
-#define mdio45_links_ok LINUX_BACKPORT(mdio45_links_ok)
-#define mdio45_nway_restart LINUX_BACKPORT(mdio45_nway_restart)
-
-#define mdio45_ethtool_gset_npage LINUX_BACKPORT(mdio45_ethtool_gset_npage)
-#define mdio45_ethtool_spauseparam_an LINUX_BACKPORT(mdio45_ethtool_spauseparam_an)
-#define mdio_mii_ioctl LINUX_BACKPORT(mdio_mii_ioctl)
-
-#ifndef NETDEV_PRE_UP
-#define NETDEV_PRE_UP		0x000D
-#endif
-
-#ifndef SDIO_DEVICE_ID_MARVELL_8688WLAN
-#define SDIO_DEVICE_ID_MARVELL_8688WLAN		0x9104
-#endif
-
-struct compat_threaded_irq {
-	unsigned int irq;
-	irq_handler_t handler;
-	irq_handler_t thread_fn;
-	void *dev_id;
-	char wq_name[64];
-	struct workqueue_struct *wq;
-	struct work_struct work;
-};
-
-/*
- * kmemleak was introduced on 2.6.31, since older kernels do not have
- * we simply ignore its tuning.
- */
-static inline void kmemleak_ignore(const void *ptr)
-{
-	return;
-}
-
-static inline void kmemleak_not_leak(const void *ptr)
-{
-	return;
-}
-
-static inline void kmemleak_no_scan(const void *ptr)
-{
-	return;
-}
-
-/*
- * Added via adf30907d63893e4208dfe3f5c88ae12bc2f25d5
- *
- * There is no _sk_dst on older kernels, so just set the
- * old dst to NULL and release it directly.
- */
-static inline void skb_dst_drop(struct sk_buff *skb)
-{
-	dst_release(skb->dst);
-	skb->dst = NULL;
-}
-
-static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
-{
-	return (struct dst_entry *)skb->dst;
-}
-
-static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
-{
-	skb->dst = dst;
-}
-
-static inline struct rtable *skb_rtable(const struct sk_buff *skb)
-{
-	return (struct rtable *)skb_dst(skb);
-}
-
-/* Backport threaded IRQ support */
-
-static inline
-void compat_irq_work(struct work_struct *work)
-{
-	struct compat_threaded_irq *comp = container_of(work, struct compat_threaded_irq, work);
-	comp->thread_fn(comp->irq, comp->dev_id);
-}
-
-static inline
-irqreturn_t compat_irq_dispatcher(int irq, void *dev_id)
-{
-	struct compat_threaded_irq *comp = dev_id;
-	irqreturn_t res;
-
-	res = comp->handler(irq, comp->dev_id);
-	if (res == IRQ_WAKE_THREAD) {
-		queue_work(comp->wq, &comp->work);
-		res = IRQ_HANDLED;
-	}
-
-	return res;
-}
-
-static inline
-int compat_request_threaded_irq(struct compat_threaded_irq *comp,
-				unsigned int irq,
-				irq_handler_t handler,
-				irq_handler_t thread_fn,
-				unsigned long flags,
-				const char *name,
-				void *dev_id)
-{
-	comp->irq = irq;
-	comp->handler = handler;
-	comp->thread_fn = thread_fn;
-	comp->dev_id = dev_id;
-	INIT_WORK(&comp->work, compat_irq_work);
-
-	if (!comp->wq) {
-		snprintf(comp->wq_name, sizeof(comp->wq_name),
-			 "compirq/%u-%s", irq, name);
-		comp->wq = create_singlethread_workqueue(comp->wq_name);
-		if (!comp->wq) {
-			printk(KERN_ERR "Failed to create compat-threaded-IRQ workqueue %s\n",
-			       comp->wq_name);
-			return -ENOMEM;
-		}
-	}
-	return request_irq(irq, compat_irq_dispatcher, flags, name, comp);
-}
-
-static inline
-void compat_free_threaded_irq(struct compat_threaded_irq *comp)
-{
-	free_irq(comp->irq, comp);
-}
-
-static inline
-void compat_destroy_threaded_irq(struct compat_threaded_irq *comp)
-{
-	if (comp->wq)
-		destroy_workqueue(comp->wq);
-	comp->wq = NULL;
-}
-
-static inline
-void compat_synchronize_threaded_irq(struct compat_threaded_irq *comp)
-{
-	synchronize_irq(comp->irq);
-	cancel_work_sync(&comp->work);
-}
-
-/**
- * list_entry_rcu - get the struct for this entry
- * @ptr:        the &struct list_head pointer.
- * @type:       the type of the struct this is embedded in.
- * @member:     the name of the list_struct within the struct.
- *
- * This primitive may safely run concurrently with the _rcu list-mutation
- * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
- */
-#define list_entry_rcu(ptr, type, member) \
-	container_of(rcu_dereference(ptr), type, member)
-
-#define skb_walk_frags(skb, iter)	\
-	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
-
-#ifndef CONFIG_64BIT
-
-typedef struct {
-	long long counter;
-} atomic64_t;
-
-#define atomic64_read LINUX_BACKPORT(atomic64_read)
-extern long long atomic64_read(const atomic64_t *v);
-#define atomic64_add_return LINUX_BACKPORT(atomic64_add_return)
-extern long long atomic64_add_return(long long a, atomic64_t *v);
-
-#define atomic64_inc_return(v)          atomic64_add_return(1LL, (v))
-
-#endif
-
-/**
- * sk_rmem_alloc_get - returns read allocations
- * @sk: socket
- *
- * Returns sk_rmem_alloc
- */
-static inline int sk_rmem_alloc_get(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_rmem_alloc);
-}
-
-/**
- * sk_wmem_alloc_get - returns write allocations
- * @sk: socket
- *
- * Returns sk_wmem_alloc minus initial offset of one
- */
-static inline int sk_wmem_alloc_get(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_wmem_alloc) - 1;
-}
-
-/**
- * sk_has_allocations - check if allocations are outstanding
- * @sk: socket
- *
- * Returns true if socket has write or read allocations
- */
-static inline bool sk_has_allocations(const struct sock *sk)
-{
-	return sk_wmem_alloc_get(sk) || sk_rmem_alloc_get(sk);
-}
-
-#define USB_SUBCLASS_VENDOR_SPEC	0xff
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
-
-#endif /* LINUX_26_31_COMPAT_H */
diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 2236d0e..4fb3dcc 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -14,4 +14,18 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 #define ETHTOOL_FWVERS_LEN 32
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#define SUPPORTED_Backplane            (1 << 16)
+#define SUPPORTED_1000baseKX_Full      (1 << 17)
+#define SUPPORTED_10000baseKX4_Full    (1 << 18)
+#define SUPPORTED_10000baseKR_Full     (1 << 19)
+#define SUPPORTED_10000baseR_FEC       (1 << 20)
+
+#define ADVERTISED_Backplane           (1 << 16)
+#define ADVERTISED_1000baseKX_Full     (1 << 17)
+#define ADVERTISED_10000baseKX4_Full   (1 << 18)
+#define ADVERTISED_10000baseKR_Full    (1 << 19)
+#define ADVERTISED_10000baseR_FEC      (1 << 20)
+#endif
+
 #endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 908ef36..546a7fb 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -25,4 +25,87 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+struct compat_threaded_irq {
+	unsigned int irq;
+	irq_handler_t handler;
+	irq_handler_t thread_fn;
+	void *dev_id;
+	char wq_name[64];
+	struct workqueue_struct *wq;
+	struct work_struct work;
+};
+
+static inline
+void compat_irq_work(struct work_struct *work)
+{
+	struct compat_threaded_irq *comp = container_of(work, struct compat_threaded_irq, work);
+	comp->thread_fn(comp->irq, comp->dev_id);
+}
+
+static inline
+irqreturn_t compat_irq_dispatcher(int irq, void *dev_id)
+{
+	struct compat_threaded_irq *comp = dev_id;
+	irqreturn_t res;
+
+	res = comp->handler(irq, comp->dev_id);
+	if (res == IRQ_WAKE_THREAD) {
+		queue_work(comp->wq, &comp->work);
+		res = IRQ_HANDLED;
+	}
+
+	return res;
+}
+
+static inline
+int compat_request_threaded_irq(struct compat_threaded_irq *comp,
+				unsigned int irq,
+				irq_handler_t handler,
+				irq_handler_t thread_fn,
+				unsigned long flags,
+				const char *name,
+				void *dev_id)
+{
+	comp->irq = irq;
+	comp->handler = handler;
+	comp->thread_fn = thread_fn;
+	comp->dev_id = dev_id;
+	INIT_WORK(&comp->work, compat_irq_work);
+
+	if (!comp->wq) {
+		snprintf(comp->wq_name, sizeof(comp->wq_name),
+			 "compirq/%u-%s", irq, name);
+		comp->wq = create_singlethread_workqueue(comp->wq_name);
+		if (!comp->wq) {
+			printk(KERN_ERR "Failed to create compat-threaded-IRQ workqueue %s\n",
+			       comp->wq_name);
+			return -ENOMEM;
+		}
+	}
+	return request_irq(irq, compat_irq_dispatcher, flags, name, comp);
+}
+
+static inline
+void compat_free_threaded_irq(struct compat_threaded_irq *comp)
+{
+	free_irq(comp->irq, comp);
+}
+
+static inline
+void compat_destroy_threaded_irq(struct compat_threaded_irq *comp)
+{
+	if (comp->wq)
+		destroy_workqueue(comp->wq);
+	comp->wq = NULL;
+}
+
+static inline
+void compat_synchronize_threaded_irq(struct compat_threaded_irq *comp)
+{
+	synchronize_irq(comp->irq);
+	cancel_work_sync(&comp->work);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_INTERRUPT_H */
diff --git a/backport/backport-include/linux/kmemleak.h b/backport/backport-include/linux/kmemleak.h
index 83bd199..99fff66 100644
--- a/backport/backport-include/linux/kmemleak.h
+++ b/backport/backport-include/linux/kmemleak.h
@@ -2,4 +2,23 @@
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30))
 #include_next <linux/kmemleak.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
+#else
+/*
+ * kmemleak was introduced on 2.6.31, since older kernels do not have
+ * we simply ignore its tuning.
+ */
+static inline void kmemleak_ignore(const void *ptr)
+{
+	return;
+}
+
+static inline void kmemleak_not_leak(const void *ptr)
+{
+	return;
+}
+
+static inline void kmemleak_no_scan(const void *ptr)
+{
+	return;
+}
+#endif
diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
new file mode 100644
index 0000000..888bfee
--- /dev/null
+++ b/backport/backport-include/linux/mdio.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_MDIO_H
+#define __BACKPORT_LINUX_MDIO_H
+#include_next <linux/mdio.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#define mdio45_probe LINUX_BACKPORT(mdio45_probe)
+#define mdio_set_flag LINUX_BACKPORT(mdio_set_flag)
+#define mdio45_links_ok LINUX_BACKPORT(mdio45_links_ok)
+#define mdio45_nway_restart LINUX_BACKPORT(mdio45_nway_restart)
+
+#define mdio45_ethtool_gset_npage LINUX_BACKPORT(mdio45_ethtool_gset_npage)
+#define mdio45_ethtool_spauseparam_an LINUX_BACKPORT(mdio45_ethtool_spauseparam_an)
+#define mdio_mii_ioctl LINUX_BACKPORT(mdio_mii_ioctl)
+#endif
+
+#endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/backport/backport-include/linux/mmc/sdio_ids.h b/backport/backport-include/linux/mmc/sdio_ids.h
index 3223fca..64fe8ec 100644
--- a/backport/backport-include/linux/mmc/sdio_ids.h
+++ b/backport/backport-include/linux/mmc/sdio_ids.h
@@ -7,4 +7,8 @@
 #define SDIO_CLASS_BT_AMP	0x09	/* Type-A Bluetooth AMP interface */
 #endif
 
+#ifndef SDIO_DEVICE_ID_MARVELL_8688WLAN
+#define SDIO_DEVICE_ID_MARVELL_8688WLAN		0x9104
+#endif
+
 #endif /* __BACKPORT_MMC_SDIO_IDS_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index ee4f410..0300ca0 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -291,4 +291,8 @@ do {								\
 #define NETDEV_POST_INIT 0xffff
 #endif
 
+#ifndef NETDEV_PRE_UP
+#define NETDEV_PRE_UP		0x000D
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index bb9f367..73c47df 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -46,4 +46,9 @@
 	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 #endif
 
+#ifndef list_entry_rcu
+#define list_entry_rcu(ptr, type, member) \
+	container_of(rcu_dereference(ptr), type, member)
+#endif
+
 #endif /* __BACKPORT_RCULIST_H */
diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index da236b2..01d18f1 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -1,9 +1,25 @@
 #ifndef __COMPAT_RFKILL_H
 #define __COMPAT_RFKILL_H
+#include <linux/version.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 #include_next <linux/rfkill.h>
 #else
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)
+#define rfkill_set_led_trigger_name LINUX_BACKPORT(rfkill_set_led_trigger_name)
+#define rfkill_set_hw_state LINUX_BACKPORT(rfkill_set_hw_state)
+#define rfkill_set_sw_state LINUX_BACKPORT(rfkill_set_sw_state)
+#define rfkill_init_sw_state LINUX_BACKPORT(rfkill_init_sw_state)
+#define rfkill_set_states LINUX_BACKPORT(rfkill_set_states)
+#define rfkill_pause_polling LINUX_BACKPORT(rfkill_pause_polling)
+#define rfkill_resume_polling LINUX_BACKPORT(rfkill_resume_polling)
+#define rfkill_blocked LINUX_BACKPORT(rfkill_blocked)
+#define rfkill_alloc LINUX_BACKPORT(rfkill_alloc)
+#define rfkill_register LINUX_BACKPORT(rfkill_register)
+#define rfkill_unregister LINUX_BACKPORT(rfkill_unregister)
+#define rfkill_destroy LINUX_BACKPORT(rfkill_destroy)
+#endif
 #include <linux/rfkill_backport.h>
 #endif
 
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index e7f667e..cc145a6 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -117,4 +117,9 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 }
 #endif
 
+#ifndef skb_walk_frags
+#define skb_walk_frags(skb, iter)	\
+	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 79ac140..4ed9617 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -92,4 +92,9 @@ static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *int
 #endif /* CONFIG_USB_SUSPEND */
 #endif /* < 2.6.33 */
 
+#ifndef USB_SUBCLASS_VENDOR_SPEC
+/* this is defined in usb/ch9.h, but we only need it through here */
+#define USB_SUBCLASS_VENDOR_SPEC	0xff
+#endif
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/dst.h b/backport/backport-include/net/dst.h
new file mode 100644
index 0000000..e4e3d8f
--- /dev/null
+++ b/backport/backport-include/net/dst.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_NET_DST_H
+#define __BACKPORT_NET_DST_H
+#include_next <net/dst.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+/*
+ * Added via adf30907d63893e4208dfe3f5c88ae12bc2f25d5
+ *
+ * There is no _sk_dst on older kernels, so just set the
+ * old dst to NULL and release it directly.
+ */
+static inline void skb_dst_drop(struct sk_buff *skb)
+{
+	dst_release(skb->dst);
+	skb->dst = NULL;
+}
+
+static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
+{
+	return (struct dst_entry *)skb->dst;
+}
+
+static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
+{
+	skb->dst = dst;
+}
+
+static inline struct rtable *skb_rtable(const struct sk_buff *skb)
+{
+	return (struct rtable *)skb_dst(skb);
+}
+#endif
+
+#endif /* __BACKPORT_NET_DST_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 93dc6a8..b4f3e6a 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -56,4 +56,21 @@ static inline struct sock *sk_entry(const struct hlist_node *node)
 #define sock_recv_ts_and_drops(msg, sk, skb) sock_recv_timestamp(msg, sk, skb)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+static inline int sk_rmem_alloc_get(const struct sock *sk)
+{
+	return atomic_read(&sk->sk_rmem_alloc);
+}
+
+static inline int sk_wmem_alloc_get(const struct sock *sk)
+{
+	return atomic_read(&sk->sk_wmem_alloc) - 1;
+}
+
+static inline bool sk_has_allocations(const struct sock *sk)
+{
+	return sk_wmem_alloc_get(sk) || sk_rmem_alloc_get(sk);
+}
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
1.8.0

