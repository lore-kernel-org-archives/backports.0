Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44253 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzc (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 16/42] backports: dissolve compat-3.4.h
Date: Sun, 14 Apr 2013 01:53:36 +0200
Message-Id: <1365897243-31214-17-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015640_213813_7E0C9827)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This also requires some changes around kconfig.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h   |   1 +
 backport/backport-include/linux/compat-2.6.28.h |   3 -
 backport/backport-include/linux/compat-3.4.h    | 225 ------------------------
 backport/backport-include/linux/compat.h        |  16 ++
 backport/backport-include/linux/etherdevice.h   |  32 ++++
 backport/backport-include/linux/fs.h            |   5 +
 backport/backport-include/linux/i2c-algo-bit.h  |  12 ++
 backport/backport-include/linux/kconfig.h       |  24 +++
 backport/backport-include/linux/mm.h            |  14 ++
 backport/backport-include/linux/pci.h           |  14 ++
 backport/backport-include/linux/poll.h          |  21 +++
 backport/backport-include/linux/regmap.h        |  40 +++++
 backport/backport-include/linux/skbuff.h        |  18 ++
 backport/backport-include/linux/slab.h          |  27 +++
 backport/backport-include/linux/wait.h          |  19 ++
 15 files changed, 243 insertions(+), 228 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.4.h
 create mode 100644 backport/backport-include/linux/compat.h
 create mode 100644 backport/backport-include/linux/i2c-algo-bit.h
 create mode 100644 backport/backport-include/linux/kconfig.h
 create mode 100644 backport/backport-include/linux/poll.h
 create mode 100644 backport/backport-include/linux/skbuff.h
 create mode 100644 backport/backport-include/linux/slab.h
 create mode 100644 backport/backport-include/linux/wait.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index 790fe48..7cf21aa 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_H
 #define __BACKPORT_H
 #include <backport/autoconf.h>
+#include <linux/kconfig.h>
 
 #ifndef __ASSEMBLY__
 #define LINUX_BACKPORT(__sym) backport_ ##__sym
diff --git a/backport/backport-include/linux/compat-2.6.28.h b/backport/backport-include/linux/compat-2.6.28.h
index 611065b..12b644f 100644
--- a/backport/backport-include/linux/compat-2.6.28.h
+++ b/backport/backport-include/linux/compat-2.6.28.h
@@ -260,9 +260,6 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 #define round_jiffies_up LINUX_BACKPORT(round_jiffies_up)
 unsigned long round_jiffies_up(unsigned long j);
 
-extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page,
-			    int off, int size);
-
 #define wake_up_interruptible_poll(x, m)			\
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
 
diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
deleted file mode 100644
index a152d51..0000000
--- a/backport/backport-include/linux/compat-3.4.h
+++ /dev/null
@@ -1,225 +0,0 @@
-#ifndef LINUX_3_4_COMPAT_H
-#define LINUX_3_4_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
-
-#include <linux/poll.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
-/* need to import it, but it only exists since kernel 3.1 */
-#include <linux/kconfig.h>
-#endif
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-#if defined(CONFIG_REGMAP)
-#include <linux/regmap.h>
-#define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				const struct regmap_config *config);
-#if defined(CONFIG_REGMAP_I2C)
-#define devm_regmap_init_i2c LINUX_BACKPORT(devm_regmap_init_i2c)
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config);
-#endif /* defined(CONFIG_REGMAP_I2C) */
-#if defined(CONFIG_REGMAP_SPI)
-#define devm_regmap_init_spi LINUX_BACKPORT(devm_regmap_init_spi)
-struct regmap *devm_regmap_init_spi(struct spi_device *dev,
-				    const struct regmap_config *config);
-#endif /* defined(CONFIG_REGMAP_SPI) */
-
-/*
- * We can't backport these unless we try to backport
- * the full regmap into core so warn if used.
- * No drivers are using this yet anyway.
- */
-#define regmap_raw_write_async LINUX_BACKPORT(regmap_raw_write_async)
-static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
-					 const void *val, size_t val_len)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-	return -EINVAL;
-}
-
-#define regmap_async_complete LINUX_BACKPORT(regmap_async_complete)
-static inline void regmap_async_complete(struct regmap *map)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-}
-
-#endif /* defined(CONFIG_REGMAP) */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
-
-/*
- * defined here to allow things to compile but technically
- * using this for memory regions will yield in a no-op on newer
- * kernels but on older kernels (v3.3 and older) this bit was used
- * for VM_ALWAYSDUMP. The goal was to remove this bit moving forward
- * and since we can't skip the core dump on old kernels we just make
- * this bit name now a no-op.
- *
- * For details see commits: 909af7 accb61fe cdaaa7003
- */
-#define VM_NODUMP      0x0
-
-/* This backports:
- *
- * commit 63b2001169e75cd71e917ec953fdab572e3f944a
- * Author: Thomas Gleixner <tglx@linutronix.de>
- * Date:   Thu Dec 1 00:04:00 2011 +0100
-
- * 	sched/wait: Add __wake_up_all_locked() API
- */
-#include <linux/wait.h>
-extern void compat_wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
-#define wake_up_all_locked(x)	compat_wake_up_locked((x), TASK_NORMAL, 0)
-
-/* This backports:
- *
- * commit a8203725dfded5c1f79dca3368a4a273e24b59bb
- * Author: Xi Wang <xi.wang@gmail.com>
- * Date:   Mon Mar 5 15:14:41 2012 -0800
- *
- * 	slab: introduce kmalloc_array()
- */
-
-/* SIZE_MAX is backported in compat-3.5.h so include it */
-#include <linux/compat-3.5.h>
-#define kmalloc_array LINUX_BACKPORT(kmalloc_array)
-static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
-{
-	if (size != 0 && n > SIZE_MAX / size)
-		return NULL;
-	return __kmalloc(n * size, flags);
-}
-
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-#define i2c_bit_algo LINUX_BACKPORT(i2c_bit_algo)
-extern const struct i2c_algorithm i2c_bit_algo;
-#endif
-
-#define simple_open LINUX_BACKPORT(simple_open)
-extern int simple_open(struct inode *inode, struct file *file);
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
-#else
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	skb_add_rx_frag(skb, i, page, off, size)
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
-#define COMPAT_USE_64BIT_TIME \
-	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
-#else
-#define COMPAT_USE_64BIT_TIME 0
-#endif
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12))
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-#error eth_hw_addr_random() needs to be implemented for < 2.6.12
-}
-#else  /* kernels >= 2.6.12 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	get_random_bytes(dev->dev_addr, ETH_ALEN);
-	dev->dev_addr[0] &= 0xfe;       /* clear multicast bit */
-	dev->dev_addr[0] |= 0x02;       /* set local assignment bit (IEEE802) */
-}
-#else /* kernels >= 2.6.31 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-/* So this is 2.6.31..2.6.35 */
-
-/* Just have the flags present, they won't really mean anything though */
-#define NET_ADDR_PERM          0       /* address is permanent (default) */
-#define NET_ADDR_RANDOM                1       /* address is generated randomly */
-#define NET_ADDR_STOLEN                2       /* address is stolen from other device */
-
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
-
-#else /* 2.6.36 and on */
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	dev_hw_addr_random(dev, dev->dev_addr);
-}
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)) */
-
-/* source include/linux/pci.h */
-/**
- * module_pci_driver() - Helper macro for registering a PCI driver
- * @__pci_driver: pci_driver struct
- *
- * Helper macro for PCI drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_pci_driver(__pci_driver) \
-	module_driver(__pci_driver, pci_register_driver, \
-		       pci_unregister_driver)
-
-/*
- * Getting something that works in C and CPP for an arg that may or may
- * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
- * we match on the placeholder define, insert the "0," for arg1 and generate
- * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
- * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
- * the last step cherry picks the 2nd arg, we get a zero.
- */
-#define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
-
-/* 3.1 - 3.3 had a broken version of this, so undef */
-#undef IS_ENABLED
-#define IS_ENABLED(option) \
-        (config_enabled(option) || config_enabled(option##_MODULE))
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31))
-/*
- * Return true if it is guaranteed that poll will not wait. This is the case
- * if the poll() of another file descriptor in the set got an event, so there
- * is no need for waiting.
- */
-#define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
-static inline bool poll_does_not_wait(const poll_table *p)
-{
-	return p == NULL || p->qproc == NULL;
-}
-
-/*
- * Return the set of events that the application wants to poll for.
- * This is useful for drivers that need to know whether a DMA transfer has
- * to be started implicitly on poll(). You typically only want to do that
- * if the application is actually polling for POLLIN and/or POLLOUT.
- */
-#define poll_requested_events LINUX_BACKPORT(poll_requested_events)
-static inline unsigned long poll_requested_events(const poll_table *p)
-{
-	return p ? p->key : ~0UL;
-}
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
-
-#endif /* LINUX_5_4_COMPAT_H */
diff --git a/backport/backport-include/linux/compat.h b/backport/backport-include/linux/compat.h
new file mode 100644
index 0000000..22db9b0
--- /dev/null
+++ b/backport/backport-include/linux/compat.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_COMPAT_H
+#define __BACKPORT_COMPAT_H
+
+#include_next <linux/compat.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#ifdef CONFIG_X86_X32_ABI
+#define COMPAT_USE_64BIT_TIME \
+	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
+#else
+#define COMPAT_USE_64BIT_TIME 0
+#endif
+#endif
+
+#endif /* __BACKPORT_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index aba5e67..bbabfbd 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -3,6 +3,38 @@
 #include_next <linux/etherdevice.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+#error eth_hw_addr_random() needs to be implemented for < 2.6.12
