Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44231 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzM (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:12 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 33/42] backports: dissolve compat-2.6.27.h
Date: Sun, 14 Apr 2013 01:53:53 +0200
Message-Id: <1365897243-31214-34-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015515_322231_4CDF06C8)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm-generic/bug.h        |  18 ++
 .../backport-include/asm-generic/pci-dma-compat.h  |  17 ++
 backport/backport-include/linux/compat-2.6.27.h    | 317 ---------------------
 backport/backport-include/linux/debugfs.h          |  18 ++
 backport/backport-include/linux/device.h           |  12 +
 backport/backport-include/linux/dma-mapping.h      |  43 +++
 backport/backport-include/linux/ethtool.h          |  13 +
 backport/backport-include/linux/firmware.h         |   8 +
 backport/backport-include/linux/kernel.h           |   4 +
 backport/backport-include/linux/list.h             |  58 ++++
 backport/backport-include/linux/lockdep.h          |  23 ++
 backport/backport-include/linux/mmc/core.h         |  12 +
 backport/backport-include/linux/mmc/sdio_func.h    |   6 +
 backport/backport-include/linux/netdevice.h        |  30 ++
 backport/backport-include/linux/pci.h              |   5 +
 backport/backport-include/linux/pci_regs.h         |   4 +
 backport/backport-include/linux/workqueue.h        |   5 +
 backport/backport-include/net/iw_handler.h         |  17 ++
 backport/backport-include/net/sch_generic.h        |  38 +++
 19 files changed, 331 insertions(+), 317 deletions(-)
 create mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.27.h
 create mode 100644 backport/backport-include/linux/debugfs.h
 create mode 100644 backport/backport-include/linux/mmc/core.h

diff --git a/backport/backport-include/asm-generic/bug.h b/backport/backport-include/asm-generic/bug.h
index 52d74d3..4e9e05f 100644
--- a/backport/backport-include/asm-generic/bug.h
+++ b/backport/backport-include/asm-generic/bug.h
@@ -18,4 +18,22 @@
 })
 #endif
 
+#ifndef __WARN_printf
+/*
+ * To port this properly we'd have to port warn_slowpath_null(),
+ * which I'm lazy to do so just do a regular print for now. If you
+ * want to port this read kernel/panic.c
+ */
+#define __WARN_printf(arg...)   do { printk(arg); __WARN(); } while (0)
+#endif
+
+#ifndef WARN
+#define WARN(condition, format...) ({					\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on))					\
+		__WARN_printf(format);					\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+
 #endif /* __BACKPORT_ASM_GENERIC_BUG_H */
