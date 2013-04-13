Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44241 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzW (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:22 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 26/42] backports: dissolve compat-2.6.34.h
Date: Sun, 14 Apr 2013 01:53:46 +0200
Message-Id: <1365897243-31214-27-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015523_801622_6E05C267)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.34.h | 347 ------------------------
 backport/backport-include/linux/device.h        |  29 ++
 backport/backport-include/linux/dma-mapping.h   |  32 +++
 backport/backport-include/linux/input.h         |   4 +
 backport/backport-include/linux/kernel.h        |   6 +
 backport/backport-include/linux/mmc/sdio_func.h |  20 ++
 backport/backport-include/linux/netdevice.h     | 149 ++++++++++
 backport/backport-include/linux/rcupdate.h      |  22 ++
 backport/backport-include/linux/rtnetlink.h     |  14 +
 backport/backport-include/linux/seq_file.h      |  10 +
 backport/backport-include/linux/sysfs.h         |  34 +++
 backport/backport-include/linux/usb.h           |  11 +
 backport/backport-include/net/sock.h            |   7 +
 backport/backport-include/pcmcia/device_id.h    |   7 +
 14 files changed, 345 insertions(+), 347 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.34.h
 create mode 100644 backport/backport-include/linux/sysfs.h

diff --git a/backport/backport-include/linux/compat-2.6.34.h b/backport/backport-include/linux/compat-2.6.34.h
deleted file mode 100644
index d444853..0000000
--- a/backport/backport-include/linux/compat-2.6.34.h
+++ /dev/null
@@ -1,347 +0,0 @@
-#ifndef LINUX_26_34_COMPAT_H
-#define LINUX_26_34_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34))
-
-#include <linux/netdevice.h>
-#include <linux/usb.h>
-#include <linux/mmc/sdio_func.h>
-#include <net/sock.h>
-
-/*
- * Backports da68c4eb25
- * sdio: introduce API for special power management features
- *
- * We wimply carry around the data structures and flags, and
- * make the host return no flags set by the driver.
- */
-typedef unsigned int mmc_pm_flag_t;
-
-#define MMC_PM_KEEP_POWER      (1 << 0)        /* preserve card power during suspend */
-#define MMC_PM_WAKE_SDIO_IRQ   (1 << 1)        /* wake up host system on SDIO IRQ assertion */
-
-extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
-extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
-
-#define netdev_mc_count(dev) ((dev)->mc_count)
-#define netdev_mc_empty(dev) (netdev_mc_count(dev) == 0)
-
-/* mask netdev_for_each_mc_addr as RHEL6 backports this */
-#if !defined(netdev_for_each_mc_addr)
-#define netdev_for_each_mc_addr(mclist, dev) \
-	for (mclist = dev->mc_list; mclist; mclist = mclist->next)
-#endif
-/* source: include/linux/netdevice.h */
-
-
-/* Logging, debugging and troubleshooting/diagnostic helpers. */
-
-/* netdev_printk helpers, similar to dev_printk */
-
-#ifndef netdev_name
-#define netdev_name(__dev) \
-	((__dev->reg_state != NETREG_REGISTERED) ? \
-		"(unregistered net_device)" : __dev->name)
-#endif
-
-#define netdev_printk(level, netdev, format, args...)		\
-	dev_printk(level, (netdev)->dev.parent,			\
-		   "%s: " format,				\
-		   netdev_name(netdev), ##args)
-
-#define netdev_emerg(dev, format, args...)			\
-	netdev_printk(KERN_EMERG, dev, format, ##args)
-#define netdev_alert(dev, format, args...)			\
-	netdev_printk(KERN_ALERT, dev, format, ##args)
-#define netdev_crit(dev, format, args...)			\
-	netdev_printk(KERN_CRIT, dev, format, ##args)
-#define netdev_err(dev, format, args...)			\
-	netdev_printk(KERN_ERR, dev, format, ##args)
-#define netdev_warn(dev, format, args...)			\
-	netdev_printk(KERN_WARNING, dev, format, ##args)
-#define netdev_notice(dev, format, args...)			\
-	netdev_printk(KERN_NOTICE, dev, format, ##args)
-#define netdev_info(dev, format, args...)			\
-	netdev_printk(KERN_INFO, dev, format, ##args)
-
-/* mask netdev_dbg as RHEL6 backports this */
-#if !defined(netdev_dbg)
-
-#if defined(DEBUG)
-#define netdev_dbg(__dev, format, args...)			\
-	netdev_printk(KERN_DEBUG, __dev, format, ##args)
-#elif defined(CONFIG_DYNAMIC_DEBUG)
-#define netdev_dbg(__dev, format, args...)			\
-do {								\
-	dynamic_dev_dbg((__dev)->dev.parent, "%s: " format,	\
-			netdev_name(__dev), ##args);		\
-} while (0)
-#else
-#define netdev_dbg(__dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, __dev, format, ##args); \
-	0;							\
-})
-#endif
-
-#endif
-
-/* mask netdev_vdbg as RHEL6 backports this */
-#if !defined(netdev_dbg)
-
-#if defined(VERBOSE_DEBUG)
-#define netdev_vdbg	netdev_dbg
-#else
-
-#define netdev_vdbg(dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, dev, format, ##args);	\
-	0;							\
-})
-#endif
-
-#endif
-
-/*
- * netdev_WARN() acts like dev_printk(), but with the key difference
- * of using a WARN/WARN_ON to get the message out, including the
- * file/line information and a backtrace.
- */
-#define netdev_WARN(dev, format, args...)			\
-	WARN(1, "netdevice: %s\n" format, netdev_name(dev), ##args);
-
-/* netif printk helpers, similar to netdev_printk */
-
-#define netif_printk(priv, type, level, dev, fmt, args...)	\
-do {					  			\
-	if (netif_msg_##type(priv))				\
-		netdev_printk(level, (dev), fmt, ##args);	\
-} while (0)
-
-#define netif_emerg(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_EMERG, dev, fmt, ##args)
-#define netif_alert(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_ALERT, dev, fmt, ##args)
-#define netif_crit(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_CRIT, dev, fmt, ##args)
-#define netif_err(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_ERR, dev, fmt, ##args)
-#define netif_warn(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_WARNING, dev, fmt, ##args)
-#define netif_notice(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_NOTICE, dev, fmt, ##args)
-#define netif_info(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_INFO, (dev), fmt, ##args)
-
-/* mask netif_dbg as RHEL6 backports this */
-#if !defined(netif_dbg)
-
-#if defined(DEBUG)
-#define netif_dbg(priv, type, dev, format, args...)		\
-	netif_printk(priv, type, KERN_DEBUG, dev, format, ##args)
-#elif defined(CONFIG_DYNAMIC_DEBUG)
-#define netif_dbg(priv, type, netdev, format, args...)		\
-do {								\
-	if (netif_msg_##type(priv))				\
-		dynamic_dev_dbg((netdev)->dev.parent,		\
-				"%s: " format,			\
-				netdev_name(netdev), ##args);	\
-} while (0)
-#else
-#define netif_dbg(priv, type, dev, format, args...)			\
-({									\
-	if (0)								\
-		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
-	0;								\
-})
-#endif
-
-#endif
-
-/* mask netif_vdbg as RHEL6 backports this */
-#if !defined(netif_vdbg)
-
-#if defined(VERBOSE_DEBUG)
-#define netif_vdbg	netdev_dbg
-#else
-#define netif_vdbg(priv, type, dev, format, args...)		\
-({								\
-	if (0)							\
-		netif_printk(KERN_DEBUG, dev, format, ##args);	\
-	0;							\
-})
-#endif
-#endif
-/* source: include/linux/netdevice.h */
-
-
-static inline void device_lock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-        mutex_lock(&dev->mutex);
-#else
-	down(&dev->sem);
-#endif
-}
-
-static inline int device_trylock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-	return mutex_trylock(&dev->mutex);
-#else
-	return down_trylock(&dev->sem);
-#endif
-}
-
-static inline void device_unlock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-        mutex_unlock(&dev->mutex);
-#else
-	up(&dev->sem);
-#endif
-}
-
-#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-#define PCMCIA_DEVICE_PROD_ID3(v3, vh3) { \
-	.match_flags = PCMCIA_DEV_ID_MATCH_PROD_ID3, \
-	.prod_id = { NULL, NULL, (v3), NULL },  \
-	.prod_id_hash = { 0, 0, (vh3), 0 }, }
-#endif
-
-#define rcu_dereference_check(p, c) rcu_dereference(p)
-
-/**
- *	sysfs_attr_init - initialize a dynamically allocated sysfs attribute
- *	@attr: struct attribute to initialize
- *
- *	Initialize a dynamically allocated struct attribute so we can
- *	make lockdep happy.  This is a new requirement for attributes
- *	and initially this is only needed when lockdep is enabled.
- *	Lockdep gives a nice error when your attribute is added to
- *	sysfs if you don't have this.
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define sysfs_attr_init(attr)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	(attr)->key = &__key;				\
-} while(0)
-#else
-#define sysfs_attr_init(attr) do {} while(0)
-#endif
-
-/* mask sysfs_bin_attr_init as RHEL6 backports this */
-#if !defined(sysfs_bin_attr_init)
-/**
- *	sysfs_bin_attr_init - initialize a dynamically allocated bin_attribute
- *	@attr: struct bin_attribute to initialize
- *
- *	Initialize a dynamically allocated struct bin_attribute so we
- *	can make lockdep happy.  This is a new requirement for
- *	attributes and initially this is only needed when lockdep is
- *	enabled.  Lockdep gives a nice error when your attribute is
- *	added to sysfs if you don't have this.
- */
-#define sysfs_bin_attr_init(bin_attr) sysfs_attr_init(&(bin_attr)->attr)
-#endif
-
-#define usb_alloc_coherent(dev, size, mem_flags, dma) usb_buffer_alloc(dev, size, mem_flags, dma)
-#define usb_free_coherent(dev, size, addr, dma) usb_buffer_free(dev, size, addr, dma)
-
-/* only include this if DEFINE_DMA_UNMAP_ADDR is not set as debian squeeze also backports this  */
-#ifndef DEFINE_DMA_UNMAP_ADDR
-#ifdef CONFIG_NEED_DMA_MAP_STATE
-#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME
-#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)          __u32 LEN_NAME
-#define dma_unmap_addr(PTR, ADDR_NAME)           ((PTR)->ADDR_NAME)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  (((PTR)->ADDR_NAME) = (VAL))
-#define dma_unmap_len(PTR, LEN_NAME)             ((PTR)->LEN_NAME)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    (((PTR)->LEN_NAME) = (VAL))
-#else
-#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
-#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
-#endif
-#endif
-
-/* mask dma_set_coherent_mask as debian squeeze also backports this */
-#define dma_set_coherent_mask(a, b) compat_dma_set_coherent_mask(a, b)
-
-static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (!dma_supported(dev, mask))
-		return -EIO;
-	dev->coherent_dma_mask = mask;
-	return 0;
-}
-
-/* USB autosuspend and autoresume */
-static inline int usb_enable_autosuspend(struct usb_device *udev)
-{ return 0; }
-static inline int usb_disable_autosuspend(struct usb_device *udev)
-{ return 0; }
-
-#if !defined(rcu_dereference_protected)
-#define rcu_dereference_protected(p, c) (p)
-#endif
-#define rcu_access_pointer(p)   ACCESS_ONCE(p)
-
-#define rcu_dereference_raw(p)	rcu_dereference(p)
-
-#define KEY_WPS_BUTTON		0x211	/* WiFi Protected Setup key */
-
-/*
- * This looks more complex than it should be. But we need to
- * get the type for the ~ right in round_down (it needs to be
- * as wide as the result!), and we want to evaluate the macro
- * arguments just once each.
- */
-#define __round_mask(x, y) ((__typeof__(x))((y)-1))
-#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-#define round_down(x, y) ((x) & ~__round_mask(x, y))
-
-static inline int rcu_read_lock_held(void)
-{
-	return 1;
-}
-
-#ifdef CONFIG_PROVE_LOCKING
-/*
- * Obviously, this is wrong.  But the base kernel will have rtnl_mutex
- * declared static, with no way to access it.  I think this is the best
- * we can do...
- */
-static inline int lockdep_rtnl_is_held(void)
-{
-        return 1;
-}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
-
-#define seq_hlist_start_head LINUX_BACKPORT(seq_hlist_start_head)
-extern struct hlist_node *seq_hlist_start_head(struct hlist_head *head,
-					       loff_t pos);
-
-#define seq_hlist_next LINUX_BACKPORT(seq_hlist_next)
-extern struct hlist_node *seq_hlist_next(void *v, struct hlist_head *head,
-					 loff_t *ppos);
-
-static inline struct sock *sk_entry(const struct hlist_node *node)
-{
-	return hlist_entry(node, struct sock, sk_node);
-}
-
-#else /* Kernels >= 2.6.34 */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)) */
-
-
-#endif /* LINUX_26_34_COMPAT_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index cb76099..0e45c1b 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -93,4 +93,33 @@ do {									\
 static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+static inline void device_lock(struct device *dev)
+{
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
+        mutex_lock(&dev->mutex);
+#else
+	down(&dev->sem);
+#endif
+}
+
+static inline int device_trylock(struct device *dev)
+{
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
+	return mutex_trylock(&dev->mutex);
+#else
+	return down_trylock(&dev->sem);
+#endif
+}
+
+static inline void device_unlock(struct device *dev)
+{
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
+        mutex_unlock(&dev->mutex);
+#else
+	up(&dev->sem);
+#endif
+}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index 091e505..540355a 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -14,4 +14,36 @@ static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+/* only include this if DEFINE_DMA_UNMAP_ADDR is not set as debian squeeze also backports this  */
+#ifndef DEFINE_DMA_UNMAP_ADDR
+#ifdef CONFIG_NEED_DMA_MAP_STATE
+#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME
+#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)          __u32 LEN_NAME
+#define dma_unmap_addr(PTR, ADDR_NAME)           ((PTR)->ADDR_NAME)
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  (((PTR)->ADDR_NAME) = (VAL))
+#define dma_unmap_len(PTR, LEN_NAME)             ((PTR)->LEN_NAME)
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    (((PTR)->LEN_NAME) = (VAL))
+#else
+#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
+#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
+#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             (0)
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#endif
+#endif
+
+/* mask dma_set_coherent_mask as debian squeeze also backports this */
+#define dma_set_coherent_mask LINUX_BACKPORT(dma_set_coherent_mask)
+
+static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (!dma_supported(dev, mask))
+		return -EIO;
+	dev->coherent_dma_mask = mask;
+	return 0;
+}
+#endif /* < 2.6.34 */
+
 #endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/input.h b/backport/backport-include/linux/input.h
index 588b4f6..0d58f9b 100644
--- a/backport/backport-include/linux/input.h
+++ b/backport/backport-include/linux/input.h
@@ -6,4 +6,8 @@
 #define KEY_WIMAX		246
 #endif
 
+#ifndef KEY_WPS_BUTTON
+#define KEY_WPS_BUTTON		0x211
+#endif
+
 #endif /* __BACKPORT_INPUT_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index dafcc33..f189f54 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -184,4 +184,10 @@ int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 int hex_to_bin(char ch);
 #endif
 
+#ifndef __round_mask
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index 9f720a2..62f89a5 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -7,4 +7,24 @@
 #define sdio_writeb_readb(func, write_byte, addr, err_ret) sdio_readb(func, addr, err_ret)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+/*
+ * Backports da68c4eb25
+ * sdio: introduce API for special power management features
+ *
+ * We simply carry around the data structures and flags, and
+ * make the host return no flags set by the driver.
+ *
+ * This is declared in mmc/pm.h upstream, but that files
+ * didn't exist before this commit and isn't included directly.
+ */
+typedef unsigned int mmc_pm_flag_t;
+
+#define MMC_PM_KEEP_POWER      (1 << 0)        /* preserve card power during suspend */
+#define MMC_PM_WAKE_SDIO_IRQ   (1 << 1)        /* wake up host system on SDIO IRQ assertion */
+
+extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
+extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
+#endif
+
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index cba926b..b18d9c7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -128,4 +128,153 @@ extern int netif_set_real_num_tx_queues(struct net_device *dev,
 					unsigned int txq);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#define netdev_mc_count(dev) ((dev)->mc_count)
+#define netdev_mc_empty(dev) (netdev_mc_count(dev) == 0)
+
+/* mask netdev_for_each_mc_addr as RHEL6 backports this */
+#ifndef netdev_for_each_mc_addr
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = dev->mc_list; mclist; mclist = mclist->next)
+#endif
+
+#ifndef netdev_name
+#define netdev_name(__dev) \
+	((__dev->reg_state != NETREG_REGISTERED) ? \
+		"(unregistered net_device)" : __dev->name)
+#endif
+
+#define netdev_printk(level, netdev, format, args...)		\
+	dev_printk(level, (netdev)->dev.parent,			\
+		   "%s: " format,				\
+		   netdev_name(netdev), ##args)
+
+#define netdev_emerg(dev, format, args...)			\
+	netdev_printk(KERN_EMERG, dev, format, ##args)
+#define netdev_alert(dev, format, args...)			\
+	netdev_printk(KERN_ALERT, dev, format, ##args)
+#define netdev_crit(dev, format, args...)			\
+	netdev_printk(KERN_CRIT, dev, format, ##args)
+#define netdev_err(dev, format, args...)			\
+	netdev_printk(KERN_ERR, dev, format, ##args)
+#define netdev_warn(dev, format, args...)			\
+	netdev_printk(KERN_WARNING, dev, format, ##args)
+#define netdev_notice(dev, format, args...)			\
+	netdev_printk(KERN_NOTICE, dev, format, ##args)
+#define netdev_info(dev, format, args...)			\
+	netdev_printk(KERN_INFO, dev, format, ##args)
+
+/* mask netdev_dbg as RHEL6 backports this */
+#if !defined(netdev_dbg)
+
+#if defined(DEBUG)
+#define netdev_dbg(__dev, format, args...)			\
+	netdev_printk(KERN_DEBUG, __dev, format, ##args)
+#elif defined(CONFIG_DYNAMIC_DEBUG)
+#define netdev_dbg(__dev, format, args...)			\
+do {								\
+	dynamic_dev_dbg((__dev)->dev.parent, "%s: " format,	\
+			netdev_name(__dev), ##args);		\
+} while (0)
+#else
+#define netdev_dbg(__dev, format, args...)			\
+({								\
+	if (0)							\
+		netdev_printk(KERN_DEBUG, __dev, format, ##args); \
+	0;							\
+})
+#endif
+
+#endif
+
+/* mask netdev_vdbg as RHEL6 backports this */
+#if !defined(netdev_dbg)
+
+#if defined(VERBOSE_DEBUG)
+#define netdev_vdbg	netdev_dbg
+#else
+
+#define netdev_vdbg(dev, format, args...)			\
+({								\
+	if (0)							\
+		netdev_printk(KERN_DEBUG, dev, format, ##args);	\
+	0;							\
+})
+#endif
+
+#endif
+
+/*
+ * netdev_WARN() acts like dev_printk(), but with the key difference
+ * of using a WARN/WARN_ON to get the message out, including the
+ * file/line information and a backtrace.
+ */
+#define netdev_WARN(dev, format, args...)			\
+	WARN(1, "netdevice: %s\n" format, netdev_name(dev), ##args);
+
+/* netif printk helpers, similar to netdev_printk */
+
+#define netif_printk(priv, type, level, dev, fmt, args...)	\
+do {					  			\
+	if (netif_msg_##type(priv))				\
+		netdev_printk(level, (dev), fmt, ##args);	\
+} while (0)
+
+#define netif_emerg(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_EMERG, dev, fmt, ##args)
+#define netif_alert(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_ALERT, dev, fmt, ##args)
+#define netif_crit(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_CRIT, dev, fmt, ##args)
+#define netif_err(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_ERR, dev, fmt, ##args)
+#define netif_warn(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_WARNING, dev, fmt, ##args)
+#define netif_notice(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_NOTICE, dev, fmt, ##args)
+#define netif_info(priv, type, dev, fmt, args...)		\
+	netif_printk(priv, type, KERN_INFO, (dev), fmt, ##args)
+
+/* mask netif_dbg as RHEL6 backports this */
+#if !defined(netif_dbg)
+
+#if defined(DEBUG)
+#define netif_dbg(priv, type, dev, format, args...)		\
+	netif_printk(priv, type, KERN_DEBUG, dev, format, ##args)
+#elif defined(CONFIG_DYNAMIC_DEBUG)
+#define netif_dbg(priv, type, netdev, format, args...)		\
+do {								\
+	if (netif_msg_##type(priv))				\
+		dynamic_dev_dbg((netdev)->dev.parent,		\
+				"%s: " format,			\
+				netdev_name(netdev), ##args);	\
+} while (0)
+#else
+#define netif_dbg(priv, type, dev, format, args...)			\
+({									\
+	if (0)								\
+		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
+	0;								\
+})
+#endif
+
+#endif
+
+/* mask netif_vdbg as RHEL6 backports this */
+#if !defined(netif_vdbg)
+
+#if defined(VERBOSE_DEBUG)
+#define netif_vdbg	netdev_dbg
+#else
+#define netif_vdbg(priv, type, dev, format, args...)		\
+({								\
+	if (0)							\
+		netif_printk(KERN_DEBUG, dev, format, ##args);	\
+	0;							\
+})
+#endif
+#endif
+
+#endif /* < 2.6.34 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index 5770b11..d6d9262 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -26,4 +26,26 @@
 		p = (typeof(*v) __force __rcu *)(v)
 #endif
 
+#ifndef rcu_dereference_check
+#define rcu_dereference_check(p, c) rcu_dereference(p)
+#endif
+
+#ifndef rcu_dereference_protected
+#define rcu_dereference_protected(p, c) (p)
+#endif
+#ifndef rcu_access_pointer
+#define rcu_access_pointer(p)   ACCESS_ONCE(p)
+#endif
+
+#ifndef rcu_dereference_raw
+#define rcu_dereference_raw(p)	rcu_dereference(p)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+static inline int rcu_read_lock_held(void)
+{
+	return 1;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index b765cc8..56ba9f6 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -7,4 +7,18 @@
         rcu_dereference_protected(p, lockdep_rtnl_is_held())
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#ifdef CONFIG_PROVE_LOCKING
+/*
+ * Obviously, this is wrong.  But the base kernel will have rtnl_mutex
+ * declared static, with no way to access it.  I think this is the best
+ * we can do...
+ */
+static inline int lockdep_rtnl_is_held(void)
+{
+        return 1;
+}
+#endif /* #ifdef CONFIG_PROVE_LOCKING */
+#endif /* < 2.6.34 */
+
 #endif /* __BACKPORT_LINUX_RTNETLINK_H */
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index c407161..17f7b3d 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -31,4 +31,14 @@ static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 #endif /* CONFIG_USER_NS */
 #endif /* < 3.7 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#define seq_hlist_start_head LINUX_BACKPORT(seq_hlist_start_head)
+extern struct hlist_node *seq_hlist_start_head(struct hlist_head *head,
+					       loff_t pos);
+
+#define seq_hlist_next LINUX_BACKPORT(seq_hlist_next)
+extern struct hlist_node *seq_hlist_next(void *v, struct hlist_head *head,
+					 loff_t *ppos);
+#endif
+
 #endif /* __BACKPORT_SEQ_FILE_H */
diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
new file mode 100644
index 0000000..a2ef73f
--- /dev/null
+++ b/backport/backport-include/linux/sysfs.h
@@ -0,0 +1,34 @@
+#ifndef __BACKPORT_LINUX_SYSFS_H
+#define __BACKPORT_LINUX_SYSFS_H
+#include_next <linux/sysfs.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define sysfs_attr_init(attr)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	(attr)->key = &__key;				\
+} while(0)
+#else
+#define sysfs_attr_init(attr) do {} while(0)
+#endif
+
+/* mask sysfs_bin_attr_init as RHEL6 backports this */
+#if !defined(sysfs_bin_attr_init)
+/**
+ *	sysfs_bin_attr_init - initialize a dynamically allocated bin_attribute
+ *	@attr: struct bin_attribute to initialize
+ *
+ *	Initialize a dynamically allocated struct bin_attribute so we
+ *	can make lockdep happy.  This is a new requirement for
+ *	attributes and initially this is only needed when lockdep is
+ *	enabled.  Lockdep gives a nice error when your attribute is
+ *	added to sysfs if you don't have this.
+ */
+#define sysfs_bin_attr_init(bin_attr) sysfs_attr_init(&(bin_attr)->attr)
+#endif
+#endif
+
+#endif /* __BACKPORT_LINUX_SYSFS_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 3e820f0..d67317f 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -63,4 +63,15 @@ usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#define usb_alloc_coherent(dev, size, mem_flags, dma) usb_buffer_alloc(dev, size, mem_flags, dma)
+#define usb_free_coherent(dev, size, addr, dma) usb_buffer_free(dev, size, addr, dma)
+
+/* USB autosuspend and autoresume */
+static inline int usb_enable_autosuspend(struct usb_device *udev)
+{ return 0; }
+static inline int usb_disable_autosuspend(struct usb_device *udev)
+{ return 0; }
+#endif
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 4e1141f..6943721 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -45,4 +45,11 @@ static inline wait_queue_head_t *sk_sleep(struct sock *sk)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+static inline struct sock *sk_entry(const struct hlist_node *node)
+{
+	return hlist_entry(node, struct sock, sk_node);
+}
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
diff --git a/backport/backport-include/pcmcia/device_id.h b/backport/backport-include/pcmcia/device_id.h
index 0c47a68..908af50 100644
--- a/backport/backport-include/pcmcia/device_id.h
+++ b/backport/backport-include/pcmcia/device_id.h
@@ -13,4 +13,11 @@
 	.prod_id_hash = { 0, 0, (vh3), 0 }, }
 #endif
 
+#ifndef PCMCIA_DEVICE_PROD_ID3
+#define PCMCIA_DEVICE_PROD_ID3(v3, vh3) { \
+	.match_flags = PCMCIA_DEV_ID_MATCH_PROD_ID3, \
+	.prod_id = { NULL, NULL, (v3), NULL },  \
+	.prod_id_hash = { 0, 0, (vh3), 0 }, }
+#endif
+
 #endif /* __BACKPORT_PCMCIA_DEVICE_ID_H */
-- 
1.8.0

