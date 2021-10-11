Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7330C433EF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E360EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhJKWZL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhJKWZD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5BC061570
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:02 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HStbS1964zQk3d;
        Tue, 12 Oct 2021 00:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ES0iBMAAt6O/C6h5uKUfQRwt+JTYgOUKLCMz94toedY=;
        b=lyAJsRThUN72VcKbmDDj3atuzTqxS1DtuKzT4322908gp1Q+DiZyIt3HmF0mq1jJkt6hUT
        ZsLXMtzF3ANGODuCi7EHEoUGd6UBAuZCefOrtRmehHVSx2s1EVVDhMnoFTtGXrHtGAW1wC
        wUhG8z9CmdTeNz9GJ9tiJ4fpWZKqdQ+nEHAOXODMR1oUGUrNUEoemW7GKmUXY9SUyk2Hyv
        RRtLsBQfkqcB4Ypz8TbGrDq8tao6Hlp4oyR26Xo4tfZsYjBwVIcngSrZu50S5qMQCyDh5W
        BaN+Wov89DTyKBw4kWw7Y57G63vrEQGWM6XwHBKn4VwZCsr/RO581YoMY7OVKw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/14] backports: Remove support for kernel smaller than 4.3
Date:   Tue, 12 Oct 2021 00:22:26 +0200
Message-Id: <20211011222227.1189850-14-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1295718BB
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the code which is needed to support kernel 4.2.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                        |   2 +-
 .../backport-include/linux/compiler-gcc5.h    |   1 -
 .../backport-include/linux/compiler-gcc6.h    |   1 -
 .../backport-include/linux/compiler-gcc7.h    |   1 -
 .../backport-include/linux/compiler-gcc8.h    |   1 -
 .../backport-include/linux/compiler-gcc9.h    |   1 -
 .../backport-include/linux/compiler-gccN.h    | 126 --------
 backport/backport-include/linux/mei_cl_bus.h  |   5 +-
 .../backport-include/linux/mmc/sdio_func.h    |  12 -
 backport/backport-include/linux/of_platform.h |  19 --
 backport/backport-include/linux/phy.h         |   5 -
 backport/backport-include/linux/property.h    |  13 -
 backport/backport-include/linux/seq_file.h    |   6 -
 backport/backport-include/linux/string.h      |   4 -
 backport/backport-include/linux/thermal.h     |  74 -----
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.3.c                | 294 ------------------
 backport/compat/backport-4.4.c                |  36 ---
 patches/0062-iff-no-queue.cocci               |   9 -
 patches/0070-mac80211-fils.patch              |  54 ----
 20 files changed, 2 insertions(+), 663 deletions(-)
 delete mode 100644 backport/backport-include/linux/compiler-gcc5.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc6.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc7.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc8.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc9.h
 delete mode 100644 backport/backport-include/linux/compiler-gccN.h
 delete mode 100644 backport/backport-include/linux/of_platform.h
 delete mode 100644 backport/backport-include/linux/property.h
 delete mode 100644 backport/compat/backport-4.3.c
 delete mode 100644 patches/0062-iff-no-queue.cocci
 delete mode 100644 patches/0070-mac80211-fils.patch