diff --git a/backport/backport-include/asm-generic/pci-dma-compat.h b/backport/backport-include/asm-generic/pci-dma-compat.h
new file mode 100644
index 0000000..aa61f4d
--- /dev/null
+++ b/backport/backport-include/asm-generic/pci-dma-compat.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_ASM_PCI_DMA_COMPAT_H
+#define __BACKPORT_ASM_PCI_DMA_COMPAT_H
+#include_next <asm-generic/pci-dma-compat.h>
+#include <linux/version.h>
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#include <backport/magic.h>
+
+#define pci_dma_mapping_error1(dma_addr) dma_mapping_error1(dma_addr)
+#define pci_dma_mapping_error2(pdev, dma_addr) dma_mapping_error2(pdev, dma_addr)
+#undef pci_dma_mapping_error
+#define pci_dma_mapping_error(...) \
+	macro_dispatcher(pci_dma_mapping_error, __VA_ARGS__)(__VA_ARGS__)
+#endif
+
+#endif /* __BACKPORT_ASM_PCI_DMA_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.27.h b/backport/backport-include/linux/compat-2.6.27.h
deleted file mode 100644
index b71a3b5..0000000
--- a/backport/backport-include/linux/compat-2.6.27.h
+++ /dev/null
@@ -1,317 +0,0 @@
-#ifndef LINUX_26_27_COMPAT_H
-#define LINUX_26_27_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27))
-
-#include <linux/debugfs.h>
-#include <linux/list.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-#include <linux/mmc/sdio.h>
-#include <linux/mmc/sdio_func.h>
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24) */
-#include <linux/netdevice.h>
-#include <linux/workqueue.h>
-#include <net/iw_handler.h>
-#include <asm-generic/bug.h>
-#include <linux/wireless.h>
-#include <linux/skbuff.h>
-#include <net/sch_generic.h>
-#include <linux/ethtool.h>
-
-static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
-{
-	return qdisc->dev;
-}
-
-/*
- * Backports 378a2f09 and c27f339a
- * This may need a bit more work.
- */
-enum net_xmit_qdisc_t {
-	__NET_XMIT_STOLEN = 0x00010000,
-	__NET_XMIT_BYPASS = 0x00020000,
-};
-
-struct qdisc_skb_cb {
-	unsigned int            pkt_len;
-	char                    data[];
-};
-
-static inline struct qdisc_skb_cb *qdisc_skb_cb(struct sk_buff *skb)
-{
-	return (struct qdisc_skb_cb *)skb->cb;
-}
-
-static inline unsigned int qdisc_pkt_len(struct sk_buff *skb)
-{
-	return qdisc_skb_cb(skb)->pkt_len;
-}
-
-#define PCI_PM_CAP_PME_SHIFT	11
-
-/* I can't find a more suitable replacement... */
-#define flush_work(work) cancel_work_sync(work)
-
-struct builtin_fw {
-	char *name;
-	void *data;
-	unsigned long size;
-};
-
-/*
- * On older kernels we do not have net_device Multi Queue support, but
- * since we no longer use MQ on mac80211 we can simply use the 0 queue.
- * Note that if other fullmac drivers make use of this they then need
- * to be backported somehow or deal with just 1 queueue from MQ.
- */
-static inline void netif_tx_wake_all_queues(struct net_device *dev)
-{
-	netif_wake_queue(dev);
-}
-static inline void netif_tx_start_all_queues(struct net_device *dev)
-{
-	netif_start_queue(dev);
-}
-static inline void netif_tx_stop_all_queues(struct net_device *dev)
-{
-	netif_stop_queue(dev);
-}
-
-/* Are all TX queues of the device empty?  */
-static inline bool qdisc_all_tx_empty(const struct net_device *dev)
-{
-	return skb_queue_empty(&dev->qdisc->q);
-}
-
-#define pci_pme_capable LINUX_BACKPORT(pci_pme_capable)
-bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
-
-/*
- * The net_device has a spin_lock on newer kernels, on older kernels we're out of luck
- */
-#define netif_addr_lock_bh(dev)
-#define netif_addr_unlock_bh(dev)
-
-/*
- * To port this properly we'd have to port warn_slowpath_null(),
- * which I'm lazy to do so just do a regular print for now. If you
- * want to port this read kernel/panic.c
- */
-#define __WARN_printf(arg...)   do { printk(arg); __WARN(); } while (0)
-
-/* This is ported directly as-is on newer kernels */
-#ifndef WARN
-#define WARN(condition, format...) ({					\
-	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
-		__WARN_printf(format);					\
-	unlikely(__ret_warn_on);					\
-})
-#endif
-
-/* On 2.6.27 a second argument was added, on older kernels we ignore it */
-#define dma_mapping_error(pdev, dma_addr) dma_mapping_error(dma_addr)
-#define pci_dma_mapping_error(pdev, dma_addr) dma_mapping_error(pdev, dma_addr)
-
-/* This is from include/linux/ieee80211.h */
-#define IEEE80211_HT_CAP_DSSSCCK40		0x1000
-
-/* New link list changes added as of 2.6.27, needed for ath9k */
-
-static inline void __list_cut_position(struct list_head *list,
-		struct list_head *head, struct list_head *entry)
-{
-	struct list_head *new_first = entry->next;
-	list->next = head->next;
-	list->next->prev = list;
-	list->prev = entry;
-	entry->next = list;
-	head->next = new_first;
-	new_first->prev = head;
-}
-
-/**
- * list_cut_position - cut a list into two
- * @list: a new list to add all removed entries
- * @head: a list with entries
- * @entry: an entry within head, could be the head itself
- *	and if so we won't cut the list
- *
- * This helper moves the initial part of @head, up to and
- * including @entry, from @head to @list. You should
- * pass on @entry an element you know is on @head. @list
- * should be an empty list or a list you do not care about
- * losing its data.
- *
- */
-static inline void list_cut_position(struct list_head *list,
-		struct list_head *head, struct list_head *entry)
-{
-	if (list_empty(head))
-		return;
-	if (list_is_singular(head) &&
-		(head->next != entry && head != entry))
-		return;
-	if (entry == head)
-		INIT_LIST_HEAD(list);
-	else
-		__list_cut_position(list, head, entry);
-}
-
-
-/* __list_splice as re-implemented on 2.6.27, we backport it */
-static inline void __compat_list_splice_new_27(const struct list_head *list,
-				 struct list_head *prev,
-				 struct list_head *next)
-{
-	struct list_head *first = list->next;
-	struct list_head *last = list->prev;
-
-	first->prev = prev;
-	prev->next = first;
-
-	last->next = next;
-	next->prev = last;
-}
-
-/**
- * list_splice_tail - join two lists, each list being a queue
- * @list: the new list to add.
- * @head: the place to add it in the first list.
- */
-static inline void list_splice_tail(struct list_head *list,
-				struct list_head *head)
-{
-	if (!list_empty(list))
-		__compat_list_splice_new_27(list, head->prev, head);
-}
-
-/**
- * list_splice_tail_init - join two lists and reinitialise the emptied list
- * @list: the new list to add.
- * @head: the place to add it in the first list.
- *
- * Each of the lists is a queue.
- * The list at @list is reinitialised
- */
-static inline void list_splice_tail_init(struct list_head *list,
-					 struct list_head *head)
-{
-	if (!list_empty(list)) {
-		__compat_list_splice_new_27(list, head->prev, head);
-		INIT_LIST_HEAD(list);
-	}
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-#define mmc_align_data_size LINUX_BACKPORT(mmc_align_data_size)
-extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
-#define sdio_align_size LINUX_BACKPORT(sdio_align_size)
-extern unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24) */
-
-#define iwe_stream_add_value(info, event, value, ends, iwe, event_len) iwe_stream_add_value(event, value, ends, iwe, event_len)
-#define iwe_stream_add_point(info, stream, ends, iwe, extra) iwe_stream_add_point(stream, ends, iwe, extra)
-#define iwe_stream_add_event(info, stream, ends, iwe, event_len) iwe_stream_add_event(stream, ends, iwe, event_len)
-
-/* Flags available in struct iw_request_info */
-#define IW_REQUEST_FLAG_COMPAT	0x0001	/* Compat ioctl call */
-
-static inline int iwe_stream_lcp_len(struct iw_request_info *info)
-{
-#ifdef CONFIG_COMPAT
-	if (info->flags & IW_REQUEST_FLAG_COMPAT)
-		return IW_EV_COMPAT_LCP_LEN;
-#endif
-	return IW_EV_LCP_LEN;
-}
-
-#ifdef CONFIG_ARM
-
-/*
- * The caller asks to handle a range between offset and offset + size,
- * but we process a larger range from 0 to offset + size due to lack of
- * offset support.
- */
-
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	dma_sync_single_for_cpu(dev, handle, offset + size, dir);
-}
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	dma_sync_single_for_device(dev, handle, offset + size, dir);
-}
-
-#endif /* arm */
-
-#define debugfs_remove_recursive LINUX_BACKPORT(debugfs_remove_recursive)
-
-#if defined(CONFIG_DEBUG_FS)
-void debugfs_remove_recursive(struct dentry *dentry);
-#else
-static inline void debugfs_remove_recursive(struct dentry *dentry)
-{ }
-#endif
-
-#define device_create(cls, parent, devt, drvdata, fmt, ...)		\
-({									\
-	struct device *_dev;						\
-	_dev = (device_create)(cls, parent, devt, fmt, __VA_ARGS__);	\
-	dev_set_drvdata(_dev, drvdata);					\
-	_dev;								\
-})
-
-#define dev_name(dev) dev_name((struct device *)dev)
-
-static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
-					 __u32 speed)
-{
-	ep->speed = (__u16)speed;
-}
-
-static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
-{
-	return ep->speed;
-}
-
-/**
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((u32)(n))
-
-#define netif_wake_subqueue netif_start_subqueue
-
-/* Backport of:
- *
- * commit 3295f0ef9ff048a4619ede597ad9ec9cab725654
- * Author: Ingo Molnar <mingo@elte.hu>
- * Date:   Mon Aug 11 10:30:30 2008 +0200
- *
- *     lockdep: rename map_[acquire|release]() => lock_map_[acquire|release]()
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# ifdef CONFIG_PROVE_LOCKING
-#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 2, NULL, _THIS_IP_)
-# else
-#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 1, NULL, _THIS_IP_)
-# endif
-# define lock_map_release(l)			lock_release(l, 1, _THIS_IP_)
-#else
-# define lock_map_acquire(l)			do { } while (0)
-# define lock_map_release(l)			do { } while (0)
-#endif
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)) */
-
-#endif /* LINUX_26_27_COMPAT_H */
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
new file mode 100644
index 0000000..16604e3
--- /dev/null
+++ b/backport/backport-include/linux/debugfs.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_LINUX_DEBUGFS_H
+#define __BACKPORT_LINUX_DEBUGFS_H
+#include_next <linux/debugfs.h>
+#include <linux/version.h>
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#define debugfs_remove_recursive LINUX_BACKPORT(debugfs_remove_recursive)
+
+#if defined(CONFIG_DEBUG_FS)
+void debugfs_remove_recursive(struct dentry *dentry);
+#else
+static inline void debugfs_remove_recursive(struct dentry *dentry)
+{ }
+#endif
+#endif /* < 2.6.27 */
+
+#endif /* __BACKPORT_LINUX_DEBUGFS_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 516cc31..07ebe9f 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -129,4 +129,16 @@ static inline void dev_set_uevent_suppress(struct device *dev, int val)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#define device_create(cls, parent, devt, drvdata, fmt, ...)		\
+({									\
+	struct device *_dev;						\
+	_dev = (device_create)(cls, parent, devt, fmt, __VA_ARGS__);	\
+	dev_set_drvdata(_dev, drvdata);					\
+	_dev;								\
+})
+
+#define dev_name(dev) dev_name((struct device *)dev)
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index 540355a..e5d1d3e 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -46,4 +46,47 @@ static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 #endif /* < 2.6.34 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#include <backport/magic.h>
+/* These really belong to asm/dma-mapping.h but it doesn't really matter */
+/* On 2.6.27 a second argument was added, on older kernels we ignore it */
+static inline int dma_mapping_error1(dma_addr_t dma_addr)
+{
+	/* use an inline to grab the old definition */
+	return dma_mapping_error(dma_addr);
+}
+
+#define dma_mapping_error2(pdef, dma_addr) \
+	dma_mapping_error1(dma_addr)
+
+#undef dma_mapping_error
+#define dma_mapping_error(...) \
+	macro_dispatcher(dma_mapping_error, __VA_ARGS__)(__VA_ARGS__)
+
+/* This kinda belongs into asm/dma-mapping.h or so, but doesn't matter */
+#ifdef CONFIG_ARM
+
+/*
+ * The caller asks to handle a range between offset and offset + size,
+ * but we process a larger range from 0 to offset + size due to lack of
+ * offset support.
+ */
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t handle, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	dma_sync_single_for_cpu(dev, handle, offset + size, dir);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t handle, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	dma_sync_single_for_device(dev, handle, offset + size, dir);
+}
+
+#endif /* arm */
+#endif
+
 #endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 4fb3dcc..9ed268b 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -28,4 +28,17 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 #define ADVERTISED_10000baseR_FEC      (1 << 20)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
