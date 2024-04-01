Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C12A1BF
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009033; cv=none; b=Zr+ruYNoPwWQe3eD0pbcUuPJ0aFcE8E/a0JKU6QlOWuP9gybaEOTGFcGKHRCt81ffDmCdmtWTbfSbLO35sxt9iv2DnbaX5SuLVIqtUygTsY/4PTv6cDDeQcrvD/IvbRZjT3RF7b1ROlGb5f/Xgp658dVjnV3rQ3ShKMjTxo+rVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009033; c=relaxed/simple;
	bh=KQFhOrutgfyQ7T98oxQsdZXlbCa/QZehZYRi3+bfHNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RevkL2Tht59psZcXVrTKSrFJGYzpum+GVo6tm4QVLRsSgamnBM73Vkpge4wcFDEyV/FmtoiSB7A0mLEiaiSHke63mJ6YQwcbjiXVA+DttaVRm5uwTRcrzkoI5S+xi6rnHNSk7nfzKAFaeMLGn1jaBoofsS1dTGFWh5aNlOluk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=oiq9xqFc; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="oiq9xqFc"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V7lQW41SXz9sW9;
	Tue,  2 Apr 2024 00:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g6M6uPc+3AZiWSymtAlm+PqmABvAtW1kRqGAaW0HGY=;
	b=oiq9xqFcoypl5z6wwK+N8W3Tjkfl0ewArGM3jp0avPu40JB+NqqCNonq+vv7Sd01KrboZw
	3WrrBu9QvFXwn1dhlh4RSreEZFhuC7x3iHPGNmlxEJnHCb3feLj4Qe1dqnl1htpOsfBmhh
	x1ja5P2Pbn9XXhPFMjVPjBKmQFk3U4DJZY/KNODUA9mYaqtDXw+AL0DlvxnwQykyAHNfti
	x0Fn/1B2P0PuogcYIwZa2QWbY8LUk7oBGXVZi2WlAOMsXMo6xm4/6DhP2Fiz7kY4uFHHSz
	bNEkAGtWd+jB/ae5tauBubxTUYeQ67muWKgT3MVlD8IXBHMMeo0BjgrPQpl42A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] backports: Remove support for kernel smaller than 4.6
Date: Tue,  2 Apr 2024 00:03:06 +0200
Message-ID: <20240401220314.2434455-3-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes all the code which is needed to support kernel 4.5.
---
 .github/workflows/create.yml                |   1 -
 README                                      |   2 +-
 backport/backport-include/crypto/hash.h     |  38 --------
 backport/backport-include/linux/kcov.h      |   2 -
 backport/backport-include/linux/kernel.h    |   9 --
 backport/backport-include/linux/mii.h       |   4 +-
 backport/backport-include/linux/netdevice.h |   2 +-
 backport/backport-include/linux/page_ref.h  |  23 -----
 backport/backport-include/linux/sched.h     |   5 -
 backport/backport-include/linux/string.h    |  10 --
 backport/backport-include/linux/usb/ch9.h   |  12 ---
 backport/compat/Makefile                    |   1 -
 backport/compat/backport-4.10.c             |   2 -
 backport/compat/backport-4.6.c              | 103 --------------------
 backport/compat/backport-5.15.c             |   2 -
 dependencies                                |   6 --
 16 files changed, 4 insertions(+), 218 deletions(-)
 delete mode 100644 backport/backport-include/crypto/hash.h
 delete mode 100644 backport/backport-include/linux/page_ref.h
 delete mode 100644 backport/backport-include/linux/string.h
 delete mode 100644 backport/backport-include/linux/usb/ch9.h
 delete mode 100644 backport/compat/backport-4.6.c

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 2c937b5c..f181da62 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.5",
            "4.6",
            "4.7",
            "4.8",
