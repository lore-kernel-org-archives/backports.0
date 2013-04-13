Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44229 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMXzK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 13/42] backports: dissolve compat-3.6.h
Date: Sun, 14 Apr 2013 01:53:33 +0200
Message-Id: <1365897243-31214-14-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015513_606310_1DFAB63C)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../asm-generic/dma-mapping-common.h               |  25 ++++
 backport/backport-include/backport/backport.h      |   1 -
 backport/backport-include/linux/compat-3.6.h       | 139 ---------------------
 backport/backport-include/linux/etherdevice.h      |  28 +++++
 backport/backport-include/linux/i2c.h              |  15 +++
 backport/backport-include/linux/leds.h             |  29 +++++
 backport/backport-include/linux/pci_regs.h         |  34 +++++
 backport/backport-include/linux/scatterlist.h      |   9 ++
 backport/backport-include/linux/string.h           |  11 ++
 backport/backport-include/linux/usb.h              |  27 ++++
 backport/backport-include/net/genetlink.h          |   4 +
 11 files changed, 182 insertions(+), 140 deletions(-)
 create mode 100644 backport/backport-include/asm-generic/dma-mapping-common.h
 delete mode 100644 backport/backport-include/linux/compat-3.6.h
 create mode 100644 backport/backport-include/linux/i2c.h
 create mode 100644 backport/backport-include/linux/leds.h
 create mode 100644 backport/backport-include/linux/string.h
 create mode 100644 backport/backport-include/linux/usb.h

diff --git a/backport/backport-include/asm-generic/dma-mapping-common.h b/backport/backport-include/asm-generic/dma-mapping-common.h
new file mode 100644
index 0000000..ed2fe61
--- /dev/null
+++ b/backport/backport-include/asm-generic/dma-mapping-common.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_ASM_GENERIC_DMA_MAPPING_COMMON_H
+#define __BACKPORT_ASM_GENERIC_DMA_MAPPING_COMMON_H
+#include_next <asm-generic/dma-mapping-common.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+
+#define dma_common_get_sgtable LINUX_BACKPORT(dma_common_get_sgtable)
+int
+dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+
+#define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
+struct dma_attrs;
+static inline int
+dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
+		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
+}
+
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
+#endif
+
+#endif /* __BACKPORT_ASM_GENERIC_DMA_MAPPING_COMMON_H */
diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index e892279..c5c194e 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -76,7 +76,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.3.h>
 #include <linux/compat-3.4.h>
 #include <linux/compat-3.5.h>