+					 __u32 speed)
+{
+	ep->speed = (__u16)speed;
+}
+
+static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
+{
+	return ep->speed;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index 9271f96..8db0953 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -18,4 +18,12 @@ int request_firmware_nowait(
 void release_firmware(const struct firmware *fw);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+struct builtin_fw {
+	char *name;
+	void *data;
+	unsigned long size;
+};
+#endif
+
 #endif /* __BACKPORT_LINUX_FIRMWARE_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 19ea0e9..b0ab089 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -202,4 +202,8 @@ int hex_to_bin(char ch);
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 #endif
 
+#ifndef lower_32_bits
+#define lower_32_bits(n) ((u32)(n))
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index a02e0dd..8ad0b28 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -50,4 +50,62 @@
 
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+static inline void __list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	struct list_head *new_first = entry->next;
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry;
+	entry->next = list;
+	head->next = new_first;
+	new_first->prev = head;
+}
+
+static inline void list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	if (list_empty(head))
+		return;
+	if (list_is_singular(head) &&
+		(head->next != entry && head != entry))
+		return;
+	if (entry == head)
+		INIT_LIST_HEAD(list);
+	else
+		__list_cut_position(list, head, entry);
+}
+
+static inline void __compat_list_splice_new_27(const struct list_head *list,
+				 struct list_head *prev,
+				 struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+static inline void list_splice_tail(struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__compat_list_splice_new_27(list, head->prev, head);
+}
+
+static inline void list_splice_tail_init(struct list_head *list,
+					 struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__compat_list_splice_new_27(list, head->prev, head);
+		INIT_LIST_HEAD(list);
+	}
+}
+#endif
+
 #endif /* __BACKPORT_LIST_H */
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index f7f7fb8..c194713 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -28,4 +28,27 @@
 #define lockdep_assert_held(l)			do { } while (0)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+/* Backport of:
+ *
+ * commit 3295f0ef9ff048a4619ede597ad9ec9cab725654
+ * Author: Ingo Molnar <mingo@elte.hu>
+ * Date:   Mon Aug 11 10:30:30 2008 +0200
+ *
+ *     lockdep: rename map_[acquire|release]() => lock_map_[acquire|release]()
+ */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# ifdef CONFIG_PROVE_LOCKING
+#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 2, NULL, _THIS_IP_)
+# else
+#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 1, NULL, _THIS_IP_)
+# endif
+# define lock_map_release(l)			lock_release(l, 1, _THIS_IP_)
+#else
+# define lock_map_acquire(l)			do { } while (0)
+# define lock_map_release(l)			do { } while (0)
+#endif
+
+#endif /* < 2.6.27 */
+
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
diff --git a/backport/backport-include/linux/mmc/core.h b/backport/backport-include/linux/mmc/core.h
new file mode 100644
index 0000000..02d7a98
--- /dev/null
+++ b/backport/backport-include/linux/mmc/core.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_MMC_CORE_H
+#define __BACKPORT_MMC_CORE_H
+#include <linux/version.h>
+#include_next <linux/mmc/core.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
+#define mmc_align_data_size LINUX_BACKPORT(mmc_align_data_size)
+extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
+#endif /* 2.6.24 - 2.6.26 */
+
+#endif /* __BACKPORT_MMC_CORE_H */
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index b596004..f32cafc 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -31,4 +31,10 @@ extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 #define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
+#define sdio_align_size LINUX_BACKPORT(sdio_align_size)
+extern unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz);
+#endif /* 2.6.24 - 2.6.26 */
+
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index dc08764..ca2baf7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -6,6 +6,7 @@
 
 /* older kernels don't include this here, we need it */
 #include <linux/ethtool.h>