diff --git a/README b/README
index 92512d5c..31add70f 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.5 and above.
+for kernels 4.6 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/crypto/hash.h b/backport/backport-include/crypto/hash.h
deleted file mode 100644
index 96ae799d..00000000
--- a/backport/backport-include/crypto/hash.h
+++ /dev/null
@@ -1,38 +0,0 @@
-#ifndef _BACKPORT_CRYPTO_HASH_H
-#define _BACKPORT_CRYPTO_HASH_H
-#include_next <crypto/hash.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-#define shash_desc_zero LINUX_BACKPORT(shash_desc_zero)
-static inline void shash_desc_zero(struct shash_desc *desc)
-{
-	memzero_explicit(desc,
-			 sizeof(*desc) + crypto_shash_descsize(desc->tfm));
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-#define ahash_request_zero LINUX_BACKPORT(ahash_request_zero)
-static inline void ahash_request_zero(struct ahash_request *req)
-{
-	memzero_explicit(req, sizeof(*req) +
-			      crypto_ahash_reqsize(crypto_ahash_reqtfm(req)));
-}
-#endif
-
-#ifndef AHASH_REQUEST_ON_STACK
-#define AHASH_REQUEST_ON_STACK(name, ahash) \
-	char __##name##_desc[sizeof(struct ahash_request) + \
-		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-	struct ahash_request *name = (void *)__##name##_desc
-#endif
-
-#ifndef SHASH_DESC_ON_STACK
-#define SHASH_DESC_ON_STACK(shash, ctx)				  \
-	char __##shash##_desc[sizeof(struct shash_desc) +	  \
-		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
-	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
-#endif
-
-#endif /* _BACKPORT_CRYPTO_HASH_H */
diff --git a/backport/backport-include/linux/kcov.h b/backport/backport-include/linux/kcov.h
index 92095e63..2bea9057 100644
--- a/backport/backport-include/linux/kcov.h
+++ b/backport/backport-include/linux/kcov.h
@@ -2,9 +2,7 @@
 #ifndef __BACKPORTS_LINUX_KCOV_H
 #define __BACKPORTS_LINUX_KCOV_H
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,6,0)
 #include_next <linux/kcov.h>
-#endif
 
 #if LINUX_VERSION_IS_LESS(5,5,0)
 #define kcov_remote_stop LINUX_BACKPORT(kcov_remote_stop)
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 23a451b9..ae73f8db 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -3,14 +3,5 @@
 #include_next <linux/kernel.h>
 /* needed to include BUILD_BUG_ON_ZERO on <= 4.12 */
 #include <linux/bug.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-#define kstrtobool LINUX_BACKPORT(kstrtobool)
-int __must_check kstrtobool(const char *s, bool *res);
-#define kstrtobool_from_user LINUX_BACKPORT(kstrtobool_from_user)
-int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
-#endif
 
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
index 06bdc9b8..dcabbcc8 100644
--- a/backport/backport-include/linux/mii.h
+++ b/backport/backport-include/linux/mii.h
@@ -4,11 +4,11 @@
 #include <linux/version.h>
 
 
-#if LINUX_VERSION_IN_RANGE(4,6,0, 4,11,0)
+#if LINUX_VERSION_IS_LESS(4,11,0)
 extern int mii_ethtool_get_link_ksettings(
 	struct mii_if_info *mii, struct ethtool_link_ksettings *cmd);
 extern int mii_ethtool_set_link_ksettings(
 	struct mii_if_info *mii, const struct ethtool_link_ksettings *cmd);
-#endif /* LINUX_VERSION_IN_RANGE(4,6,0, 4,11,0) */
+#endif /* < 4,11,0 */
 
 #endif /* __BACKPORT_LINUX_MII_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f6d53f8a..71961625 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -129,7 +129,7 @@ struct rtnl_link_stats64 *
 bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 #endif /* < 4.11 */
 
-#if LINUX_VERSION_IN_RANGE(4,6,0, 5,15,0)
+#if LINUX_VERSION_IS_LESS(5,15,0)
 #define get_user_ifreq LINUX_BACKPORT(get_user_ifreq)
 int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg);
 #define put_user_ifreq LINUX_BACKPORT(put_user_ifreq)
diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
deleted file mode 100644
index e45734ec..00000000
--- a/backport/backport-include/linux/page_ref.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __BP_PAGE_REF_H
-#define __BP_PAGE_REF_H
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,6,0)
-#include_next <linux/page_ref.h>
-#else
-static inline void page_ref_inc(struct page *page)
-{
-	atomic_inc(&page->_count);
-}
-
-static inline int page_ref_count(struct page *page)
-{
-	return atomic_read(&page->_count);
-}
-
-static inline int page_ref_sub_and_test(struct page *page, int nr)
-{
-	return atomic_sub_and_test(nr, &page->_count);
-}
-#endif
-
-#endif /* __BP_PAGE_REF_H */
diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
index 6a5cf8db..36263857 100644
--- a/backport/backport-include/linux/sched.h
+++ b/backport/backport-include/linux/sched.h
@@ -4,11 +4,6 @@
 #include_next <linux/sched.h>
 #include <linux/version.h>
 