-#include <linux/compat-3.6.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/backport/backport-include/linux/compat-3.6.h b/backport/backport-include/linux/compat-3.6.h
deleted file mode 100644
index 770a333..0000000
--- a/backport/backport-include/linux/compat-3.6.h
+++ /dev/null
@@ -1,139 +0,0 @@
-#ifndef LINUX_3_6_COMPAT_H
-#define LINUX_3_6_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
-
-#include <linux/scatterlist.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-#include <linux/i2c.h>
-#include <linux/dma-attrs.h>
-/* Unlocked flavor */
-#define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
-extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			  int num);
-#endif
-
-
-#define memweight LINUX_BACKPORT(memweight)
-extern size_t memweight(const void *ptr, size_t bytes);
-
-/* backports efc42bc9 */
-#define sg_alloc_table_from_pages LINUX_BACKPORT(sg_alloc_table_from_pages)
-int sg_alloc_table_from_pages(struct sg_table *sgt,
-			      struct page **pages, unsigned int n_pages,
-			      unsigned long offset, unsigned long size,
-			      gfp_t gfp_mask);
-
-#define dma_common_get_sgtable LINUX_BACKPORT(dma_common_get_sgtable)
-int
-dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
-
-#define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
-struct dma_attrs;
-static inline int
-dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
-{
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
-}
-
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
-
-
-/**
- * Backports
- *
- * commit d81a5d1956731c453b85c141458d4ff5d6cc5366
- * Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
- * Date:   Tue Jul 10 19:10:06 2012 -0300
- *
- * 	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
- */
-#include <linux/usb.h>
-#define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
-       .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
-               | USB_DEVICE_ID_MATCH_VENDOR, \
-       .idVendor = (vend), \
-       .bInterfaceClass = (cl), \
-       .bInterfaceSubClass = (sc), \
-       .bInterfaceProtocol = (pr)
-
-/**
- * Backports
- *
- * commit cdcac9cd7741af2c2b9255cbf060f772596907bb
- * Author: Dave Airlie <airlied@redhat.com>
- * Date:   Wed Jun 27 08:35:52 2012 +0100
- *
- * 	pci_regs: define LNKSTA2 pcie cap + bits.
- *
- * 	We need these for detecting the max link speed for drm drivers.
- *
- * 	Acked-by: Bjorn Helgaas <bhelgass@google.com>
- * 	Signed-off-by: Dave Airlie <airlied@redhat.com>
- */
-
-#define  PCI_EXP_LNKCAP2 		44	/* Link Capability 2 */
-#define  PCI_EXP_LNKCAP2_SLS_2_5GB 	0x01	/* Current Link Speed 2.5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB 	0x02	/* Current Link Speed 5.0GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB 	0x04	/* Current Link Speed 8.0GT/s */
-#define  PCI_EXP_LNKCAP2_CROSSLINK 	0x100 /* Crosslink supported */
-
-#include <net/genetlink.h>
-#include <linux/etherdevice.h>
-
-/**
- * eth_broadcast_addr - Assign broadcast address
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Assign the broadcast address to the given address array.
- */
-static inline void eth_broadcast_addr(u8 *addr)
-{
-	memset(addr, 0xff, ETH_ALEN);
-}
-
-/**
- * eth_random_addr - Generate software assigned random Ethernet address
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Generate a random Ethernet address (MAC) that is not multicast
- * and has the local assigned bit set.
- */
-static inline void eth_random_addr(u8 *addr)
-{
-	get_random_bytes(addr, ETH_ALEN);
-	addr[0] &= 0xfe;        /* clear multicast bit */
-	addr[0] |= 0x02;        /* set local assignment bit (IEEE802) */
-}
-
-#define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
-
-/*
- * Backports 
- * 
- * commit 959d62fa865d2e616b61a509e1cc5b88741f065e
- * Author: Shuah Khan <shuahkhan@gmail.com>
- * Date:   Thu Jun 14 04:34:30 2012 +0800
- *
- *   leds: Rename led_brightness_set() to led_set_brightness()
- *   
- *   Rename leds external interface led_brightness_set() to led_set_brightness().
- *   This is the second phase of the change to reduce confusion between the
- *   leds internal and external interfaces that set brightness. With this change,
- *   now the external interface is led_set_brightness(). The first phase renamed
- *   the internal interface led_set_brightness() to __led_set_brightness().
- *   There are no changes to the interface implementations.
- *   
- *   Signed-off-by: Shuah Khan <shuahkhan@gmail.com>
- *   Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
- */
-#define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)) */
-
-#endif /* LINUX_3_6_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 8cedf49..1246be4 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -3,6 +3,34 @@
 #include_next <linux/etherdevice.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#include <linux/random.h>
+/**
+ * eth_broadcast_addr - Assign broadcast address
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Assign the broadcast address to the given address array.
+ */
+static inline void eth_broadcast_addr(u8 *addr)
+{
+	memset(addr, 0xff, ETH_ALEN);
+}
+
+/**
+ * eth_random_addr - Generate software assigned random Ethernet address
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Generate a random Ethernet address (MAC) that is not multicast
+ * and has the local assigned bit set.
+ */
+static inline void eth_random_addr(u8 *addr)
+{
+	get_random_bytes(addr, ETH_ALEN);
+	addr[0] &= 0xfe;        /* clear multicast bit */
+	addr[0] |= 0x02;        /* set local assignment bit (IEEE802) */
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 
 /* This backports:
diff --git a/backport/backport-include/linux/i2c.h b/backport/backport-include/linux/i2c.h
new file mode 100644
index 0000000..5b87732
--- /dev/null
+++ b/backport/backport-include/linux/i2c.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_LINUX_I2C_H
+#define __BACKPORT_LINUX_I2C_H
+#include_next <linux/i2c.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) && \
+    LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#include <linux/i2c.h>
+/* Unlocked flavor */
+#define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
+extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			  int num);
+#endif
+
+#endif /* __BACKPORT_LINUX_I2C_H */
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
new file mode 100644
index 0000000..17fc89e
--- /dev/null
+++ b/backport/backport-include/linux/leds.h
@@ -0,0 +1,29 @@
+#ifndef __BACKPORT_LINUX_LEDS_H
+#define __BACKPORT_LINUX_LEDS_H
+#include_next <linux/leds.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+/*
+ * Backports 
+ * 
+ * commit 959d62fa865d2e616b61a509e1cc5b88741f065e
+ * Author: Shuah Khan <shuahkhan@gmail.com>
+ * Date:   Thu Jun 14 04:34:30 2012 +0800
+ *
+ *   leds: Rename led_brightness_set() to led_set_brightness()
+ *   
+ *   Rename leds external interface led_brightness_set() to led_set_brightness().
+ *   This is the second phase of the change to reduce confusion between the
+ *   leds internal and external interfaces that set brightness. With this change,
+ *   now the external interface is led_set_brightness(). The first phase renamed
+ *   the internal interface led_set_brightness() to __led_set_brightness().
+ *   There are no changes to the interface implementations.
+ *   
+ *   Signed-off-by: Shuah Khan <shuahkhan@gmail.com>
+ *   Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
+ */
+#define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
+#endif
+
+#endif /* __BACKPORT_LINUX_LEDS_H */
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index dd13eb3..f479236 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -30,4 +30,38 @@
 #define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
 #endif
 
