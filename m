Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49587 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbcD3VBF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/16] backport: make media depend on kernel 3.8
Date: Sat, 30 Apr 2016 23:00:33 +0200
Message-Id: <1462050048-8953-2-git-send-email-hauke@hauke-m.de> (sfid-20160430_230109_306553_0ADE9EE3)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The media backports are not used by so many users in my opinion and to
reduce the efforts needed to make the new changes to media introduced
by new kernel versions work on older kernel versions just make it
depend on kernel 3.8 and do not support all the older kernel versions
for media any more. This makes it possible to remove some patches and
other changes.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/dma-mapping.h        |  27 --
 backport/backport-include/linux/i2c.h              |   9 -
 backport/backport-include/linux/mm.h               |   5 -
 backport/backport-include/linux/scatterlist.h      |  15 -
 backport/backport-include/linux/string.h           |   5 -
 backport/compat/Kconfig                            |  11 -
 backport/compat/Makefile                           |   1 -
 backport/compat/compat-3.6.c                       | 136 --------
 backport/compat/compat-3.8.c                       |  55 ---
 backport/compat/dma-shared-helpers.c               |  41 ---
 dependencies                                       |  78 +----
 .../media/0002-no_dmabuf.cocci                     |  75 ----
 .../media/0002-no_dmabuf/v4l2.patch                | 385 ---------------------
 .../media/0003-devnode_param_type/INFO             |   8 -
 .../media/0003-devnode_param_type/ddbridge.patch   |  14 -
 .../media/0003-devnode_param_type/dvb-core.patch   |  14 -
 .../media/0003-devnode_param_type/rc.patch         |  14 -
 .../media/0004-missing-include/airspy.patch        |  18 -
 .../media/0004-missing-include/hackrf.patch        |  10 -
 .../media/0004-missing-include/ir-hix5hd2.patch    |  10 -
 .../media/0005-dma-no-sync/v4l2.patch              |  64 ----
 .../media/0006-no-eprobe_defer/v4l2-clk.patch      |  13 -
 22 files changed, 1 insertion(+), 1007 deletions(-)
 delete mode 100644 backport/backport-include/asm/dma-mapping.h
 delete mode 100644 backport/backport-include/linux/scatterlist.h
 delete mode 100644 backport/compat/dma-shared-helpers.c
 delete mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf.cocci
 delete mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/INFO
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/airspy.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
 delete mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
 delete mode 100644 patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch

diff --git a/backport/backport-include/asm/dma-mapping.h b/backport/backport-include/asm/dma-mapping.h
deleted file mode 100644
index b73b7da..0000000
--- a/backport/backport-include/asm/dma-mapping.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __BACKPORT_ASM_DMA_MAPPING_H
-#define __BACKPORT_ASM_DMA_MAPPING_H
-#include_next <asm/dma-mapping.h>
-#include <linux/version.h>
-
-#if defined(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS)
-#define dma_common_get_sgtable LINUX_BACKPORT(dma_common_get_sgtable)
-int
-dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
-#endif /* defined(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
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
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
-
-#endif /* __BACKPORT_ASM_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/i2c.h b/backport/backport-include/linux/i2c.h
index 2350835..c8f7a8d 100644
--- a/backport/backport-include/linux/i2c.h
+++ b/backport/backport-include/linux/i2c.h
@@ -3,15 +3,6 @@
 #include_next <linux/i2c.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) && \
-    LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
-#include <linux/i2c.h>
-/* Unlocked flavor */
-#define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
-extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			  int num);
-#endif
-
 /* This backports
  *
  * commit 14674e70119ea01549ce593d8901a797f8a90f74
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 7e6f77c..bac2303 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -20,11 +20,6 @@
 #define VM_DONTDUMP    VM_NODUMP
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
-#define vm_iomap_memory LINUX_BACKPORT(vm_iomap_memory)
-int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
 #define kvfree LINUX_BACKPORT(kvfree)
 void kvfree(const void *addr);
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
deleted file mode 100644
index f939e8c..0000000
--- a/backport/backport-include/linux/scatterlist.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __BACKPORT_SCATTERLIST_H
-#define __BACKPORT_SCATTERLIST_H
-#include_next <linux/scatterlist.h>
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
-/* backports efc42bc9 */
-#define sg_alloc_table_from_pages LINUX_BACKPORT(sg_alloc_table_from_pages)
-int sg_alloc_table_from_pages(struct sg_table *sgt,
-			      struct page **pages, unsigned int n_pages,
-			      unsigned long offset, unsigned long size,
-			      gfp_t gfp_mask);
-#endif /* < 3.6 */
-
-#endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 878d033..f585862 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -3,11 +3,6 @@
 #include_next <linux/string.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
