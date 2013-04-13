Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44245 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:25 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 32/42] backports: dissolve compat-2.6.28.h
Date: Sun, 14 Apr 2013 01:53:52 +0200
Message-Id: <1365897243-31214-33-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015528_051388_C714FB1A)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm-generic/bug.h       |  12 +
 backport/backport-include/linux/compat-2.6.28.h   | 286 ----------------------
 backport/backport-include/linux/cpumask.h         |  10 +
 backport/backport-include/linux/hid.h             |  10 +
 backport/backport-include/linux/if_ether.h        |   4 +
 backport/backport-include/linux/interrupt.h       |   1 +
 backport/backport-include/linux/mod_devicetable.h |  14 ++
 backport/backport-include/linux/pci.h             |   8 +
 backport/backport-include/linux/pci_regs.h        |  10 +
 backport/backport-include/linux/platform_device.h |   6 +
 backport/backport-include/linux/printk.h          |   4 +
 backport/backport-include/linux/skbuff.h          |  80 ++++++
 backport/backport-include/linux/timer.h           |  10 +
 backport/backport-include/linux/tty.h             |   6 +
 backport/backport-include/linux/usb.h             |  10 +
 backport/backport-include/linux/wait.h            |   5 +
 backport/backport-include/linux/workqueue.h       |   4 +
 backport/backport-include/pcmcia/ds.h             |  18 ++
 18 files changed, 212 insertions(+), 286 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.28.h
 create mode 100644 backport/backport-include/linux/cpumask.h
 create mode 100644 backport/backport-include/linux/timer.h

diff --git a/backport/backport-include/asm-generic/bug.h b/backport/backport-include/asm-generic/bug.h
index 86d683c..52d74d3 100644
--- a/backport/backport-include/asm-generic/bug.h
+++ b/backport/backport-include/asm-generic/bug.h
@@ -6,4 +6,16 @@
 #define __WARN(foo) dump_stack()
 #endif
 
+#ifndef WARN_ONCE
+#define WARN_ONCE(condition, format...) ({                      \
+	static int __warned;                                    \
+	int __ret_warn_once = !!(condition);                    \
+								\
+	if (unlikely(__ret_warn_once))                          \
+		if (WARN(!__warned, format))                    \
+			__warned = 1;                           \
+	unlikely(__ret_warn_once);                              \
+})
+#endif
+
 #endif /* __BACKPORT_ASM_GENERIC_BUG_H */