+/**
+ * Backports
+ *
+ * commit cdcac9cd7741af2c2b9255cbf060f772596907bb
+ * Author: Dave Airlie <airlied@redhat.com>
+ * Date:   Wed Jun 27 08:35:52 2012 +0100
+ *
+ * 	pci_regs: define LNKSTA2 pcie cap + bits.
+ *
+ * 	We need these for detecting the max link speed for drm drivers.
+ *
+ * 	Acked-by: Bjorn Helgaas <bhelgass@google.com>
+ * 	Signed-off-by: Dave Airlie <airlied@redhat.com>
+ */
+#ifndef PCI_EXP_LNKCAP2
+#define  PCI_EXP_LNKCAP2 		44	/* Link Capability 2 */
+#endif
+
+#ifndef PCI_EXP_LNKCAP2_SLS_2_5GB
+#define  PCI_EXP_LNKCAP2_SLS_2_5GB 	0x01	/* Current Link Speed 2.5GT/s */
+#endif
+
+#ifndef PCI_EXP_LNKCAP2_SLS_5_0GB
+#define  PCI_EXP_LNKCAP2_SLS_5_0GB 	0x02	/* Current Link Speed 5.0GT/s */
+#endif
+
+#ifndef PCI_EXP_LNKCAP2_SLS_8_0GB
+#define  PCI_EXP_LNKCAP2_SLS_8_0GB 	0x04	/* Current Link Speed 8.0GT/s */
+#endif
+
+#ifndef PCI_EXP_LNKCAP2_CROSSLINK
+#define  PCI_EXP_LNKCAP2_CROSSLINK 	0x100 /* Crosslink supported */
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index 678b03c..448730f 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -31,6 +31,15 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask);
 #define SG_MAX_SINGLE_ALLOC            (PAGE_SIZE / sizeof(struct scatterlist))
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
+/* backports efc42bc9 */
+#define sg_alloc_table_from_pages LINUX_BACKPORT(sg_alloc_table_from_pages)
+int sg_alloc_table_from_pages(struct sg_table *sgt,
+			      struct page **pages, unsigned int n_pages,
+			      unsigned long offset, unsigned long size,
+			      gfp_t gfp_mask);
+#endif /* < 3.6 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 
 /* Lets expect distributions might backport this */
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
new file mode 100644
index 0000000..819d141
--- /dev/null
+++ b/backport/backport-include/linux/string.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_STRING_H
+#define __BACKPORT_LINUX_STRING_H
+#include_next <linux/string.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
+#define memweight LINUX_BACKPORT(memweight)
+extern size_t memweight(const void *ptr, size_t bytes);
+#endif
+
+#endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
new file mode 100644
index 0000000..e1ff8be
--- /dev/null
+++ b/backport/backport-include/linux/usb.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_USB_H
+#define __BACKPORT_USB_H
+
+#include_next <linux/usb.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+/**
+ * Backports
+ *
+ * commit d81a5d1956731c453b85c141458d4ff5d6cc5366
+ * Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
+ * Date:   Tue Jul 10 19:10:06 2012 -0300
+ *
+ * 	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
+ */
+#include <linux/usb.h>
+#define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
+       .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
+               | USB_DEVICE_ID_MATCH_VENDOR, \
+       .idVendor = (vend), \
+       .bInterfaceClass = (cl), \
+       .bInterfaceSubClass = (sc), \
+       .bInterfaceProtocol = (pr)
+#endif
+
+#endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 9512549..44ffcaf 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -9,4 +9,8 @@
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
 #endif
 
+#ifndef GENLMSG_DEFAULT_SIZE
+#define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
1.8.0