+}
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	get_random_bytes(dev->dev_addr, ETH_ALEN);
+	dev->dev_addr[0] &= 0xfe;       /* clear multicast bit */
+	dev->dev_addr[0] |= 0x02;       /* set local assignment bit (IEEE802) */
+}
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+/* So this is 2.6.31..2.6.35 */
+
+/* Just have the flags present, they won't really mean anything though */
+#define NET_ADDR_PERM		0	/* address is permanent (default) */
+#define NET_ADDR_RANDOM		1	/* address is generated randomly */
+#define NET_ADDR_STOLEN		2	/* address is stolen from other device */
+
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	random_ether_addr(dev->dev_addr);
+}
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	dev_hw_addr_random(dev, dev->dev_addr);
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 #include <linux/random.h>
 /**
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 746c7d1..b441236 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -8,6 +8,11 @@
  */
 #include <linux/uidgid.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#define simple_open LINUX_BACKPORT(simple_open)
+extern int simple_open(struct inode *inode, struct file *file);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 /**
  * backport of:
diff --git a/backport/backport-include/linux/i2c-algo-bit.h b/backport/backport-include/linux/i2c-algo-bit.h
new file mode 100644
index 0000000..643e0c7
--- /dev/null
+++ b/backport/backport-include/linux/i2c-algo-bit.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_I2C_ALGO_BIT_H
+#define __BACKPORT_LINUX_I2C_ALGO_BIT_H
+#include_next <linux/i2c-algo-bit.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
+#define i2c_bit_algo LINUX_BACKPORT(i2c_bit_algo)
+extern const struct i2c_algorithm i2c_bit_algo;
+#endif
+
+#endif /* __BACKPORT_LINUX_I2C_ALGO_BIT_H */
diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
new file mode 100644
index 0000000..d5c483d
--- /dev/null
+++ b/backport/backport-include/linux/kconfig.h
@@ -0,0 +1,24 @@
+#ifndef __BACKPORT_LINUX_KCONFIG_H
+#define __BACKPORT_LINUX_KCONFIG_H
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
+#include_next <linux/kconfig.h>
+#endif
+
+#ifndef __ARG_PLACEHOLDER_1
+#define __ARG_PLACEHOLDER_1 0,
+#define config_enabled(cfg) _config_enabled(cfg)
+#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
+#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
+#define ___config_enabled(__ignored, val, ...) val
+
+/*
+ * 3.1 - 3.3 had a broken version of this, so undef
+ * (they didn't have __ARG_PLACEHOLDER_1)
+ */
+#undef IS_ENABLED
+#define IS_ENABLED(option) \
+        (config_enabled(option) || config_enabled(option##_MODULE))
+#endif
+
+#endif
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index bfb771c..9ba1f00 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -2,6 +2,20 @@
 #define __BACKPORT_MM_H
 #include_next <linux/mm.h>
 
+#ifndef VM_NODUMP
+/*
+ * defined here to allow things to compile but technically
+ * using this for memory regions will yield in a no-op on newer
+ * kernels but on older kernels (v3.3 and older) this bit was used
+ * for VM_ALWAYSDUMP. The goal was to remove this bit moving forward
+ * and since we can't skip the core dump on old kernels we just make
+ * this bit name now a no-op.
+ *
+ * For details see commits: 909af7 accb61fe cdaaa7003
+ */
+#define VM_NODUMP      0x0
+#endif
+
 #ifndef VM_DONTDUMP
 #define VM_DONTDUMP    VM_NODUMP
 #endif
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 58f539f..eb985f1 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -12,6 +12,20 @@ int __must_check pci_enable_device_mem(struct pci_dev *dev);
 	const struct pci_device_id _table[] __devinitdata
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+/**
+ * module_pci_driver() - Helper macro for registering a PCI driver
+ * @__pci_driver: pci_driver struct
+ *
+ * Helper macro for PCI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pci_driver(__pci_driver) \
+	module_driver(__pci_driver, pci_register_driver, \
+		       pci_unregister_driver)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define pcie_capability_read_word LINUX_BACKPORT(pcie_capability_read_word)
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
diff --git a/backport/backport-include/linux/poll.h b/backport/backport-include/linux/poll.h
new file mode 100644
index 0000000..978b95c
--- /dev/null
+++ b/backport/backport-include/linux/poll.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_LINUX_POLL_H
+#define __BACKPORT_LINUX_POLL_H
+#include_next <linux/poll.h>
+#include <linux/version.h>
+
+#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && \
+     LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+#define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
+static inline bool poll_does_not_wait(const poll_table *p)
+{
+	return p == NULL || p->qproc == NULL;
+}
+
+#define poll_requested_events LINUX_BACKPORT(poll_requested_events)
+static inline unsigned long poll_requested_events(const poll_table *p)
+{
+	return p ? p->key : ~0UL;
+}
+#endif /* 2.6.31 <= version < 3.4 */
+
+#endif /* __BACKPORT_LINUX_POLL_H */
diff --git a/backport/backport-include/linux/regmap.h b/backport/backport-include/linux/regmap.h
index fff8e46..ac6a3f2 100644
--- a/backport/backport-include/linux/regmap.h
+++ b/backport/backport-include/linux/regmap.h
@@ -13,4 +13,44 @@ struct regmap *dev_get_regmap(struct device *dev, const char *name)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if defined(CONFIG_REGMAP)
+#define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
+struct regmap *devm_regmap_init(struct device *dev,
+				const struct regmap_bus *bus,
+				const struct regmap_config *config);
+#if defined(CONFIG_REGMAP_I2C)
+#define devm_regmap_init_i2c LINUX_BACKPORT(devm_regmap_init_i2c)
+struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
+				    const struct regmap_config *config);
+#endif /* defined(CONFIG_REGMAP_I2C) */
+#if defined(CONFIG_REGMAP_SPI)
+#define devm_regmap_init_spi LINUX_BACKPORT(devm_regmap_init_spi)
+struct regmap *devm_regmap_init_spi(struct spi_device *dev,
+				    const struct regmap_config *config);
+#endif /* defined(CONFIG_REGMAP_SPI) */
+
+/*
+ * We can't backport these unless we try to backport
+ * the full regmap into core so warn if used.
+ * No drivers are using this yet anyway.
+ */
+#define regmap_raw_write_async LINUX_BACKPORT(regmap_raw_write_async)
+static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
+					 const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+#define regmap_async_complete LINUX_BACKPORT(regmap_async_complete)
+static inline void regmap_async_complete(struct regmap *map)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+}
+
+#endif /* defined(CONFIG_REGMAP) */
+#endif /* 3.2 <= version < 3.4 */
+
 #endif /* __BACKPORT_LINUX_REGMAP_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