-/* kcov was added in 4.6 and is included since then */
-#if LINUX_VERSION_IS_LESS(4,6,0)
-#include <linux/kcov.h>
-#endif
-
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #if LINUX_VERSION_IS_GEQ(4,11,0)
 #include <uapi/linux/sched/types.h>
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
deleted file mode 100644
index bbb076e0..00000000
--- a/backport/backport-include/linux/string.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_STRING_H
-#define __BACKPORT_LINUX_STRING_H
-#include_next <linux/string.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-int match_string(const char * const *array, size_t n, const char *string);
-#endif /* LINUX_VERSION_IS_LESS(4,5,0) */
-
-#endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
deleted file mode 100644
index d8d9a48b..00000000
--- a/backport/backport-include/linux/usb/ch9.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __BACKPORT__LINUX_USB_CH9_H
-#define __BACKPORT__LINUX_USB_CH9_H
-
-#include <linux/version.h>
-#include_next <linux/usb/ch9.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-#define USB_SPEED_SUPER_PLUS	6
-#endif
-
-#endif /* __BACKPORT__LINUX_USB_CH9_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index dfd72d2d..87238c70 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
index d1d69115..497d51ab 100644
--- a/backport/compat/backport-4.10.c
+++ b/backport/compat/backport-4.10.c
@@ -15,7 +15,6 @@
 #include <linux/page_ref.h>
 #include <linux/gfp.h>
 
-#if LINUX_VERSION_IS_GEQ(4,6,0)
 #if LINUX_VERSION_IS_LESS(4,7,0)
 static bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 						    const unsigned long *src)
@@ -253,7 +252,6 @@ int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 	return 0;
 }
 EXPORT_SYMBOL(mii_ethtool_get_link_ksettings);
-#endif /* LINUX_VERSION_IS_GEQ(4,6,0) */
 
 void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
diff --git a/backport/compat/backport-4.6.c b/backport/compat/backport-4.6.c
deleted file mode 100644
index 8d0ecf56..00000000
--- a/backport/compat/backport-4.6.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Copyright(c) 2016 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.6.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/uaccess.h>
-#include <linux/export.h>
-
-/**
- * kstrtobool - convert common user inputs into boolean values
- * @s: input string
- * @res: result
- *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
- * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
- * pointed to by res is updated upon finding a match.
- */
-int kstrtobool(const char *s, bool *res)
-{
-	if (!s)
-		return -EINVAL;
-
-	switch (s[0]) {
-	case 'y':
-	case 'Y':
-	case '1':
-		*res = true;
-		return 0;
-	case 'n':
-	case 'N':
-	case '0':
-		*res = false;
-		return 0;
-	case 'o':
-	case 'O':
-		switch (s[1]) {
-		case 'n':
-		case 'N':
-			*res = true;
-			return 0;
-		case 'f':
-		case 'F':
-			*res = false;
-			return 0;
-		default:
-			break;
-		}
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(kstrtobool);
-
-/*
- * Since "base" would be a nonsense argument, this open-codes the
- * _from_user helper instead of using the helper macro below.
- */
-int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
-{
-	/* Longest string needed to differentiate, newline, terminator */
-	char buf[4];
-
-	count = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, s, count))
-		return -EFAULT;
-	buf[count] = '\0';
-	return kstrtobool(buf, res);
-}
-EXPORT_SYMBOL_GPL(kstrtobool_from_user);
-
-/**
- * match_string - matches given string in an array
- * @array:	array of strings
- * @n:		number of strings in the array or -1 for NULL terminated arrays
- * @string:	string to match with
- *
- * Return:
- * index of a @string in the @array if matches, or %-EINVAL otherwise.
- */
-int match_string(const char * const *array, size_t n, const char *string)
-{
-	int index;
-	const char *item;
-
-	for (index = 0; index < n; index++) {
-		item = array[index];
-		if (!item)
-			break;
-		if (!strcmp(item, string))
-			return index;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL(match_string);
diff --git a/backport/compat/backport-5.15.c b/backport/compat/backport-5.15.c
index 11aa74f6..bfafaec5 100644
--- a/backport/compat/backport-5.15.c
+++ b/backport/compat/backport-5.15.c
@@ -8,7 +8,6 @@
 
 #include <uapi/linux/if.h>
 
-#if LINUX_VERSION_IS_GEQ(4,6,0)
 
 int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg)
 {
@@ -53,7 +52,6 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg)
 }
 EXPORT_SYMBOL(put_user_ifreq);
 
-#endif /* >= 4.6.0 */
 
 /**
  * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
diff --git a/dependencies b/dependencies
index 3f88c446..e25d08e9 100644
--- a/dependencies
+++ b/dependencies
@@ -11,12 +11,6 @@ ATMEL 4.18
 QTNFMAC 5.1
 QTNFMAC_PCIE 5.1
 
-# needs GPIO stuff we didn't backport
-SSB_DRIVER_GPIO 4.5
-
-# Uses gpiochip_get_data()
-BCMA_DRIVER_GPIO 4.5
-
 # struct ethtool_link_ksettings is missing, I'm lazy
 USB_USBNET 4.6
 USB_NET_RNDIS_WLAN 4.6
-- 
2.44.0

