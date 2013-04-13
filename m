Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44279 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXz4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:56 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 10/42] backports: dissolve compat-2.6.25.h
Date: Sun, 14 Apr 2013 01:53:30 +0200
Message-Id: <1365897243-31214-11-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015644_639110_41EC6C0B)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm-generic/bug.h        |   9 +
 backport/backport-include/backport/backport.h      |   1 -
 .../backport-include/linux/byteorder/generic.h     |  52 ++++
 backport/backport-include/linux/compat-2.6.25.h    | 314 ---------------------
 backport/backport-include/linux/compat-2.6.28.h    |  16 --
 backport/backport-include/linux/device.h           |   9 +
 backport/backport-include/linux/in.h               |  75 +++++
 backport/backport-include/linux/init.h             |  19 ++
 backport/backport-include/linux/input.h            |   9 +
 backport/backport-include/linux/kernel.h           |  17 ++
 backport/backport-include/linux/netdevice.h        |  13 +
 backport/backport-include/linux/pci.h              |   9 +
 backport/backport-include/linux/pm.h               |   9 +
 backport/backport-include/linux/pm_qos.h           |  45 +++
 backport/backport-include/linux/pm_qos_params.h    |   3 +-
 backport/backport-include/linux/scatterlist.h      |  28 ++
 backport/backport-include/linux/types.h            |  35 +++
 backport/compat/main.c                             |   1 +
 18 files changed, 331 insertions(+), 333 deletions(-)
 create mode 100644 backport/backport-include/asm-generic/bug.h
 create mode 100644 backport/backport-include/linux/byteorder/generic.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.25.h
 create mode 100644 backport/backport-include/linux/in.h
 create mode 100644 backport/backport-include/linux/init.h
 create mode 100644 backport/backport-include/linux/input.h
 create mode 100644 backport/backport-include/linux/kernel.h
 create mode 100644 backport/backport-include/linux/netdevice.h
 create mode 100644 backport/backport-include/linux/pm.h
 create mode 100644 backport/backport-include/linux/types.h

diff --git a/backport/backport-include/asm-generic/bug.h b/backport/backport-include/asm-generic/bug.h
new file mode 100644
index 0000000..86d683c
--- /dev/null
+++ b/backport/backport-include/asm-generic/bug.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_ASM_GENERIC_BUG_H
+#define __BACKPORT_ASM_GENERIC_BUG_H
+#include_next <asm-generic/bug.h>
+
+#ifndef __WARN
+#define __WARN(foo) dump_stack()
+#endif
+
+#endif /* __BACKPORT_ASM_GENERIC_BUG_H */
diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index a50e488..2c86774 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -56,7 +56,6 @@ void backport_dependency_symbol(void);
  * code introduced for *that* kernel revision.
  */
 
-#include <linux/compat-2.6.25.h>
 #include <linux/compat-2.6.26.h>
 #include <linux/compat-2.6.27.h>
 #include <linux/compat-2.6.28.h>