diff --git a/backport/backport-include/linux/compat-2.6.28.h b/backport/backport-include/linux/compat-2.6.28.h
deleted file mode 100644
index 12b644f..0000000
--- a/backport/backport-include/linux/compat-2.6.28.h
+++ /dev/null
@@ -1,286 +0,0 @@
-#ifndef LINUX_26_28_COMPAT_H
-#define LINUX_26_28_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
-
-#include <linux/skbuff.h>
-#include <linux/if_ether.h>
-#include <linux/usb.h>
-#include <linux/types.h>
-#include <linux/types.h>
-#include <linux/cpumask.h>
-#include <linux/mod_devicetable.h>
-#include <linux/input.h>
-
-#define HID_ANY_ID                             (~0)
-
-#define HID_USB_DEVICE(ven, prod)                              \
-	.bus = BUS_USB, .vendor = (ven), .product = (prod)
-#define HID_BLUETOOTH_DEVICE(ven, prod)                                        \
-	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
-
-
-struct hid_device_id {
-	__u16 bus;
-	__u32 vendor;
-	__u32 product;
-	kernel_ulong_t driver_data
-		__attribute__((aligned(sizeof(kernel_ulong_t))));
-};
-
-#ifndef ETH_P_PAE
-#define ETH_P_PAE 0x888E      /* Port Access Entity (IEEE 802.1X) */
-#endif
-
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/platform_device.h>
-
-#define platform_device_register_data LINUX_BACKPORT(platform_device_register_data)
-extern struct platform_device *platform_device_register_data(struct device *,
-		const char *, int, const void *, size_t);
-
-typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } compat_cpumask_t;
-
-#ifndef WARN_ONCE
-#define WARN_ONCE(condition, format...) ({                      \
-	static int __warned;                                    \
-	int __ret_warn_once = !!(condition);                    \
-								\
-	if (unlikely(__ret_warn_once))                          \
-		if (WARN(!__warned, format))                    \
-			__warned = 1;                           \
-	unlikely(__ret_warn_once);                              \
-})
-#endif /* From include/asm-generic/bug.h */
-
-#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cs.h>
-#include <pcmcia/cistpl.h>
-#ifdef pcmcia_parse_tuple
-#undef pcmcia_parse_tuple
-#define pcmcia_parse_tuple(tuple, parse) pccard_parse_tuple(tuple, parse)
-#endif
-
-/* From : include/pcmcia/ds.h */
-/* loop CIS entries for valid configuration */
-#define pcmcia_loop_config LINUX_BACKPORT(pcmcia_loop_config)
-int pcmcia_loop_config(struct pcmcia_device *p_dev,
-		       int	(*conf_check)	(struct pcmcia_device *p_dev,
-						 cistpl_cftable_entry_t *cfg,
-						 cistpl_cftable_entry_t *dflt,
-						 unsigned int vcc,
-						 void *priv_data),
-		       void *priv_data);
-
-#endif /* CONFIG_PCMCIA */
-
-/* USB anchors were added as of 2.6.23 */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23))
-
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-#if 0
-#define usb_poison_urb LINUX_BACKPORT(usb_poison_urb)
-extern void usb_poison_urb(struct urb *urb);
-#endif
-#define usb_unpoison_urb LINUX_BACKPORT(usb_unpoison_urb)
-extern void usb_unpoison_urb(struct urb *urb);
-
-#if 0
-#define usb_poison_anchored_urbs LINUX_BACKPORT(usb_poison_anchored_urbs)
-extern void usb_poison_anchored_urbs(struct usb_anchor *anchor);
-#endif
-
-#define usb_anchor_empty LINUX_BACKPORT(usb_anchor_empty)
-extern int usb_anchor_empty(struct usb_anchor *anchor);
-#endif /* CONFIG_USB */
-#endif
-
-
-#define pci_ioremap_bar LINUX_BACKPORT(pci_ioremap_bar)
-void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
-
-/**
- *	skb_queue_is_last - check if skb is the last entry in the queue
- *	@list: queue head
- *	@skb: buffer
- *
- *	Returns true if @skb is the last buffer on the list.
- */
-static inline bool skb_queue_is_last(const struct sk_buff_head *list,
-				     const struct sk_buff *skb)
-{
-	return (skb->next == (struct sk_buff *) list);
-}
-
-/**
- *	skb_queue_next - return the next packet in the queue
- *	@list: queue head
- *	@skb: current buffer
- *
- *	Return the next packet in @list after @skb.  It is only valid to
- *	call this if skb_queue_is_last() evaluates to false.
- */
-static inline struct sk_buff *skb_queue_next(const struct sk_buff_head *list,
-                                             const struct sk_buff *skb)
-{
-	/* This BUG_ON may seem severe, but if we just return then we
-	 * are going to dereference garbage.
-	 */
-	BUG_ON(skb_queue_is_last(list, skb));
-	return skb->next;
-}
-
-/**
- *	__skb_queue_head_init - initialize non-spinlock portions of sk_buff_head
- *	@list: queue to initialize
- *
- *	This initializes only the list and queue length aspects of
- *	an sk_buff_head object.  This allows to initialize the list
- *	aspects of an sk_buff_head without reinitializing things like
- *	the spinlock.  It can also be used for on-stack sk_buff_head
- *	objects where the spinlock is known to not be used.
- */
-static inline void __skb_queue_head_init(struct sk_buff_head *list)
-{
-	list->prev = list->next = (struct sk_buff *)list;
-	list->qlen = 0;
-}
-
-static inline void __skb_queue_splice(const struct sk_buff_head *list,
-				      struct sk_buff *prev,
-				      struct sk_buff *next)
-{
-	struct sk_buff *first = list->next;
-	struct sk_buff *last = list->prev;
-
-	first->prev = prev;
-	prev->next = first;
-
-	last->next = next;
-	next->prev = last;
-}
-
-/**
- *	skb_queue_splice - join two skb lists, this is designed for stacks
- *	@list: the new list to add
- *	@head: the place to add it in the first list
- */
-static inline void skb_queue_splice(const struct sk_buff_head *list,
-				    struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
-		head->qlen += list->qlen;
-	}
-}
-
-/**
- *	skb_queue_splice - join two skb lists and reinitialise the emptied list
- *	@list: the new list to add
- *	@head: the place to add it in the first list
- *
- *	The list at @list is reinitialised
- */
-static inline void skb_queue_splice_init(struct sk_buff_head *list,
-					 struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
-		head->qlen += list->qlen;
-		__skb_queue_head_init(list);
-	}
-}
-
-/**
- *	skb_queue_splice_tail - join two skb lists and reinitialise the emptied list
- *	@list: the new list to add
- *	@head: the place to add it in the first list
- *
- *	Each of the lists is a queue.
- *	The list at @list is reinitialised
- */
-static inline void skb_queue_splice_tail_init(struct sk_buff_head *list,
-					      struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
-		head->qlen += list->qlen;
-		__skb_queue_head_init(list);
-	}
-} /* From include/linux/skbuff.h */
-
-/**
- *	skb_queue_splice_tail - join two skb lists, each list being a queue
- *	@list: the new list to add
- *	@head: the place to add it in the first list
- */
-static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
-					 struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
-		head->qlen += list->qlen;
-	}
-}
-
-#define skb_queue_walk_from(queue, skb)						\
-		for (; skb != (struct sk_buff *)(queue);			\
-		     skb = skb->next)
-
-#ifndef DECLARE_TRACE
-
-#define TP_PROTO(args...)	args
-#define TP_ARGS(args...)		args
-
-#define DECLARE_TRACE(name, proto, args)				\
-	static inline void _do_trace_##name(struct tracepoint *tp, proto) \
-	{ }								\
-	static inline void trace_##name(proto)				\
-	{ }								\
-	static inline int register_trace_##name(void (*probe)(proto))	\
-	{								\
-		return -ENOSYS;						\
-	}								\
-	static inline int unregister_trace_##name(void (*probe)(proto))	\
-	{								\
-		return -ENOSYS;						\
-	}
-
-#define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
-#define EXPORT_TRACEPOINT_SYMBOL(name)
-
-
-#endif
-
-#define round_jiffies_up LINUX_BACKPORT(round_jiffies_up)
-unsigned long round_jiffies_up(unsigned long j);
-
-#define wake_up_interruptible_poll(x, m)			\
-	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
-
-#define n_tty_ioctl_helper LINUX_BACKPORT(n_tty_ioctl_helper)
-extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg);
-
-#define pci_wake_from_d3 LINUX_BACKPORT(pci_wake_from_d3)
-int pci_wake_from_d3(struct pci_dev *dev, bool enable);
-
-#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active)
-
-#ifndef pr_fmt
-#define pr_fmt(fmt) fmt
-#endif
-
-#define PCI_EXP_DEVCAP2		36      /* Device Capabilities 2 */
-#define  PCI_EXP_DEVCAP2_ARI  	0x20    /* Alternative Routing-ID */
-#define PCI_EXP_DEVCTL2		40      /* Device Control 2 */
-#define  PCI_EXP_DEVCTL2_ARI	0x20    /* Alternative Routing-ID */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)) */
-
-#endif /* LINUX_26_28_COMPAT_H */
diff --git a/backport/backport-include/linux/cpumask.h b/backport/backport-include/linux/cpumask.h
new file mode 100644
index 0000000..7df3457
--- /dev/null
+++ b/backport/backport-include/linux/cpumask.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_CPUMASK_H
+#define __BACKPORT_LINUX_CPUMASK_H
+#include_next <linux/cpumask.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } compat_cpumask_t;
+#endif
+
+#endif /* __BACKPORT_LINUX_CPUMASK_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index 4ad740a..22ff6f1 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -24,4 +24,14 @@ extern bool hid_ignore(struct hid_device *);
 #define HID_QUIRK_IGNORE                       0x00000004
 #endif
 
