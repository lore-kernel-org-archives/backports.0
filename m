Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:38747 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab3HWLoF (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 23 Aug 2013 07:44:05 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC] remove support for kernel 2.6.24
Date: Fri, 23 Aug 2013 13:43:58 +0200
Message-Id: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net> (sfid-20130823_134410_672062_E2662128)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

By requiring 2.6.25 we can get rid of quite a lot of backport work.
2.6.25 was released more than five years ago (April 2011) and wasn't
a long-term kernel either, so there's little point in supporting it
now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 README                                             |   3 +-
 .../backport-include/linux/byteorder/generic.h     |  52 ---
 backport/backport-include/linux/device.h           |   9 -
 backport/backport-include/linux/gpio.h             |  10 -
 backport/backport-include/linux/in.h               |  69 ---
 backport/backport-include/linux/irq.h              |   2 -
 backport/backport-include/linux/kernel.h           |  11 -
 backport/backport-include/linux/math64.h           |   6 -
 backport/backport-include/linux/netdevice.h        |   7 -
 backport/backport-include/linux/pci.h              |   9 -
 backport/backport-include/linux/pm_qos.h           |  41 --
 backport/backport-include/linux/pm_qos_params.h    |  41 --
 backport/backport-include/linux/scatterlist.h      |  28 --
 backport/backport-include/linux/semaphore.h        |  12 -
 backport/backport-include/linux/types.h            |  12 +-
 backport/backport-include/linux/vmalloc.h          |   6 -
 backport/compat/Makefile                           |   1 -
 backport/compat/compat-2.6.25.c                    | 307 -------------
 backport/compat/compat-2.6.26.c                    |  24 --
 backport/compat/compat-2.6.37.c                    |   2 -
 backport/compat/main.c                             |   2 -
 backport/compat/pm_qos_params.c                    | 478 ---------------------
 backport/compat/sch_fq_codel_core.c                |   4 -
 dependencies                                       |   9 -
 devel/get-compat-kernels                           |   1 -
 .../drivers_net_wireless_iwlegacy_common.patch     |  28 --
 .../drivers_net_wireless_iwlwifi_dvm_led.patch     |  28 --
 27 files changed, 2 insertions(+), 1200 deletions(-)
 delete mode 100644 backport/backport-include/linux/byteorder/generic.h
 delete mode 100644 backport/backport-include/linux/gpio.h
 delete mode 100644 backport/backport-include/linux/pm_qos_params.h
 delete mode 100644 backport/backport-include/linux/semaphore.h
 delete mode 100644 backport/compat/compat-2.6.25.c
 delete mode 100644 backport/compat/pm_qos_params.c
 delete mode 100644 patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlegacy_common.patch
 delete mode 100644 patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlwifi_dvm_led.patch