new file mode 100644
index 0000000..37c622c
--- /dev/null
+++ b/backport/backport-include/linux/skbuff.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_SKBUFF_H
+#define __BACKPORT_SKBUFF_H
+#include_next <linux/skbuff.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
+extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
+				    struct page *page,
+				    int off, int size);
+
+#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
+	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
+	skb_add_rx_frag(skb, i, page, off, size)
+#endif
+
+#endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/slab.h b/backport/backport-include/linux/slab.h
new file mode 100644
index 0000000..850020b
--- /dev/null
+++ b/backport/backport-include/linux/slab.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_SLAB_H
+#define __BACKPORT_SLAB_H
+#include_next <linux/slab.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+/* This backports:
+ *
+ * commit a8203725dfded5c1f79dca3368a4a273e24b59bb
+ * Author: Xi Wang <xi.wang@gmail.com>
+ * Date:   Mon Mar 5 15:14:41 2012 -0800
+ *
+ * 	slab: introduce kmalloc_array()
+ */
+
+#include <linux/kernel.h> /* for SIZE_MAX */
+
+#define kmalloc_array LINUX_BACKPORT(kmalloc_array)
+static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	if (size != 0 && n > SIZE_MAX / size)
+		return NULL;
+	return __kmalloc(n * size, flags);
+}
+#endif
+
+#endif /* __BACKPORT_SLAB_H */
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
new file mode 100644
index 0000000..9549984
--- /dev/null
+++ b/backport/backport-include/linux/wait.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_LINUX_WAIT_H
+#define __BACKPORT_LINUX_WAIT_H
+#include_next <linux/wait.h>
+
+/* This backports:
+ *
+ * commit 63b2001169e75cd71e917ec953fdab572e3f944a
+ * Author: Thomas Gleixner <tglx@linutronix.de>
+ * Date:   Thu Dec 1 00:04:00 2011 +0100
+ *
+ * 	sched/wait: Add __wake_up_all_locked() API
+ */
+
+#ifndef wake_up_all_locked
+extern void compat_wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
+#define wake_up_all_locked(x)	compat_wake_up_locked((x), TASK_NORMAL, 0)
+#endif
+
+#endif /* __BACKPORT_LINUX_WAIT_H */
-- 
1.8.0

