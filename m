Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737A55C26
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009033; cv=none; b=HhT+oRTQUPibcEV4NI2hzsCBBK0ZJz1EqarEs32owiKedIRAz5hh32XtzKjCUQG0dbOx8PE886D8gAiqlJkTi+fAEizKQ8m2fbSRlgl0hAUlEbBrqUnWWWFdQybl4/B1P5+FnavTPLqU3ENVO2cpzAGKGNR97pMAfjaFLLBha8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009033; c=relaxed/simple;
	bh=fkkay8UJcKcm16jXeqxOSFm7cUss8TN8yFOFlu83C6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl5ld9qgpiX3g+Fx9ummMwFuxs/0S0gmJIC0U/L0Ub2XLLQF//OttPGKyJMRq87/CpbYxPk8EKcj8cfadHx7QKhYT5eZPDODmSOpmPuoDzF/blM+MNdVz2PReF0++FKMEStnNlYXEaldCr6SOQ2WF4cRkpCzhYrhFN7ugol2km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=JWlBd6IQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="JWlBd6IQ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V7lQX1Rr6z9slD;
	Tue,  2 Apr 2024 00:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRKqtgb/PgjfILz6i5hPb3TFZxgyvD1Ss9rNVbsfX0I=;
	b=JWlBd6IQZqC8H0qtsYK53ZwkzQmGCVW9UnJR3DC/jGcLAgqHMmh3J8+0dYypo1DTyLdyeK
	8qII+HjbeWYe0YV+bEvsTHiNBNPMgMD4BQ9R4PvyrZasUbkJVNTS6qpn7Yk82N5RMMuCDb
	OIM+J/B0wj1Hf1XLMlbhlaCW4UtKgb1sfTa49XD10UiwXYYnpcnL7jpxmq4eZYi4H/BYQR
	daK+sDyCv6wAybpPmT7DtznSzDJZvHXUJf3RdBfCneYzZGkhK1yzzQanbLiz/Oj5T14EjP
	gggsEZJfis0yHeqNJhG3FqTs6F4FY0xD+EIrPAI4FIumeieco9+91vG0KuxURQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/10] backports: Remove support for kernel smaller than 4.8
Date: Tue,  2 Apr 2024 00:03:08 +0200
Message-ID: <20240401220314.2434455-5-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQX1Rr6z9slD

This removes all the code which is needed to support kernel 4.7.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml              |   1 -
 README                                    |   2 +-
 backport/backport-include/linux/atomic.h  |  48 ------
 backport/backport-include/linux/debugfs.h |   5 +-
 backport/backport-include/linux/pci.h     |  22 ---
 backport/backport-include/linux/time.h    |   8 -
 backport/backport-include/linux/usb/cdc.h |  61 -------
 backport/compat/Makefile                  |   1 -
 backport/compat/backport-4.8.c            | 196 ----------------------
 9 files changed, 3 insertions(+), 341 deletions(-)
 delete mode 100644 backport/backport-include/linux/usb/cdc.h
 delete mode 100644 backport/compat/backport-4.8.c

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 9d5873b2..3bdbc2a8 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.7",
            "4.8",
            "4.9",
            "4.10",
diff --git a/README b/README
index 46c734d3..e1f40943 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.7 and above.
+for kernels 4.8 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
index 6669831c..18d2df21 100644
--- a/backport/backport-include/linux/atomic.h
+++ b/backport/backport-include/linux/atomic.h
@@ -2,30 +2,6 @@
 #define __BP_ATOMIC_H
 #include_next <linux/atomic.h>
 
-/* atomic_cmpxchg_relaxed */
-#ifndef atomic_cmpxchg_relaxed
-#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
-#define  atomic_cmpxchg_acquire		atomic_cmpxchg
-#define  atomic_cmpxchg_release		atomic_cmpxchg
-
-#else /* atomic_cmpxchg_relaxed */
-
-#ifndef atomic_cmpxchg_acquire
-#define  atomic_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic_cmpxchg_release
-#define  atomic_cmpxchg_release(...)					\
-	__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic_cmpxchg
-#define  atomic_cmpxchg(...)						\
-	__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
-#endif
-#endif /* atomic_cmpxchg_relaxed */
-
 /* these were introduced together, so just a single check is enough */
 #ifndef atomic_try_cmpxchg_acquire
 #ifndef atomic_try_cmpxchg