diff --git a/README b/README
index 99718b1..eacd116 100644
--- a/README
+++ b/README
@@ -13,8 +13,7 @@ down to older kernels. It currently backports the following subsystems:
   * Regulator
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 2.6.24 and above. It is technically possible to support
-kernels < 2.6.24 but more work is required for that.
+for kernels 2.6.25 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/byteorder/generic.h b/backport/backport-include/linux/byteorder/generic.h
deleted file mode 100644
index 005a92f..0000000
--- a/backport/backport-include/linux/byteorder/generic.h
+++ /dev/null
@@ -1,52 +0,0 @@
-#ifndef __BACKPORT_BYTEORDER_GENERIC_H
-#define __BACKPORT_BYTEORDER_GENERIC_H
-#include_next <linux/byteorder/generic.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-/* The patch:
- * commit 8b5f6883683c91ad7e1af32b7ceeb604d68e2865
- * Author: Marcin Slusarz <marcin.slusarz@gmail.com>
- * Date:   Fri Feb 8 04:20:12 2008 -0800
- *
- *     byteorder: move le32_add_cpu & friends from OCFS2 to core
- *
- * moves le*_add_cpu and be*_add_cpu functions from OCFS2 to core
- * header (1st) and converted some existing code to it. We port
- * it here as later kernels will most likely use it.
- */
-static inline void le16_add_cpu(__le16 *var, u16 val)
-{
-	*var = cpu_to_le16(le16_to_cpu(*var) + val);
-}
-
-static inline void le32_add_cpu(__le32 *var, u32 val)
-{
-	*var = cpu_to_le32(le32_to_cpu(*var) + val);
-}
-
-static inline void le64_add_cpu(__le64 *var, u64 val)
-{
-	*var = cpu_to_le64(le64_to_cpu(*var) + val);
-}
-
-static inline void be16_add_cpu(__be16 *var, u16 val)
-{
-	u16 v = be16_to_cpu(*var);
-	*var = cpu_to_be16(v + val);
-}
-
-static inline void be32_add_cpu(__be32 *var, u32 val)
-{
-	u32 v = be32_to_cpu(*var);
-	*var = cpu_to_be32(v + val);
-}
-
-static inline void be64_add_cpu(__be64 *var, u64 val)
-{
-	u64 v = be64_to_cpu(*var);
-	*var = cpu_to_be64(v + val);
-}
-#endif
-
-#endif /* __BACKPORT_BYTEORDER_GENERIC_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 90a5c71..06e1292 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -19,15 +19,6 @@ typedef int (backport_device_find_function_t)(struct device *, void *);
 			  (backport_device_find_function_t *)(fun))
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-#define dev_emerg(dev, format, arg...)          \
-	dev_printk(KERN_EMERG , dev , format , ## arg)
-#define dev_alert(dev, format, arg...)          \
-	dev_printk(KERN_ALERT , dev , format , ## arg)
-#define dev_crit(dev, format, arg...)           \
-	dev_printk(KERN_CRIT , dev , format , ## arg)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 static inline int
 backport_device_move(struct device *dev, struct device *new_parent,
diff --git a/backport/backport-include/linux/gpio.h b/backport/backport-include/linux/gpio.h
deleted file mode 100644
index d31e14e..0000000
--- a/backport/backport-include/linux/gpio.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _COMPAT_LINUX_GPIO_H
-#define _COMPAT_LINUX_GPIO_H 1
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
-#include_next <linux/gpio.h>
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25)) */
-
-#endif	/* _COMPAT_LINUX_GPIO_H */
diff --git a/backport/backport-include/linux/in.h b/backport/backport-include/linux/in.h
index f019e0a..1fcc384 100644
--- a/backport/backport-include/linux/in.h
+++ b/backport/backport-include/linux/in.h
@@ -3,75 +3,6 @@
 #include_next <linux/in.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-/*
- * backports 2658fa803111dae1353602e7f586de8e537803e2
- */
-
-static inline bool ipv4_is_loopback(__be32 addr)
-{
-	return (addr & htonl(0xff000000)) == htonl(0x7f000000);
-}
-
-static inline bool ipv4_is_multicast(__be32 addr)
-{
-	return (addr & htonl(0xf0000000)) == htonl(0xe0000000);
-}
-
-static inline bool ipv4_is_local_multicast(__be32 addr)
-{
-	return (addr & htonl(0xffffff00)) == htonl(0xe0000000);
-}
-
-static inline bool ipv4_is_lbcast(__be32 addr)
-{
-	/* limited broadcast */
-	return addr == htonl(INADDR_BROADCAST);
-}
-
-static inline bool ipv4_is_zeronet(__be32 addr)
-{
-	return (addr & htonl(0xff000000)) == htonl(0x00000000);
-}
-
-/* Special-Use IPv4 Addresses (RFC3330) */
-
-static inline bool ipv4_is_private_10(__be32 addr)
-{
-	return (addr & htonl(0xff000000)) == htonl(0x0a000000);
-}
-
-static inline bool ipv4_is_private_172(__be32 addr)
-{
-	return (addr & htonl(0xfff00000)) == htonl(0xac100000);
-}
-
-static inline bool ipv4_is_private_192(__be32 addr)
-{
-	return (addr & htonl(0xffff0000)) == htonl(0xc0a80000);
-}
-
-static inline bool ipv4_is_linklocal_169(__be32 addr)
-{
-	return (addr & htonl(0xffff0000)) == htonl(0xa9fe0000);
-}
-
-static inline bool ipv4_is_anycast_6to4(__be32 addr)
-{
-	return (addr & htonl(0xffffff00)) == htonl(0xc0586300);
-}
-
-static inline bool ipv4_is_test_192(__be32 addr)
-{
-	return (addr & htonl(0xffffff00)) == htonl(0xc0000200);
-}
-
-static inline bool ipv4_is_test_198(__be32 addr)
-{
-	return (addr & htonl(0xfffe0000)) == htonl(0xc6120000);
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
 static inline int proto_ports_offset(int proto)
 {
diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
index 5d7326f..f8d12d9 100644
--- a/backport/backport-include/linux/irq.h
+++ b/backport/backport-include/linux/irq.h
@@ -51,7 +51,6 @@ static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
 	return get_irq_msi(irq);
 }
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
 static inline void irq_set_noprobe(unsigned int irq)
 {
 	set_irq_noprobe(irq);
@@ -61,7 +60,6 @@ static inline void irq_set_probe(unsigned int irq)
 	set_irq_probe(irq);
 }
 #endif
-#endif
 
 /* This is really in irqdesc.h, but nothing includes that directly */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39) && \
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 42aa91d..4e249db 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -8,17 +8,6 @@
  */
 #include <linux/printk.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25))
-/**
- * The following things are out of ./include/linux/kernel.h
- * The new iwlwifi driver is using them.
- */
-#define strict_strtoul LINUX_BACKPORT(strict_strtoul)
-extern int strict_strtoul(const char *, unsigned int, unsigned long *);
-#define strict_strtol LINUX_BACKPORT(strict_strtol)
-extern int strict_strtol(const char *, unsigned int, long *);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)) */
-
 /*
  * This backports:
  *
diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
index 775c2d3..d551db6 100644
--- a/backport/backport-include/linux/math64.h
+++ b/backport/backport-include/linux/math64.h
@@ -2,13 +2,7 @@
 #define _COMPAT_LINUX_MATH64_H 1
 
 #include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 #include_next <linux/math64.h>
-#else
-#include <linux/types.h>
-#include <asm/div64.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
 #if BITS_PER_LONG == 64
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index aa1dcd6..631fc84 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -115,13 +115,6 @@ extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-#define __dev_addr_sync LINUX_BACKPORT(__dev_addr_sync)
-extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
-#define __dev_addr_unsync LINUX_BACKPORT(__dev_addr_unsync)
-extern void __dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
 #define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
 void netdev_attach_ops(struct net_device *dev,
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 08783e5..61f0f08 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -3,15 +3,6 @@
 #include_next <linux/pci.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-/* Backports b718989da7 */
-#define pci_enable_device_mem LINUX_BACKPORT(pci_enable_device_mem)
-int __must_check pci_enable_device_mem(struct pci_dev *dev);
-
-#define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[] __devinitdata
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
 #define compat_pci_suspend(fn)						\
 	int fn##_compat(struct pci_dev *pdev, pm_message_t state) 	\
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index 96a600f..26e23a5 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -3,47 +3,6 @@
 
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
-/*
- * Kernels >= 2.6.25 have pm-qos and its initialized as part of
- * the bootup process
- */
-static inline int backport_pm_qos_power_init(void)
-{
-	return 0;
-}
-
-static inline int backport_pm_qos_power_deinit(void)
-{
-	return 0;
-}
-#else
-/*
- * Backport work for QoS dependencies (kernel/pm_qos_params.c)
- * pm-qos stuff written by mark gross mgross@linux.intel.com.
- *
- * ipw2100 now makes use of:
- *
- * pm_qos_add_requirement(),
- * pm_qos_update_requirement() and
- * pm_qos_remove_requirement() from it
- *
- * mac80211 uses the network latency to determine if to enable or not
- * dynamic PS. mac80211 also and registers a notifier for when
- * the latency changes. Since older kernels do no thave pm-qos stuff
- * we just implement it completley here and register it upon cfg80211
- * init. I haven't tested ipw2100 on 2.6.24 though.
- *
- * This pm-qos implementation is copied verbatim from the kernel
- * written by mark gross mgross@linux.intel.com. You don't have
- * to do anythinig to use pm-qos except use the same exported
- * routines as used in newer kernels. The backport_pm_qos_power_init()
- * defned below is used by the compat module to initialize pm-qos.
- */
-int backport_pm_qos_power_init(void);
-int backport_pm_qos_power_deinit(void);
-#endif
-
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include_next <linux/pm_qos.h>
 #else