-#define memweight LINUX_BACKPORT(memweight)
-extern size_t memweight(const void *ptr, size_t bytes);
-#endif
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
 #define memdup_user_nul LINUX_BACKPORT(memdup_user_nul)
 extern void *memdup_user_nul(const void __user *, size_t);
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index a99f11f..b5b9100 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -77,17 +77,6 @@ config BPAUTO_CORDIC
 config BPAUTO_MII
 	bool
 
-config BPAUTO_BUILD_DMA_SHARED_HELPERS
-	bool
-	depends on HAS_DMA
-	# Build on other kernels kernels < 3.9 if HAVE_GENERIC_DMA_COHERENT is
-	# not set. Kernels >= 3.8 have this if HAS_DMA is set.
-	depends on (!HAVE_GENERIC_DMA_COHERENT && KERNEL_3_8)
-	# Always build if on 3.3 - 3.5
-	default y if (KERNEL_3_4 || KERNEL_3_5 || KERNEL_3_6)
-	# build for testing
-	default y if BPAUTO_USERSEL_BUILD_ALL
-
 config BPAUTO_BUILD_LEDS
 	bool
 	depends on !NEW_LEDS || LEDS_CLASS=n || !LEDS_TRIGGERS
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index be9e5c6..7cbb881 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -33,4 +33,3 @@ compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
-compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index c82bfb8..ef36485 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -9,145 +9,9 @@
  */
 
 #include <linux/module.h>
-#include <linux/scatterlist.h>
 #include <linux/export.h>
-#include <linux/bug.h>
-#include <linux/bitmap.h>
-#include <linux/i2c.h>
 #include <linux/clk.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-/**
