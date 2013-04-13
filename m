Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44288 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3DMX4E (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:56:04 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 18/42] backports: dissolve compat-3.2.h
Date: Sun, 14 Apr 2013 01:53:38 +0200
Message-Id: <1365897243-31214-19-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015644_090720_C08591B0)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Also get rid of __netdev_printk() as it's no longer
exported from the kernel and thus can't be used by
any drivers/other backported code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.2.h      | 111 ----------------------
 backport/backport-include/linux/dma-mapping.h     |  17 ++++
 backport/backport-include/linux/dynamic_debug.h   |  25 +++++
 backport/backport-include/linux/if_ether.h        |   4 +
 backport/backport-include/linux/kernel.h          |  20 ++++
 backport/backport-include/linux/mmc/sdio.h        |  14 +++
 backport/backport-include/linux/platform_device.h |   6 ++
 backport/backport-include/linux/pm.h              |   4 +
 backport/backport-include/linux/skbuff.h          |  28 ++++++
 backport/compat/Makefile                          |   1 -
 backport/compat/compat-2.6.26.c                   |   3 +
 backport/compat/compat-3.2.c                      |  34 -------
 12 files changed, 121 insertions(+), 146 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.2.h
 create mode 100644 backport/backport-include/linux/dma-mapping.h
 create mode 100644 backport/backport-include/linux/dynamic_debug.h
 create mode 100644 backport/backport-include/linux/mmc/sdio.h
 delete mode 100644 backport/compat/compat-3.2.c