diff --git a/backport/backport-include/linux/pm_qos_params.h b/backport/backport-include/linux/pm_qos_params.h
deleted file mode 100644
index c591753..0000000
--- a/backport/backport-include/linux/pm_qos_params.h
+++ /dev/null
@@ -1,41 +0,0 @@
-#ifndef __COMPAT_LINUX_PM_QOS_PARAMS_H
-#define __COMPAT_LINUX_PM_QOS_PARAMS_H
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
-#include_next <linux/pm_qos_params.h>
-#else
-/* interface for the pm_qos_power infrastructure of the linux kernel.
- *
- * Mark Gross <mgross@linux.intel.com>
- */
-#include <linux/list.h>
-#include <linux/notifier.h>
-#include <linux/miscdevice.h>
-
-#define PM_QOS_RESERVED 0
-#define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
-#define PM_QOS_SYSTEM_BUS_FREQ 4
-
-#define PM_QOS_NUM_CLASSES 5
-#define PM_QOS_DEFAULT_VALUE -1
-
-#define pm_qos_add_requirement LINUX_BACKPORT(pm_qos_add_requirement)
-int pm_qos_add_requirement(int qos, char *name, s32 value);
-#define pm_qos_update_requirement LINUX_BACKPORT(pm_qos_update_requirement)
-int pm_qos_update_requirement(int qos, char *name, s32 new_value);
-#define pm_qos_remove_requirement LINUX_BACKPORT(pm_qos_remove_requirement)
-void pm_qos_remove_requirement(int qos, char *name);
-
-#define pm_qos_requirement LINUX_BACKPORT(pm_qos_requirement)
-int pm_qos_requirement(int qos);
-
-#define pm_qos_add_notifier LINUX_BACKPORT(pm_qos_add_notifier)
-int pm_qos_add_notifier(int qos, struct notifier_block *notifier);
-#define pm_qos_remove_notifier LINUX_BACKPORT(pm_qos_remove_notifier)
-int pm_qos_remove_notifier(int qos, struct notifier_block *notifier);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25)) */
-
-#endif
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index 448730f..bb2b5a4 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -3,34 +3,6 @@
 #include_next <linux/scatterlist.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-struct sg_table {
-	struct scatterlist *sgl;        /* the list */
-	unsigned int nents;             /* number of mapped entries */
-	unsigned int orig_nents;        /* original size of list */
-};
-
-#define sg_alloc_fn LINUX_BACKPORT(sg_alloc_fn)
-typedef struct scatterlist *(sg_alloc_fn)(unsigned int, gfp_t);
-
-#define sg_free_fn LINUX_BACKPORT(sg_free_fn)
-typedef void (sg_free_fn)(struct scatterlist *, unsigned int);
-
-#define __sg_free_table LINUX_BACKPORT(__sg_free_table)
-void __sg_free_table(struct sg_table *table, unsigned int max_ents,
-		     sg_free_fn *free_fn);
-#define sg_free_table LINUX_BACKPORT(sg_free_table)
-void sg_free_table(struct sg_table *);
-#define __sg_alloc_table LINUX_BACKPORT(__sg_alloc_table)
-int __sg_alloc_table(struct sg_table *table, unsigned int nents,
-		     unsigned int max_ents, gfp_t gfp_mask,
-		     sg_alloc_fn *alloc_fn);
-#define sg_alloc_table LINUX_BACKPORT(sg_alloc_table)
-int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask);
-
-#define SG_MAX_SINGLE_ALLOC            (PAGE_SIZE / sizeof(struct scatterlist))
-#endif
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
 /* backports efc42bc9 */
 #define sg_alloc_table_from_pages LINUX_BACKPORT(sg_alloc_table_from_pages)
diff --git a/backport/backport-include/linux/semaphore.h b/backport/backport-include/linux/semaphore.h
deleted file mode 100644
index 78af4db..0000000
--- a/backport/backport-include/linux/semaphore.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _COMPAT_LINUX_SEMAPHORE_H
-#define _COMPAT_LINUX_SEMAPHORE_H 1
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
-#include_next <linux/semaphore.h>
-#else
-#include <asm/semaphore.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
-
-#endif	/* _COMPAT_LINUX_SEMAPHORE_H */
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index 0aadc80..cd46e07 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -3,17 +3,7 @@
 #include_next <linux/types.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_ARM)