@@ -68,28 +44,4 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define __atomic_post_full_fence        smp_mb__after_atomic
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,8,0)
-static inline int
-atomic_fetch_add(int i, atomic_t *v)
-{
-	return atomic_add_return(i, v) - i;
-}
-
-static inline int
-atomic_fetch_sub(int i, atomic_t *v)
-{
-	return atomic_sub_return(i, v) + i;
-}
-#endif
-
-#ifndef atomic_fetch_add_relaxed
-#define atomic_fetch_add_relaxed atomic_fetch_add
-#endif
-
-#ifndef atomic_fetch_sub_relaxed
-#define atomic_fetch_sub_acquire atomic_fetch_sub
-#define atomic_fetch_sub_release atomic_fetch_sub
-#define atomic_fetch_sub_relaxed atomic_fetch_sub
-#endif
-
 #endif /* __BP_ATOMIC_H */
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index af401cf5..5c671d2d 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -5,8 +5,7 @@
 #include <linux/device.h>
 
 #if LINUX_VERSION_IS_LESS(4,9,0) && \
-    !LINUX_VERSION_IN_RANGE(4,8,4, 4,9,0) && \
-    !LINUX_VERSION_IN_RANGE(4,7,10, 4,8,0)
+    !LINUX_VERSION_IN_RANGE(4,8,4, 4,9,0)
 static inline const struct file_operations *
 debugfs_real_fops(const struct file *filp)
 {
@@ -16,7 +15,7 @@ debugfs_real_fops(const struct file *filp)
 	 */
 	return filp->f_path.dentry->d_fsdata;
 }
-#endif /* <4.9.0 but not >= 4.8.4, 4.7.10 */
+#endif /* <4.9.0 but not >= 4.8.4 */
 
 #ifndef DEFINE_DEBUGFS_ATTRIBUTE
 #define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt) \
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 75eb2359..2a5309d9 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -7,28 +7,6 @@
 #include <linux/pci-aspm.h>
 #endif
 
-
-
-#if LINUX_VERSION_IS_LESS(4,8,0)
-#define pci_alloc_irq_vectors LINUX_BACKPORT(pci_alloc_irq_vectors)
-#ifdef CONFIG_PCI_MSI
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags);
-#else
-static inline int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags)
-{ return -ENOSYS; }
-#endif
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,8,0)
-#define pci_free_irq_vectors LINUX_BACKPORT(pci_free_irq_vectors)
-static inline void pci_free_irq_vectors(struct pci_dev *dev)
-{
-}
-#endif
-
-
 #if LINUX_VERSION_IS_LESS(4,9,0) &&			\
 	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
 
diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index 712881db..1678c91a 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -4,14 +4,6 @@
 
 #include <linux/time64.h>
 
-#if LINUX_VERSION_IS_LESS(4,8,0)
-static inline void time64_to_tm(time64_t totalsecs, int offset,
-				struct tm *result)
-{
-	time_to_tm((time_t)totalsecs, 0, result);
-}
-#endif
-
 #ifndef time_after32
 /**
  * time_after32 - compare two 32-bit relative times
diff --git a/backport/backport-include/linux/usb/cdc.h b/backport/backport-include/linux/usb/cdc.h
deleted file mode 100644
index 5ad31bf1..00000000
--- a/backport/backport-include/linux/usb/cdc.h
+++ /dev/null
@@ -1,61 +0,0 @@
-#ifndef __BP_USB_CDC_H
-#define __BP_USB_CDC_H
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(4,8,0)
-#include_next <linux/usb/cdc.h>
-#else
-#include <uapi/linux/usb/cdc.h>
-
-/*
- * inofficial magic numbers
- */
-
-#define CDC_PHONET_MAGIC_NUMBER		0xAB
-
-#ifndef USB_CDC_MBIM_EXTENDED_TYPE
-#define USB_CDC_MBIM_EXTENDED_TYPE 0x1c
-
-/* "MBIM Extended Functional Descriptor" from CDC MBIM spec 1.0 errata-1 */
-struct usb_cdc_mbim_extended_desc {
-	__u8	bLength;
-	__u8	bDescriptorType;
-	__u8	bDescriptorSubType;
-
-	__le16	bcdMBIMExtendedVersion;
-	__u8	bMaxOutstandingCommandMessages;
-	__le16	wMTU;
-} __attribute__ ((packed));
-#endif
-
-/*
- * parsing CDC headers
- */
-
-struct usb_cdc_parsed_header {
-	struct usb_cdc_union_desc *usb_cdc_union_desc;
-	struct usb_cdc_header_desc *usb_cdc_header_desc;
-
-	struct usb_cdc_call_mgmt_descriptor *usb_cdc_call_mgmt_descriptor;
-	struct usb_cdc_acm_descriptor *usb_cdc_acm_descriptor;
-	struct usb_cdc_country_functional_desc *usb_cdc_country_functional_desc;
-	struct usb_cdc_network_terminal_desc *usb_cdc_network_terminal_desc;
-	struct usb_cdc_ether_desc *usb_cdc_ether_desc;
-	struct usb_cdc_dmm_desc *usb_cdc_dmm_desc;
-	struct usb_cdc_mdlm_desc *usb_cdc_mdlm_desc;
-	struct usb_cdc_mdlm_detail_desc *usb_cdc_mdlm_detail_desc;
-	struct usb_cdc_obex_desc *usb_cdc_obex_desc;
-	struct usb_cdc_ncm_desc *usb_cdc_ncm_desc;
-	struct usb_cdc_mbim_desc *usb_cdc_mbim_desc;
-	struct usb_cdc_mbim_extended_desc *usb_cdc_mbim_extended_desc;
-
-	bool phonet_magic_present;
-};
-
-#define cdc_parse_cdc_header LINUX_BACKPORT(cdc_parse_cdc_header)
-int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
-			 struct usb_interface *intf,
-			 u8 *buffer, int buflen);
-#endif
-
-#endif /* __BP_USB_CDC_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index e5ec7092..7bc66fb1 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_11) += backport-4.11.o
 compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-4.8.c