+#ifndef HID_USB_DEVICE
+#define HID_USB_DEVICE(ven, prod)                              \
+	.bus = BUS_USB, .vendor = (ven), .product = (prod)
+#endif
+
+#ifndef HID_BLUETOOTH_DEVICE
+#define HID_BLUETOOTH_DEVICE(ven, prod)                                        \
+	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
+#endif
+
 #endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index dd1bae4..8581283 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -27,4 +27,8 @@
 int mac_pton(const char *s, u8 *mac);
 #endif
 
+#ifndef ETH_P_PAE
+#define ETH_P_PAE 0x888E      /* Port Access Entity (IEEE 802.1X) */
+#endif
+
 #endif /* __BACKPORT_IF_ETHER_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 9e51303..1729567 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -11,6 +11,7 @@ static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#include <linux/cpumask.h>
 /* mask irq_set_affinity_hint as RHEL6 backports this */
 #define irq_set_affinity_hint LINUX_BACKPORT(irq_set_affinity_hint)
 /*
diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index 59321af..1f85ce6 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -10,6 +10,20 @@
 #define HID_GROUP_ANY                          0x0000
 #endif
 
+#ifndef HID_ANY_ID
+#define HID_ANY_ID                             (~0)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+struct hid_device_id {
+	__u16 bus;
+	__u32 vendor;
+	__u32 product;
+	kernel_ulong_t driver_data
+		__attribute__((aligned(sizeof(kernel_ulong_t))));
+};
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
 #ifndef BCMA_CORE
 /* Broadcom's specific AMBA core, see drivers/bcma/ */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 49bcc6f..94199bb 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -165,4 +165,12 @@ static inline bool pci_is_pcie(struct pci_dev *dev)
 }
 #endif /* < 2.6.33 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define pci_ioremap_bar LINUX_BACKPORT(pci_ioremap_bar)