-
-#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PHYS_64BIT)
-typedef u64 phys_addr_t;
-#else
-typedef u32 phys_addr_t;
-#endif
-
-#endif /* x86 || ARM */
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28) /* < 2.6.25 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
 
 #if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_PPC)
 /*
diff --git a/backport/backport-include/linux/vmalloc.h b/backport/backport-include/linux/vmalloc.h
index 9e8ff3b..c47536f 100644
--- a/backport/backport-include/linux/vmalloc.h
+++ b/backport/backport-include/linux/vmalloc.h
@@ -3,12 +3,6 @@
 #include_next <linux/vmalloc.h>
 #include <linux/version.h>
 
-/* avoid warnings due to b3bdda02aa547a0753b4fdbc105e86ef9046b30b */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-#define vfree(ptr) vfree((void *)(ptr))
-#define vunmap(ptr) vunmap((void *)(ptr))
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
 #define vzalloc LINUX_BACKPORT(vzalloc)
 extern void *vzalloc(unsigned long size);
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 80c0294..b73f73d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -13,7 +13,6 @@ obj-$(CPTCFG_BACKPORT_BUILD_CORDIC) += cordic.o
 obj-$(CPTCFG_BACKPORT_BUILD_CRC8) += crc8.o
 
 # Compat kernel compatibility code
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_25) += compat-2.6.25.o pm_qos_params.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_27) += compat-2.6.27.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_28) += compat-2.6.28.o
diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
deleted file mode 100644
index 37407a4..0000000
--- a/backport/compat/compat-2.6.25.c
+++ /dev/null
@@ -1,307 +0,0 @@
-/*
- * Copyright 2007-2012	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.25.
- */
-
-#include <linux/miscdevice.h>
-#include <linux/pci.h>
-
-/*
- * The default behaviour of sg_alloc_table() is to use these kmalloc/kfree
- * helpers.
- */
-static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
-{
-	if (nents == SG_MAX_SINGLE_ALLOC) {
-		return (struct scatterlist *) __get_free_page(gfp_mask);
-	} else
-		return kmalloc(nents * sizeof(struct scatterlist), gfp_mask);
-}
-
-static void sg_kfree(struct scatterlist *sg, unsigned int nents)
-{
-	if (nents == SG_MAX_SINGLE_ALLOC)
-		free_page((unsigned long) sg);
-	else
-		kfree(sg);
-}
-
-
-/**
- * __sg_free_table - Free a previously mapped sg table
- * @table:	The sg table header to use
- * @max_ents:	The maximum number of entries per single scatterlist
- * @free_fn:	Free function
- *
- *  Description:
- *    Free an sg table previously allocated and setup with
- *    __sg_alloc_table().  The @max_ents value must be identical to
- *    that previously used with __sg_alloc_table().
- *
- **/
-void __sg_free_table(struct sg_table *table, unsigned int max_ents,
-		     sg_free_fn *free_fn)
-{
-	struct scatterlist *sgl, *next;
-
-	if (unlikely(!table->sgl))
-		return;
-
-	sgl = table->sgl;
-	while (table->orig_nents) {
-		unsigned int alloc_size = table->orig_nents;
-		unsigned int sg_size;
-
-		/*
-		 * If we have more than max_ents segments left,
-		 * then assign 'next' to the sg table after the current one.
-		 * sg_size is then one less than alloc size, since the last
-		 * element is the chain pointer.
-		 */
-		if (alloc_size > max_ents) {
-			next = sg_chain_ptr(&sgl[max_ents - 1]);
-			alloc_size = max_ents;
-			sg_size = alloc_size - 1;
-		} else {
-			sg_size = alloc_size;
-			next = NULL;
-		}
-
-		table->orig_nents -= sg_size;
-		free_fn(sgl, alloc_size);
-		sgl = next;
-	}
-
-	table->sgl = NULL;
-}
-EXPORT_SYMBOL_GPL(__sg_free_table);
-
-/**
- * sg_free_table - Free a previously allocated sg table
- * @table:	The mapped sg table header
- *
- **/
-void sg_free_table(struct sg_table *table)
-{
-	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, sg_kfree);
-}
-EXPORT_SYMBOL_GPL(sg_free_table);
-
-/**
- * __sg_alloc_table - Allocate and initialize an sg table with given allocator
- * @table:	The sg table header to use
- * @nents:	Number of entries in sg list
- * @max_ents:	The maximum number of entries the allocator returns per call
- * @gfp_mask:	GFP allocation mask
- * @alloc_fn:	Allocator to use
- *
- * Description:
- *   This function returns a @table @nents long. The allocator is
- *   defined to return scatterlist chunks of maximum size @max_ents.
- *   Thus if @nents is bigger than @max_ents, the scatterlists will be
- *   chained in units of @max_ents.
- *
- * Notes:
- *   If this function returns non-0 (eg failure), the caller must call
- *   __sg_free_table() to cleanup any leftover allocations.
- *
- **/
-int __sg_alloc_table(struct sg_table *table, unsigned int nents,
-		     unsigned int max_ents, gfp_t gfp_mask,
-		     sg_alloc_fn *alloc_fn)
-{
-	struct scatterlist *sg, *prv;
-	unsigned int left;
-
-#ifndef ARCH_HAS_SG_CHAIN
-	if (WARN_ON_ONCE(nents > max_ents))
-		return -EINVAL;
-#endif
-
-	memset(table, 0, sizeof(*table));
-
-	left = nents;
-	prv = NULL;
-	do {
-		unsigned int sg_size, alloc_size = left;
-
-		if (alloc_size > max_ents) {
-			alloc_size = max_ents;
-			sg_size = alloc_size - 1;
-		} else
-			sg_size = alloc_size;
-
-		left -= sg_size;
-
-		sg = alloc_fn(alloc_size, gfp_mask);
-		if (unlikely(!sg)) {
-			/*
-			 * Adjust entry count to reflect that the last
-			 * entry of the previous table won't be used for
-			 * linkage.  Without this, sg_kfree() may get
-			 * confused.
-			 */
-			if (prv)
-				table->nents = ++table->orig_nents;
-
- 			return -ENOMEM;
-		}
-
-		sg_init_table(sg, alloc_size);
-		table->nents = table->orig_nents += sg_size;
-
-		/*
-		 * If this is the first mapping, assign the sg table header.
-		 * If this is not the first mapping, chain previous part.
-		 */
-		if (prv)
-			sg_chain(prv, max_ents, sg);
-		else
-			table->sgl = sg;
-
-		/*
-		 * If no more entries after this one, mark the end
-		 */
-		if (!left)
-			sg_mark_end(&sg[sg_size - 1]);
-
-		prv = sg;
-	} while (left);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__sg_alloc_table);
-
-/**
- * sg_alloc_table - Allocate and initialize an sg table
- * @table:	The sg table header to use
- * @nents:	Number of entries in sg list
- * @gfp_mask:	GFP allocation mask
- *
- *  Description:
- *    Allocate and initialize an sg table. If @nents@ is larger than
- *    SG_MAX_SINGLE_ALLOC a chained sg table will be setup.
- *
- **/
-int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
-{
-	int ret;
-
-	ret = __sg_alloc_table(table, nents, SG_MAX_SINGLE_ALLOC,
-			       gfp_mask, sg_kmalloc);
-	if (unlikely(ret))
-		__sg_free_table(table, SG_MAX_SINGLE_ALLOC, sg_kfree);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(sg_alloc_table);
-
-
-/*
- * To backport b718989d correctly pcibios_enable_device()
- * is required but we don't have access to it on modules
- * as its an architecture specific routine that is not
- * exported and as such only core kernel code has access
- * to it. We implement a sloppy work around for backporting
- * this.
- */
-#ifdef CONFIG_PCI
-int pci_enable_device_mem(struct pci_dev *dev)
-{
-	int bars = pci_select_bars(dev, IORESOURCE_MEM);
-
-	return pci_enable_device_bars(dev, bars);
-}
-EXPORT_SYMBOL_GPL(pci_enable_device_mem);
-#endif
-
-/**
- * The following things are out of ./lib/vsprintf.c
- * The new iwlwifi driver is using them.
- */
-
-/**
- * strict_strtoul - convert a string to an unsigned long strictly
- * @cp: The string to be converted
- * @base: The number base to use
- * @res: The converted result value
- *
- * strict_strtoul converts a string to an unsigned long only if the
- * string is really an unsigned long string, any string containing
- * any invalid char at the tail will be rejected and -EINVAL is returned,
- * only a newline char at the tail is acceptible because people generally
- * change a module parameter in the following way:
- *
- * 	echo 1024 > /sys/module/e1000/parameters/copybreak
- *
- * echo will append a newline to the tail.
- *
- * It returns 0 if conversion is successful and *res is set to the converted
- * value, otherwise it returns -EINVAL and *res is set to 0.
- *
- * simple_strtoul just ignores the successive invalid characters and
- * return the converted value of prefix part of the string.
- */
-int strict_strtoul(const char *cp, unsigned int base, unsigned long *res);
-
-/**
- * strict_strtol - convert a string to a long strictly
- * @cp: The string to be converted
- * @base: The number base to use
- * @res: The converted result value
- *
- * strict_strtol is similiar to strict_strtoul, but it allows the first
- * character of a string is '-'.
- *
- * It returns 0 if conversion is successful and *res is set to the converted
- * value, otherwise it returns -EINVAL and *res is set to 0.
- */
-int strict_strtol(const char *cp, unsigned int base, long *res);
-
-#define define_strict_strtoux(type, valtype)				\
-int strict_strtou##type(const char *cp, unsigned int base, valtype *res)\
-{									\
-	char *tail;							\
-	valtype val;							\
-	size_t len;							\
-									\
-	*res = 0;							\
-	len = strlen(cp);						\
-	if (len == 0)							\
-		return -EINVAL;						\
-									\
-	val = simple_strtou##type(cp, &tail, base);			\
-	if ((*tail == '\0') ||						\
-		((len == (size_t)(tail - cp) + 1) && (*tail == '\n'))) {\
-		*res = val;						\
-		return 0;						\
-	}								\
-									\
-	return -EINVAL;							\
-}									\
-
-#define define_strict_strtox(type, valtype)				\
-int strict_strto##type(const char *cp, unsigned int base, valtype *res)	\
-{									\
-	int ret;							\
-	if (*cp == '-') {						\
-		ret = strict_strtou##type(cp+1, base, res);		\
-		if (!ret)						\
-			*res = -(*res);					\
-	} else								\
-		ret = strict_strtou##type(cp, base, res);		\
-									\
-	return ret;							\
-}									\
-
-define_strict_strtoux(l, unsigned long)
-define_strict_strtox(l, long)
-
-EXPORT_SYMBOL_GPL(strict_strtoul);
-EXPORT_SYMBOL_GPL(strict_strtol);
-
diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
index c7c457f..72b1707 100644
--- a/backport/compat/compat-2.6.26.c
+++ b/backport/compat/compat-2.6.26.c
@@ -20,9 +20,6 @@
 const char hex_asc[] = "0123456789abcdef";
 EXPORT_SYMBOL_GPL(hex_asc);
 
-/* 2.6.24 does not have the struct kobject with a name */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
-
 /**
  * kobject_set_name_vargs - Set the name of an kobject
  * @kobj: struct kobject to set the name of
@@ -50,27 +47,6 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
 	kfree(old_name);
 	return 0;
 }
-#else
-static
-int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
-				  va_list vargs)
-{
-	struct device *dev;
-	unsigned int len;
-	va_list aq;
-
-	dev = container_of(kobj, struct device, kobj);
-
-	va_copy(aq, vargs);
-	len = vsnprintf(NULL, 0, fmt, aq);
-	va_end(aq);
-
-	len = len < BUS_ID_SIZE ? (len + 1) : BUS_ID_SIZE;
-
-	vsnprintf(dev->bus_id, len, fmt, vargs);
-	return 0;
-}
-#endif
 
 /**
  * dev_set_name - set a device name
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index ab5423c..078912a 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -259,11 +259,9 @@ void led_blink_set(struct led_classdev *led_cdev,
 	struct led_timer *led;
 	int current_brightness;
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
 	if (led_cdev->blink_set &&
 	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
 		return;
-#endif
 
 	led = led_get_timer(led_cdev);
 	if (!led) {
diff --git a/backport/compat/main.c b/backport/compat/main.c
index da64057..9a82f72 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -54,7 +54,6 @@ EXPORT_SYMBOL_GPL(backport_dependency_symbol);
 
 static int __init backport_init(void)
 {
-	backport_pm_qos_power_init();
 	backport_system_workqueue_create();
 	backport_init_mmc_pm_flags();
 	dma_buf_init();
@@ -76,7 +75,6 @@ subsys_initcall(backport_init);
 
 static void __exit backport_exit(void)
 {
-	backport_pm_qos_power_deinit();
 	backport_system_workqueue_destroy();
 
         return;
diff --git a/backport/compat/pm_qos_params.c b/backport/compat/pm_qos_params.c
deleted file mode 100644
index 1f000ab..0000000
--- a/backport/compat/pm_qos_params.c
+++ /dev/null
@@ -1,478 +0,0 @@
-#include <net/sock.h>
-#include <net/compat.h>
-
-/* This is the backport of pm-qos params for kernels <= 2.6.25 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25))
-
-/*
- * This module exposes the interface to kernel space for specifying
- * QoS dependencies.  It provides infrastructure for registration of:
- *
- * Dependents on a QoS value : register requirements
- * Watchers of QoS value : get notified when target QoS value changes
- *
- * This QoS design is best effort based.  Dependents register their QoS needs.
- * Watchers register to keep track of the current QoS needs of the system.
- *
- * There are 3 basic classes of QoS parameter: latency, timeout, throughput
- * each have defined units:
- * latency: usec
- * timeout: usec <-- currently not used.
- * throughput: kbs (kilo byte / sec)
- *
- * There are lists of pm_qos_objects each one wrapping requirements, notifiers
- *
- * User mode requirements on a QOS parameter register themselves to the
- * subsystem by opening the device node /dev/... and writing there request to
- * the node.  As long as the process holds a file handle open to the node the
- * client continues to be accounted for.  Upon file release the usermode
- * requirement is removed and a new qos target is computed.  This way when the
- * requirement that the application has is cleaned up when closes the file
- * pointer or exits the pm_qos_object will get an opportunity to clean up.
- *
- * Mark Gross <mgross@linux.intel.com>
- */
-
-#include <linux/pm_qos_params.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/fs.h>
-#include <linux/device.h>
-#include <linux/miscdevice.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-
-#include <linux/uaccess.h>
-
-/*
- * locking rule: all changes to requirements or notifiers lists
- * or pm_qos_object list and pm_qos_objects need to happen with pm_qos_lock
- * held, taken with _irqsave.  One lock to rule them all
- */
-struct requirement_list {
-	struct list_head list;
-	union {
-		s32 value;
-		s32 usec;
-		s32 kbps;
-	};
-	char *name;
-};
-
-static s32 max_compare(s32 v1, s32 v2);
-static s32 min_compare(s32 v1, s32 v2);
-
-struct pm_qos_object {
-	struct requirement_list requirements;
-	struct blocking_notifier_head *notifiers;
-	struct miscdevice pm_qos_power_miscdev;
-	char *name;
-	s32 default_value;
-	atomic_t target_value;
-	s32 (*comparitor)(s32, s32);
-};
-
-static struct pm_qos_object null_pm_qos;
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
-static struct pm_qos_object cpu_dma_pm_qos = {
-	.requirements = {LIST_HEAD_INIT(cpu_dma_pm_qos.requirements.list)},
-	.notifiers = &cpu_dma_lat_notifier,
-	.name = "cpu_dma_latency",
-	.default_value = 2000 * USEC_PER_SEC,
-	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
-	.comparitor = min_compare
-};
-
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
-static struct pm_qos_object network_lat_pm_qos = {
-	.requirements = {LIST_HEAD_INIT(network_lat_pm_qos.requirements.list)},
-	.notifiers = &network_lat_notifier,
-	.name = "network_latency",
-	.default_value = 2000 * USEC_PER_SEC,
-	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
-	.comparitor = min_compare
-};
-
-
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
-static struct pm_qos_object network_throughput_pm_qos = {
-	.requirements =
-		{LIST_HEAD_INIT(network_throughput_pm_qos.requirements.list)},
-	.notifiers = &network_throughput_notifier,
-	.name = "network_throughput",
-	.default_value = 0,
-	.target_value = ATOMIC_INIT(0),
-	.comparitor = max_compare
-};
-
-static BLOCKING_NOTIFIER_HEAD(system_bus_freq_notifier);
-static struct pm_qos_object system_bus_freq_pm_qos = {
-	.requirements =
-		{LIST_HEAD_INIT(system_bus_freq_pm_qos.requirements.list)},
-	.notifiers = &system_bus_freq_notifier,
-	.name = "system_bus_freq",
-	.default_value = 0,
-	.target_value = ATOMIC_INIT(0),
-	.comparitor = max_compare
-};
-
-
-static struct pm_qos_object *pm_qos_array[PM_QOS_NUM_CLASSES] = {
-	[PM_QOS_RESERVED] = &null_pm_qos,
-	[PM_QOS_CPU_DMA_LATENCY] = &cpu_dma_pm_qos,
-	[PM_QOS_NETWORK_LATENCY] = &network_lat_pm_qos,
-	[PM_QOS_NETWORK_THROUGHPUT] = &network_throughput_pm_qos,
-	[PM_QOS_SYSTEM_BUS_FREQ] = &system_bus_freq_pm_qos,
-};
-
-static DEFINE_SPINLOCK(pm_qos_lock);
-
-static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-		size_t count, loff_t *f_pos);
-static int pm_qos_power_open(struct inode *inode, struct file *filp);
-static int pm_qos_power_release(struct inode *inode, struct file *filp);
-
-static const struct file_operations pm_qos_power_fops = {
-	.write = pm_qos_power_write,
-	.open = pm_qos_power_open,
-	.release = pm_qos_power_release,
-};
-
-/* static helper functions */
-static s32 max_compare(s32 v1, s32 v2)
-{
-	return max(v1, v2);
-}
-
-static s32 min_compare(s32 v1, s32 v2)
-{
-	return min(v1, v2);
-}
-
-
-static void update_target(int target)
-{
-	s32 extreme_value;
-	struct requirement_list *node;
-	unsigned long flags;
-	int call_notifier = 0;
-
-	spin_lock_irqsave(&pm_qos_lock, flags);
-	extreme_value = pm_qos_array[target]->default_value;
-	list_for_each_entry(node,
-			&pm_qos_array[target]->requirements.list, list) {
-		extreme_value = pm_qos_array[target]->comparitor(
-				extreme_value, node->value);
-	}
-	if (atomic_read(&pm_qos_array[target]->target_value) != extreme_value) {
-		call_notifier = 1;
-		atomic_set(&pm_qos_array[target]->target_value, extreme_value);
-		pr_debug(KERN_ERR "new target for qos %d is %d\n", target,
-			atomic_read(&pm_qos_array[target]->target_value));
-	}
-	spin_unlock_irqrestore(&pm_qos_lock, flags);
-
-	if (call_notifier)
-		blocking_notifier_call_chain(pm_qos_array[target]->notifiers,
-			(unsigned long) extreme_value, NULL);
-}
-
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
-
-static int find_pm_qos_object_by_minor(int minor)
-{
-	int pm_qos_class;
-
-	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
-		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
-	}
-	return -1;
-}
-
-/**
- * pm_qos_requirement - returns current system wide qos expectation
- * @pm_qos_class: identification of which qos value is requested
- *
- * This function returns the current target value in an atomic manner.
- */
-int pm_qos_requirement(int pm_qos_class)
-{
-	return atomic_read(&pm_qos_array[pm_qos_class]->target_value);
-}
-EXPORT_SYMBOL_GPL(pm_qos_requirement);
-
-/**
- * pm_qos_add_requirement - inserts new qos request into the list
- * @pm_qos_class: identifies which list of qos request to us
- * @name: identifies the request
- * @value: defines the qos request
- *
- * This function inserts a new entry in the pm_qos_class list of requested qos
- * performance characteristics.  It recomputes the aggregate QoS expectations
- * for the pm_qos_class of parameters.
- */
-int pm_qos_add_requirement(int pm_qos_class, char *name, s32 value)
-{
-	struct requirement_list *dep;
-	unsigned long flags;
-
-	dep = kzalloc(sizeof(struct requirement_list), GFP_KERNEL);
-	if (dep) {
-		if (value == PM_QOS_DEFAULT_VALUE)
-			dep->value = pm_qos_array[pm_qos_class]->default_value;
-		else
-			dep->value = value;
-		dep->name = kstrdup(name, GFP_KERNEL);
-		if (!dep->name)
-			goto cleanup;
-
-		spin_lock_irqsave(&pm_qos_lock, flags);
-		list_add(&dep->list,
-			&pm_qos_array[pm_qos_class]->requirements.list);
-		spin_unlock_irqrestore(&pm_qos_lock, flags);
-		update_target(pm_qos_class);
-
-		return 0;
-	}
-
-cleanup:
-	kfree(dep);
-	return -ENOMEM;
-}
-EXPORT_SYMBOL_GPL(pm_qos_add_requirement);
-
-/**
- * pm_qos_update_requirement - modifies an existing qos request
- * @pm_qos_class: identifies which list of qos request to us
- * @name: identifies the request
- * @value: defines the qos request
- *
- * Updates an existing qos requirement for the pm_qos_class of parameters along
- * with updating the target pm_qos_class value.
- *
- * If the named request isn't in the list then no change is made.
- */
-int pm_qos_update_requirement(int pm_qos_class, char *name, s32 new_value)
-{
-	unsigned long flags;
-	struct requirement_list *node;
-	int pending_update = 0;
-
-	spin_lock_irqsave(&pm_qos_lock, flags);
-	list_for_each_entry(node,
-		&pm_qos_array[pm_qos_class]->requirements.list, list) {
-		if (strcmp(node->name, name) == 0) {
-			if (new_value == PM_QOS_DEFAULT_VALUE)
-				node->value =
-				pm_qos_array[pm_qos_class]->default_value;
-			else
-				node->value = new_value;
-			pending_update = 1;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&pm_qos_lock, flags);
-	if (pending_update)
-		update_target(pm_qos_class);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pm_qos_update_requirement);
-
-/**
- * pm_qos_remove_requirement - modifies an existing qos request
- * @pm_qos_class: identifies which list of qos request to us
- * @name: identifies the request
- *
- * Will remove named qos request from pm_qos_class list of parameters and
- * recompute the current target value for the pm_qos_class.
- */
-void pm_qos_remove_requirement(int pm_qos_class, char *name)
-{
-	unsigned long flags;
-	struct requirement_list *node;
-	int pending_update = 0;
-
-	spin_lock_irqsave(&pm_qos_lock, flags);
-	list_for_each_entry(node,
-		&pm_qos_array[pm_qos_class]->requirements.list, list) {
-		if (strcmp(node->name, name) == 0) {
-			kfree(node->name);
-			list_del(&node->list);
-			kfree(node);
-			pending_update = 1;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&pm_qos_lock, flags);
-	if (pending_update)
-		update_target(pm_qos_class);
-}
-EXPORT_SYMBOL_GPL(pm_qos_remove_requirement);
-
-/**
- * pm_qos_add_notifier - sets notification entry for changes to target value
- * @pm_qos_class: identifies which qos target changes should be notified.
- * @notifier: notifier block managed by caller.
- *
- * will register the notifier into a notification chain that gets called
- * upon changes to the pm_qos_class target value.
- */
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
-{
-	int retval;
-
-	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
-
-/**
- * pm_qos_remove_notifier - deletes notification entry from chain.
- * @pm_qos_class: identifies which qos target changes are notified.
- * @notifier: notifier block to be removed.
- *
- * will remove the notifier from the notification chain that gets called
- * upon changes to the pm_qos_class target value.
- */
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
-{
-	int retval;
-
-	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
-
-#define PID_NAME_LEN 32
-
-static int pm_qos_power_open(struct inode *inode, struct file *filp)
-{
-	int ret;
-	long pm_qos_class;
-	char name[PID_NAME_LEN];
-
-	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= 0) {
-		filp->private_data = (void *)pm_qos_class;
-		snprintf(name, PID_NAME_LEN, "process_%d", current->pid);
-		ret = pm_qos_add_requirement(pm_qos_class, name,
-					PM_QOS_DEFAULT_VALUE);
-		if (ret >= 0)
-			return 0;
-	}
-	return -EPERM;
-}
-
-static int pm_qos_power_release(struct inode *inode, struct file *filp)
-{
-	int pm_qos_class;
-	char name[PID_NAME_LEN];
-
-	pm_qos_class = (long)filp->private_data;
-	snprintf(name, PID_NAME_LEN, "process_%d", current->pid);
-	pm_qos_remove_requirement(pm_qos_class, name);
-
-	return 0;
-}
-
-static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-		size_t count, loff_t *f_pos)
-{
-	s32 value;
-	int pm_qos_class;
-	char name[PID_NAME_LEN];
-
-	pm_qos_class = (long)filp->private_data;
-	if (count != sizeof(s32))
-		return -EINVAL;
-	if (copy_from_user(&value, buf, sizeof(s32)))
-		return -EFAULT;
-	snprintf(name, PID_NAME_LEN, "process_%d", current->pid);
-	pm_qos_update_requirement(pm_qos_class, name, value);
-
-	return  sizeof(s32);
-}
-
-
-/*
- * This initializes pm-qos for older kernels.
- */
-int backport_pm_qos_power_init(void)
-{
-	int ret = 0;
-
-	ret = register_pm_qos_misc(&cpu_dma_pm_qos);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: cpu_dma_latency setup failed\n");
-		return ret;
-	}
-	ret = register_pm_qos_misc(&network_lat_pm_qos);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
-		return ret;
-	}
-	ret = register_pm_qos_misc(&network_throughput_pm_qos);
-	if (ret < 0) {
-		printk(KERN_ERR
-			"pm_qos_param: network_throughput setup failed\n");
-		return ret;
-	}
-	ret = register_pm_qos_misc(&system_bus_freq_pm_qos);
-	if (ret < 0)
-		printk(KERN_ERR
-			"pm_qos_param: system_bus_freq setup failed\n");
-
-	return ret;
-}
-
-int backport_pm_qos_power_deinit(void)
-{
-	int ret = 0;
-
-	ret = misc_deregister(&cpu_dma_pm_qos.pm_qos_power_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: cpu_dma_latency deinit failed\n");
-		return ret;
-	}
-
-	ret = misc_deregister(&network_lat_pm_qos.pm_qos_power_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: network_latency deinit failed\n");
-		return ret;
-	}
-
-	ret = misc_deregister(&network_throughput_pm_qos.pm_qos_power_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR
-			"pm_qos_param: network_throughput deinit failed\n");
-		return ret;
-	}
-
-	ret = misc_deregister(&system_bus_freq_pm_qos.pm_qos_power_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR
-			"pm_qos_param: system_bus_freq deinit failed\n");
-		return ret;
-	}
-
-	return ret;
-}
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25) */
diff --git a/backport/compat/sch_fq_codel_core.c b/backport/compat/sch_fq_codel_core.c
index f03df2a..6b87c71 100644
--- a/backport/compat/sch_fq_codel_core.c
+++ b/backport/compat/sch_fq_codel_core.c
@@ -393,11 +393,7 @@ static void fq_codel_destroy(struct Qdisc *sch)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 	tcf_destroy_chain(&q->filter_list);
-#else
-	tcf_destroy_chain(q->filter_list);
-#endif
 	fq_codel_free(q->backlogs);
 	fq_codel_free(q->flows);
 }