deleted file mode 100644
index 11b2e7d7..00000000
--- a/backport/compat/backport-4.8.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Deutschland GmbH
- *
- * Backport functionality introduced in Linux 4.8.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/usb.h>
-#include <linux/usb/cdc.h>
-#include <linux/pci.h>
-
-int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
-			 struct usb_interface *intf,
-			 u8 *buffer, int buflen)
-{
-	/* duplicates are ignored */
-	struct usb_cdc_union_desc *union_header = NULL;
-
-	/* duplicates are not tolerated */
-	struct usb_cdc_header_desc *header = NULL;
-	struct usb_cdc_ether_desc *ether = NULL;
-	struct usb_cdc_mdlm_detail_desc *detail = NULL;
-	struct usb_cdc_mdlm_desc *desc = NULL;
-
-	unsigned int elength;
-	int cnt = 0;
-
-	memset(hdr, 0x00, sizeof(struct usb_cdc_parsed_header));
-	hdr->phonet_magic_present = false;
-	while (buflen > 0) {
-		elength = buffer[0];
-		if (!elength) {
-			dev_err(&intf->dev, "skipping garbage byte\n");
-			elength = 1;
-			goto next_desc;
-		}
-		if (buffer[1] != USB_DT_CS_INTERFACE) {
-			dev_err(&intf->dev, "skipping garbage\n");
-			goto next_desc;
-		}
-
-		switch (buffer[2]) {
-		case USB_CDC_UNION_TYPE: /* we've found it */
-			if (elength < sizeof(struct usb_cdc_union_desc))
-				goto next_desc;
-			if (union_header) {
-				dev_err(&intf->dev, "More than one union descriptor, skipping ...\n");
-				goto next_desc;
-			}
-			union_header = (struct usb_cdc_union_desc *)buffer;
-			break;
-		case USB_CDC_COUNTRY_TYPE:
-			if (elength < sizeof(struct usb_cdc_country_functional_desc))
-				goto next_desc;
-			hdr->usb_cdc_country_functional_desc =
-				(struct usb_cdc_country_functional_desc *)buffer;
-			break;
-		case USB_CDC_HEADER_TYPE:
-			if (elength != sizeof(struct usb_cdc_header_desc))
-				goto next_desc;
-			if (header)
-				return -EINVAL;
-			header = (struct usb_cdc_header_desc *)buffer;
-			break;
-		case USB_CDC_ACM_TYPE:
-			if (elength < sizeof(struct usb_cdc_acm_descriptor))
-				goto next_desc;
-			hdr->usb_cdc_acm_descriptor =
-				(struct usb_cdc_acm_descriptor *)buffer;
-			break;
-		case USB_CDC_ETHERNET_TYPE:
-			if (elength != sizeof(struct usb_cdc_ether_desc))
-				goto next_desc;
-			if (ether)
-				return -EINVAL;
-			ether = (struct usb_cdc_ether_desc *)buffer;
-			break;
-		case USB_CDC_CALL_MANAGEMENT_TYPE:
-			if (elength < sizeof(struct usb_cdc_call_mgmt_descriptor))
-				goto next_desc;
-			hdr->usb_cdc_call_mgmt_descriptor =
-				(struct usb_cdc_call_mgmt_descriptor *)buffer;
-			break;
-		case USB_CDC_DMM_TYPE:
-			if (elength < sizeof(struct usb_cdc_dmm_desc))
-				goto next_desc;
-			hdr->usb_cdc_dmm_desc =
-				(struct usb_cdc_dmm_desc *)buffer;
-			break;
-		case USB_CDC_MDLM_TYPE:
-			if (elength < sizeof(struct usb_cdc_mdlm_desc *))
-				goto next_desc;
-			if (desc)
-				return -EINVAL;
-			desc = (struct usb_cdc_mdlm_desc *)buffer;
-			break;
-		case USB_CDC_MDLM_DETAIL_TYPE:
-			if (elength < sizeof(struct usb_cdc_mdlm_detail_desc *))
-				goto next_desc;
-			if (detail)
-				return -EINVAL;
-			detail = (struct usb_cdc_mdlm_detail_desc *)buffer;
-			break;
-		case USB_CDC_NCM_TYPE:
-			if (elength < sizeof(struct usb_cdc_ncm_desc))
-				goto next_desc;
-			hdr->usb_cdc_ncm_desc = (struct usb_cdc_ncm_desc *)buffer;
-			break;
-		case USB_CDC_MBIM_TYPE:
-			if (elength < sizeof(struct usb_cdc_mbim_desc))
-				goto next_desc;
-
-			hdr->usb_cdc_mbim_desc = (struct usb_cdc_mbim_desc *)buffer;
-			break;
-		case USB_CDC_MBIM_EXTENDED_TYPE:
-			if (elength < sizeof(struct usb_cdc_mbim_extended_desc))
-				break;
-			hdr->usb_cdc_mbim_extended_desc =
-				(struct usb_cdc_mbim_extended_desc *)buffer;
-			break;
-		case CDC_PHONET_MAGIC_NUMBER:
-			hdr->phonet_magic_present = true;
-			break;
-		default:
-			/*
-			 * there are LOTS more CDC descriptors that
-			 * could legitimately be found here.
-			 */
-			dev_dbg(&intf->dev, "Ignoring descriptor: type %02x, length %ud\n",
-					buffer[2], elength);
-			goto next_desc;
-		}
-		cnt++;
-next_desc:
-		buflen -= elength;
-		buffer += elength;
-	}
-	hdr->usb_cdc_union_desc = union_header;
-	hdr->usb_cdc_header_desc = header;
-	hdr->usb_cdc_mdlm_detail_desc = detail;
-	hdr->usb_cdc_mdlm_desc = desc;
-	hdr->usb_cdc_ether_desc = ether;
-	return cnt;
-}
-EXPORT_SYMBOL_GPL(cdc_parse_cdc_header);
-
-#ifdef CONFIG_PCI
-#ifdef CONFIG_PCI_MSI
-
-/**
- * pci_alloc_irq_vectors - allocate multiple IRQs for a device
- * @dev:		PCI device to operate on
- * @min_vecs:		minimum number of vectors required (must be >= 1)
- * @max_vecs:		maximum (desired) number of vectors
- * @flags:		flags or quirks for the allocation
- *
- * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
- * vectors if available, and fall back to a single legacy vector
- * if neither is available.  Return the number of vectors allocated,
- * (which might be smaller than @max_vecs) if successful, or a negative
- * error code on error. If less than @min_vecs interrupt vectors are
- * available for @dev the function will fail with -ENOSPC.
- *
- * To get the Linux IRQ number used for a vector that can be passed to
- * request_irq() use the pci_irq_vector() helper.
- */
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags)
-{
-	int vecs = -ENOSPC;
-
-	if (flags & PCI_IRQ_MSIX) {
-		vecs = pci_enable_msix_range(dev, NULL, min_vecs, max_vecs);
-		if (vecs > 0)
-			return vecs;
-	}
-
-	if (flags & PCI_IRQ_MSI) {
-		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
-		if (vecs > 0)
-			return vecs;
-	}
-
-	/* use legacy irq if allowed */
-	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
-		pci_intx(dev, 1);
-		return 1;
-	}
-
-	return vecs;
-}
-EXPORT_SYMBOL_GPL(pci_alloc_irq_vectors);
-#endif /* CONFIG_PCI_MSI */
-#endif /* CONFIG_PCI */
-- 
2.44.0