diff --git a/README b/README
index 01961249..acc0d7cd 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.2 and above.
+for kernels 4.3 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/compiler-gcc5.h b/backport/backport-include/linux/compiler-gcc5.h
deleted file mode 100644
index 9ff99f0d..00000000
--- a/backport/backport-include/linux/compiler-gcc5.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/compiler-gccN.h>
diff --git a/backport/backport-include/linux/compiler-gcc6.h b/backport/backport-include/linux/compiler-gcc6.h
deleted file mode 100644
index 9ff99f0d..00000000
--- a/backport/backport-include/linux/compiler-gcc6.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/compiler-gccN.h>
diff --git a/backport/backport-include/linux/compiler-gcc7.h b/backport/backport-include/linux/compiler-gcc7.h
deleted file mode 100644
index 9ff99f0d..00000000
--- a/backport/backport-include/linux/compiler-gcc7.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/compiler-gccN.h>
diff --git a/backport/backport-include/linux/compiler-gcc8.h b/backport/backport-include/linux/compiler-gcc8.h
deleted file mode 100644
index 9ff99f0d..00000000
--- a/backport/backport-include/linux/compiler-gcc8.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/compiler-gccN.h>
diff --git a/backport/backport-include/linux/compiler-gcc9.h b/backport/backport-include/linux/compiler-gcc9.h
deleted file mode 100644
index 9ff99f0d..00000000
--- a/backport/backport-include/linux/compiler-gcc9.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/compiler-gccN.h>
diff --git a/backport/backport-include/linux/compiler-gccN.h b/backport/backport-include/linux/compiler-gccN.h
deleted file mode 100644
index 97e7541d..00000000
--- a/backport/backport-include/linux/compiler-gccN.h
+++ /dev/null
@@ -1,126 +0,0 @@
-/* gcc version specific checks */
-
-#ifndef GCC_VERSION
-#define GCC_VERSION (__GNUC__ * 10000           \
-                     + __GNUC_MINOR__ * 100     \
-                     + __GNUC_PATCHLEVEL__)
-#endif
-
-#if GCC_VERSION < 30200
-# error Sorry, your compiler is too old - please upgrade it.
-#endif
-
-#if GCC_VERSION < 30300
-# define __used			__attribute__((__unused__))
-#else
-# define __used			__attribute__((__used__))
-#endif
-
-#ifdef CONFIG_GCOV_KERNEL
-# if GCC_VERSION < 30400
-#   error "GCOV profiling support for gcc versions below 3.4 not included"
-# endif /* __GNUC_MINOR__ */
-#endif /* CONFIG_GCOV_KERNEL */
-
-#if GCC_VERSION >= 30400
-#define __must_check		__attribute__((warn_unused_result))
-#endif
-
-#if GCC_VERSION >= 40000
-
-/* GCC 4.1.[01] miscompiles __weak */
-#ifdef __KERNEL__
-# if GCC_VERSION >= 40100 &&  GCC_VERSION <= 40101
-#  error Your version of gcc miscompiles the __weak directive
-# endif
-#endif
-
-#define __used			__attribute__((__used__))
-#define __compiler_offsetof(a, b)					\
-	__builtin_offsetof(a, b)
-
-#if GCC_VERSION >= 40100 && GCC_VERSION < 40600
-# define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-#endif
-
-#if GCC_VERSION >= 40300
-/* Mark functions as cold. gcc will assume any path leading to a call
- * to them will be unlikely.  This means a lot of manual unlikely()s
- * are unnecessary now for any paths leading to the usual suspects
- * like BUG(), printk(), panic() etc. [but let's keep them for now for
- * older compilers]
- *
- * Early snapshots of gcc 4.3 don't support this and we can't detect this
- * in the preprocessor, but we can live with this because they're unreleased.
- * Maketime probing would be overkill here.
- *
- * gcc also has a __attribute__((__hot__)) to move hot functions into
- * a special section, but I don't see any sense in this right now in
- * the kernel context
- */
-#define __cold			__attribute__((__cold__))
-
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
-#ifndef __CHECKER__
-# define __compiletime_warning(message) __attribute__((warning(message)))
-# define __compiletime_error(message) __attribute__((error(message)))
-#endif /* __CHECKER__ */
-#endif /* GCC_VERSION >= 40300 */
-
-#if GCC_VERSION >= 40500
-/*
- * Mark a position in code as unreachable.  This can be used to
- * suppress control flow warnings after asm blocks that transfer
- * control elsewhere.
- *
- * Early snapshots of gcc 4.5 don't support this and we can't detect
- * this in the preprocessor, but we can live with this because they're
- * unreleased.  Really, we need to have autoconf for the kernel.
- */
-#define unreachable() __builtin_unreachable()
-
-/* Mark a function definition as prohibited from being cloned. */
-#define __noclone	__attribute__((__noclone__))
-
-#endif /* GCC_VERSION >= 40500 */
-
-#if GCC_VERSION >= 40600
-/*
- * Tell the optimizer that something else uses this function or variable.
- */
-#define __visible	__attribute__((externally_visible))
-#endif
-
-/*
- * GCC 'asm goto' miscompiles certain code sequences:
- *
- *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
- *
- * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
- *
- * (asm goto is automatically volatile - the naming reflects this.)
- */
-#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
-
-#ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
-#if GCC_VERSION >= 40400
-#define __HAVE_BUILTIN_BSWAP32__
-#define __HAVE_BUILTIN_BSWAP64__
-#endif
-#if GCC_VERSION >= 40800 || (defined(__powerpc__) && GCC_VERSION >= 40600)
-#define __HAVE_BUILTIN_BSWAP16__
-#endif
-#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
-
-#if GCC_VERSION >= 50000
-#define KASAN_ABI_VERSION 4
-#elif GCC_VERSION >= 40902
-#define KASAN_ABI_VERSION 3
-#endif
-
-#endif	/* gcc version >= 40000 specific checks */
-
-#ifndef OPTIMIZER_HIDE_VAR
-#define OPTIMIZER_HIDE_VAR(var) __asm__ ("" : "=r" (var) : "0" (var))
-#endif
diff --git a/backport/backport-include/linux/mei_cl_bus.h b/backport/backport-include/linux/mei_cl_bus.h
index c0e522f6..d6ef77e1 100644
--- a/backport/backport-include/linux/mei_cl_bus.h
+++ b/backport/backport-include/linux/mei_cl_bus.h
@@ -2,10 +2,7 @@
 #define __BACKPORT_LINUX_MEI_CL_BUS_H
 #include_next <linux/mei_cl_bus.h>
 