diff --git a/dependencies b/dependencies
index 79d4415..bd15b56 100644
--- a/dependencies
+++ b/dependencies
@@ -30,8 +30,6 @@ USB_NET_RNDIS_WLAN 2.6.29
 CARL9170 2.6.29
 
 WL1251_SPI 2.6.37
-WLCORE_SPI 2.6.25
-P54_SPI 2.6.25
 
 WL1251_SDIO 2.6.37
 WLCORE_SDIO 2.6.38
@@ -165,13 +163,6 @@ DVB_USB_PCTV452E DISABLE
 USB_GSPCA DISABLE
 VIDEO_MXB DISABLE
 
-# This requires proc_create(), and that doesn't exist before 2.6.24
-LIBIPW_DEBUG 2.6.25
-
-# blink_set is used unconditionally and we don't carry a patch, so
-# this option must depend on 2.6.25 which got blink_set()
-RT2X00_LIB_LEDS 2.6.25
-
 # struct gpio_chip only got the required members in 2.6.28
 BCMA_DRIVER_GPIO 2.6.28
 SSB_DRIVER_GPIO 2.6.28
diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index 036b482..5c75ec4 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -39,7 +39,6 @@ fi
 mkdir -p $KSRC_PREFIX/{usr/src,lib/modules}
 
 # List of currently supported kernels that will be downloaded