+#include <linux/rculist.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
@@ -405,4 +406,33 @@ do {								\
 #define NETDEV_PRE_UP		0x000D
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+/*
+ * On older kernels we do not have net_device Multi Queue support, but
+ * since we no longer use MQ on mac80211 we can simply use the 0 queue.
+ * Note that if other fullmac drivers make use of this they then need
+ * to be backported somehow or deal with just 1 queue from MQ.
+ */
+static inline void netif_tx_wake_all_queues(struct net_device *dev)
+{
+	netif_wake_queue(dev);
+}
+static inline void netif_tx_start_all_queues(struct net_device *dev)
+{
+	netif_start_queue(dev);
+}
+static inline void netif_tx_stop_all_queues(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+}
+
+/*
+ * The net_device has a spin_lock on newer kernels, on older kernels we're out of luck
+ */
+#define netif_addr_lock_bh(dev)
+#define netif_addr_unlock_bh(dev)
+
+#define netif_wake_subqueue netif_start_subqueue
+#endif /* < 2.6.27 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 94199bb..99091d5 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -173,4 +173,9 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#define pci_pme_capable LINUX_BACKPORT(pci_pme_capable)
+bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index 401875f..5cfa742 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -121,4 +121,8 @@
 #define  PCI_EXP_DEVCTL2_ARI	0x20    /* Alternative Routing-ID */
 #endif
 
+#ifndef PCI_PM_CAP_PME_SHIFT
+#define PCI_PM_CAP_PME_SHIFT	11
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 3a035de..9958715 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -71,6 +71,11 @@ static inline void backport_system_workqueue_destroy(void)
 }
 #endif /* < 2.6.36 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+/* I can't find a more suitable replacement... */