diff --git a/backport/backport-include/linux/compat-3.2.h b/backport/backport-include/linux/compat-3.2.h
deleted file mode 100644
index 982b989..0000000
--- a/backport/backport-include/linux/compat-3.2.h
+++ /dev/null
@@ -1,111 +0,0 @@
-#ifndef LINUX_3_2_COMPAT_H
-#define LINUX_3_2_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0))
-
-#include <linux/skbuff.h>
-#include <linux/dma-mapping.h>
-#include <linux/printk.h>
-
-/* backports 07613b0b */
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)               \
-	static struct _ddebug __used __aligned(8)               \
-	__attribute__((section("__verbose"))) name = {          \
-		.modname = KBUILD_MODNAME,                      \
-		.function = __func__,                           \
-		.filename = __FILE__,                           \
-		.format = (fmt),                                \
-		.lineno = __LINE__,                             \
-		.flags =  _DPRINTK_FLAGS_DEFAULT,               \
-		.enabled = false,                               \
-	}
-#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
-
-/* backports b4625dab */
-#define  SDIO_CCCR_REV_3_00    3       /* CCCR/FBR Version 3.00 */
-#define  SDIO_SDIO_REV_3_00    4       /* SDIO Spec Version 3.00 */
-
-#define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
-
-/* mask skb_frag_page as RHEL6 backports this */
-#define skb_frag_page(a) compat_skb_frag_page(a)
-
-/**
- * skb_frag_page - retrieve the page refered to by a paged fragment
- * @frag: the paged fragment
- *
- * Returns the &struct page associated with @frag.
- */
-static inline struct page *skb_frag_page(const skb_frag_t *frag)
-{
-	return frag->page;
-}
-
-/* mask skb_frag_dma_map as RHEL6 backports this */
-#define skb_frag_dma_map(a,b,c,d,e) compat_skb_frag_dma_map(a,b,c,d,e)
-
-/**
- * skb_frag_dma_map - maps a paged fragment via the DMA API
- * @device: the device to map the fragment to
- * @frag: the paged fragment to map
- * @offset: the offset within the fragment (starting at the
- *          fragment's own offset)
- * @size: the number of bytes to map
- * @direction: the direction of the mapping (%PCI_DMA_*)
- *
- * Maps the page associated with @frag to @device.
- */
-static inline dma_addr_t skb_frag_dma_map(struct device *dev,
-					  const skb_frag_t *frag,
-					  size_t offset, size_t size,
-					  enum dma_data_direction dir)
-{
-	return dma_map_page(dev, skb_frag_page(frag),
-			    frag->page_offset + offset, size, dir);
-}
-
-#define ETH_P_TDLS	0x890D          /* TDLS */
-
-/* mask skb_frag_size as RHEL6 backports this */
-#define skb_frag_size(a) compat_skb_frag_size(a)
-
-static inline unsigned int skb_frag_size(const skb_frag_t *frag)
-{
-	return frag->size;
-}
-
-static inline char *hex_byte_pack(char *buf, u8 byte)
-{
-	*buf++ = hex_asc_hi(byte);
-	*buf++ = hex_asc_lo(byte);
-	return buf;
-}
-
-/* module_platform_driver() - Helper macro for drivers that don't do
- * anything special in module init/exit.  This eliminates a lot of
- * boilerplate.  Each module may only use this macro once, and
- * calling it replaces module_init() and module_exit()
- */
-#define module_platform_driver(__platform_driver) \
-        module_driver(__platform_driver, platform_driver_register, \
-                        platform_driver_unregister)
-
-static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flag)
-{
-	void *ret = dma_alloc_coherent(dev, size, dma_handle, flag);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-
-#define __netdev_printk LINUX_BACKPORT(__netdev_printk)
-extern int __netdev_printk(const char *level, const struct net_device *dev,
-			   struct va_format *vaf);
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)) */
-
-#endif /* LINUX_3_2_COMPAT_H */
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
new file mode 100644
index 0000000..091e505
--- /dev/null
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_DMA_MAPPING_H
+#define __BACKPORT_LINUX_DMA_MAPPING_H
+#include_next <linux/dma-mapping.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
+					dma_addr_t *dma_handle, gfp_t flag)
+{
+	void *ret = dma_alloc_coherent(dev, size, dma_handle, flag);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/dynamic_debug.h b/backport/backport-include/linux/dynamic_debug.h
new file mode 100644
index 0000000..00ab160
--- /dev/null
+++ b/backport/backport-include/linux/dynamic_debug.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_DYNAMIC_DEBUG_H
+#define __BACKPORT_LINUX_DYNAMIC_DEBUG_H
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+#include_next <linux/dynamic_debug.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+/* backports 07613b0b */
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)               \
+	static struct _ddebug __used __aligned(8)               \
+	__attribute__((section("__verbose"))) name = {          \
+		.modname = KBUILD_MODNAME,                      \
+		.function = __func__,                           \
+		.filename = __FILE__,                           \
+		.format = (fmt),                                \
+		.lineno = __LINE__,                             \
+		.flags =  _DPRINTK_FLAGS_DEFAULT,               \
+		.enabled = false,                               \
+	}
+#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
+#endif /* < 3.2 */
+
+#endif /* __BACKPORT_LINUX_DYNAMIC_DEBUG_H */
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index a3c6e45..e5f103e 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -14,4 +14,8 @@
 #define ETH_P_802_3_MIN 0x0600
 #endif
 
+#ifndef ETH_P_TDLS
+#define ETH_P_TDLS	0x890D          /* TDLS */
+#endif
+
 #endif /* __BACKPORT_IF_ETHER_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 01aaa91..67dca62 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -26,4 +26,24 @@ extern int strict_strtol(const char *, unsigned int, long *);
 #define SIZE_MAX    (~(size_t)0)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+extern const char hex_asc[];