-#if LINUX_VERSION_IS_LESS(4,3,0)
-#define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
-	mei_cl_register_event_cb(cldev, read_cb, context)
-#elif LINUX_VERSION_IS_LESS(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 #define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
 	mei_cl_register_event_cb(cldev, event_mask, read_cb, context)
 #endif
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index 7ff926ae..f56b2aaa 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -32,11 +32,6 @@
  *	This function should be called while the host is claimed.
  */
 #define sdio_retune_hold_now LINUX_BACKPORT(sdio_retune_hold_now)
-#if LINUX_VERSION_IS_LESS(4,3,0)
-static inline void sdio_retune_hold_now(struct sdio_func *func)
-{
-}
-#else
 static inline void sdio_retune_hold_now(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
@@ -44,7 +39,6 @@ static inline void sdio_retune_hold_now(struct sdio_func *func)
 	host->retune_now = 0;
 	host->hold_retune += 1;
 }
-#endif /* < 4.3 */
 
 /**
  *	sdio_retune_release - signal that it's OK to retune now
@@ -57,11 +51,6 @@ static inline void sdio_retune_hold_now(struct sdio_func *func)
  *	This function should be called while the host is claimed.
  */
 #define sdio_retune_release LINUX_BACKPORT(sdio_retune_release)
-#if LINUX_VERSION_IS_LESS(4,3,0)
-static inline void sdio_retune_release(struct sdio_func *func)
-{
-}
-#else
 static inline void sdio_retune_release(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
@@ -71,7 +60,6 @@ static inline void sdio_retune_release(struct sdio_func *func)
 	else
 		WARN_ON(1);
 }
-#endif
 
 #define sdio_retune_crc_disable LINUX_BACKPORT(sdio_retune_crc_disable)
 static inline void sdio_retune_crc_disable(struct sdio_func *func)
diff --git a/backport/backport-include/linux/of_platform.h b/backport/backport-include/linux/of_platform.h
deleted file mode 100644
index 8e522e24..00000000
--- a/backport/backport-include/linux/of_platform.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __BACKPORT_LINUX_OF_PLATFORM_H
-#define __BACKPORT_LINUX_OF_PLATFORM_H
-#include_next <linux/of_platform.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,3,0) && !defined(CONFIG_OF_DEVICE)
-struct of_dev_auxdata;
-#define of_platform_default_populate \
-	LINUX_BACKPORT(of_platform_default_populate)
-static inline int
-of_platform_default_populate(struct device_node *root,
-			     const struct of_dev_auxdata *lookup,
-			     struct device *parent)
-{
-	return -ENODEV;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
-
-#endif /* __BACKPORT_LINUX_OF_PLATFORM_H */
diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 8ffdbc8e..4d6f37e8 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -33,12 +33,7 @@ static inline int backport_mdiobus_register(struct mii_bus *bus)
 
 	memset(bus->irq, PHY_POLL, sizeof(int) * PHY_MAX_ADDR);
 
-/* in kernel 4.3 a #define for mdiobus_register is added to the kernel. */
-#ifndef mdiobus_register
-	return mdiobus_register(bus);
-#else
 	return __mdiobus_register(bus, THIS_MODULE);
-#endif
 }
 #ifdef mdiobus_register
 #undef mdiobus_register