+#define flush_work(work) cancel_work_sync(work)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 static inline void flush_delayed_work(struct delayed_work *dwork)
 {
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index 6776720..c418d7d 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -7,4 +7,21 @@
 #define wireless_send_event(a, b, c, d) wireless_send_event(a, b, c, (char * ) d)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#define iwe_stream_add_value(info, event, value, ends, iwe, event_len) iwe_stream_add_value(event, value, ends, iwe, event_len)
+#define iwe_stream_add_point(info, stream, ends, iwe, extra) iwe_stream_add_point(stream, ends, iwe, extra)
+#define iwe_stream_add_event(info, stream, ends, iwe, event_len) iwe_stream_add_event(stream, ends, iwe, event_len)
+
+#define IW_REQUEST_FLAG_COMPAT	0x0001	/* Compat ioctl call */
+
+static inline int iwe_stream_lcp_len(struct iw_request_info *info)
+{
+#ifdef CONFIG_COMPAT
+	if (info->flags & IW_REQUEST_FLAG_COMPAT)
+		return IW_EV_COMPAT_LCP_LEN;
+#endif
+	return IW_EV_LCP_LEN;
+}
+#endif
+
 #endif /* __BACKPORT_NET_IW_HANDLER_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index 196d098..04997c7 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -22,6 +22,37 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 #endif
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
+{
+	return qdisc->dev;
+}
+
+/*
+ * Backports 378a2f09 and c27f339a
+ * This may need a bit more work.
+ */
+enum net_xmit_qdisc_t {
+	__NET_XMIT_STOLEN = 0x00010000,
+	__NET_XMIT_BYPASS = 0x00020000,
+};
+
+struct qdisc_skb_cb {
+	unsigned int            pkt_len;
+	char                    data[];
+};
+
+static inline struct qdisc_skb_cb *qdisc_skb_cb(struct sk_buff *skb)
+{
+	return (struct qdisc_skb_cb *)skb->cb;
+}
+
+static inline unsigned int qdisc_pkt_len(struct sk_buff *skb)
+{
+	return qdisc_skb_cb(skb)->pkt_len;
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30)
 static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
@@ -91,4 +122,11 @@ static inline int qdisc_qlen(const struct Qdisc *q)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+static inline bool qdisc_all_tx_empty(const struct net_device *dev)
+{
+	return skb_queue_empty(&dev->qdisc->q);
+}
+#endif
+
 #endif /* __BACKPORT_NET_SCH_GENERIC_H */
-- 
1.8.0

