Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50902 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab3JEWow (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:52 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 08/15] backports: remove some stuff related to MTRR
Date: Sun,  6 Oct 2013 00:43:57 +0200
Message-Id: <1381013044-7724-9-git-send-email-hauke@hauke-m.de> (sfid-20131006_004454_113614_3A8D9AB4)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/mtrr.h |   21 --------
 backport/backport-include/linux/io.h |   38 --------------
 backport/compat/Makefile             |    1 -
 backport/compat/backport-3.11.c      |   92 ----------------------------------
 4 files changed, 152 deletions(-)
 delete mode 100644 backport/backport-include/asm/mtrr.h
 delete mode 100644 backport/backport-include/linux/io.h
 delete mode 100644 backport/compat/backport-3.11.c

diff --git a/backport/backport-include/asm/mtrr.h b/backport/backport-include/asm/mtrr.h
deleted file mode 100644
index 861438a..0000000
--- a/backport/backport-include/asm/mtrr.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef __BACKPORT_ASM_MTRR_H
-#define __BACKPORT_ASM_MTRR_H
-#include_next <asm/mtrr.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0))
-/*
- * The following functions are for use by other drivers that cannot use
- * arch_phys_wc_add and arch_phys_wc_del.
- */
-#define phys_wc_to_mtrr_index LINUX_BACKPORT(phys_wc_to_mtrr_index)
-#ifdef CONFIG_MTRR
-extern int phys_wc_to_mtrr_index(int handle);
-#else
-static inline int phys_wc_to_mtrr_index(int handle)
-{
-	return -1;
-}
-#endif /* CONFIG_MTRR */
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) */
-
-#endif /* __BACKPORT_ASM_MTRR_H */
diff --git a/backport/backport-include/linux/io.h b/backport/backport-include/linux/io.h
deleted file mode 100644
index 84a8c21..0000000
--- a/backport/backport-include/linux/io.h
+++ /dev/null
@@ -1,38 +0,0 @@
-#ifndef __BACKPORT_LINUX_IO_H
-#define __BACKPORT_LINUX_IO_H
-#include_next <linux/io.h>
-
-/*
- * Some systems (x86 without PAT) have a somewhat reliable way to mark a
- * physical address range such that uncached mappings will actually
- * end up write-combining.  This facility should be used in conjunction
- * with pgprot_writecombine, ioremap-wc, or set_memory_wc, since it has
- * no effect if the per-page mechanisms are functional.
- * (On x86 without PAT, these functions manipulate MTRRs.)
- *
- * arch_phys_del_wc(0) or arch_phys_del_wc(any error code) is guaranteed
- * to have no effect.
- */
-#ifndef arch_phys_wc_add
-
-#define arch_phys_wc_add LINUX_BACKPORT(arch_phys_wc_add)
-#define arch_phys_wc_del LINUX_BACKPORT(arch_phys_wc_del)
-
-#ifdef CONFIG_MTRR
-extern int __must_check arch_phys_wc_add(unsigned long base,
-					 unsigned long size);
-extern void arch_phys_wc_del(int handle);
-#else
-static inline int __must_check arch_phys_wc_add(unsigned long base,
-						unsigned long size)
-{
-	return 0;  /* It worked (i.e. did nothing). */
-}
-
-static inline void arch_phys_wc_del(int handle)
-{
-}
-#endif /* CONFIG_MTRR */
-#endif
-
-#endif /* __BACKPORT_LINUX_IO_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 2d4928c..4485552 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -34,7 +34,6 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_7) += compat-3.7.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_8) += compat-3.8.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_10) += backport-3.10.o
-compat-$(CPTCFG_BACKPORT_KERNEL_3_11) += backport-3.11.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
deleted file mode 100644
index e7b93fc..0000000
--- a/backport/compat/backport-3.11.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.11.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/export.h>
-
-#ifdef CONFIG_MTRR
-
-#include <asm/mtrr.h>
-#include <asm/cpufeature.h>
-#include <linux/io.h>
-#include <linux/printk.h>
-
-/* arch_phys_wc_add returns an MTRR register index plus this offset. */
-#define MTRR_TO_PHYS_WC_OFFSET 1000
-
-/**
- * arch_phys_wc_add - add a WC MTRR and handle errors if PAT is unavailable
- * @base: Physical base address
- * @size: Size of region
- *
- * If PAT is available, this does nothing.  If PAT is unavailable, it
- * attempts to add a WC MTRR covering size bytes starting at base and
- * logs an error if this fails.
- *
- * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
- * but drivers should not try to interpret that return value.
- */
-int backport_arch_phys_wc_add(unsigned long base, unsigned long size)
-{
-	int ret;
-
-#if defined(CONFIG_X86_PAT)
-	if (cpu_has_pat)
-		return 0;
-#endif
-
-	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
-	if (ret < 0) {
-		pr_warn("Failed to add WC MTRR for [%p-%p]; performance may suffer.",
-			(void *)base, (void *)(base + size - 1));
-		return ret;
-	}
-	return ret + MTRR_TO_PHYS_WC_OFFSET;
-}
-EXPORT_SYMBOL_GPL(backport_arch_phys_wc_add);
-
-/*
- * arch_phys_wc_del - undoes arch_phys_wc_add
- * @handle: Return value from arch_phys_wc_add
- *
- * This cleans up after mtrr_add_wc_if_needed.
- *
- * The API guarantees that mtrr_del_wc_if_needed(error code) and
- * mtrr_del_wc_if_needed(0) do nothing.
- */
-void backport_arch_phys_wc_del(int handle)
-{
-	if (handle >= 1) {
-		WARN_ON(handle < MTRR_TO_PHYS_WC_OFFSET);
-		mtrr_del(handle - MTRR_TO_PHYS_WC_OFFSET, 0, 0);
-	}
-}
-EXPORT_SYMBOL_GPL(backport_arch_phys_wc_del);
-
-/*
- * phys_wc_to_mtrr_index - translates arch_phys_wc_add's return value
- * @handle: Return value from arch_phys_wc_add
- *
- * This will turn the return value from arch_phys_wc_add into an mtrr
- * index suitable for debugging.
- *
- * Note: There is no legitimate use for this function, except possibly
- * in printk line.  Alas there is an illegitimate use in some ancient
- * drm ioctls.
- */
-int phys_wc_to_mtrr_index(int handle)
-{
-	if (handle < MTRR_TO_PHYS_WC_OFFSET)
-		return -1;
-	else
-		return handle - MTRR_TO_PHYS_WC_OFFSET;
-}
-EXPORT_SYMBOL_GPL(phys_wc_to_mtrr_index);
-
-#endif /* CONFIG_MTRR */
-- 
1.7.10.4