-KERNELS="$KERNELS ${KPATH}/v2.6.24/linux-headers-2.6.24-020624_2.6.24-020624_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.25/linux-headers-2.6.25-020625_2.6.25-020625_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.26/linux-headers-2.6.26-020626_2.6.26-020626_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.27/linux-headers-2.6.27-020627_2.6.27-020627_all.deb"
diff --git a/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlegacy_common.patch
deleted file mode 100644
index 74f7f7d..0000000
--- a/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlegacy_common.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/common.c
-+++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -540,6 +540,7 @@ il_led_brightness_set(struct led_classde
- 	il_led_cmd(il, on, 0);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
- static int
- il_led_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
- 		 unsigned long *delay_off)
-@@ -548,6 +549,7 @@ il_led_blink_set(struct led_classdev *le
- 
- 	return il_led_cmd(il, *delay_on, *delay_off);
- }
-+#endif
- 
- void
- il_leds_init(struct il_priv *il)
-@@ -561,7 +563,9 @@ il_leds_init(struct il_priv *il)
- 	il->led.name =
- 	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
- 	il->led.brightness_set = il_led_brightness_set;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
- 	il->led.blink_set = il_led_blink_set;
-+#endif
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	il->led.max_brightness = 1;
- #endif
diff --git a/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlwifi_dvm_led.patch b/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlwifi_dvm_led.patch
deleted file mode 100644
index bdde96a..0000000
--- a/patches/collateral-evolutions/network/39-remove_blink_set/drivers_net_wireless_iwlwifi_dvm_led.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/dvm/led.c
-+++ b/drivers/net/wireless/iwlwifi/dvm/led.c
-@@ -162,6 +162,7 @@ static void iwl_led_brightness_set(struc
- 	iwl_led_cmd(priv, on, 0);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
- static int iwl_led_blink_set(struct led_classdev *led_cdev,
- 			     unsigned long *delay_on,
- 			     unsigned long *delay_off)
-@@ -170,6 +171,7 @@ static int iwl_led_blink_set(struct led_
- 
- 	return iwl_led_cmd(priv, *delay_on, *delay_off);
- }
-+#endif
- 
- void iwl_leds_init(struct iwl_priv *priv)
- {
-@@ -186,7 +188,9 @@ void iwl_leds_init(struct iwl_priv *priv
- 	priv->led.name = kasprintf(GFP_KERNEL, "%s-led",
- 				   wiphy_name(priv->hw->wiphy));
- 	priv->led.brightness_set = iwl_led_brightness_set;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
- 	priv->led.blink_set = iwl_led_blink_set;
-+#endif
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	priv->led.max_brightness = 1;
- #endif
-- 
1.8.4.rc2