diff --git a/backport/backport-include/linux/byteorder/generic.h b/backport/backport-include/linux/byteorder/generic.h
new file mode 100644
index 0000000..005a92f
--- /dev/null
+++ b/backport/backport-include/linux/byteorder/generic.h
@@ -0,0 +1,52 @@
+#ifndef __BACKPORT_BYTEORDER_GENERIC_H
+#define __BACKPORT_BYTEORDER_GENERIC_H
+#include_next <linux/byteorder/generic.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+/* The patch:
+ * commit 8b5f6883683c91ad7e1af32b7ceeb604d68e2865
+ * Author: Marcin Slusarz <marcin.slusarz@gmail.com>
+ * Date:   Fri Feb 8 04:20:12 2008 -0800
+ *
+ *     byteorder: move le32_add_cpu & friends from OCFS2 to core
+ *
+ * moves le*_add_cpu and be*_add_cpu functions from OCFS2 to core
+ * header (1st) and converted some existing code to it. We port
+ * it here as later kernels will most likely use it.
+ */
+static inline void le16_add_cpu(__le16 *var, u16 val)
+{
+	*var = cpu_to_le16(le16_to_cpu(*var) + val);
+}
+
+static inline void le32_add_cpu(__le32 *var, u32 val)
+{
+	*var = cpu_to_le32(le32_to_cpu(*var) + val);
+}
+
+static inline void le64_add_cpu(__le64 *var, u64 val)
+{
+	*var = cpu_to_le64(le64_to_cpu(*var) + val);
+}
+
+static inline void be16_add_cpu(__be16 *var, u16 val)
+{
+	u16 v = be16_to_cpu(*var);
+	*var = cpu_to_be16(v + val);
+}
+
+static inline void be32_add_cpu(__be32 *var, u32 val)
+{
+	u32 v = be32_to_cpu(*var);
+	*var = cpu_to_be32(v + val);
+}
+
+static inline void be64_add_cpu(__be64 *var, u64 val)
+{
+	u64 v = be64_to_cpu(*var);
+	*var = cpu_to_be64(v + val);
+}
+#endif
+
+#endif /* __BACKPORT_BYTEORDER_GENERIC_H */
diff --git a/backport/backport-include/linux/compat-2.6.25.h b/backport/backport-include/linux/compat-2.6.25.h
deleted file mode 100644
index 9a2afdb..0000000
--- a/backport/backport-include/linux/compat-2.6.25.h
+++ /dev/null
@@ -1,314 +0,0 @@
-#ifndef LINUX_26_25_COMPAT_H
-#define LINUX_26_25_COMPAT_H
-
-#include <linux/version.h>
-
-/* Compat work for 2.6.24 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25))
-
-#include <linux/types.h>
-#include <linux/io.h>
-#include <linux/hw_random.h>
-#include <linux/leds.h>
-#include <linux/kernel.h>
-#include <linux/netdevice.h>
-#include <linux/pm.h>
-#include <asm-generic/bug.h>
-#include <linux/pm_qos_params.h>
-#include <linux/pci.h>
-#include <linux/in.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/scatterlist.h>
-
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
-/*
- * Maximum number of entries that will be allocated in one piece, if
- * a list larger than this is required then chaining will be utilized.
- */
-#define SG_MAX_SINGLE_ALLOC            (PAGE_SIZE / sizeof(struct scatterlist))
-
-
-/* Backports b718989da7 */
-#define pci_enable_device_mem LINUX_BACKPORT(pci_enable_device_mem)
-int __must_check pci_enable_device_mem(struct pci_dev *dev);
-
-/*
- * Backports 312b1485fb509c9bc32eda28ad29537896658cb8
- * Author: Sam Ravnborg <sam@ravnborg.org>
- * Date:   Mon Jan 28 20:21:15 2008 +0100
- * 
- * Introduce new section reference annotations tags: __ref, __refdata, __refconst
- */
-#define __ref		__init_refok
-#define __refdata	__initdata_refok
-
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
-
-/*
- * phys_addr_t was added as a generic arch typedef on 2.6.28,
- * that backport is dealt with in compat-2.6.28.h
- */
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
-
-#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PHYS_64BIT)
-typedef u64 phys_addr_t;
-#else
-typedef u32 phys_addr_t;
-#endif
-
-#endif /* x86 */
-
-/* The macro below uses a const upstream, this differs */
-
-/**
- * DEFINE_PCI_DEVICE_TABLE - macro used to describe a pci device table
- * @_table: device table name
- *
- * This macro is used to create a struct pci_device_id array (a device table)
- * in a generic manner.
- */
-#define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[] __devinitdata
-
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
-
-/*
- * 2.6.25 adds PM_EVENT_HIBERNATE as well here but
- * we don't have this on <= 2.6.23)
- */
-#ifndef PM_EVENT_SLEEP /* some distribution have mucked with their own headers to add this.. */
-#define PM_EVENT_SLEEP  (PM_EVENT_SUSPEND)
-#endif
-
-/* Although we don't care about wimax this is needed for rfkill input stuff */
-#define KEY_WIMAX		246
-
-/* Although pm_qos stuff is not implemented on <= 2.6.24 lets keep the define */
-#define PM_QOS_DEFAULT_VALUE -1
-
-#define __WARN(foo) dump_stack()
-
-#define dev_emerg(dev, format, arg...)          \
-	dev_printk(KERN_EMERG , dev , format , ## arg)
-#define dev_alert(dev, format, arg...)          \
-	dev_printk(KERN_ALERT , dev , format , ## arg)
-#define dev_crit(dev, format, arg...)           \
-	dev_printk(KERN_CRIT , dev , format , ## arg)
-
-#define __dev_addr_sync LINUX_BACKPORT(__dev_addr_sync)
-extern int		__dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
-#define __dev_addr_unsync LINUX_BACKPORT(__dev_addr_unsync)
-extern void		__dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
-
-#define seq_file_net &init_net;
-
-enum nf_inet_hooks {
-	NF_INET_PRE_ROUTING = 0,
-	NF_INET_LOCAL_IN = 1,
-	NF_INET_FORWARD = 2,
-	NF_INET_LOCAL_OUT = 3,
-	NF_INET_POST_ROUTING = 4,
-	NF_INET_NUMHOOKS = 5
-};
-
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
-
-/* 2.6.25 changes hwrng_unregister()'s behaviour by supporting
- * suspend of its parent device (the misc device, which is itself the
- * hardware random number generator). It does this by passing a parameter to
- * unregister_miscdev() which is not supported in older kernels. The suspend
- * parameter allows us to enable access to the device's hardware
- * number generator during suspend. As far as wireless is concerned this means
- * if a driver goes to suspend it you won't have the HNR available in
- * older kernels. */
-static inline void __hwrng_unregister(struct hwrng *rng, bool suspended)
-{
-	hwrng_unregister(rng);
-}
-
-static inline void led_classdev_unregister_suspended(struct led_classdev *lcd)
-{
-	led_classdev_unregister(lcd);
-}
-
-/**
- * The following things are out of ./include/linux/kernel.h
- * The new iwlwifi driver is using them.
- */
-#define strict_strtoul LINUX_BACKPORT(strict_strtoul)
-extern int strict_strtoul(const char *, unsigned int, unsigned long *);
-#define strict_strtol LINUX_BACKPORT(strict_strtol)
-extern int strict_strtol(const char *, unsigned int, long *);
-
-#else
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
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)) */
-
-#endif /* LINUX_26_25_COMPAT_H */
diff --git a/backport/backport-include/linux/compat-2.6.28.h b/backport/backport-include/linux/compat-2.6.28.h
index 3b5f3ea..611065b 100644
--- a/backport/backport-include/linux/compat-2.6.28.h
+++ b/backport/backport-include/linux/compat-2.6.28.h
@@ -44,22 +44,6 @@ extern struct platform_device *platform_device_register_data(struct device *,
 
 typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } compat_cpumask_t;
 
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_PPC)
-/*
- * CONFIG_PHYS_ADDR_T_64BIT was added as new to all architectures
- * as of 2.6.28 but x86 and ppc had it already. x86 only got phys_addr_t
- * as of 2.6.25 but then is backported in compat-2.6.25.h
- */
-#else
-#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defned(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
-#define CONFIG_PHYS_ADDR_T_64BIT 1
-typedef u64 phys_addr_t;
-#else
-typedef u32 phys_addr_t;
-#endif
-
-#endif /* non x86 and ppc */
-
 #ifndef WARN_ONCE
 #define WARN_ONCE(condition, format...) ({                      \
 	static int __warned;                                    \
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index e10360b..2851dae 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -5,6 +5,15 @@
 
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+#define dev_emerg(dev, format, arg...)          \
+	dev_printk(KERN_EMERG , dev , format , ## arg)
+#define dev_alert(dev, format, arg...)          \
+	dev_printk(KERN_ALERT , dev , format , ## arg)
+#define dev_crit(dev, format, arg...)           \
+	dev_printk(KERN_CRIT , dev , format , ## arg)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
diff --git a/backport/backport-include/linux/in.h b/backport/backport-include/linux/in.h
new file mode 100644
index 0000000..5cca155
--- /dev/null
+++ b/backport/backport-include/linux/in.h
@@ -0,0 +1,75 @@
+#ifndef __BACKPORT_IN_H
+#define __BACKPORT_IN_H
+#include_next <linux/in.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+/*
+ * backports 2658fa803111dae1353602e7f586de8e537803e2
+ */
+
+static inline bool ipv4_is_loopback(__be32 addr)
+{
+	return (addr & htonl(0xff000000)) == htonl(0x7f000000);
+}
+
+static inline bool ipv4_is_multicast(__be32 addr)
+{
+	return (addr & htonl(0xf0000000)) == htonl(0xe0000000);
+}
+
+static inline bool ipv4_is_local_multicast(__be32 addr)
+{
+	return (addr & htonl(0xffffff00)) == htonl(0xe0000000);
+}
+
+static inline bool ipv4_is_lbcast(__be32 addr)
+{
+	/* limited broadcast */
+	return addr == htonl(INADDR_BROADCAST);
+}
+
+static inline bool ipv4_is_zeronet(__be32 addr)
+{
+	return (addr & htonl(0xff000000)) == htonl(0x00000000);
+}
+
+/* Special-Use IPv4 Addresses (RFC3330) */
+
+static inline bool ipv4_is_private_10(__be32 addr)
+{
+	return (addr & htonl(0xff000000)) == htonl(0x0a000000);
+}
+
+static inline bool ipv4_is_private_172(__be32 addr)
+{
+	return (addr & htonl(0xfff00000)) == htonl(0xac100000);
+}
+
+static inline bool ipv4_is_private_192(__be32 addr)
+{
+	return (addr & htonl(0xffff0000)) == htonl(0xc0a80000);
+}
+
+static inline bool ipv4_is_linklocal_169(__be32 addr)
+{
+	return (addr & htonl(0xffff0000)) == htonl(0xa9fe0000);
+}
+
+static inline bool ipv4_is_anycast_6to4(__be32 addr)
+{
+	return (addr & htonl(0xffffff00)) == htonl(0xc0586300);
+}
+
+static inline bool ipv4_is_test_192(__be32 addr)
+{
+	return (addr & htonl(0xffffff00)) == htonl(0xc0000200);
+}
+
+static inline bool ipv4_is_test_198(__be32 addr)
+{
+	return (addr & htonl(0xfffe0000)) == htonl(0xc6120000);
+}
+#endif
+
+#endif /* __BACKPORT_IN_H */
diff --git a/backport/backport-include/linux/init.h b/backport/backport-include/linux/init.h
new file mode 100644
index 0000000..a835e33
--- /dev/null
+++ b/backport/backport-include/linux/init.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_INIT_H
+#define __BACKPORT_INIT_H
+#include_next <linux/init.h>
+
+/*
+ * Backports 312b1485fb509c9bc32eda28ad29537896658cb8
+ * Author: Sam Ravnborg <sam@ravnborg.org>
+ * Date:   Mon Jan 28 20:21:15 2008 +0100
+ * 
+ * Introduce new section reference annotations tags: __ref, __refdata, __refconst
+ */
+#ifndef __ref
+#define __ref		__init_refok
+#endif
+#ifndef __refdata
+#define __refdata	__initdata_refok
+#endif
+
+#endif /* __BACKPORT_INIT_H */
diff --git a/backport/backport-include/linux/input.h b/backport/backport-include/linux/input.h
new file mode 100644
index 0000000..588b4f6
--- /dev/null
+++ b/backport/backport-include/linux/input.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_INPUT_H
+#define __BACKPORT_INPUT_H
+#include_next <linux/input.h>
+
+#ifndef KEY_WIMAX
+#define KEY_WIMAX		246
+#endif
+
+#endif /* __BACKPORT_INPUT_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
new file mode 100644
index 0000000..499f538
--- /dev/null
+++ b/backport/backport-include/linux/kernel.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_KERNEL_H
+#define __BACKPORT_KERNEL_H
+#include_next <linux/kernel.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25))
+/**
+ * The following things are out of ./include/linux/kernel.h
+ * The new iwlwifi driver is using them.
+ */
+#define strict_strtoul LINUX_BACKPORT(strict_strtoul)
+extern int strict_strtoul(const char *, unsigned int, unsigned long *);
+#define strict_strtol LINUX_BACKPORT(strict_strtol)
+extern int strict_strtol(const char *, unsigned int, long *);
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)) */
+
+#endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
new file mode 100644
index 0000000..0b83dc4
--- /dev/null
+++ b/backport/backport-include/linux/netdevice.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_NETDEVICE_H
+#define __BACKPORT_NETDEVICE_H
+#include_next <linux/netdevice.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+#define __dev_addr_sync LINUX_BACKPORT(__dev_addr_sync)
+extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
+#define __dev_addr_unsync LINUX_BACKPORT(__dev_addr_unsync)
+extern void __dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
+#endif
+
+#endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index d8410a4..3ddbc25 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -3,6 +3,15 @@
 #include_next <linux/pci.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+/* Backports b718989da7 */
+#define pci_enable_device_mem LINUX_BACKPORT(pci_enable_device_mem)
+int __must_check pci_enable_device_mem(struct pci_dev *dev);
+
+#define DEFINE_PCI_DEVICE_TABLE(_table) \
+	const struct pci_device_id _table[] __devinitdata
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 /*
  * DRM requires this, but we can't really backport it well
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
new file mode 100644
index 0000000..5040949
--- /dev/null
+++ b/backport/backport-include/linux/pm.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_PM_H
+#define __BACKPORT_PM_H
+#include_next <linux/pm.h>
+
+#ifndef PM_EVENT_SLEEP
+#define PM_EVENT_SLEEP  (PM_EVENT_SUSPEND)
+#endif
+
+#endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index c58c1c1..806a20f 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -3,10 +3,55 @@
 
 #include <linux/version.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
+/*
+ * Kernels >= 2.6.25 have pm-qos and its initialized as part of
+ * the bootup process
+ */
+static inline int backport_pm_qos_power_init(void)
+{
+	return 0;
+}
+
+static inline int backport_pm_qos_power_deinit(void)
+{
+	return 0;
+}
+#else
+/*
+ * Backport work for QoS dependencies (kernel/pm_qos_params.c)
+ * pm-qos stuff written by mark gross mgross@linux.intel.com.
+ *
+ * ipw2100 now makes use of:
+ *
+ * pm_qos_add_requirement(),
+ * pm_qos_update_requirement() and
+ * pm_qos_remove_requirement() from it
+ *
+ * mac80211 uses the network latency to determine if to enable or not
+ * dynamic PS. mac80211 also and registers a notifier for when
+ * the latency changes. Since older kernels do no thave pm-qos stuff
+ * we just implement it completley here and register it upon cfg80211
+ * init. I haven't tested ipw2100 on 2.6.24 though.
+ *
+ * This pm-qos implementation is copied verbatim from the kernel
+ * written by mark gross mgross@linux.intel.com. You don't have
+ * to do anythinig to use pm-qos except use the same exported
+ * routines as used in newer kernels. The backport_pm_qos_power_init()
+ * defned below is used by the compat module to initialize pm-qos.
+ */
+int backport_pm_qos_power_init(void);
+int backport_pm_qos_power_deinit(void);
+#endif
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include_next <linux/pm_qos.h>
 #else
 #include <linux/pm_qos_params.h>
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
+#ifndef PM_QOS_DEFAULT_VALUE
+#define PM_QOS_DEFAULT_VALUE -1
+#endif
+
 #endif	/* _COMPAT_LINUX_PM_QOS_H */
diff --git a/backport/backport-include/linux/pm_qos_params.h b/backport/backport-include/linux/pm_qos_params.h
index 4c8c89e..c591753 100644
--- a/backport/backport-include/linux/pm_qos_params.h
+++ b/backport/backport-include/linux/pm_qos_params.h
@@ -1,7 +1,6 @@
-#include <linux/version.h>
-
 #ifndef __COMPAT_LINUX_PM_QOS_PARAMS_H
 #define __COMPAT_LINUX_PM_QOS_PARAMS_H
+#include <linux/version.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
 #include_next <linux/pm_qos_params.h>
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index 66bce16..678b03c 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -3,6 +3,34 @@
 #include_next <linux/scatterlist.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+struct sg_table {
+	struct scatterlist *sgl;        /* the list */
+	unsigned int nents;             /* number of mapped entries */
+	unsigned int orig_nents;        /* original size of list */
+};
+
+#define sg_alloc_fn LINUX_BACKPORT(sg_alloc_fn)
+typedef struct scatterlist *(sg_alloc_fn)(unsigned int, gfp_t);
+
+#define sg_free_fn LINUX_BACKPORT(sg_free_fn)
+typedef void (sg_free_fn)(struct scatterlist *, unsigned int);
+
+#define __sg_free_table LINUX_BACKPORT(__sg_free_table)
+void __sg_free_table(struct sg_table *table, unsigned int max_ents,
+		     sg_free_fn *free_fn);
+#define sg_free_table LINUX_BACKPORT(sg_free_table)
+void sg_free_table(struct sg_table *);
+#define __sg_alloc_table LINUX_BACKPORT(__sg_alloc_table)
+int __sg_alloc_table(struct sg_table *table, unsigned int nents,
+		     unsigned int max_ents, gfp_t gfp_mask,
+		     sg_alloc_fn *alloc_fn);
+#define sg_alloc_table LINUX_BACKPORT(sg_alloc_table)
+int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask);
+
+#define SG_MAX_SINGLE_ALLOC            (PAGE_SIZE / sizeof(struct scatterlist))
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 
 /* Lets expect distributions might backport this */
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
new file mode 100644
index 0000000..b787df6
--- /dev/null
+++ b/backport/backport-include/linux/types.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_TYPES_H
+#define __BACKPORT_TYPES_H
+#include_next <linux/types.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+
+#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PHYS_64BIT)
+typedef u64 phys_addr_t;
+#else
+typedef u32 phys_addr_t;
+#endif
+
+#endif /* x86 */
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28) /* < 2.6.25 */
+
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_PPC)
+/*
+ * CONFIG_PHYS_ADDR_T_64BIT was added as new to all architectures
+ * as of 2.6.28 but x86 and ppc had it already.
+ */
+#else
+#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defned(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
+#define CONFIG_PHYS_ADDR_T_64BIT 1
+typedef u64 phys_addr_t;
+#else
+typedef u32 phys_addr_t;
+#endif
+
+#endif /* non x86 and ppc */
+
+#endif /* < 2.6.28 */
+
+#endif /* __BACKPORT_TYPES_H */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 7818d73..9607209 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/pm_qos.h>
 #include "compat-2.6.34.h"
 
 MODULE_AUTHOR("Luis R. Rodriguez");
-- 
1.8.0