+#endif
+
+#ifndef hex_asc_hi
+#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
+#endif
+#ifndef hex_asc_lo
+#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+static inline char *hex_byte_pack(char *buf, u8 byte)
+{
+	*buf++ = hex_asc_hi(byte);
+	*buf++ = hex_asc_lo(byte);
+	return buf;
+}
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/mmc/sdio.h b/backport/backport-include/linux/mmc/sdio.h
new file mode 100644
index 0000000..9bdbdc5
--- /dev/null
+++ b/backport/backport-include/linux/mmc/sdio.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_MMC_SDIO_H
+#define __BACKPORT_MMC_SDIO_H
+#include <linux/version.h>
+#include_next <linux/mmc/sdio.h>
+
+/* backports b4625dab */
+#ifndef SDIO_CCCR_REV_3_00
+#define  SDIO_CCCR_REV_3_00    3       /* CCCR/FBR Version 3.00 */
+#endif
+#ifndef SDIO_SDIO_REV_3_00
+#define  SDIO_SDIO_REV_3_00    4       /* SDIO Spec Version 3.00 */
+#endif
+
+#endif /* __BACKPORT_MMC_SDIO_H */
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index f0d6f89..d7a34a9 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -27,4 +27,10 @@ module_exit(__platform_driver##_exit);
 #define PLATFORM_DEVID_AUTO	(-1)
 #endif
 
+#ifndef module_platform_driver
+#define module_platform_driver(__platform_driver) \
+        module_driver(__platform_driver, platform_driver_register, \
+                        platform_driver_unregister)
+#endif
+
 #endif /* __BACKPORT_PLATFORM_DEVICE_H */
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 5040949..09ab926 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -6,4 +6,8 @@
 #define PM_EVENT_SLEEP  (PM_EVENT_SUSPEND)
 #endif
 
+#ifndef PMSG_IS_AUTO
+#define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
+#endif
+
 #endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index e8ff5ac..113d638 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -26,4 +26,32 @@ static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#include <linux/dma-mapping.h>
+
+/* mask skb_frag_page as RHEL6 backports this */
+#define skb_frag_page LINUX_BACKPORT(skb_frag_page)
+static inline struct page *skb_frag_page(const skb_frag_t *frag)
+{
+	return frag->page;
+}
+
+#define skb_frag_size LINUX_BACKPORT(skb_frag_size)
+static inline unsigned int skb_frag_size(const skb_frag_t *frag)
+{
+	return frag->size;
+}
+
+/* mask skb_frag_dma_map as RHEL6 backports this */
+#define skb_frag_dma_map LINUX_BACKPORT(skb_frag_dma_map)
+static inline dma_addr_t skb_frag_dma_map(struct device *dev,
+					  const skb_frag_t *frag,
+					  size_t offset, size_t size,
+					  enum dma_data_direction dir)
+{
+	return dma_map_page(dev, skb_frag_page(frag),
+			    frag->page_offset + offset, size, dir);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 8c62cbb..59584f1 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -28,7 +28,6 @@ compat-$(CPTCFG_BACKPORT_BUILD_AVERAGE) += average.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_39) += compat-2.6.39.o kstrtox.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_0) += compat-3.0.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_1) += compat-3.1.o
-compat-$(CPTCFG_BACKPORT_KERNEL_3_2) += compat-3.2.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_3) += compat-3.3.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_4) += compat-3.4.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_5) += compat-3.5.o user_namespace.o
diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
index 5193886..9063a6a 100644
--- a/backport/compat/compat-2.6.26.c
+++ b/backport/compat/compat-2.6.26.c
@@ -17,6 +17,9 @@
 #include <net/sock.h>
 #include <net/compat.h>
 
+const char hex_asc[] = "0123456789abcdef";
+EXPORT_SYMBOL(hex_asc);
+
 /* 2.6.24 does not have the struct kobject with a name */
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
 
diff --git a/backport/compat/compat-3.2.c b/backport/compat/compat-3.2.c
deleted file mode 100644
index 55ae6af..0000000
--- a/backport/compat/compat-3.2.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright 2012  Luis R. Rodriguez <mcgrof@frijolero.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 3.2.
- */
-
-#include <linux/kernel.h>
-#include <linux/device.h>
-
-int __netdev_printk(const char *level, const struct net_device *dev,
-			   struct va_format *vaf)
-{
-	int r;
-
-	if (dev && dev->dev.parent)
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35))
-		r = dev_printk(level, dev->dev.parent, "%s: %pV",
-			       netdev_name(dev), vaf);
-#else
-		/* XXX: this could likely be done better but I'm lazy */
-		r = printk("%s%s: %pV", level, netdev_name(dev), vaf);
-#endif
-	else if (dev)
-		r = printk("%s%s: %pV", level, netdev_name(dev), vaf);
-	else
-		r = printk("%s(NULL net_device): %pV", level, vaf);
-
-	return r;
-}
-EXPORT_SYMBOL_GPL(__netdev_printk);
-- 
1.8.0