- * __i2c_transfer - unlocked flavor of i2c_transfer
- * @adap: Handle to I2C bus
- * @msgs: One or more messages to execute before STOP is issued to
- *     terminate the operation; each message begins with a START.
- * @num: Number of messages to be executed.
- *
- * Returns negative errno, else the number of messages executed.
- *
- * Adapter lock must be held when calling this function. No debug logging
- * takes place. adap->algo->master_xfer existence isn't checked.
- */
-int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
-{
-	unsigned long orig_jiffies;
-	int ret, try;
-
-	/* Retry automatically on arbitration loss */
-	orig_jiffies = jiffies;
-	for (ret = 0, try = 0; try <= adap->retries; try++) {
-		ret = adap->algo->master_xfer(adap, msgs, num);
-		if (ret != -EAGAIN)
-			break;
-		if (time_after(jiffies, orig_jiffies + adap->timeout))
-			break;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__i2c_transfer);
-#endif
-
-/**
- * memweight - count the total number of bits set in memory area
- * @ptr: pointer to the start of the area
- * @bytes: the size of the area
- */
-size_t memweight(const void *ptr, size_t bytes)
-{
-	size_t ret = 0;
-	size_t longs;
-	const unsigned char *bitmap = ptr;
-
-	for (; bytes > 0 && ((unsigned long)bitmap) % sizeof(long);
-			bytes--, bitmap++)
-		ret += hweight8(*bitmap);
-
-	longs = bytes / sizeof(long);
-	if (longs) {
-		BUG_ON(longs >= INT_MAX / BITS_PER_LONG);
-		ret += bitmap_weight((unsigned long *)bitmap,
-				longs * BITS_PER_LONG);
-		bytes -= longs * sizeof(long);
-		bitmap += longs * sizeof(long);
-	}
-	/*
-	 * The reason that this last loop is distinct from the preceding
-	 * bitmap_weight() call is to compute 1-bits in the last region smaller
-	 * than sizeof(long) properly on big-endian systems.
-	 */
-	for (; bytes > 0; bytes--, bitmap++)
-		ret += hweight8(*bitmap);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(memweight);
-
-/**
- * sg_alloc_table_from_pages - Allocate and initialize an sg table from
- *			       an array of pages
- * @sgt:	The sg table header to use
- * @pages:	Pointer to an array of page pointers
- * @n_pages:	Number of pages in the pages array
- * @offset:     Offset from start of the first page to the start of a buffer
- * @size:       Number of valid bytes in the buffer (after offset)
- * @gfp_mask:	GFP allocation mask
- *
- *  Description:
- *    Allocate and initialize an sg table from a list of pages. Contiguous
- *    ranges of the pages are squashed into a single scatterlist node. A user
- *    may provide an offset at a start and a size of valid data in a buffer
- *    specified by the page array. The returned sg table is released by
- *    sg_free_table.
- *
- * Returns:
- *   0 on success, negative error on failure
- */
-int sg_alloc_table_from_pages(struct sg_table *sgt,
-	struct page **pages, unsigned int n_pages,
-	unsigned long offset, unsigned long size,
-	gfp_t gfp_mask)
-{
-	unsigned int chunks;
-	unsigned int i;
-	unsigned int cur_page;
-	int ret;
-	struct scatterlist *s;
-
-	/* compute number of contiguous chunks */
-	chunks = 1;
-	for (i = 1; i < n_pages; ++i)
-		if (page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1)
-			++chunks;
-
-	ret = sg_alloc_table(sgt, chunks, gfp_mask);
-	if (unlikely(ret))
-		return ret;
-
-	/* merging chunks and putting them into the scatterlist */
-	cur_page = 0;
-	for_each_sg(sgt->sgl, s, sgt->orig_nents, i) {
-		unsigned long chunk_size;
-		unsigned int j;
-
-		/* look for the end of the current chunk */
-		for (j = cur_page + 1; j < n_pages; ++j)
-			if (page_to_pfn(pages[j]) !=
-			    page_to_pfn(pages[j - 1]) + 1)
-				break;
-
-		chunk_size = ((j - cur_page) << PAGE_SHIFT) - offset;
-		sg_set_page(s, pages[cur_page], min(size, chunk_size), offset);
-		size -= chunk_size;
-		offset = 0;
-		cur_page = j;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(sg_alloc_table_from_pages);
-
 /* whoopsie ! */
 #ifndef CONFIG_COMMON_CLK
 int clk_enable(struct clk *clk)
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index a318c15..7e1b979 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -357,61 +357,6 @@ bool hid_ignore(struct hid_device *hdev)
 EXPORT_SYMBOL_GPL(hid_ignore);
 
 /**
- * Backport this:
- * commit b4cbb197c7e7a68dbad0d491242e3ca67420c13e
- * Author: Linus Torvalds <torvalds@linux-foundation.org>
- * Date:   Tue Apr 16 13:45:37 2013 -0700
- *
- *     vm: add vm_iomap_memory() helper function
- */
-/**
- * vm_iomap_memory - remap memory to userspace
- * @vma: user vma to map to
- * @start: start of area
- * @len: size of area
- *
- * This is a simplified io_remap_pfn_range() for common driver use. The
- * driver just needs to give us the physical memory range to be mapped,
- * we'll figure out the rest from the vma information.
- *
- * NOTE! Some drivers might want to tweak vma->vm_page_prot first to get
- * whatever write-combining details or similar.
- */
-int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len)
-{
-	unsigned long vm_len, pfn, pages;
-
-	/* Check that the physical memory area passed in looks valid */
-	if (start + len < start)
-		return -EINVAL;
-	/*
-	 * You *really* shouldn't map things that aren't page-aligned,
-	 * but we've historically allowed it because IO memory might
-	 * just have smaller alignment.
-	 */
-	len += start & ~PAGE_MASK;
-	pfn = start >> PAGE_SHIFT;
-	pages = (len + ~PAGE_MASK) >> PAGE_SHIFT;
-	if (pfn + pages < pfn)
-		return -EINVAL;
-
-	/* We start the mapping 'vm_pgoff' pages into the area */
-	if (vma->vm_pgoff > pages)
-		return -EINVAL;
-	pfn += vma->vm_pgoff;
-	pages -= vma->vm_pgoff;
-
-	/* Can we fit all of the mapping? */
-	vm_len = vma->vm_end - vma->vm_start;
-	if (vm_len >> PAGE_SHIFT > pages)
-		return -EINVAL;
-
-	/* Ok, let it rip */
-	return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
-}
-EXPORT_SYMBOL_GPL(vm_iomap_memory);
-
-/**
  *	prandom_bytes - get the requested number of pseudo-random bytes
  *	@buf: where to copy the pseudo-random bytes to
  *	@bytes: the requested number of bytes
diff --git a/backport/compat/dma-shared-helpers.c b/backport/compat/dma-shared-helpers.c
deleted file mode 100644
index 2ada681..0000000
--- a/backport/compat/dma-shared-helpers.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport compatibility file for Linux for some DMA helpers
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
-#include <linux/device.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0)
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <asm/dma-mapping.h>
-#endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
-
-#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-/*
- * Create scatter-list for the already allocated DMA buffer.
- */
-int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t handle, size_t size)
-{
-	struct page *page = virt_to_page(cpu_addr);
-	int ret;
-
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (unlikely(ret))
-		return ret;
-
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dma_common_get_sgtable);
-#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) */
diff --git a/dependencies b/dependencies
index 50cd6f1..b711099 100644
--- a/dependencies
+++ b/dependencies
@@ -23,39 +23,9 @@ AIRO 3.9
 AIRO_CS 3.9
 
 # Media
-MEDIA_SUPPORT 3.2
-USB_GSPCA_OV534 3.5
-# Some media drivers depend on the CONFIG_REGULATOR which
-# we only support on >= 3.4 give that reguatory itself depends
-# on -EPROBE_DEFER.
-SOC_CAMERA 3.4
-VIDEO_S5K5BAF 3.4
-VIDEO_S5K4ECGX 3.4
-# 49920bc6 and 1003cab8 and while it seems there is a
-# one to one map DMA_FROM_DEVICE to DMA_DEV_TO_MEM
-# I can't verify this fully yet.
-VIDEO_TIMBERDALE 3.4
+MEDIA_SUPPORT 3.8
 # someone has to backport "firewire: introduce fw_driver.probe and .remove methods"
 DVB_FIREDTV 3.11
-VIDEO_RENESAS_VSP1 3.4
-VIDEO_MEM2MEM_DEINTERLACE 3.3
-MEDIA_TUNER_E4000 3.4
-DVB_USB_RTL28XXU 3.4
-
-# missing many members in struct regmap_config
-DVB_USB_RTL28XXU 3.8
-DVB_RTL2830 3.8
-DVB_RTL2832 3.8
-DVB_M88DS3103 3.8
-DVB_TS2020 3.8
-DVB_USB_DW2102 3.8
-DVB_USB_LME2510 3.8
-DVB_USB_DVBSKY 3.8
-VIDEO_EM28XX_DVB 3.8
-VIDEO_CX23885 3.8
-VIDEO_CX88_DVB 3.8
-DVB_DM1105 3.8
-DVB_SMIPCIE 3.8
 
 SOC_CAMERA_PLATFORM 3.9
 
@@ -92,18 +62,6 @@ NFC_ST21NFCA_I2C 3.18
 NFC_ST_NCI_I2C 3.18
 NFC_ST_NCI_SPI 3.18
 
-# missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
-VIDEO_MT9V032 3.3
-VIDEO_S5K6AA 3.3
-
-# missing devm_regulator_bulk_get
-VIDEO_MT9T001 3.5
-VIDEO_NOON010PC30 3.5
-
-# missing of_property_read_bool() added via fa4d34cc on v3.4-rc1~71, backport
-# that attomically and you can enable this for older kernels.
-VIDEO_ADV7343 3.4
-
 # for whoever wants to backport this: GPIOF_EXPORT was redefined via commit
 # 79a9becd on v3.13-rc1~120^2~15, before this it was redefined via commit
 # f567fde2 on v3.5-rc7~32^2~4 and finally added via commit fc3a1f04 on
@@ -112,43 +70,9 @@ VIDEO_ADV7343 3.4
 VIDEO_S5K6AA 3.13
 VIDEO_S5K6A3 3.13
 
-# missing linux/sizes.h
-VIDEO_M5MOLS 3.6
-VIDEO_S5C73M3 3.6
-
-# missing function devm_regmap_init_i2c()
-VIDEO_LM3646 3.3
-VIDEO_LM3560 3.3
-MEDIA_TUNER_M88RS6000T 3.3
-MEDIA_TUNER_FC2580 3.3
-MEDIA_TUNER_TUA9001 3.3
-
-# missing regmap_bulk_write()
-DVB_USB_AF9035 3.4
-DVB_USB_ANYSEE 3.4
-DVB_USB_DVBSKY 3.4
-DVB_TDA10071 3.4
-DVB_SMIPCIE 3.4
-MEDIA_TUNER_E4000 3.4
-MEDIA_TUNER_M88TS2022 3.4
-MEDIA_TUNER_TDA18212 3.4
-MEDIA_TUNER_IT913X 3.4
-VIDEO_CX23885 3.4
-VIDEO_EM28XX_DVB 3.4
-
 # this needs arch_phys_wc_add(), arch_phys_wc_del() and pat_enabled()
 VIDEO_FB_IVTV 4.2
 
-# missing kthread_freezable_should_stop()
-DVB_PT3 3.3
-
-# missing spi_finalize_current_message() and struct spi_master.transfer_one_message
-USB_MSI2500 3.4
-DVB_NETUP_UNIDVB 3.4
-
-# missing vb2_expbuf()
-SOC_CAMERA 3.5
-
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf.cocci b/patches/collateral-evolutions/media/0002-no_dmabuf.cocci
deleted file mode 100644
index edcfd1d..0000000
--- a/patches/collateral-evolutions/media/0002-no_dmabuf.cocci
+++ /dev/null
@@ -1,75 +0,0 @@
-/* c5384048 */
-
-@ vb2_mem_ops @
-identifier s, dma_fn;
-identifier dma_op =~ "(get_dma|map_dma|unmap_dma|attach_dma|detach_dma)";
-@@
-
- struct vb2_mem_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.dma_op = dma_fn,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-};
-
-@ mod_dma_fn depends on vb2_mem_ops @
-identifier vb2_mem_ops.dma_fn;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- dma_fn(...)
- {
- 	...
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-
-@ v4l_ioctl_ops @
-identifier s, ioctl_fn;
-identifier ioctl_op =~ "(vidioc_expbuf)";
-@@
-struct v4l2_ioctl_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
-	.ioctl_op = ioctl_fn,
-+#endif
-};
-
-@ mod_ioctl_fn depends on v4l_ioctl_ops @
-identifier v4l_ioctl_ops.ioctl_fn;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- ioctl_fn(...)
- {
- 	...
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-
-@ dma_buf_op_add_ifdef @
-identifier s, dma_fn;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- struct dma_buf_ops s = {
- ...
-};
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-
-@ dma_buf_op @
-identifier s, dma_fn;
-identifier dma_op;
-@@
-
- struct dma_buf_ops s = {
-	.dma_op = dma_fn,
-};
-
-@ modify_dma_fn depends on dma_buf_op @
-identifier dma_buf_op.dma_fn;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- dma_fn(...)
- {
- 	...
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
deleted file mode 100644
index e668bb7..0000000
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ /dev/null
@@ -1,385 +0,0 @@
---- a/drivers/media/v4l2-core/Kconfig
-+++ b/drivers/media/v4l2-core/Kconfig
-@@ -79,7 +79,7 @@ config VIDEOBUF_DVB
- 
- # Used by drivers that need Videobuf2 modules
- config VIDEOBUF2_CORE
--	select DMA_SHARED_BUFFER
-+	select DMA_SHARED_BUFFER if !KERNEL_3_5
- 	tristate
- 
- config VIDEOBUF2_MEMOPS
-@@ -91,13 +91,13 @@ config VIDEOBUF2_DMA_CONTIG
- 	depends on HAS_DMA
- 	select VIDEOBUF2_CORE
- 	select VIDEOBUF2_MEMOPS
--	select DMA_SHARED_BUFFER
-+	select DMA_SHARED_BUFFER if !KERNEL_3_5
- 
- config VIDEOBUF2_VMALLOC
- 	tristate
- 	select VIDEOBUF2_CORE
- 	select VIDEOBUF2_MEMOPS
--	select DMA_SHARED_BUFFER
-+	select DMA_SHARED_BUFFER if !KERNEL_3_5
- 
- config VIDEOBUF2_DMA_SG
- 	tristate
---- a/drivers/media/v4l2-core/v4l2-mem2mem.c
-+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
-@@ -466,6 +466,7 @@ int v4l2_m2m_create_bufs(struct file *fi
- }
- EXPORT_SYMBOL_GPL(v4l2_m2m_create_bufs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * v4l2_m2m_expbuf() - export a source or destination buffer, depending on
-  * the type
-@@ -479,6 +480,7 @@ int v4l2_m2m_expbuf(struct file *file, s
- 	return vb2_expbuf(vq, eb);
- }
- EXPORT_SYMBOL_GPL(v4l2_m2m_expbuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- /**
-  * v4l2_m2m_streamon() - turn on streaming for a video queue
-  */
-@@ -841,6 +843,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
- }
- EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_prepare_buf);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int v4l2_m2m_ioctl_expbuf(struct file *file, void *priv,
- 				struct v4l2_exportbuffer *eb)
- {
-@@ -849,6 +852,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
- 	return v4l2_m2m_expbuf(file, fh->m2m_ctx, eb);
- }
- EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_expbuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- int v4l2_m2m_ioctl_streamon(struct file *file, void *priv,
- 				enum v4l2_buf_type type)
---- a/drivers/media/v4l2-core/videobuf2-core.c
-+++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -254,6 +254,7 @@ static void __vb2_buf_userptr_put(struct
- 	}
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * __vb2_plane_dmabuf_put() - release memory associated with
-  * a DMABUF shared plane
-@@ -284,6 +285,7 @@ static void __vb2_buf_dmabuf_put(struct
- 	for (plane = 0; plane < vb->num_planes; ++plane)
- 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /**
-  * __setup_offsets() - setup unique offsets ("cookies") for every plane in
-@@ -399,8 +401,10 @@ static void __vb2_free_mem(struct vb2_qu
- 		/* Free MMAP buffers or release USERPTR buffers */
- 		if (q->memory == VB2_MEMORY_MMAP)
- 			__vb2_buf_mem_free(vb);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 		else if (q->memory == VB2_MEMORY_DMABUF)
- 			__vb2_buf_dmabuf_put(vb);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 		else
- 			__vb2_buf_userptr_put(vb);
- 	}
-@@ -498,11 +502,13 @@ static int __vb2_queue_free(struct vb2_q
- 			pr_info("vb2:     attach_dmabuf: %u detach_dmabuf: %u map_dmabuf: %u unmap_dmabuf: %u\n",
- 				vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf,
- 				vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 			pr_info("vb2:     get_dmabuf: %u num_users: %u vaddr: %u cookie: %u\n",
- 				vb->cnt_mem_get_dmabuf,
- 				vb->cnt_mem_num_users,
- 				vb->cnt_mem_vaddr,
- 				vb->cnt_mem_cookie);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 		}
- 	}
- #endif
-@@ -600,6 +606,7 @@ static int __verify_mmap_ops(struct vb2_
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * __verify_dmabuf_ops() - verify that all memory operations required for
-  * DMABUF queue type have been provided
-@@ -613,6 +620,7 @@ static int __verify_dmabuf_ops(struct vb
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /**
-  * vb2_verify_memory_type() - Check whether the memory type and buffer type
-@@ -646,10 +654,12 @@ int vb2_verify_memory_type(struct vb2_qu
- 		return -EINVAL;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	if (memory == VB2_MEMORY_DMABUF && __verify_dmabuf_ops(q)) {
- 		dprintk(1, "DMABUF for current setup unsupported\n");
- 		return -EINVAL;
- 	}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 	/*
- 	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1183,6 +1193,7 @@ err:
- 	return ret;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
-  */
-@@ -1311,6 +1322,7 @@ err:
- 
- 	return ret;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /**
-  * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1351,9 +1363,11 @@ static int __buf_prepare(struct vb2_buff
- 	case VB2_MEMORY_USERPTR:
- 		ret = __qbuf_userptr(vb, pb);
- 		break;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	case VB2_MEMORY_DMABUF:
- 		ret = __qbuf_dmabuf(vb, pb);
- 		break;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	default:
- 		WARN(1, "Invalid queue type\n");
- 		ret = -EINVAL;
-@@ -1691,8 +1705,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
-  */
- static void __vb2_dqbuf(struct vb2_buffer *vb)
- {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	struct vb2_queue *q = vb->vb2_queue;
- 	unsigned int i;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 	/* nothing to do if the buffer is already dequeued */
- 	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -1700,6 +1716,7 @@ static void __vb2_dqbuf(struct vb2_buffe
- 
- 	vb->state = VB2_BUF_STATE_DEQUEUED;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	/* unmap DMABUF buffer */
- 	if (q->memory == VB2_MEMORY_DMABUF)
- 		for (i = 0; i < vb->num_planes; ++i) {
-@@ -1708,6 +1725,7 @@ static void __vb2_dqbuf(struct vb2_buffe
- 			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
- 			vb->planes[i].dbuf_mapped = 0;
- 		}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- }
- 
- /**
-@@ -1961,6 +1979,7 @@ static int __find_plane_by_offset(struct
- 	return -EINVAL;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * vb2_core_expbuf() - Export a buffer as a file descriptor
-  * @q:		videobuf2 queue
-@@ -2044,6 +2063,7 @@ int vb2_core_expbuf(struct vb2_queue *q,
- 	return 0;
- }
- EXPORT_SYMBOL_GPL(vb2_core_expbuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /**
-  * vb2_mmap() - map video buffers into application address space
---- a/drivers/media/v4l2-core/videobuf2-v4l2.c
-+++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
-@@ -709,6 +709,7 @@ int vb2_streamoff(struct vb2_queue *q, e
- }
- EXPORT_SYMBOL_GPL(vb2_streamoff);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /**
-  * vb2_expbuf() - Export a buffer as a file descriptor
-  * @q:		videobuf2 queue
-@@ -724,6 +725,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
- 				eb->plane, eb->flags);
- }
- EXPORT_SYMBOL_GPL(vb2_expbuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /**
-  * vb2_queue_init() - initialize a videobuf2 queue
-@@ -951,6 +953,7 @@ int vb2_ioctl_streamoff(struct file *fil
- }
- EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
- {
- 	struct video_device *vdev = video_devdata(file);
-@@ -960,6 +963,7 @@ int vb2_ioctl_expbuf(struct file *file,
- 	return vb2_expbuf(vdev->queue, p);
- }
- EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /* v4l2_file_operations helpers */
- 
---- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
-+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -78,8 +78,10 @@ static void *vb2_dc_vaddr(void *buf_priv
- {
- 	struct vb2_dc_buf *buf = buf_priv;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	if (!buf->vaddr && buf->db_attach)
- 		buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 	return buf->vaddr;
- }
-@@ -253,6 +255,7 @@ static int vb2_dc_mmap(void *buf_priv, s
- }
- #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /*********************************************/
- /*         DMABUF ops for exporters          */
- /*********************************************/
-@@ -425,6 +428,7 @@ static struct sg_table *vb2_dc_get_base_
- 
- 	return sgt;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static struct dma_buf *vb2_dc_get_dmabuf(void *buf_priv, unsigned long flags)
- {
---- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
-+++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
-@@ -28,7 +28,9 @@ struct vb2_vmalloc_buf {
- 	unsigned long			size;
- 	atomic_t			refcount;
- 	struct vb2_vmarea_handler	handler;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	struct dma_buf			*dbuf;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- };
- 
- static void vb2_vmalloc_put(void *buf_priv);
---- a/include/media/v4l2-mem2mem.h
-+++ b/include/media/v4l2-mem2mem.h
-@@ -125,8 +125,10 @@ int v4l2_m2m_prepare_buf(struct file *fi
- int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
- 			 struct v4l2_create_buffers *create);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int v4l2_m2m_expbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
- 		   struct v4l2_exportbuffer *eb);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- int v4l2_m2m_streamon(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
- 		      enum v4l2_buf_type type);
-@@ -265,8 +267,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
- 				struct v4l2_create_buffers *create);
- int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
- 				struct v4l2_buffer *buf);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
- 				struct v4l2_exportbuffer *eb);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- int v4l2_m2m_ioctl_qbuf(struct file *file, void *fh,
- 				struct v4l2_buffer *buf);
- int v4l2_m2m_ioctl_dqbuf(struct file *file, void *fh,
---- a/include/media/videobuf2-core.h
-+++ b/include/media/videobuf2-core.h
-@@ -97,7 +97,9 @@ struct vb2_mem_ops {
- 				  enum dma_data_direction dma_dir,
- 				  gfp_t gfp_flags);
- 	void		(*put)(void *buf_priv);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	struct dma_buf *(*get_dmabuf)(void *buf_priv, unsigned long flags);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 	void		*(*get_userptr)(void *alloc_ctx, unsigned long vaddr,
- 					unsigned long size,
-@@ -107,12 +109,14 @@ struct vb2_mem_ops {
- 	void		(*prepare)(void *buf_priv);
- 	void		(*finish)(void *buf_priv);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	void		*(*attach_dmabuf)(void *alloc_ctx, struct dma_buf *dbuf,
- 					  unsigned long size,
- 					  enum dma_data_direction dma_dir);
- 	void		(*detach_dmabuf)(void *buf_priv);
- 	int		(*map_dmabuf)(void *buf_priv);
- 	void		(*unmap_dmabuf)(void *buf_priv);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 	void		*(*vaddr)(void *buf_priv);
- 	void		*(*cookie)(void *buf_priv);
---- a/include/media/videobuf2-v4l2.h
-+++ b/include/media/videobuf2-v4l2.h
-@@ -55,7 +55,9 @@ int vb2_create_bufs(struct vb2_queue *q,
- int vb2_prepare_buf(struct vb2_queue *q, struct v4l2_buffer *b);
- 
- int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
- 
- int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -87,8 +89,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
- int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
- int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
- int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int vb2_ioctl_expbuf(struct file *file, void *priv,
- 	struct v4l2_exportbuffer *p);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /* struct v4l2_file_operations helpers */
- 
---- a/drivers/media/usb/uvc/uvc_queue.c
-+++ b/drivers/media/usb/uvc/uvc_queue.c
-@@ -271,6 +271,7 @@ int uvc_queue_buffer(struct uvc_video_qu
- 	return ret;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- int uvc_export_buffer(struct uvc_video_queue *queue,
- 		      struct v4l2_exportbuffer *exp)
- {
-@@ -282,6 +283,7 @@ int uvc_export_buffer(struct uvc_video_q
- 
- 	return ret;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
- 		       int nonblocking)
---- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
-+++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -317,9 +317,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
- 	BUG_ON(!buf);
- 
- 	if (!buf->vaddr) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 		if (buf->db_attach)
- 			buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
- 		else
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 			buf->vaddr = vm_map_ram(buf->pages,
- 					buf->num_pages, -1, PAGE_KERNEL);
- 	}
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/INFO b/patches/collateral-evolutions/media/0003-devnode_param_type/INFO
deleted file mode 100644
index 192cfb8..0000000
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/INFO
+++ /dev/null
@@ -1,8 +0,0 @@
-The mode parameter type was changed in the callback function devnode in
-struct device_type.
-
-commit 2c9ede55ecec58099b72e4bb8eab719f32f72c31
-Author: Al Viro <viro@zeniv.linux.org.uk>
-Date:   Sat Jul 23 20:24:48 2011 -0400
-
-    switch device_get_devnode() and ->devnode() to umode_t *
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
deleted file mode 100644
index 98923bc..0000000
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/media/pci/ddbridge/ddbridge-core.c
-+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
-@@ -1476,7 +1476,11 @@ static const struct file_operations ddb_
- 	.open           = ddb_open,
- };
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static char *ddb_devnode(struct device *device, umode_t *mode)
-+#else
-+static char *ddb_devnode(struct device *device, mode_t *mode)
-+#endif
- {
- 	struct ddb *dev = dev_get_drvdata(device);
- 
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
deleted file mode 100644
index 23b21d9..0000000
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/media/dvb-core/dvbdev.c
-+++ b/drivers/media/dvb-core/dvbdev.c
-@@ -912,7 +912,11 @@ static int dvb_uevent(struct device *dev
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static char *dvb_devnode(struct device *dev, umode_t *mode)
-+#else
-+static char *dvb_devnode(struct device *dev, mode_t *mode)
-+#endif
- {
- 	struct dvb_device *dvbdev = dev_get_drvdata(dev);
- 
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
deleted file mode 100644
index 2d0f58f..0000000
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/media/rc/rc-main.c
-+++ b/drivers/media/rc/rc-main.c
-@@ -762,7 +762,11 @@ static void ir_close(struct input_dev *i
- }
- 
- /* class for /sys/class/rc */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static char *rc_devnode(struct device *dev, umode_t *mode)
-+#else
-+static char *rc_devnode(struct device *dev, mode_t *mode)
-+#endif
- {
- 	return kasprintf(GFP_KERNEL, "rc/%s", dev_name(dev));
- }
diff --git a/patches/collateral-evolutions/media/0004-missing-include/airspy.patch b/patches/collateral-evolutions/media/0004-missing-include/airspy.patch
deleted file mode 100644
index ee31d01..0000000
--- a/patches/collateral-evolutions/media/0004-missing-include/airspy.patch
+++ /dev/null
@@ -1,18 +0,0 @@
-Without this patch I get the following error message when compiling 
-against kernel 3.2, all other kernel versions work:
-
-3.2.60/drivers/media/usb/airspy/airspy.c: In function ‘airspy_queue_setup’:
-3.2.60/drivers/media/usb/airspy/airspy.c:506:2: error: implicit declaration of function ‘PAGE_ALIGN’ [-Werror=implicit-function-declaration]
-sizes[0] = PAGE_ALIGN(s->buffersize);
-
-
---- a/drivers/media/usb/airspy/airspy.c
-+++ b/drivers/media/usb/airspy/airspy.c
-@@ -16,6 +16,7 @@
- 
- #include <linux/module.h>
- #include <linux/slab.h>
-+#include <linux/mm.h>
- #include <linux/usb.h>
- #include <media/v4l2-device.h>
- #include <media/v4l2-ioctl.h>
diff --git a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
deleted file mode 100644
index dfc5a36..0000000
--- a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/media/usb/hackrf/hackrf.c
-+++ b/drivers/media/usb/hackrf/hackrf.c
-@@ -23,6 +23,7 @@
- #include <media/v4l2-event.h>
- #include <media/videobuf2-v4l2.h>
- #include <media/videobuf2-vmalloc.h>
-+#include <linux/mm.h>
- 
- /*
-  * Used Avago MGA-81563 RF amplifier could be destroyed pretty easily with too
diff --git a/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch b/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
deleted file mode 100644
index 92368fa..0000000
--- a/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/media/rc/ir-hix5hd2.c
-+++ b/drivers/media/rc/ir-hix5hd2.c
-@@ -15,6 +15,7 @@
- #include <linux/of_device.h>
- #include <linux/regmap.h>
- #include <media/rc-core.h>
-+#include <linux/of.h>
- 
- #define IR_ENABLE		0x00
- #define IR_CONFIG		0x04
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
deleted file mode 100644
index 1c17489..0000000
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ /dev/null
@@ -1,64 +0,0 @@
---- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
-+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -471,7 +471,9 @@ static void vb2_dc_put_userptr(void *buf
- 	if (sgt) {
- 		DEFINE_DMA_ATTRS(attrs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 		/*
- 		 * No need to sync to CPU, it's already synced to the CPU
- 		 * since the finish() memop will have been called before this.
-@@ -535,7 +537,9 @@ static void *vb2_dc_get_userptr(void *al
- 	unsigned long dma_align = dma_get_cache_alignment();
- 	DEFINE_DMA_ATTRS(attrs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 
- 	/* Only cache aligned DMA transfers are reliable */
- 	if (!IS_ALIGNED(vaddr | size, dma_align)) {
---- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
-+++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -109,7 +109,9 @@ static void *vb2_dma_sg_alloc(void *allo
- 	int num_pages;
- 	DEFINE_DMA_ATTRS(attrs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 
- 	if (WARN_ON(alloc_ctx == NULL))
- 		return NULL;
-@@ -185,7 +187,9 @@ static void vb2_dma_sg_put(void *buf_pri
- 	if (atomic_dec_and_test(&buf->refcount)) {
- 		DEFINE_DMA_ATTRS(attrs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
- 			buf->num_pages);
- 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-@@ -236,7 +240,9 @@ static void *vb2_dma_sg_get_userptr(void
- 	DEFINE_DMA_ATTRS(attrs);
- 	struct frame_vector *vec;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) 
- 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
- 	if (!buf)
- 		return NULL;
-@@ -293,7 +299,9 @@ static void vb2_dma_sg_put_userptr(void
- 	int i = buf->num_pages;
- 	DEFINE_DMA_ATTRS(attrs);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
-+#endif
- 
- 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
- 	       __func__, buf->num_pages);
diff --git a/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch b/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
deleted file mode 100644
index 8498457..0000000
--- a/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/media/v4l2-core/v4l2-clk.c
-+++ b/drivers/media/v4l2-core/v4l2-clk.c
-@@ -42,8 +42,10 @@ struct v4l2_clk *v4l2_clk_get(struct dev
- 	struct clk *ccf_clk = clk_get(dev, id);
- 	char clk_name[V4L2_CLK_NAME_SIZE];
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
- 	if (PTR_ERR(ccf_clk) == -EPROBE_DEFER)
- 		return ERR_PTR(-EPROBE_DEFER);
-+#endif
- 
- 	if (!IS_ERR_OR_NULL(ccf_clk)) {
- 		clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