diff --git a/backport/backport-include/linux/property.h b/backport/backport-include/linux/property.h
deleted file mode 100644
index 7f3c6fe6..00000000
--- a/backport/backport-include/linux/property.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __BACKPORT_LINUX_PROPERTY_H_
-#define __BACKPORT_LINUX_PROPERTY_H_
-#include <linux/version.h>
-#include_next <linux/property.h>
-
-#if LINUX_VERSION_IS_LESS(4,3,0)
-
-#define device_get_mac_address LINUX_BACKPORT(device_get_mac_address)
-void *device_get_mac_address(struct device *dev, char *addr, int alen);
-
-#endif /* < 4.3 */
-
-#endif /* __BACKPORT_LINUX_PROPERTY_H_ */
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 08c68ed7..e0f055e3 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -3,12 +3,6 @@
 #include_next <linux/seq_file.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,3,0)
-#define seq_hex_dump LINUX_BACKPORT(seq_hex_dump)
-void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
-		  int rowsize, int groupsize, const void *buf, size_t len,
-		  bool ascii);
-#endif
 
 #ifndef DEFINE_SHOW_ATTRIBUTE
 #define DEFINE_SHOW_ATTRIBUTE(__name)					\
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 9a6b420e..39257e5f 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,10 +8,6 @@
 extern void *memdup_user_nul(const void __user *, size_t);
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,3,0)
-ssize_t strscpy(char *dest, const char *src, size_t count);
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,6,0)
 int match_string(const char * const *array, size_t n, const char *string);
 #endif /* LINUX_VERSION_IS_LESS(4,5,0) */
diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 68b78eab..d9b8153e 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,80 +3,6 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
-#ifdef CONFIG_THERMAL
-
-#if LINUX_VERSION_IS_LESS(4,3,0)
-
-typedef struct thermal_zone_device_ops old_thermal_zone_device_ops_t;
-
-/* also add a way to call the old register and unregister functions */
-static inline struct thermal_zone_device *old_thermal_zone_device_register(
-	const char *type, int trips, int mask, void *devdata,
-	old_thermal_zone_device_ops_t *_ops,
-	const struct thermal_zone_params *_tzp,
-	int passive_delay, int polling_delay)
-{
-	struct thermal_zone_device_ops *ops =
-		(struct thermal_zone_device_ops *) _ops;
-
-	/* cast the const away */
-	struct thermal_zone_params *tzp =
-		(struct thermal_zone_params *)_tzp;
-
-	return thermal_zone_device_register(type, trips, mask, devdata,
-					    ops, tzp, passive_delay,
-					    polling_delay);
-}
-
-static inline
-void old_thermal_zone_device_unregister(struct thermal_zone_device *dev)
-{
-	thermal_zone_device_unregister(dev);
-}
-
-struct backport_thermal_zone_device_ops {
-	int (*bind) (struct thermal_zone_device *,
-		     struct thermal_cooling_device *);
-	int (*unbind) (struct thermal_zone_device *,
-		       struct thermal_cooling_device *);
-	int (*get_temp) (struct thermal_zone_device *, int *);
-	int (*get_mode) (struct thermal_zone_device *,
-			 enum thermal_device_mode *);
-	int (*set_mode) (struct thermal_zone_device *,
-		enum thermal_device_mode);
-	int (*get_trip_type) (struct thermal_zone_device *, int,
-		enum thermal_trip_type *);
-	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
-	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
-	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
-	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
-	int (*get_crit_temp) (struct thermal_zone_device *, int *);
-	int (*set_emul_temp) (struct thermal_zone_device *, int);
-	int (*get_trend) (struct thermal_zone_device *, int,
-			  enum thermal_trend *);
-	int (*notify) (struct thermal_zone_device *, int,
-		       enum thermal_trip_type);
-};
-#define thermal_zone_device_ops LINUX_BACKPORT(thermal_zone_device_ops)
-
-#undef thermal_zone_device_register
-struct thermal_zone_device *backport_thermal_zone_device_register(
-	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
-	const struct thermal_zone_params *tzp,
-	int passive_delay, int polling_delay);
-
-#define thermal_zone_device_register \
-	LINUX_BACKPORT(thermal_zone_device_register)
-
-#undef thermal_zone_device_unregister
-void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
-#define thermal_zone_device_unregister			\
-	LINUX_BACKPORT(thermal_zone_device_unregister)
-
-#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
-#endif /* CONFIG_THERMAL */
-
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 45edb8da..bdb478bb 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
deleted file mode 100644
index 12cc6cf7..00000000
--- a/backport/compat/backport-4.3.c
+++ /dev/null
@@ -1,294 +0,0 @@
-/*
- * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (c) 2015 - 2016 Intel Deutschland GmbH
- *
- * Backport functionality introduced in Linux 4.3.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/version.h>
-#include <linux/seq_file.h>
-#include <linux/export.h>
-#include <linux/printk.h>
-#include <linux/thermal.h>
-#include <linux/slab.h>
-#include <linux/property.h>
-#include <linux/etherdevice.h>
-#include <linux/of.h>
-
-#ifdef CONFIG_THERMAL
-struct backport_thermal_ops_wrapper {
-	old_thermal_zone_device_ops_t ops;
-	struct thermal_zone_device_ops *driver_ops;
-};
-
-static int backport_thermal_get_temp(struct thermal_zone_device *dev,
-				     unsigned long *temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-	int _temp, ret;
-
-	ret = wrapper->driver_ops->get_temp(dev, &_temp);
-	if (!ret)
-		*temp = (unsigned long)_temp;
-
-	return ret;
-}
-
-static int backport_thermal_get_trip_temp(struct thermal_zone_device *dev,
-					  int i, unsigned long *temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-	int _temp, ret;
-
-	ret = wrapper->driver_ops->get_trip_temp(dev, i,  &_temp);
-	if (!ret)
-		*temp = (unsigned long)_temp;
-
-	return ret;
-}
-
-static int backport_thermal_set_trip_temp(struct thermal_zone_device *dev,
-					  int i, unsigned long temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-
-	return wrapper->driver_ops->set_trip_temp(dev, i, (int)temp);
-}
-
-static int backport_thermal_get_trip_hyst(struct thermal_zone_device *dev,
-					  int i, unsigned long *temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-	int _temp, ret;
-
-	ret = wrapper->driver_ops->get_trip_hyst(dev, i, &_temp);
-	if (!ret)
-		*temp = (unsigned long)_temp;
-
-	return ret;
-}
-
-static int backport_thermal_set_trip_hyst(struct thermal_zone_device *dev,
-					  int i, unsigned long temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-
-	return wrapper->driver_ops->set_trip_hyst(dev, i, (int)temp);
-}
-
-static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
-					  unsigned long *temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-	int _temp, ret;
-
-	ret = wrapper->driver_ops->get_crit_temp(dev, &_temp);
-	if (!ret)
-		*temp = (unsigned long)_temp;
-
-	return ret;
-}
-
-static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
-					  unsigned long temp)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-
-	return wrapper->driver_ops->set_emul_temp(dev, (int)temp);
-}
-
-struct thermal_zone_device *backport_thermal_zone_device_register(
-	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
-	const struct thermal_zone_params *tzp,
-	int passive_delay, int polling_delay)
-{
-	struct backport_thermal_ops_wrapper *wrapper = kzalloc(sizeof(*wrapper), GFP_KERNEL);
-	struct thermal_zone_device *ret;
-
-	if (!wrapper)
-		return NULL;
-
-	wrapper->driver_ops = ops;
-
-#define copy(_op)		\
-	wrapper->ops._op = ops->_op
-
-	copy(bind);
-	copy(unbind);
-	copy(get_mode);
-	copy(set_mode);
-	copy(get_trip_type);
-	copy(get_trend);
-	copy(notify);
-
-	/* Assign the backport ops to the old struct to get the
-	 * correct types.  But only assign if the registrant defined
-	 * the ops.
-	 */
-#define assign_ops(_op)		\
-	if (ops->_op)		\
-		wrapper->ops._op = backport_thermal_##_op
-
-	assign_ops(get_temp);
-	assign_ops(get_trip_temp);
-	assign_ops(set_trip_temp);
-	assign_ops(get_trip_hyst);
-	assign_ops(set_trip_hyst);
-	assign_ops(get_crit_temp);
-	assign_ops(set_emul_temp);
-#undef assign_ops
-
-	ret = old_thermal_zone_device_register(type, trips, mask, devdata,
-					       &wrapper->ops, tzp, passive_delay,
-					       polling_delay);
-	if (!ret)
-		kfree(wrapper);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(backport_thermal_zone_device_register);
-
-void backport_thermal_zone_device_unregister(struct thermal_zone_device *dev)
-{
-	struct backport_thermal_ops_wrapper *wrapper =
-		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
-
-	old_thermal_zone_device_unregister(dev);
-	kfree(wrapper);
-}
-EXPORT_SYMBOL_GPL(backport_thermal_zone_device_unregister);
-
-#endif /* CONFIG_THERMAL */
-
-static void seq_set_overflow(struct seq_file *m)
-{
-	m->count = m->size;
-}
-
-/* A complete analogue of print_hex_dump() */
-void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
-		  int rowsize, int groupsize, const void *buf, size_t len,
-		  bool ascii)
-{
-	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
-	int ret;
-
-	if (rowsize != 16 && rowsize != 32)
-		rowsize = 16;
-
-	for (i = 0; i < len && !seq_has_overflowed(m); i += rowsize) {
-		linelen = min(remaining, rowsize);
-		remaining -= rowsize;
-
-		switch (prefix_type) {
-		case DUMP_PREFIX_ADDRESS:
-			seq_printf(m, "%s%p: ", prefix_str, ptr + i);
-			break;
-		case DUMP_PREFIX_OFFSET:
-			seq_printf(m, "%s%.8x: ", prefix_str, i);
-			break;
-		default:
-			seq_printf(m, "%s", prefix_str);
-			break;
-		}
-
-		ret = hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-					 m->buf + m->count, m->size - m->count,
-					 ascii);
-		if (ret >= m->size - m->count) {
-			seq_set_overflow(m);
-		} else {
-			m->count += ret;
-			seq_putc(m, '\n');
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(seq_hex_dump);
-
-ssize_t strscpy(char *dest, const char *src, size_t count)
-{
-	long res = 0;
-
-	if (count == 0)
-		return -E2BIG;
-
-	while (count) {
-		char c;
-
-		c = src[res];
-		dest[res] = c;
-		if (!c)
-			return res;
-		res++;
-		count--;
-	}
-
-	/* Hit buffer length without finding a NUL; force NUL-termination. */
-	if (res)
-		dest[res-1] = '\0';
-
-	return -E2BIG;
-}
-EXPORT_SYMBOL_GPL(strscpy);
-
-static void *device_get_mac_addr(struct device *dev,
-				 const char *name, char *addr,
-				 int alen)
-{
-	int ret = device_property_read_u8_array(dev, name, addr, alen);
-
-	if (ret == 0 && alen == ETH_ALEN && is_valid_ether_addr(addr))
-		return addr;
-	return NULL;
-}
-
-/**
- * device_get_mac_address - Get the MAC for a given device
- * @dev:	Pointer to the device
- * @addr:	Address of buffer to store the MAC in
- * @alen:	Length of the buffer pointed to by addr, should be ETH_ALEN
- *
- * Search the firmware node for the best MAC address to use.  'mac-address' is
- * checked first, because that is supposed to contain to "most recent" MAC
- * address. If that isn't set, then 'local-mac-address' is checked next,
- * because that is the default address.  If that isn't set, then the obsolete
- * 'address' is checked, just in case we're using an old device tree.
- *
- * Note that the 'address' property is supposed to contain a virtual address of
- * the register set, but some DTS files have redefined that property to be the
- * MAC address.
- *
- * All-zero MAC addresses are rejected, because those could be properties that
- * exist in the firmware tables, but were not updated by the firmware.  For
- * example, the DTS could define 'mac-address' and 'local-mac-address', with
- * zero MAC addresses.  Some older U-Boots only initialized 'local-mac-address'.
- * In this case, the real MAC is in 'local-mac-address', and 'mac-address'
- * exists but is all zeros.
-*/
-void *device_get_mac_address(struct device *dev, char *addr, int alen)
-{
-	char *res;
-
-	res = device_get_mac_addr(dev, "mac-address", addr, alen);
-	if (res)
-		return res;
-
-	res = device_get_mac_addr(dev, "local-mac-address", addr, alen);
-	if (res)
-		return res;
-
-	return device_get_mac_addr(dev, "address", addr, alen);
-}
-EXPORT_SYMBOL_GPL(device_get_mac_address);
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
index 7966e949..71edc2be 100644
--- a/backport/compat/backport-4.4.c
+++ b/backport/compat/backport-4.4.c
@@ -21,42 +21,6 @@
 #include <asm/unaligned.h>
 
 #ifdef CONFIG_DEBUG_FS
-#if LINUX_VERSION_IS_LESS(4,3,0)
-static ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	char buf[3];
-	bool *val = file->private_data;
-
-	if (*val)
-		buf[0] = 'Y';
-	else
-		buf[0] = 'N';
-	buf[1] = '\n';
-	buf[2] = 0x00;
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t debugfs_write_file_bool(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
-{
-	char buf[32];
-	size_t buf_size;
-	bool bv;
-	bool *val = file->private_data;
-
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &bv) == 0)
-		*val = bv;
-
-	return count;
-}
-#endif /* < 4.3.0 */
 
 static const struct file_operations fops_bool = {
 	.read =		debugfs_read_file_bool,
diff --git a/patches/0062-iff-no-queue.cocci b/patches/0062-iff-no-queue.cocci
deleted file mode 100644
index 237985c5..00000000
--- a/patches/0062-iff-no-queue.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@@
-expression E;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(4,3,0)
- E->priv_flags |= IFF_NO_QUEUE;
-+#else
-+E->tx_queue_len = 0;
-+#endif
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
deleted file mode 100644
index 5fa5f54b..00000000
--- a/patches/0070-mac80211-fils.patch
+++ /dev/null
@@ -1,54 +0,0 @@
---- a/net/mac80211/fils_aead.c
-+++ b/net/mac80211/fils_aead.c
-@@ -1,3 +1,4 @@
-+#if LINUX_VERSION_IS_GEQ(4,3,0)
- // SPDX-License-Identifier: GPL-2.0-only
- /*
-  * FILS AEAD for (Re)Association Request/Response frames
-@@ -329,3 +330,4 @@ int fils_decrypt_assoc_resp(struct ieee8
- 	*frame_len -= AES_BLOCK_SIZE;
- 	return 0;
- }
-+#endif
---- a/net/mac80211/fils_aead.h
-+++ b/net/mac80211/fils_aead.h
-@@ -7,10 +7,27 @@
- #ifndef FILS_AEAD_H
- #define FILS_AEAD_H
- 
-+#if LINUX_VERSION_IS_GEQ(4,3,0)
- int fils_encrypt_assoc_req(struct sk_buff *skb,
- 			   struct ieee80211_mgd_assoc_data *assoc_data);
- int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
- 			    u8 *frame, size_t *frame_len,
- 			    struct ieee80211_mgd_assoc_data *assoc_data);
-+#else
-+static inline
-+int fils_encrypt_assoc_req(struct sk_buff *skb,
-+			   struct ieee80211_mgd_assoc_data *assoc_data)
-+{
-+	return -EOPNOTSUPP;
-+}
-+
-+static inline
-+int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
-+			    u8 *frame, size_t *frame_len,
-+			    struct ieee80211_mgd_assoc_data *assoc_data)
-+{
-+	return -EOPNOTSUPP;
-+}
-+#endif
- 
- #endif /* FILS_AEAD_H */
---- a/net/mac80211/main.c
-+++ b/net/mac80211/main.c
-@@ -591,7 +591,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
- 			   NL80211_FEATURE_MAC_ON_CREATE |
- 			   NL80211_FEATURE_USERSPACE_MPM |
- 			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
-+#if LINUX_VERSION_IS_GEQ(4,3,0)
- 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
-+#endif
- 	wiphy_ext_feature_set(wiphy,
- 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
- 	wiphy_ext_feature_set(wiphy,
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