+void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
+
+#define pci_wake_from_d3 LINUX_BACKPORT(pci_wake_from_d3)
+int pci_wake_from_d3(struct pci_dev *dev, bool enable);
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index 2591a14..401875f 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -111,4 +111,14 @@
 #define PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
 #endif
 
+#ifndef PCI_EXP_DEVCAP2
+#define PCI_EXP_DEVCAP2		36      /* Device Capabilities 2 */
+#define  PCI_EXP_DEVCAP2_ARI  	0x20    /* Alternative Routing-ID */
+#endif
+
+#ifndef PCI_EXP_DEVCTL2
+#define PCI_EXP_DEVCTL2		40      /* Device Control 2 */
+#define  PCI_EXP_DEVCTL2_ARI	0x20    /* Alternative Routing-ID */
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index d7a34a9..d93f04b 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -33,4 +33,10 @@ module_exit(__platform_driver##_exit);
                         platform_driver_unregister)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define platform_device_register_data LINUX_BACKPORT(platform_device_register_data)
+extern struct platform_device *platform_device_register_data(struct device *,
+		const char *, int, const void *, size_t);
+#endif
+
 #endif /* __BACKPORT_PLATFORM_DEVICE_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index b97f51e..00d86f3 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -9,6 +9,10 @@
 #include <linux/kernel.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35)) */
 
+#ifndef pr_fmt
+#define pr_fmt(fmt) fmt
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 /* backports 7a555613 */
 #if defined(CONFIG_DYNAMIC_DEBUG)
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 007d21d..d34378e 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -137,4 +137,84 @@ static inline struct sk_buff *skb_queue_prev(const struct sk_buff_head *list,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+static inline bool skb_queue_is_last(const struct sk_buff_head *list,
+				     const struct sk_buff *skb)
+{
+	return (skb->next == (struct sk_buff *) list);
+}
+
+static inline struct sk_buff *skb_queue_next(const struct sk_buff_head *list,
+                                             const struct sk_buff *skb)
+{
+	/* This BUG_ON may seem severe, but if we just return then we
+	 * are going to dereference garbage.
+	 */
+	BUG_ON(skb_queue_is_last(list, skb));
+	return skb->next;
+}
+
+static inline void __skb_queue_head_init(struct sk_buff_head *list)
+{
+	list->prev = list->next = (struct sk_buff *)list;
+	list->qlen = 0;
+}
+
+static inline void __skb_queue_splice(const struct sk_buff_head *list,
+				      struct sk_buff *prev,
+				      struct sk_buff *next)
+{
+	struct sk_buff *first = list->next;
+	struct sk_buff *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+static inline void skb_queue_splice(const struct sk_buff_head *list,
+				    struct sk_buff_head *head)
+{
+	if (!skb_queue_empty(list)) {
+		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
+		head->qlen += list->qlen;
+	}
+}
+
+static inline void skb_queue_splice_init(struct sk_buff_head *list,
+					 struct sk_buff_head *head)
+{
+	if (!skb_queue_empty(list)) {
+		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
+		head->qlen += list->qlen;
+		__skb_queue_head_init(list);
+	}
+}
+
+static inline void skb_queue_splice_tail_init(struct sk_buff_head *list,
+					      struct sk_buff_head *head)
+{
+	if (!skb_queue_empty(list)) {
+		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
+		head->qlen += list->qlen;
+		__skb_queue_head_init(list);
+	}
+}
+
+static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
+					 struct sk_buff_head *head)
+{
+	if (!skb_queue_empty(list)) {
+		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
+		head->qlen += list->qlen;
+	}
+}
+
+#define skb_queue_walk_from(queue, skb)						\
+		for (; skb != (struct sk_buff *)(queue);			\
+		     skb = skb->next)
+#endif /* < 2.6.28 */
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
new file mode 100644
index 0000000..2720584
--- /dev/null
+++ b/backport/backport-include/linux/timer.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_TIMER_H
+#define __BACKPORT_LINUX_TIMER_H
+#include_next <linux/timer.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define round_jiffies_up LINUX_BACKPORT(round_jiffies_up)
+unsigned long round_jiffies_up(unsigned long j);
+#endif
+
+#endif /* __BACKPORT_LINUX_TIMER_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 4a5a733..b102645 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -33,6 +33,12 @@ static inline void tty_unlock(void) __releases(kernel_lock)
 #define tty_locked()           (kernel_locked())
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define n_tty_ioctl_helper LINUX_BACKPORT(n_tty_ioctl_helper)
+extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
+		       unsigned int cmd, unsigned long arg);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /* Backports tty_lock: Localise the lock */
 #define tty_lock(__tty) tty_lock()
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index e155d72..3821575 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -112,4 +112,14 @@ extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);
 #endif /* CONFIG_USB */
 #endif /* 2.6.23 - 2.6.28 */
 
+/* USB anchors were added as of 2.6.23 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
+#define usb_unpoison_urb LINUX_BACKPORT(usb_unpoison_urb)
+extern void usb_unpoison_urb(struct urb *urb);
+
+#define usb_anchor_empty LINUX_BACKPORT(usb_anchor_empty)
+extern int usb_anchor_empty(struct usb_anchor *anchor);
+#endif /* 2.6.23-2.6.27 */
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 9549984..7ada8bc 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -16,4 +16,9 @@ extern void compat_wake_up_locked(wait_queue_head_t *q, unsigned int mode, int n
 #define wake_up_all_locked(x)	compat_wake_up_locked((x), TASK_NORMAL, 0)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define wake_up_interruptible_poll(x, m)			\
+	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
+#endif
+
 #endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 0caaf05..3a035de 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -18,6 +18,10 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active)
+#endif
+
 #ifndef alloc_workqueue
 #define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active, 0)
 #endif
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 5cc2e60..0e317cd 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -66,4 +66,22 @@ int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
 					 void *priv_data));
 #endif /* < 2.6.33 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#ifdef pcmcia_parse_tuple
+#undef pcmcia_parse_tuple
+#define pcmcia_parse_tuple(tuple, parse) pccard_parse_tuple(tuple, parse)
+#endif
+
+/* From : include/pcmcia/ds.h */
+/* loop CIS entries for valid configuration */
+#define pcmcia_loop_config LINUX_BACKPORT(pcmcia_loop_config)
+int pcmcia_loop_config(struct pcmcia_device *p_dev,
+		       int	(*conf_check)	(struct pcmcia_device *p_dev,
+						 cistpl_cftable_entry_t *cfg,
+						 cistpl_cftable_entry_t *dflt,
+						 unsigned int vcc,
+						 void *priv_data),
+		       void *priv_data);
+#endif
+
 #endif /* __BACKPORT_PCMCIA_DS_H */
-- 
1.8.0

