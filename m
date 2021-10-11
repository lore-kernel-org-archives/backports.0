Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE26FC4167E
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADD460EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhJKWZM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhJKWZD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:03 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB1C061762
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:01 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HStbR3xn6zQjwN;
        Tue, 12 Oct 2021 00:22:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrxJNuZsf/QR89x2AFzXOkFestOMeJXn4Fl0BpPIhg4=;
        b=o46m13hO82UGJCoN1ZzyI4PM/86s0dp85o2JJKZsmVWa3gBL5Pm40BYGnWNb/I6vG6u+Rr
        9zIYgICbNyttVmEykbJ6MK7EZ/iahHhv/NbBnlbJ7HsOQdMbyWF2vm5fX+JMhbDES0Xw+3
        Lz345TrM268zm7Sa8GQ0MZjhxSvv86vw0Z5aRwZ6XMPxjMhi7owVGWjCrPE+ihe9Pc/LFA
        roZvTEqewhlFH9RrVPt5oKgqiBDV58ZkKZRsnkNvafbMBm1Ua+HlTXYrqJYuSAcD24WNxI
        i5UagQXLGrvbT25cNZF45cWMzSwSMGKOBBnfnb82HKSYy7d3HsCNw+1QHu3kqA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/14] backports: Remove 3.X kernel headers
Date:   Tue, 12 Oct 2021 00:22:17 +0200
Message-Id: <20211011222227.1189850-5-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B4E518B6
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the parts from the headers which are only needed for
compatibility with kernel < 3.19.
After this change backports will only work with kernel 3.19 and later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/acpi/acpi_bus.h     |   4 +-
 .../asm-generic/pci-dma-compat.h              |  17 -
 backport/backport-include/asm/atomic.h        |  19 -
 backport/backport-include/asm/barrier.h       |   3 -
 backport/backport-include/crypto/algapi.h     |  16 -
 backport/backport-include/linux/acpi.h        |  61 +--
 .../backport-include/linux/bp-devcoredump.h   |   6 +-
 backport/backport-include/linux/clk.h         | 116 -----
 backport/backport-include/linux/compat.h      |  21 -
 backport/backport-include/linux/completion.h  |  21 -
 backport/backport-include/linux/cordic.h      |  54 ---
 backport/backport-include/linux/crc7.h        |  14 -
 backport/backport-include/linux/debugfs.h     |  19 -
 backport/backport-include/linux/device.h      | 261 ----------
 backport/backport-include/linux/dma-buf.h     |  54 ---
 backport/backport-include/linux/dma-mapping.h |  35 --
 .../backport-include/linux/dynamic_debug.h    |  36 --
 backport/backport-include/linux/err.h         |  10 -
 backport/backport-include/linux/etherdevice.h | 189 --------
 backport/backport-include/linux/export.h      |  19 -
 backport/backport-include/linux/firmware.h    |   3 -
 backport/backport-include/linux/fs.h          |  44 +-
 backport/backport-include/linux/gpio.h        |  35 --
 backport/backport-include/linux/gpio/driver.h |   8 +-
 backport/backport-include/linux/hashtable.h   |  42 --
 backport/backport-include/linux/hid.h         |  87 ----
 backport/backport-include/linux/hwmon.h       |  34 --
 backport/backport-include/linux/i2c-mux.h     |  14 -
 backport/backport-include/linux/idr.h         |  59 +--
 backport/backport-include/linux/if_vlan.h     |  43 --
 backport/backport-include/linux/irq.h         |  16 -
 backport/backport-include/linux/irqdomain.h   |   9 -
 backport/backport-include/linux/jiffies.h     |  30 --
 backport/backport-include/linux/kconfig.h     |  28 --
 backport/backport-include/linux/kernel.h      | 191 +-------
 backport/backport-include/linux/kfifo.h       |  51 --
 backport/backport-include/linux/ktime.h       |  18 -
 backport/backport-include/linux/leds.h        |  30 +-
 backport/backport-include/linux/list.h        |  91 ----
 backport/backport-include/linux/lockdep.h     |  15 -
 backport/backport-include/linux/math64.h      |  27 --
 backport/backport-include/linux/mdio.h        |  87 ----
 backport/backport-include/linux/mii.h         | 140 ------
 backport/backport-include/linux/mm.h          |   5 -
 backport/backport-include/linux/mmc/host.h    |  16 -
 backport/backport-include/linux/module.h      |   5 -
 backport/backport-include/linux/moduleparam.h |  21 -
 backport/backport-include/linux/net.h         |  93 ----
 .../backport-include/linux/netdev_features.h  |  41 --
 backport/backport-include/linux/netdevice.h   | 256 ----------
 backport/backport-include/linux/netlink.h     |   5 -
 backport/backport-include/linux/nl80211.h     |  10 -
 backport/backport-include/linux/of.h          | 259 ----------
 backport/backport-include/linux/of_irq.h      |  15 -
 backport/backport-include/linux/of_net.h      |   9 -
 backport/backport-include/linux/of_platform.h |  19 -
 backport/backport-include/linux/olpc-ec.h     |  10 -
 backport/backport-include/linux/pci.h         | 181 +------
 backport/backport-include/linux/percpu.h      |  19 -
 backport/backport-include/linux/phy.h         |   5 -
 backport/backport-include/linux/pm_qos.h      |   9 -
 backport/backport-include/linux/pm_runtime.h  |  40 --
 backport/backport-include/linux/poll.h        |  18 +-
 backport/backport-include/linux/printk.h      | 139 ------
 backport/backport-include/linux/proc_fs.h     |  29 --
 backport/backport-include/linux/property.h    |   2 -
 .../backport-include/linux/ptp_clock_kernel.h |  40 --
 backport/backport-include/linux/random.h      |  38 --
 backport/backport-include/linux/rculist.h     |  53 --
 backport/backport-include/linux/regmap.h      |  51 --
 backport/backport-include/linux/rfkill.h      | 167 -------
 backport/backport-include/linux/rtnetlink.h   |  29 --
 backport/backport-include/linux/scatterlist.h | 100 ----
 backport/backport-include/linux/security.h    |  18 -
 backport/backport-include/linux/seq_file.h    |  38 --
 backport/backport-include/linux/skbuff.h      | 304 ------------
 backport/backport-include/linux/slab.h        |  21 -
 backport/backport-include/linux/spi/spi.h     |  69 ---
 backport/backport-include/linux/spinlock.h    |  14 -
 backport/backport-include/linux/static_key.h  |  49 --
 backport/backport-include/linux/string.h      |  17 -
 backport/backport-include/linux/thermal.h     |  36 --
 backport/backport-include/linux/time64.h      |  46 --
 backport/backport-include/linux/timecounter.h |  25 -
 backport/backport-include/linux/timekeeping.h |  77 +--
 backport/backport-include/linux/tracepoint.h  | 142 ------
 backport/backport-include/linux/tty.h         |  22 -
 backport/backport-include/linux/tty_flip.h    |  11 -
 backport/backport-include/linux/types.h       |   4 -
 .../backport-include/linux/u64_stats_sync.h   | 146 ------
 backport/backport-include/linux/uidgid.h      | 221 ---------
 backport/backport-include/linux/usb.h         |  95 ----
 backport/backport-include/linux/usb/ch9.h     |  16 -
 backport/backport-include/linux/wait.h        |  73 ---
 backport/backport-include/linux/watchdog.h    |  11 -
 backport/backport-include/linux/workqueue.h   |  67 ---
 backport/backport-include/net/addrconf.h      |  17 -
 backport/backport-include/net/flow_keys.h     |  21 -
 backport/backport-include/net/genetlink.h     |  38 +-
 backport/backport-include/net/ip.h            |  14 -
 backport/backport-include/net/ipv6.h          |  35 --
 backport/backport-include/net/iw_handler.h    |   6 +-
 backport/backport-include/net/net_namespace.h |  10 -
 backport/backport-include/net/netlink.h       | 121 -----
 backport/backport-include/net/sch_generic.h   |  20 -
 backport/backport-include/net/sock.h          |  39 --
 .../{ => uapi}/linux/eventpoll.h              |   2 +-
 .../backport-include/uapi/linux/genetlink.h   |   5 -
 .../backport-include/uapi/linux/sockios.h     |  31 --
 backport/compat/Kconfig                       |  13 -
 backport/compat/Makefile                      |  19 -
 backport/compat/backport-3.10.c               | 237 ---------
 backport/compat/backport-3.11.c               | 124 -----
 backport/compat/backport-3.12.c               |  72 ---
 backport/compat/backport-3.13.c               | 169 -------
 backport/compat/backport-3.14.c               |  90 ----
 backport/compat/backport-3.15.c               |  88 ----
 backport/compat/backport-3.17.c               | 166 -------
 backport/compat/backport-3.18.c               | 332 -------------
 backport/compat/backport-3.19.c               | 165 -------
 backport/compat/backport-3.2.c                |  25 -
 backport/compat/backport-4.0.c                |   8 -
 backport/compat/backport-4.18.c               |  34 --
 backport/compat/backport-4.3.c                |  10 -
 backport/compat/backport-4.5.c                |   9 -
 backport/compat/backport-4.7.c                |   5 +-
 backport/compat/backport-5.3.c                |   2 -
 backport/compat/backport-genetlink.c          |  30 --
 backport/compat/compat-3.0.c                  |  91 ----
 backport/compat/compat-3.1.c                  | 118 -----
 backport/compat/compat-3.3.c                  | 226 ---------
 backport/compat/compat-3.4.c                  | 201 --------
 backport/compat/compat-3.5.c                  | 167 -------
 backport/compat/compat-3.6.c                  |  27 --
 backport/compat/compat-3.7.c                  | 290 -----------
 backport/compat/compat-3.8.c                  | 455 ------------------
 backport/compat/compat-3.9.c                  | 226 ---------
 backport/compat/user_namespace.c              |  68 ---
 138 files changed, 25 insertions(+), 9084 deletions(-)
 delete mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h
 delete mode 100644 backport/backport-include/asm/atomic.h
 delete mode 100644 backport/backport-include/crypto/algapi.h
 delete mode 100644 backport/backport-include/linux/clk.h
 delete mode 100644 backport/backport-include/linux/compat.h
 delete mode 100644 backport/backport-include/linux/completion.h
 delete mode 100644 backport/backport-include/linux/crc7.h
 delete mode 100644 backport/backport-include/linux/dma-buf.h
 delete mode 100644 backport/backport-include/linux/dma-mapping.h
 delete mode 100644 backport/backport-include/linux/dynamic_debug.h
 delete mode 100644 backport/backport-include/linux/err.h
 delete mode 100644 backport/backport-include/linux/export.h
 delete mode 100644 backport/backport-include/linux/gpio.h
 delete mode 100644 backport/backport-include/linux/hashtable.h
 delete mode 100644 backport/backport-include/linux/hid.h
 delete mode 100644 backport/backport-include/linux/hwmon.h
 delete mode 100644 backport/backport-include/linux/i2c-mux.h
 delete mode 100644 backport/backport-include/linux/if_vlan.h
 delete mode 100644 backport/backport-include/linux/irq.h
 delete mode 100644 backport/backport-include/linux/irqdomain.h
 delete mode 100644 backport/backport-include/linux/jiffies.h
 delete mode 100644 backport/backport-include/linux/kfifo.h
 delete mode 100644 backport/backport-include/linux/ktime.h
 delete mode 100644 backport/backport-include/linux/list.h
 delete mode 100644 backport/backport-include/linux/math64.h
 delete mode 100644 backport/backport-include/linux/mdio.h
 delete mode 100644 backport/backport-include/linux/mmc/host.h
 delete mode 100644 backport/backport-include/linux/nl80211.h
 delete mode 100644 backport/backport-include/linux/of.h
 delete mode 100644 backport/backport-include/linux/of_irq.h
 delete mode 100644 backport/backport-include/linux/olpc-ec.h
 delete mode 100644 backport/backport-include/linux/percpu.h
 delete mode 100644 backport/backport-include/linux/pm_runtime.h
 delete mode 100644 backport/backport-include/linux/proc_fs.h
 delete mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
 delete mode 100644 backport/backport-include/linux/regmap.h
 delete mode 100644 backport/backport-include/linux/rfkill.h
 delete mode 100644 backport/backport-include/linux/rtnetlink.h
 delete mode 100644 backport/backport-include/linux/security.h
 delete mode 100644 backport/backport-include/linux/spi/spi.h
 delete mode 100644 backport/backport-include/linux/static_key.h
 delete mode 100644 backport/backport-include/linux/time64.h
 delete mode 100644 backport/backport-include/linux/timecounter.h
 delete mode 100644 backport/backport-include/linux/tracepoint.h
 delete mode 100644 backport/backport-include/linux/tty_flip.h
 delete mode 100644 backport/backport-include/linux/uidgid.h
 delete mode 100644 backport/backport-include/linux/usb.h
 delete mode 100644 backport/backport-include/linux/watchdog.h
 delete mode 100644 backport/backport-include/linux/workqueue.h
 delete mode 100644 backport/backport-include/net/flow_keys.h
 delete mode 100644 backport/backport-include/net/ip.h
 delete mode 100644 backport/backport-include/net/sch_generic.h
 rename backport/backport-include/{ => uapi}/linux/eventpoll.h (94%)
 delete mode 100644 backport/backport-include/uapi/linux/sockios.h
 delete mode 100644 backport/compat/backport-3.10.c
 delete mode 100644 backport/compat/backport-3.11.c
 delete mode 100644 backport/compat/backport-3.12.c
 delete mode 100644 backport/compat/backport-3.13.c
 delete mode 100644 backport/compat/backport-3.14.c
 delete mode 100644 backport/compat/backport-3.15.c
 delete mode 100644 backport/compat/backport-3.17.c
 delete mode 100644 backport/compat/backport-3.18.c
 delete mode 100644 backport/compat/backport-3.19.c
 delete mode 100644 backport/compat/backport-3.2.c
 delete mode 100644 backport/compat/compat-3.0.c
 delete mode 100644 backport/compat/compat-3.1.c
 delete mode 100644 backport/compat/compat-3.3.c
 delete mode 100644 backport/compat/compat-3.4.c
 delete mode 100644 backport/compat/compat-3.5.c
 delete mode 100644 backport/compat/compat-3.6.c
 delete mode 100644 backport/compat/compat-3.7.c
 delete mode 100644 backport/compat/compat-3.8.c
 delete mode 100644 backport/compat/compat-3.9.c
 delete mode 100644 backport/compat/user_namespace.c

diff --git a/backport/backport-include/acpi/acpi_bus.h b/backport/backport-include/acpi/acpi_bus.h
index 4c7404a2..fbd68a16 100644
--- a/backport/backport-include/acpi/acpi_bus.h
+++ b/backport/backport-include/acpi/acpi_bus.h
@@ -3,13 +3,13 @@
 
 #include_next <acpi/acpi_bus.h>
 
-#if LINUX_VERSION_IN_RANGE(3,14,0, 4,13,0) 
+#if LINUX_VERSION_IS_LESS(4,13,0)
 static inline union acpi_object *
 backport_acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func, union acpi_object *argv4)
 {
 	return acpi_evaluate_dsm(handle, guid->b, rev, func, argv4);
 }
 #define acpi_evaluate_dsm LINUX_BACKPORT(acpi_evaluate_dsm)
-#endif /* 3.14 <= x < 4.13.0 */
+#endif /* x < 4.13.0 */
 
 #endif /* _BACKPORTS_ACPI_BUS_H__ */
diff --git a/backport/backport-include/asm-generic/pci-dma-compat.h b/backport/backport-include/asm-generic/pci-dma-compat.h
deleted file mode 100644
index 1b1433ef..00000000
--- a/backport/backport-include/asm-generic/pci-dma-compat.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H
-#define __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H
-#include_next <asm-generic/pci-dma-compat.h>
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#define pci_zalloc_consistent LINUX_BACKPORT(pci_zalloc_consistent)
-static inline void *pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
-					  dma_addr_t *dma_handle)
-{
-	void *ret = pci_alloc_consistent(hwdev, size, dma_handle);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-#endif
-
-#endif /* __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H */
diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
deleted file mode 100644
index 31bddc6b..00000000
--- a/backport/backport-include/asm/atomic.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __BACKPORT_ASM_ATOMIC_H
-#define __BACKPORT_ASM_ATOMIC_H
-#include_next <asm/atomic.h>
-#include <linux/version.h>
-#include <asm/barrier.h>
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-/*
- * In many versions, several architectures do not seem to include an
- * atomic64_t implementation, and do not include the software emulation from
- * asm-generic/atomic64_t.
- * Detect and handle this here.
- */
-#if (!defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !(defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64)))
-#include <asm-generic/atomic64.h>
-#endif
-#endif
-
-#endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index bca05588..ab205768 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -2,10 +2,7 @@
 #define __BACKPORT_ASM_BARRIER_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,4,0) || \
-    defined(CONFIG_ALPHA) || defined(CONFIG_MIPS)
 #include_next <asm/barrier.h>
-#endif /* >= 3.4 */
 
 #ifndef dma_rmb
 #define dma_rmb()	rmb()
diff --git a/backport/backport-include/crypto/algapi.h b/backport/backport-include/crypto/algapi.h
deleted file mode 100644
index b6fbdd9b..00000000
--- a/backport/backport-include/crypto/algapi.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __BP_ALGAPI_H
-#define __BP_ALGAPI_H
-#include <linux/version.h>
-#include_next <crypto/algapi.h>
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#define __crypto_memneq LINUX_BACKPORT(__crypto_memneq)
-noinline unsigned long __crypto_memneq(const void *a, const void *b, size_t size);
-#define crypto_memneq LINUX_BACKPORT(crypto_memneq)
-static inline int crypto_memneq(const void *a, const void *b, size_t size)
-{
-        return __crypto_memneq(a, b, size) != 0UL ? 1 : 0;
-}
-#endif
-
-#endif /* __BP_ALGAPI_H */
diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index 2f1072f7..bee7ae17 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -3,70 +3,13 @@
 #include_next <linux/acpi.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,8,0)
-/*
- * Backports
- *
- * commit 95f8a082b9b1ead0c2859f2a7b1ac91ff63d8765
- * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- * Date:   Wed Nov 21 00:21:50 2012 +0100
- *
- *     ACPI / driver core: Introduce struct acpi_dev_node and related macros
- *
- *     To avoid adding an ACPI handle pointer to struct device on
- *     architectures that don't use ACPI, or generally when CONFIG_ACPI is
- *     not set, in which cases that pointer is useless, define struct
- *     acpi_dev_node that will contain the handle pointer if CONFIG_ACPI is
- *     set and will be empty otherwise and use it to represent the ACPI
- *     device node field in struct device.
- *
- *     In addition to that define macros for reading and setting the ACPI
- *     handle of a device that don't generate code when CONFIG_ACPI is
- *     unset.  Modify the ACPI subsystem to use those macros instead of
- *     referring to the given device's ACPI handle directly.
- *
- *     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- *     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
- *     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
- */
-#ifdef CONFIG_ACPI
-#define ACPI_HANDLE(dev) DEVICE_ACPI_HANDLE(dev)
-#else
-#define ACPI_HANDLE(dev) (NULL)
-#endif /* CONFIG_ACPI */
-#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
-
-#ifndef ACPI_COMPANION
-#ifdef CONFIG_ACPI
-static inline struct acpi_device *_acpi_get_companion(struct device *dev)
-{
-	struct acpi_device *adev;
-	int ret;
-
-	ret = acpi_bus_get_device(ACPI_HANDLE(dev), &adev);
-	if (ret < 0)
-		adev = NULL;
-
-	return adev;
-}
-#define ACPI_COMPANION(dev)	_acpi_get_companion(dev)
-#else
-#define ACPI_COMPANION(dev)	(NULL)
-#endif /* CONFIG_ACPI */
-#endif /* ACPI_COMPANION */
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define acpi_dev_remove_driver_gpios LINUX_BACKPORT(acpi_dev_remove_driver_gpios)
-static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
-#endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
-
-#if LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0)
+#if LINUX_VERSION_IS_LESS(4,13,0)
 #define devm_acpi_dev_add_driver_gpios LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
 static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
 			      const struct acpi_gpio_mapping *gpios)
 {
 	return -ENXIO;
 }
-#endif /* LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,13,0) */
 
 #endif /* __BACKPORT_LINUX_ACPI_H */
diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backport/backport-include/linux/bp-devcoredump.h
index 1e4abf64..4a8c228b 100644
--- a/backport/backport-include/linux/bp-devcoredump.h
+++ b/backport/backport-include/linux/bp-devcoredump.h
@@ -6,8 +6,7 @@
 /* We only need to add our wrapper inside the range from 3.18 until
  * 4.6, outside that we can let our BPAUTO mechanism handle it.
  */
-#if (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
-     LINUX_VERSION_IS_LESS(4,7,0))
+#if LINUX_VERSION_IS_LESS(4,7,0)
 static inline
 void backport_dev_coredumpm(struct device *dev, struct module *owner,
 			    void *data, size_t datalen, gfp_t gfp,
@@ -26,7 +25,6 @@ void backport_dev_coredumpm(struct device *dev, struct module *owner,
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
 
-#endif /* (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
-	   LINUX_VERSION_IS_LESS(4,7,0)) */
+#endif /* LINUX_VERSION_IS_LESS(4,7,0) */
 
 #endif /* __BACKPORT_LINUX_DEVCOREDUMP_H */
diff --git a/backport/backport-include/linux/clk.h b/backport/backport-include/linux/clk.h
deleted file mode 100644
index 62d9218b..00000000
--- a/backport/backport-include/linux/clk.h
+++ /dev/null
@@ -1,116 +0,0 @@
-#ifndef __BACKPORT_LINUX_CLK_H
-#define __BACKPORT_LINUX_CLK_H
-#include_next <linux/clk.h>
-#include <linux/version.h>
-
-/*
- * commit 93abe8e4 - we only backport the non CONFIG_COMMON_CLK
- * case as the CONFIG_COMMON_CLK case requires arch support. By
- * using the backport_ namespace for older kernels we force usage
- * of these helpers and that's required given that 3.5 added some
- * of these helpers expecting a few exported symbols for the non
- * CONFIG_COMMON_CLK case. The 3.5 kernel is not supported as
- * per kernel.org so we don't send a fix upstream for that.
- */
-#if LINUX_VERSION_IS_LESS(3,6,0)
-
-#ifndef CONFIG_COMMON_CLK
-
-/*
- * Whoopsie!
- *
- * clk_enable() and clk_disable() have been left without
- * a nop export symbols when !CONFIG_COMMON_CLK since its
- * introduction on v2.6.16, but fixed until 3.6.
- */
-#if 0
-#define clk_enable LINUX_BACKPORT(clk_enable)
-static inline int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-
-#define clk_disable LINUX_BACKPORT(clk_disable)
-static inline void clk_disable(struct clk *clk) {}
-#endif
-
-
-#define clk_get LINUX_BACKPORT(clk_get)
-static inline struct clk *clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-
-#define devm_clk_get LINUX_BACKPORT(devm_clk_get)
-static inline struct clk *devm_clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-
-#define clk_put LINUX_BACKPORT(clk_put)
-static inline void clk_put(struct clk *clk) {}
-
-#define devm_clk_put LINUX_BACKPORT(devm_clk_put)
-static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
-
-#define clk_get_rate LINUX_BACKPORT(clk_get_rate)
-static inline unsigned long clk_get_rate(struct clk *clk)
-{
-	return 0;
-}
-
-#define clk_set_rate LINUX_BACKPORT(clk_set_rate)
-static inline int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	return 0;
-}
-
-#define clk_round_rate LINUX_BACKPORT(clk_round_rate)
-static inline long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	return 0;
-}
-
-#define clk_set_parent LINUX_BACKPORT(clk_set_parent)
-static inline int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	return 0;
-}
-
-#define clk_get_parent LINUX_BACKPORT(clk_get_parent)
-static inline struct clk *clk_get_parent(struct clk *clk)
-{
-	return NULL;
-}
-#endif /* CONFIG_COMMON_CLK */
-
-#endif /* #if LINUX_VERSION_IS_LESS(3,0,0) */
-
-#if LINUX_VERSION_IS_LESS(3,3,0) && \
-    LINUX_VERSION_IS_GEQ(3,2,0)
-#define clk_prepare_enable LINUX_BACKPORT(clk_prepare_enable)
-/* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-static inline int clk_prepare_enable(struct clk *clk)
-{
-	int ret;
-
-	ret = clk_prepare(clk);
-	if (ret)
-		return ret;
-	ret = clk_enable(clk);
-	if (ret)
-		clk_unprepare(clk);
-
-	return ret;
-}
-
-#define clk_disable_unprepare LINUX_BACKPORT(clk_disable_unprepare)
-/* clk_disable_unprepare helps cases using clk_disable in non-atomic context. */
-static inline void clk_disable_unprepare(struct clk *clk)
-{
-	clk_disable(clk);
-	clk_unprepare(clk);
-}
-#endif /* < 3,3,0 && >= 3,2,0 */
-
-#endif /* __LINUX_CLK_H */
diff --git a/backport/backport-include/linux/compat.h b/backport/backport-include/linux/compat.h
deleted file mode 100644
index f41ee5e6..00000000
--- a/backport/backport-include/linux/compat.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef __BACKPORT_COMPAT_H
-#define __BACKPORT_COMPAT_H
-
-#include_next <linux/compat.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,4,0)
-#ifdef CONFIG_X86_X32_ABI
-#define COMPAT_USE_64BIT_TIME \
-	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
-#else
-#define COMPAT_USE_64BIT_TIME 0
-#endif
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,4,0)
-#define compat_put_timespec LINUX_BACKPORT(compat_put_timespec)
-extern int compat_put_timespec(const struct timespec *, void __user *);
-#endif
-
-#endif /* __BACKPORT_COMPAT_H */
diff --git a/backport/backport-include/linux/completion.h b/backport/backport-include/linux/completion.h
deleted file mode 100644
index f8ce5b1f..00000000
--- a/backport/backport-include/linux/completion.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef __BACKPORT_COMPLETION_H
-#define __BACKPORT_COMPLETION_H
-#include_next <linux/completion.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-/**
- * reinit_completion - reinitialize a completion structure
- * @x:  pointer to completion structure that is to be reinitialized
- *
- * This inline function should be used to reinitialize a completion structure so it can
- * be reused. This is especially important after complete_all() is used.
- */
-#define reinit_completion LINUX_BACKPORT(reinit_completion)
-static inline void reinit_completion(struct completion *x)
-{
-	x->done = 0;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
-
-#endif /* __BACKPORT_COMPLETION_H */
diff --git a/backport/backport-include/linux/cordic.h b/backport/backport-include/linux/cordic.h
index 67d6a4ae..29466c1a 100644
--- a/backport/backport-include/linux/cordic.h
+++ b/backport/backport-include/linux/cordic.h
@@ -1,62 +1,8 @@
 #ifndef _BACKPORT_LINUX_CORDIC_H
 #define _BACKPORT_LINUX_CORDIC_H 1
 
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0))
 #include_next <linux/cordic.h>
-#else
-
-/*
- * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-#ifndef __CORDIC_H_
-#define __CORDIC_H_
-
-#include <linux/types.h>
-
-/**
- * struct cordic_iq - i/q coordinate.
- *
- * @i: real part of coordinate (in phase).
- * @q: imaginary part of coordinate (quadrature).
- */
-struct cordic_iq {
-	s32 i;
-	s32 q;
-};
-
-/**
- * cordic_calc_iq() - calculates the i/q coordinate for given angle.
- *
- * @theta: angle in degrees for which i/q coordinate is to be calculated.
- * @coord: function output parameter holding the i/q coordinate.
- *
- * The function calculates the i/q coordinate for a given angle using
- * cordic algorithm. The coordinate consists of a real (i) and an
- * imaginary (q) part. The real part is essentially the cosine of the
- * angle and the imaginary part is the sine of the angle. The returned
- * values are scaled by 2^16 for precision. The range for theta is
- * for -180 degrees to +180 degrees. Passed values outside this range are
- * converted before doing the actual calculation.
- */
-#define cordic_calc_iq LINUX_BACKPORT(cordic_calc_iq)
-struct cordic_iq cordic_calc_iq(s32 theta);
 
-#endif /* __CORDIC_H_ */
-#endif /* LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0)) */
 
 #ifndef CORDIC_FLOAT
 #define CORDIC_ANGLE_GEN	39797
diff --git a/backport/backport-include/linux/crc7.h b/backport/backport-include/linux/crc7.h
deleted file mode 100644
index 50706ea9..00000000
--- a/backport/backport-include/linux/crc7.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef _BACKPORT_LINUX_CRC7_H
-#define _BACKPORT_LINUX_CRC7_H
-#include_next <linux/crc7.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,16,0)
-#define crc7_be LINUX_BACKPORT(crc7_be)
-static inline u8 crc7_be(u8 crc, const u8 *buffer, size_t len)
-{
-	return crc7(crc, buffer, len) << 1;
-}
-#endif /* < 3.16 */
-
-#endif /* _BACKPORT_LINUX_CRC7_H */
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 973c545c..e342a38a 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -5,25 +5,6 @@
 #include <linux/device.h>
 #include <generated/utsrelease.h>
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define debugfs_create_devm_seqfile LINUX_BACKPORT(debugfs_create_devm_seqfile)
-#if defined(CONFIG_DEBUG_FS)
-struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
-					   struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data));
-#else
-static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
-							 const char *name,
-							 struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data))
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif /* CONFIG_DEBUG_FS */
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
-
 #if LINUX_VERSION_IS_LESS(4,4,0)
 #define debugfs_create_bool LINUX_BACKPORT(debugfs_create_bool)
 #ifdef CONFIG_DEBUG_FS
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 8f282ca6..72ef4ab9 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -1,270 +1,9 @@
 #ifndef __BACKPORT_DEVICE_H
 #define __BACKPORT_DEVICE_H
-#include <linux/export.h>
 #include_next <linux/device.h>
 
 #include <linux/version.h>
 
-/*
- * string.h is usually included from the asm/ folder in most configuration,
- * but on some older kernels it doesn't. As we're using memcpy() in the code
- * below, we need to be safe and make sure string.h is indeed there.
- */
-#include <linux/string.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/* backport
- * commit 9f3b795a626ee79574595e06d1437fe0c7d51d29
- * Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
- * Date: Fri Feb 1 20:40:17 2013 +0100
- *
- * driver-core: constify data for class_find_device()
- */
-typedef int (backport_device_find_function_t)(struct device *, void *);
-#define class_find_device(cls, start, idx, fun) \
-	class_find_device((cls), (start), (void *)(idx),\
-			  (backport_device_find_function_t *)(fun))
-#endif
-
-#ifndef module_driver
-/**
- * module_driver() - Helper macro for drivers that don't do anything
- * special in module init/exit. This eliminates a lot of boilerplate.
- * Each module may only use this macro once, and calling it replaces
- * module_init() and module_exit().
- *
- * Use this macro to construct bus specific macros for registering
- * drivers, and do not use it on its own.
- */
-#define module_driver(__driver, __register, __unregister) \
-static int __init __driver##_init(void) \
-{ \
-	return __register(&(__driver)); \
-} \
-module_init(__driver##_init); \
-static void __exit __driver##_exit(void) \
-{ \
-	__unregister(&(__driver)); \
-} \
-module_exit(__driver##_exit);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,5,0) && \
-    LINUX_VERSION_IS_GEQ(3,2,0)
-#define devres_release LINUX_BACKPORT(devres_release)
-extern int devres_release(struct device *dev, dr_release_t release,
-			  dr_match_t match, void *match_data);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-#include <linux/ratelimit.h>
-
-#define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	if (__ratelimit(&_rs))						\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-} while (0)
-
-#define dev_emerg_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_emerg, dev, fmt, ##__VA_ARGS__)
-#define dev_alert_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_alert, dev, fmt, ##__VA_ARGS__)
-#define dev_crit_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_crit, dev, fmt, ##__VA_ARGS__)
-#define dev_err_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
-#define dev_warn_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
-#define dev_notice_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
-#define dev_info_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
-
-
-#if defined(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
-	    __ratelimit(&_rs))						\
-		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
-				   ##__VA_ARGS__);			\
-} while (0)
-#else
-#define dev_dbg_ratelimited(dev, fmt, ...)			\
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* dynamic debug */
-#endif /* <= 3.5 */
-
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0)
-static inline void
-backport_device_release_driver(struct device *dev)
-{
-	device_release_driver(dev);
-	device_lock(dev);
-	dev_set_drvdata(dev, NULL);
-	device_unlock(dev);
-}
-#define device_release_driver LINUX_BACKPORT(device_release_driver)
-
-#define kobj_to_dev LINUX_BACKPORT(kobj_to_dev)
-static inline struct device *kobj_to_dev(struct kobject *kobj)
-{
-	return container_of(kobj, struct device, kobj);
-}
-#endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-int devm_add_action(struct device *dev, void (*action) (void *), void *data);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-#ifndef DEVICE_ATTR_RO
-#define DEVICE_ATTR_RO(_name) \
-struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
-#endif
-#ifndef DEVICE_ATTR_RW
-#define DEVICE_ATTR_RW(_name) \
-struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
-#endif
-#endif
-
-#ifndef CLASS_ATTR_RW
-#define CLASS_ATTR_RW(_name) \
-	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
-#endif
-#ifndef CLASS_ATTR_RO
-#define CLASS_ATTR_RO(_name) \
-	struct class_attribute class_attr_##_name = __ATTR_RO(_name)
-#endif
-
-#define ATTRIBUTE_GROUPS_BACKPORT(_name) \
-static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
-static void init_##_name##_attrs(void)				\
-{									\
-	int i;								\
-	for (i = 0; _name##_attrs[i]; i++)				\
-		_name##_dev_attrs[i] =				\
-			*container_of(_name##_attrs[i],		\
-				      struct BP_ATTR_GRP_STRUCT,	\
-				      attr);				\
-}
-
-#ifndef __ATTRIBUTE_GROUPS
-#define __ATTRIBUTE_GROUPS(_name)				\
-static const struct attribute_group *_name##_groups[] = {	\
-	&_name##_group,						\
-	NULL,							\
-}
-#endif /* __ATTRIBUTE_GROUPS */
-
-#undef ATTRIBUTE_GROUPS
-#define ATTRIBUTE_GROUPS(_name)					\
-static const struct attribute_group _name##_group = {		\
-	.attrs = _name##_attrs,					\
-};								\
-static inline void init_##_name##_attrs(void) {}		\
-__ATTRIBUTE_GROUPS(_name)
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#define devm_kmalloc(dev, size, flags) devm_kzalloc(dev, size, flags)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-#define devm_kstrdup LINUX_BACKPORT(devm_kstrdup)
-extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#define devm_kmalloc_array LINUX_BACKPORT(devm_kmalloc_array)
-static inline void *devm_kmalloc_array(struct device *dev,
-				       size_t n, size_t size, gfp_t flags)
-{
-	if (size != 0 && n > SIZE_MAX / size)
-		return NULL;
-	return devm_kmalloc(dev, n * size, flags);
-}
-
-#define devm_kcalloc LINUX_BACKPORT(devm_kcalloc)
-static inline void *devm_kcalloc(struct device *dev,
-				 size_t n, size_t size, gfp_t flags)
-{
-	return devm_kmalloc_array(dev, n, size, flags);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,16,0)
-#define devm_kmemdup LINUX_BACKPORT(devm_kmemdup)
-static inline void *devm_kmemdup(struct device *dev, const void *src,
-				 size_t len, gfp_t gfp)
-{
-	void *p;
-
-	p = devm_kmalloc(dev, len, gfp);
-	if (p)
-		memcpy(p, src, len);
-
-	return p;
-}
-#endif
-
-#ifndef dev_level_once
-#ifdef CONFIG_PRINTK
-#define dev_level_once(dev_level, dev, fmt, ...)			\
-do {									\
-	static bool __print_once __read_mostly;				\
-									\
-	if (!__print_once) {						\
-		__print_once = true;					\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-	}								\
-} while (0)
-#else
-#define dev_level_once(dev_level, dev, fmt, ...)			\
-do {									\
-	if (0)								\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-} while (0)
-#endif
-
-#define dev_emerg_once(dev, fmt, ...)					\
-	dev_level_once(dev_emerg, dev, fmt, ##__VA_ARGS__)
-#define dev_alert_once(dev, fmt, ...)					\
-	dev_level_once(dev_alert, dev, fmt, ##__VA_ARGS__)
-#define dev_crit_once(dev, fmt, ...)					\
-	dev_level_once(dev_crit, dev, fmt, ##__VA_ARGS__)
-#define dev_err_once(dev, fmt, ...)					\
-	dev_level_once(dev_err, dev, fmt, ##__VA_ARGS__)
-#define dev_warn_once(dev, fmt, ...)					\
-	dev_level_once(dev_warn, dev, fmt, ##__VA_ARGS__)
-#define dev_notice_once(dev, fmt, ...)					\
-	dev_level_once(dev_notice, dev, fmt, ##__VA_ARGS__)
-#define dev_info_once(dev, fmt, ...)					\
-	dev_level_once(dev_info, dev, fmt, ##__VA_ARGS__)
-#define dev_dbg_once(dev, fmt, ...)					\
-	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
-#endif /* dev_level_once */
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#define devm_kvasprintf LINUX_BACKPORT(devm_kvasprintf)
-extern char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
-			     va_list ap);
-#define devm_kasprintf LINUX_BACKPORT(devm_kasprintf)
-extern char *devm_kasprintf(struct device *dev, gfp_t gfp,
-			    const char *fmt, ...);
-#endif /* < 3.17 */
-
 #if LINUX_VERSION_IS_LESS(4, 1, 0)
 #define dev_of_node LINUX_BACKPORT(dev_of_node)
 static inline struct device_node *dev_of_node(struct device *dev)
diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
deleted file mode 100644
index ef1d0d3d..00000000
--- a/backport/backport-include/linux/dma-buf.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifndef _BACKPORT_DMA_BUF_H__
-#define _BACKPORT_DMA_BUF_H__
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,3,0)
-#include_next <linux/dma-buf.h>
-#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
-#include <linux/dma-direction.h>
-#include <linux/dma-attrs.h>
-#include <linux/dma-mapping.h>
-
-#if !defined(DEFINE_DMA_BUF_EXPORT_INFO) && LINUX_VERSION_IS_GEQ(3,3,0)
-/**
- * helper macro for exporters; zeros and fills in most common values
- */
-#define DEFINE_DMA_BUF_EXPORT_INFO(a)	\
-	struct dma_buf_export_info a = { .exp_name = KBUILD_MODNAME }
-
-struct dma_buf_export_info {
-	const char *exp_name;
-	const struct dma_buf_ops *ops;
-	size_t size;
-	int flags;
-	struct reservation_object *resv;
-	void *priv;
-};
-
-#ifdef dma_buf_export
-#undef dma_buf_export
-#endif
-
-static inline
-struct dma_buf *backport_dma_buf_export(const struct dma_buf_export_info *exp_info)
-{
-#if LINUX_VERSION_IS_LESS(3,4,0)
-	return dma_buf_export(exp_info->priv,
-			      (struct dma_buf_ops *)exp_info->ops,
-			      exp_info->size, exp_info->flags);
-#elif LINUX_VERSION_IS_LESS(3,10,0)
-	return dma_buf_export(exp_info->priv, exp_info->ops,
-			      exp_info->size, exp_info->flags);
-#elif LINUX_VERSION_IS_LESS(3,17,0)
-	return dma_buf_export_named(exp_info->priv, exp_info->ops,
-				    exp_info->size, exp_info->flags,
-				    exp_info->exp_name);
-#else
-	return dma_buf_export_named(exp_info->priv, exp_info->ops,
-				    exp_info->size, exp_info->flags,
-				    exp_info->exp_name, exp_info->resv);
-#endif
-}
-#define dma_buf_export LINUX_BACKPORT(dma_buf_export)
-#endif /* !defined(DEFINE_DMA_BUF_EXPORT_INFO) */
-
-#endif /* _BACKPORT_DMA_BUF_H__ */
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
deleted file mode 100644
index 16b0e3c6..00000000
--- a/backport/backport-include/linux/dma-mapping.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __BACKPORT_LINUX_DMA_MAPPING_H
-#define __BACKPORT_LINUX_DMA_MAPPING_H
-#include_next <linux/dma-mapping.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#define dma_zalloc_coherent LINUX_BACKPORT(dma_zalloc_coherent)
-static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flag)
-{
-	void *ret = dma_alloc_coherent(dev, size, dma_handle, flag);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-/*
- * Set both the DMA mask and the coherent DMA mask to the same thing.
- * Note that we don't check the return value from dma_set_coherent_mask()
- * as the DMA API guarantees that the coherent DMA mask can be set to
- * the same or smaller than the streaming DMA mask.
- */
-#define dma_set_mask_and_coherent LINUX_BACKPORT(dma_set_mask_and_coherent)
-static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
-{
-	int rc = dma_set_mask(dev, mask);
-	if (rc == 0)
-		dma_set_coherent_mask(dev, mask);
-	return rc;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
-
-#endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/dynamic_debug.h b/backport/backport-include/linux/dynamic_debug.h
deleted file mode 100644
index 1ff204be..00000000
--- a/backport/backport-include/linux/dynamic_debug.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef __BACKPORT_LINUX_DYNAMIC_DEBUG_H
-#define __BACKPORT_LINUX_DYNAMIC_DEBUG_H
-#include <linux/version.h>
-#include_next <linux/dynamic_debug.h>
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-/* backports 07613b0b */
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
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
-#else
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)               \
-	static struct _ddebug __used __aligned(8)               \
-	__attribute__((section("__verbose"))) name = {          \
-		.modname = KBUILD_MODNAME,                      \
-		.function = __func__,                           \
-		.filename = __FILE__,                           \
-		.format = (fmt),                                \
-		.lineno = __LINE__,                             \
-		.flags =  _DPRINTK_FLAGS_DEFAULT,               \
-	}
-#endif /* RHEL_RELEASE_CODE < 6.4 */
-#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
-#endif /* < 3.2 */
-
-#endif /* __BACKPORT_LINUX_DYNAMIC_DEBUG_H */
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
deleted file mode 100644
index d08968e5..00000000
--- a/backport/backport-include/linux/err.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_ERR_H
-#define __BACKPORT_LINUX_ERR_H
-#include_next <linux/err.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,12,0)
-#define PTR_ERR_OR_ZERO(p) PTR_RET(p)
-#endif
-
-#endif /* __BACKPORT_LINUX_ERR_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index a00e6660..55672f69 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -2,196 +2,7 @@
 #define _BACKPORT_LINUX_ETHERDEVICE_H
 #include_next <linux/etherdevice.h>
 #include <linux/version.h>
-/*
- * newer kernels include this already and some
- * users rely on getting this indirectly
- */
-#include <asm/unaligned.h>
 
-#if LINUX_VERSION_IS_LESS(3,4,0)
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	dev->addr_assign_type |= NET_ADDR_RANDOM;
-	random_ether_addr(dev->dev_addr);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,6,0)
-#include <linux/random.h>
-/**
- * eth_broadcast_addr - Assign broadcast address
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Assign the broadcast address to the given address array.
- */
-#define eth_broadcast_addr LINUX_BACKPORT(eth_broadcast_addr)
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
-#define eth_random_addr LINUX_BACKPORT(eth_random_addr)
-static inline void eth_random_addr(u8 *addr)
-{
-	get_random_bytes(addr, ETH_ALEN);
-	addr[0] &= 0xfe;        /* clear multicast bit */
-	addr[0] |= 0x02;        /* set local assignment bit (IEEE802) */
-}
-#endif /* LINUX_VERSION_IS_LESS(3,6,0) */
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-
-/* This backports:
- *
- * commit 6d57e9078e880a3dd232d579f42ac437a8f1ef7b
- * Author: Duan Jiong <djduanjiong@gmail.com>
- * Date:   Sat Sep 8 16:32:28 2012 +0000
- *
- *     etherdevice: introduce help function eth_zero_addr()
- */
-#define eth_zero_addr LINUX_BACKPORT(eth_zero_addr)
-static inline void eth_zero_addr(u8 *addr)
-{
-	memset(addr, 0x00, ETH_ALEN);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-#define ether_addr_equal LINUX_BACKPORT(ether_addr_equal)
-static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
-{
-	return !compare_ether_addr(addr1, addr2);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define eth_prepare_mac_addr_change LINUX_BACKPORT(eth_prepare_mac_addr_change)
-extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
-
-#define eth_commit_mac_addr_change LINUX_BACKPORT(eth_commit_mac_addr_change)
-extern void eth_commit_mac_addr_change(struct net_device *dev, void *p);
-#endif /* < 3.9 */
-
-#if LINUX_VERSION_IS_LESS(3,12,0)
-/**
- * eth_hw_addr_inherit - Copy dev_addr from another net_device
- * @dst: pointer to net_device to copy dev_addr to
- * @src: pointer to net_device to copy dev_addr from
- *
- * Copy the Ethernet address from one net_device to another along with
- * the address attributes (addr_assign_type).
- */
-static inline void eth_hw_addr_inherit(struct net_device *dst,
-				       struct net_device *src)
-{
-	dst->addr_assign_type = src->addr_assign_type;
-	memcpy(dst->dev_addr, src->dev_addr, ETH_ALEN);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-/**
- * ether_addr_equal_64bits - Compare two Ethernet addresses
- * @addr1: Pointer to an array of 8 bytes
- * @addr2: Pointer to an other array of 8 bytes
- *
- * Compare two Ethernet addresses, returns true if equal, false otherwise.
- *
- * The function doesn't need any conditional branches and possibly uses
- * word memory accesses on CPU allowing cheap unaligned memory reads.
- * arrays = { byte1, byte2, byte3, byte4, byte5, byte6, pad1, pad2 }
- *
- * Please note that alignment of addr1 & addr2 are only guaranteed to be 16 bits.
- */
-#define ether_addr_equal_64bits LINUX_BACKPORT(ether_addr_equal_64bits)
-static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
-					   const u8 addr2[6+2])
-{
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
-	u64 fold = (*(const u64 *)addr1) ^ (*(const u64 *)addr2);
-
-#ifdef __BIG_ENDIAN
-	return (fold >> 16) == 0;
-#else
-	return (fold << 16) == 0;
-#endif
-#else
-	return ether_addr_equal(addr1, addr2);
-#endif
-}
-#endif /* LINUX_VERSION_IS_LESS(3,5,0) */
-
-#if LINUX_VERSION_IS_LESS(3,14,0)
-/**
- * ether_addr_equal_unaligned - Compare two not u16 aligned Ethernet addresses
- * @addr1: Pointer to a six-byte array containing the Ethernet address
- * @addr2: Pointer other six-byte array containing the Ethernet address
- *
- * Compare two Ethernet addresses, returns true if equal
- *
- * Please note: Use only when any Ethernet address may not be u16 aligned.
- */
-#define ether_addr_equal_unaligned LINUX_BACKPORT(ether_addr_equal_unaligned)
-static inline bool ether_addr_equal_unaligned(const u8 *addr1, const u8 *addr2)
-{
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
-	return ether_addr_equal(addr1, addr2);
-#else
-	return memcmp(addr1, addr2, ETH_ALEN) == 0;
-#endif
-}
-
-/**
- * ether_addr_copy - Copy an Ethernet address
- * @dst: Pointer to a six-byte array Ethernet address destination
- * @src: Pointer to a six-byte array Ethernet address source
- *
- * Please note: dst & src must both be aligned to u16.
- */
-#define ether_addr_copy LINUX_BACKPORT(ether_addr_copy)
-static inline void ether_addr_copy(u8 *dst, const u8 *src)
-{
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
-	*(u32 *)dst = *(const u32 *)src;
-	*(u16 *)(dst + 4) = *(const u16 *)(src + 4);
-#else
-	u16 *a = (u16 *)dst;
-	const u16 *b = (const u16 *)src;
-
-	a[0] = b[0];
-	a[1] = b[1];
-	a[2] = b[2];
-#endif
-}
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#define eth_get_headlen LINUX_BACKPORT(eth_get_headlen)
-int eth_get_headlen(unsigned char *data, unsigned int max_len);
-#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define eth_skb_pad LINUX_BACKPORT(eth_skb_pad)
-/**
- * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
- * @skb: Buffer to pad
- *
- * An Ethernet frame should have a minimum size of 60 bytes.  This function
- * takes short frames and pads them with zeros up to the 60 byte limit.
- */
-static inline int eth_skb_pad(struct sk_buff *skb)
-{
-	return skb_put_padto(skb, ETH_ZLEN);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
 /**
diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
deleted file mode 100644
index 6f6cb6a9..00000000
--- a/backport/backport-include/linux/export.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _COMPAT_LINUX_EXPORT_H
-#define _COMPAT_LINUX_EXPORT_H 1
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-#include_next <linux/export.h>
-#else
-#ifndef pr_fmt
-#define backport_undef_pr_fmt
-#endif
-#include <linux/module.h>
-#ifdef backport_undef_pr_fmt
-#undef pr_fmt
-#undef backport_undef_pr_fmt
-#endif
-#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-#endif	/* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index b5bc16be..7d41637c 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -2,9 +2,6 @@
 #define __BACKPORT_LINUX_FIRMWARE_H
 #include_next <linux/firmware.h>
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define request_firmware_direct(fw, name, device) request_firmware(fw, name, device)
-#endif
 #if LINUX_VERSION_IS_LESS(4,18,0)
 #define firmware_request_nowarn(fw, name, device) request_firmware(fw, name, device)
 #endif
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 4e03adf6..005c3564 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -2,52 +2,12 @@
 #define _COMPAT_LINUX_FS_H
 #include_next <linux/fs.h>
 #include <linux/version.h>
-/*
- * some versions don't have this and thus don't
- * include it from the original fs.h
- */
-#include <linux/uidgid.h>
 
-#if LINUX_VERSION_IS_LESS(3,4,0)
-#define simple_open LINUX_BACKPORT(simple_open)
-extern int simple_open(struct inode *inode, struct file *file);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/**
- * backport of:
- *
- * commit 496ad9aa8ef448058e36ca7a787c61f2e63f0f54
- * Author: Al Viro <viro@zeniv.linux.org.uk>
- * Date:   Wed Jan 23 17:07:38 2013 -0500
- *
- *     new helper: file_inode(file)
- */
-static inline struct inode *file_inode(struct file *f)
-{
-	return f->f_path.dentry->d_inode;
-}
-#endif
-
-#ifndef replace_fops
-/*
- * This one is to be used *ONLY* from ->open() instances.
- * fops must be non-NULL, pinned down *and* module dependencies
- * should be sufficient to pin the caller down as well.
- */
-#define replace_fops(f, fops) \
-	do {	\
-		struct file *__file = (f); \
-		fops_put(__file->f_op); \
-		BUG_ON(!(__file->f_op = (fops))); \
-	} while(0)
-#endif /* replace_fops */
 
-#if (LINUX_VERSION_IS_LESS(4,5,0) && \
-     LINUX_VERSION_IS_GEQ(3,2,0))
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define no_seek_end_llseek LINUX_BACKPORT(no_seek_end_llseek)
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
-#endif /* < 4.5 && >= 3.2 */
+#endif /* < 4.5 */
 
 #if LINUX_VERSION_IS_LESS(5,5,0)
 #ifdef CONFIG_COMPAT
diff --git a/backport/backport-include/linux/gpio.h b/backport/backport-include/linux/gpio.h
deleted file mode 100644
index ef4a8f18..00000000
--- a/backport/backport-include/linux/gpio.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __BACKPORT_LINUX_GPIO_H
-#define __BACKPORT_LINUX_GPIO_H
-#include_next <linux/gpio.h>
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-#define devm_gpio_request_one LINUX_BACKPORT(devm_gpio_request_one)
-#define devm_gpio_request LINUX_BACKPORT(devm_gpio_request)
-#ifdef CONFIG_GPIOLIB
-int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
-int devm_gpio_request_one(struct device *dev, unsigned gpio,
-			  unsigned long flags, const char *label);
-void devm_gpio_free(struct device *dev, unsigned int gpio);
-#else
-static inline int devm_gpio_request(struct device *dev, unsigned gpio,
-				    const char *label)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-static inline int devm_gpio_request_one(struct device *dev, unsigned gpio,
-					unsigned long flags, const char *label)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-static inline void devm_gpio_free(struct device *dev, unsigned int gpio)
-{
-	WARN_ON(1);
-}
-#endif /* CONFIG_GPIOLIB */
-#endif
-
-#endif /* __BACKPORT_LINUX_GPIO_H */
diff --git a/backport/backport-include/linux/gpio/driver.h b/backport/backport-include/linux/gpio/driver.h
index cebeb482..b1d23497 100644
--- a/backport/backport-include/linux/gpio/driver.h
+++ b/backport/backport-include/linux/gpio/driver.h
@@ -1,13 +1,9 @@
 #ifndef __BP_GPIO_DRIVER_H
 #define __BP_GPIO_DRIVER_H
 #include <linux/version.h>
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#include <asm-generic/gpio.h>
-#else
 #include_next <linux/gpio/driver.h>
-#endif
 
-#if LINUX_VERSION_IN_RANGE(3,17,0, 5,3,0)
+#if LINUX_VERSION_IS_LESS(5,3,0)
 enum gpiod_flags;
 enum gpio_lookup_flags;
 
@@ -17,6 +13,6 @@ struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip *gc,
 					    const char *label,
 					    enum gpio_lookup_flags lflags,
 					    enum gpiod_flags dflags);
-#endif /* 3.17.0 <= x < 5.3.0 */
+#endif /* x < 5.3.0 */
 
 #endif /* __BP_GPIO_DRIVER_H */
diff --git a/backport/backport-include/linux/hashtable.h b/backport/backport-include/linux/hashtable.h
deleted file mode 100644
index 33314dc5..00000000
--- a/backport/backport-include/linux/hashtable.h
+++ /dev/null
@@ -1,42 +0,0 @@
-#ifndef __BACKPORT_HASHTABLE_H
-#define __BACKPORT_HASHTABLE_H
-#include_next <linux/hashtable.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/**
- * backport:
- *
- * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
- * Author: Sasha Levin <sasha.levin@oracle.com>
- * Date:   Thu Feb 7 12:32:18 2013 +1100
- *
- *     hlist: drop the node parameter from iterators
- */
-#include <linux/list.h>
-#include <backport/magic.h>
-
-#undef hash_for_each
-#define hash_for_each(name, bkt, obj, member)				\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
-		hlist_for_each_entry(obj, &name[bkt], member)
-
-#undef hash_for_each_safe
-#define hash_for_each_safe(name, bkt, tmp, obj, member)			\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
-		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
-
-#undef hash_for_each_possible
-#define hash_for_each_possible(name, obj, member, key)			\
-	hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))], member)
-
-#undef hash_for_each_possible_safe
-#define hash_for_each_possible_safe(name, obj, tmp, member, key)	\
-	hlist_for_each_entry_safe(obj, tmp,\
-		&name[hash_min(key, HASH_BITS(name))], member)
-
-#endif
-
-#endif /* __BACKPORT_HASHTABLE_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
deleted file mode 100644
index 887c6b15..00000000
--- a/backport/backport-include/linux/hid.h
+++ /dev/null
@@ -1,87 +0,0 @@
-#ifndef __BACKPORT_HID_H
-#define __BACKPORT_HID_H
-#include_next <linux/hid.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,8,0)
-#define hid_ignore LINUX_BACKPORT(hid_ignore)
-extern bool hid_ignore(struct hid_device *);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define HID_TYPE_USBNONE 2
-#endif
-
-#ifndef HID_QUIRK_NO_IGNORE
-#define HID_QUIRK_NO_IGNORE                    0x40000000
-#endif
-
-#ifndef HID_QUIRK_HIDDEV_FORCE
-#define HID_QUIRK_HIDDEV_FORCE                 0x00000010
-#endif
-
-#ifndef HID_QUIRK_IGNORE
-#define HID_QUIRK_IGNORE                       0x00000004
-#endif
-
-#ifndef HID_USB_DEVICE
-#define HID_USB_DEVICE(ven, prod)                              \
-	.bus = BUS_USB, .vendor = (ven), .product = (prod)
-#endif
-
-#ifndef HID_BLUETOOTH_DEVICE
-#define HID_BLUETOOTH_DEVICE(ven, prod)                                        \
-	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
-#endif
-
-#ifndef hid_printk
-#define hid_printk(level, hid, fmt, arg...)		\
-	dev_printk(level, &(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_emerg
-#define hid_emerg(hid, fmt, arg...)			\
-	dev_emerg(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_crit
-#define hid_crit(hid, fmt, arg...)			\
-	dev_crit(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_alert
-#define hid_alert(hid, fmt, arg...)			\
-	dev_alert(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_err
-#define hid_err(hid, fmt, arg...)			\
-	dev_err(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_notice
-#define hid_notice(hid, fmt, arg...)			\
-	dev_notice(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_warn
-#define hid_warn(hid, fmt, arg...)			\
-	dev_warn(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_info
-#define hid_info(hid, fmt, arg...)			\
-	dev_info(&(hid)->dev, fmt, ##arg)
-#endif
-
-#ifndef hid_dbg
-#define hid_dbg(hid, fmt, arg...)			\
-	dev_dbg(&(hid)->dev, fmt, ##arg)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,12,0)
-#define hid_alloc_report_buf LINUX_BACKPORT(hid_alloc_report_buf)
-u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
-#endif
-
-#endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/hwmon.h b/backport/backport-include/linux/hwmon.h
deleted file mode 100644
index 3b61b268..00000000
--- a/backport/backport-include/linux/hwmon.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef __BACKPORT_LINUX_HWMON_H
-#define __BACKPORT_LINUX_HWMON_H
-#include_next <linux/hwmon.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-/*
- * Backports
- *
- * commit bab2243ce1897865e31ea6d59b0478391f51812b
- * Author: Guenter Roeck <linux@roeck-us.net>
- * Date:   Sat Jul 6 13:57:23 2013 -0700
- *
- *     hwmon: Introduce hwmon_device_register_with_groups
- *
- *     hwmon_device_register_with_groups() lets callers register a hwmon device
- *     together with all sysfs attributes in a single call.
- *
- *     When using hwmon_device_register_with_groups(), hwmon attributes are attached
- *     to the hwmon device directly and no longer with its parent device.
- *
- * Signed-off-by: Guenter Roeck <linux@roeck-us.net>
- */
-struct device *
-hwmon_device_register_with_groups(struct device *dev, const char *name,
-				  void *drvdata,
-				  const struct attribute_group **groups);
-struct device *
-devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
-				       void *drvdata,
-				       const struct attribute_group **groups);
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
-
-#endif /* __BACKPORT_LINUX_HWMON_H */
diff --git a/backport/backport-include/linux/i2c-mux.h b/backport/backport-include/linux/i2c-mux.h
deleted file mode 100644
index d12658dc..00000000
--- a/backport/backport-include/linux/i2c-mux.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __BACKPORT_LINUX_I2C_MUX_H
-#define __BACKPORT_LINUX_I2C_MUX_H
-#include_next <linux/i2c-mux.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-#define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
-	i2c_add_mux_adapter(parent, mux_priv, force_nr, chan_id, select, deselect)
-#elif LINUX_VERSION_IS_LESS(3,7,0)
-#define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
-	i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, select, deselect)
-#endif
-
-#endif /* __BACKPORT_LINUX_I2C_MUX_H */
diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
index 01aa2c29..8918033b 100644
--- a/backport/backport-include/linux/idr.h
+++ b/backport/backport-include/linux/idr.h
@@ -1,65 +1,8 @@
 #ifndef __BACKPORT_IDR_H
 #define __BACKPORT_IDR_H
-/* some versions have a broken idr header */
-#include <linux/spinlock.h>
 #include_next <linux/idr.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define ida_simple_get LINUX_BACKPORT(ida_simple_get)
-int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
-		   gfp_t gfp_mask);
-
-#define ida_simple_remove LINUX_BACKPORT(ida_simple_remove)
-void ida_simple_remove(struct ida *ida, unsigned int id);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#include <linux/errno.h>
-/**
- * backport of idr idr_alloc() usage
- *
- * This backports a patch series send by Tejun Heo:
- * https://lkml.org/lkml/2013/2/2/159
- */
-static inline void compat_idr_destroy(struct idr *idp)
-{
-	idr_remove_all(idp);
-	idr_destroy(idp);
-}
-#define idr_destroy(idp) compat_idr_destroy(idp)
-
-static inline int idr_alloc(struct idr *idr, void *ptr, int start, int end,
-			    gfp_t gfp_mask)
-{
-	int id, ret;
-
-	do {
-		if (!idr_pre_get(idr, gfp_mask))
-			return -ENOMEM;
-		ret = idr_get_new_above(idr, ptr, start, &id);
-		if (!ret && id > end) {
-			idr_remove(idr, id);
-			ret = -ENOSPC;
-		}
-	} while (ret == -EAGAIN);
-
-	return ret ? ret : id;
-}
-
-static inline void idr_preload(gfp_t gfp_mask)
-{
-}
-
-static inline void idr_preload_end(void)
-{
-}
-#endif
-
-#ifndef idr_for_each_entry
-#define idr_for_each_entry(idp, entry, id)			\
-	for (id = 0; ((entry) = idr_get_next(idp, &(id))) != NULL; ++id)
-#endif
 
 #if LINUX_VERSION_IS_LESS(4, 11, 0)
 static inline void *backport_idr_remove(struct idr *idr, int id)
@@ -68,7 +11,7 @@ static inline void *backport_idr_remove(struct idr *idr, int id)
 	idr_remove(idr, id);
 	return item;
 }
-#define idr_remove	backport_idr_remove
+#define idr_remove LINUX_BACKPORT(idr_remove)
 #endif
 
 #endif /* __BACKPORT_IDR_H */
diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
deleted file mode 100644
index 571a8b7e..00000000
--- a/backport/backport-include/linux/if_vlan.h
+++ /dev/null
@@ -1,43 +0,0 @@
-#ifndef __BACKPORT_LINUX_IF_VLAN_H_
-#define __BACKPORT_LINUX_IF_VLAN_H_
-#include_next <linux/if_vlan.h>
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-#define vlan_insert_tag(__skb, __vlan_proto, __vlan_tci)	vlan_insert_tag(__skb, __vlan_tci)
-#define __vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		__vlan_put_tag(__skb, __vlan_tci)
-#define vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		vlan_put_tag(__skb, __vlan_tci)
-#define __vlan_hwaccel_put_tag(__skb, __vlan_proto, __vlan_tag)	__vlan_hwaccel_put_tag(__skb, __vlan_tag)
-
-#define __vlan_find_dev_deep(__real_dev, __vlan_proto, __vlan_id) __vlan_find_dev_deep(__real_dev, __vlan_id)
-
-#endif
-
-#ifndef VLAN_PRIO_MASK
-#define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
-#endif
-
-#ifndef VLAN_PRIO_SHIFT
-#define VLAN_PRIO_SHIFT		13
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,16,0)
-#define __vlan_find_dev_deep_rcu(real_dev, vlan_proto, vlan_id) __vlan_find_dev_deep(real_dev, vlan_proto, vlan_id)
-#endif
-
-#ifndef skb_vlan_tag_present
-#define skb_vlan_tag_present(__skb)	((__skb)->vlan_tci & VLAN_TAG_PRESENT)
-#endif
-
-#ifndef skb_vlan_tag_get
-#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci & ~VLAN_TAG_PRESENT)
-#endif
-
-#ifndef skb_vlan_tag_get_id
-#define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
-#endif
-
-#ifndef VLAN_N_VID
-#define VLAN_N_VID 4096
-#endif
-
-#endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
deleted file mode 100644
index e216f4f8..00000000
--- a/backport/backport-include/linux/irq.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __BACKPORT_LINUX_IRQ_H
-#define __BACKPORT_LINUX_IRQ_H
-#include_next <linux/irq.h>
-
-#ifdef CONFIG_HAVE_GENERIC_HARDIRQS
-#if LINUX_VERSION_IS_LESS(3,11,0)
-#define irq_get_trigger_type LINUX_BACKPORT(irq_get_trigger_type)
-static inline u32 irq_get_trigger_type(unsigned int irq)
-{
-	struct irq_data *d = irq_get_irq_data(irq);
-	return d ? irqd_get_trigger_type(d) : 0;
-}
-#endif
-#endif /* CONFIG_HAVE_GENERIC_HARDIRQS */
-
-#endif /* __BACKPORT_LINUX_IRQ_H */
diff --git a/backport/backport-include/linux/irqdomain.h b/backport/backport-include/linux/irqdomain.h
deleted file mode 100644
index 1878a29e..00000000
--- a/backport/backport-include/linux/irqdomain.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __BACKPORT_LINUX_IRQDOMAIN_H
-#define __BACKPORT_LINUX_IRQDOMAIN_H
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,1,0)
-#include_next <linux/irqdomain.h>
-#endif
-
-#endif /* __BACKPORT_LINUX_IRQDOMAIN_H */
diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
deleted file mode 100644
index bbadcc8c..00000000
--- a/backport/backport-include/linux/jiffies.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __BACKPORT_LNIUX_JIFFIES_H
-#define __BACKPORT_LNIUX_JIFFIES_H
-#include_next <linux/jiffies.h>
-
-#ifndef time_is_before_jiffies
-#define time_is_before_jiffies(a) time_after(jiffies, a)
-#endif
-
-#ifndef time_is_after_jiffies
-#define time_is_after_jiffies(a) time_before(jiffies, a)
-#endif
-
-#ifndef time_is_before_eq_jiffies
-#define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
-#endif
-
-#ifndef time_is_after_eq_jiffies
-#define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
-#endif
-
-/*
- * This function is available, but not exported in kernel < 3.17, add
- * an own version.
- */
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#define nsecs_to_jiffies LINUX_BACKPORT(nsecs_to_jiffies)
-extern unsigned long nsecs_to_jiffies(u64 n);
-#endif /* 3.17 */
-
-#endif /* __BACKPORT_LNIUX_JIFFIES_H */
diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index d1faad9b..b1dc95c0 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -1,35 +1,7 @@
 #ifndef __BACKPORT_LINUX_KCONFIG_H
 #define __BACKPORT_LINUX_KCONFIG_H
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,1,0)
 #include_next <linux/kconfig.h>
-#endif
-
-#ifndef __ARG_PLACEHOLDER_1
-#define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
-
-/*
- * 3.1 - 3.3 had a broken version of this, so undef
- * (they didn't have __ARG_PLACEHOLDER_1)
- */
-#undef IS_ENABLED
-#define IS_ENABLED(option) \
-        (config_enabled(option) || config_enabled(option##_MODULE))
-#endif
-
-/*
- * Since 4.9 config_enabled has been removed in favor of __is_defined.
- */
-#ifndef config_enabled
-#define config_enabled(cfg)	__is_defined(cfg)
-#endif
-
-#undef IS_BUILTIN
-#define IS_BUILTIN(option) config_enabled(option)
 
 #ifndef IS_REACHABLE
 /*
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index f5081663..36bb755e 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -1,176 +1,10 @@
 #ifndef __BACKPORT_KERNEL_H
 #define __BACKPORT_KERNEL_H
 #include_next <linux/kernel.h>
+/* needed to include BUILD_BUG_ON_ZERO on <= 4.12 */
 #include <linux/bug.h>
 #include <linux/version.h>
-/*
- * some older kernels don't have this and thus don't
- * include it from kernel.h like new kernels
- */
-#include <linux/printk.h>
-
-/*
- * This backports:
- *
- *   From a3860c1c5dd1137db23d7786d284939c5761d517 Mon Sep 17 00:00:00 2001
- *   From: Xi Wang <xi.wang@gmail.com>
- *   Date: Thu, 31 May 2012 16:26:04 -0700
- *   Subject: [PATCH] introduce SIZE_MAX
- */
-#ifndef SIZE_MAX
-#define SIZE_MAX    (~(size_t)0)
-#endif
-
-/* This backports:
- *
- * commit 36a26c69b4c70396ef569c3452690fba0c1dec08
- * Author: Nicholas Bellinger <nab@linux-iscsi.org>
- * Date:   Tue Jul 26 00:35:26 2011 -0700
- *
- * 	kernel.h: Add DIV_ROUND_UP_ULL and DIV_ROUND_UP_SECTOR_T macro usage
- */
-#ifndef DIV_ROUND_UP_ULL
-#define DIV_ROUND_UP_ULL(ll,d) \
-	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
-#endif
-
-#ifndef USHRT_MAX
-#define USHRT_MAX      ((u16)(~0U))
-#endif
-
-#ifndef SHRT_MAX
-#define SHRT_MAX       ((s16)(USHRT_MAX>>1))
-#endif
-
-#ifndef SHRT_MIN
-#define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
-#endif
-
-#ifndef U8_MAX
-#define U8_MAX		((u8)~0U)
-#endif
-
-#ifndef S8_MAX
-#define S8_MAX		((s8)(U8_MAX>>1))
-#endif
-
-#ifndef S8_MIN
-#define S8_MIN		((s8)(-S8_MAX - 1))
-#endif
 
-#ifndef U16_MAX
-#define U16_MAX		((u16)~0U)
-#endif
-
-#ifndef S16_MAX
-#define S16_MAX		((s16)(U16_MAX>>1))
-#endif
-
-#ifndef S16_MIN
-#define S16_MIN		((s16)(-S16_MAX - 1))
-#endif
-
-#ifndef U32_MAX
-#define U32_MAX		((u32)~0U)
-#endif
-
-#ifndef S32_MAX
-#define S32_MAX		((s32)(U32_MAX>>1))
-#endif
-
-#ifndef S32_MIN
-#define S32_MIN		((s32)(-S32_MAX - 1))
-#endif
-
-#ifndef __round_mask
-#define __round_mask(x, y) ((__typeof__(x))((y)-1))
-#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-#define round_down(x, y) ((x) & ~__round_mask(x, y))
-#endif
-
-#ifndef DIV_ROUND_CLOSEST
-#define DIV_ROUND_CLOSEST(x, divisor)(			\
-{							\
-	typeof(x) __x = x;				\
-	typeof(divisor) __d = divisor;			\
-	(((typeof(x))-1) > 0 ||				\
-	 ((typeof(divisor))-1) > 0 || (__x) > 0) ?	\
-		(((__x) + ((__d) / 2)) / (__d)) :	\
-		(((__x) - ((__d) / 2)) / (__d));	\
-}							\
-)
-#endif
-
-#ifndef DIV_ROUND_CLOSEST_ULL
-#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
-{							\
-	typeof(divisor) __d = divisor;			\
-	unsigned long long _tmp = (x) + (__d) / 2;	\
-	do_div(_tmp, __d);				\
-	_tmp;						\
-}							\
-)
-#endif
-
-#ifndef swap
-#define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-#endif
-
-#ifndef lower_32_bits
-#define lower_32_bits(n) ((u32)(n))
-#endif
-
-#ifndef clamp
-#define clamp(val, min, max) ({			\
-	typeof(val) __val = (val);		\
-	typeof(min) __min = (min);		\
-	typeof(max) __max = (max);		\
-	(void) (&__val == &__min);		\
-	(void) (&__val == &__max);		\
-	__val = __val < __min ? __min: __val;	\
-	__val > __max ? __max: __val; })
-#endif
-
-#ifndef clamp_t
-#define clamp_t(type, val, min, max) ({		\
-	type __val = (val);			\
-	type __min = (min);			\
-	type __max = (max);			\
-	__val = __val < __min ? __min: __val;	\
-	__val > __max ? __max: __val; })
-#endif
-
-#ifndef clamp_val
-#define clamp_val(val, min, max) ({             \
-	typeof(val) __val = (val);              \
-	typeof(val) __min = (min);              \
-	typeof(val) __max = (max);              \
-	__val = __val < __min ? __min: __val;   \
-	__val > __max ? __max: __val; })
-#endif
-
-#ifndef rounddown
-#define rounddown(x, y) (				\
-{							\
-	typeof(x) __x = (x);				\
-	__x - (__x % (y));				\
-}							\
-)
-#endif /* rounddown */
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#define hex_byte_pack pack_hex_byte
-
-/* kernels before 3.2 didn't have error checking for the function */
-#define hex2bin LINUX_BACKPORT(hex2bin)
-int __must_check hex2bin(u8 *dst, const char *src, size_t count);
-#endif /* < 3.2 */
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#undef clamp
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
-#endif /* < 3.18 */
 
 #if LINUX_VERSION_IS_LESS(4,6,0)
 #define kstrtobool LINUX_BACKPORT(kstrtobool)
@@ -207,27 +41,4 @@ int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *
 
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
-static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
-{
-	return (u32)(((u64) val * ep_ro) >> 32);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#define bin2hex LINUX_BACKPORT(bin2hex)
-extern char *bin2hex(char *dst, const void *src, size_t count);
-#endif
-
 #endif /* __BACKPORT_KERNEL_H */
-
-/*
- * We have to do this outside the include guard, because
- * out own header (linux/export.h) has to include kernel.h
- * indirectly (through module.h) and then undef's pr_fmt.
- * Then, when the real kernel.h gets included again, it's
- * not defined and we get problems ...
- */
-#ifndef pr_fmt
-#define pr_fmt(msg) msg
-#endif
diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
deleted file mode 100644
index b4fda3c3..00000000
--- a/backport/backport-include/linux/kfifo.h
+++ /dev/null
@@ -1,51 +0,0 @@
-#ifndef BACKPORT_LINUX_KFIFO_H
-#define BACKPORT_LINUX_KFIFO_H
-
-#include <linux/version.h>
-#include_next <linux/kfifo.h>
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#undef kfifo_put
-/**
- * kfifo_put - put data into the fifo
- * @fifo: address of the fifo to be used
- * @val: the data to be added
- *
- * This macro copies the given value into the fifo.
- * It returns 0 if the fifo was full. Otherwise it returns the number
- * processed elements.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_put(fifo, val) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((&val) + 1) __val = (&val); \
-	unsigned int __ret; \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) { \
-		typeof(__tmp->ptr_const) __dummy __attribute__ ((unused)); \
-		__dummy = (typeof(__val))NULL; \
-	} \
-	if (__recsize) \
-		__ret = __kfifo_in_r(__kfifo, __val, sizeof(*__val), \
-			__recsize); \
-	else { \
-		__ret = !kfifo_is_full(__tmp); \
-		if (__ret) { \
-			(__is_kfifo_ptr(__tmp) ? \
-			((typeof(__tmp->type))__kfifo->data) : \
-			(__tmp->buf) \
-			)[__kfifo->in & __tmp->kfifo.mask] = \
-				*(typeof(__tmp->type))__val; \
-			smp_wmb(); \
-			__kfifo->in++; \
-		} \
-	} \
-	__ret; \
-})
-#endif
-
-#endif /* BACKPORT_LINUX_KFIFO_H */
diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
deleted file mode 100644
index 94272968..00000000
--- a/backport/backport-include/linux/ktime.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __BACKPORT_LINUX_KTIME_H
-#define __BACKPORT_LINUX_KTIME_H
-#include_next <linux/ktime.h>
-#include <linux/timekeeping.h>
-#include <linux/version.h>
-
-#if  LINUX_VERSION_IS_LESS(3,17,0)
-#define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
-extern ktime_t ktime_get_raw(void);
-
-#endif /* < 3.17 */
-
-#ifndef ktime_to_timespec64
-/* Map the ktime_t to timespec conversion to ns_to_timespec function */
-#define ktime_to_timespec64(kt)		ns_to_timespec64((kt).tv64)
-#endif
-
-#endif /* __BACKPORT_LINUX_KTIME_H */
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index b98f8a51..ce2e7d1d 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -5,31 +5,6 @@
 
 #include <backport/leds-disabled.h>
 
-#ifndef CPTCFG_BPAUTO_BUILD_LEDS
-#if LINUX_VERSION_IS_LESS(3,6,0)
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
-#endif /* LINUX_VERSION_IS_LESS(3,6,0) */
-#endif /* CPTCFG_BPAUTO_BUILD_LEDS */
-
 #if LINUX_VERSION_IS_LESS(4,2,0)
 /*
  * There is no LINUX_BACKPORT() guard here because we want it to point to
@@ -42,8 +17,7 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
 #endif
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,5,0) && \
-    LINUX_VERSION_IS_GEQ(3,19,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define led_set_brightness_sync LINUX_BACKPORT(led_set_brightness_sync)
 /**
  * led_set_brightness_sync - set LED brightness synchronously
@@ -58,7 +32,7 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
  */
 extern int led_set_brightness_sync(struct led_classdev *led_cdev,
 				   enum led_brightness value);
-#endif /* < 4.5 && >= 3.19 */
+#endif /* < 4.5 */
 
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define devm_led_trigger_register LINUX_BACKPORT(devm_led_trigger_register)
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
deleted file mode 100644
index 13ab9762..00000000
--- a/backport/backport-include/linux/list.h
+++ /dev/null
@@ -1,91 +0,0 @@
-#ifndef __BACKPORT_LIST_H
-#define __BACKPORT_LIST_H
-#include_next <linux/list.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/**
- * backport:
- *
- * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
- * Author: Sasha Levin <sasha.levin@oracle.com>
- * Date:   Thu Feb 7 12:32:18 2013 +1100
- *
- *     hlist: drop the node parameter from iterators
- */
-#include <backport/magic.h>
-
-#undef hlist_entry_safe
-#define hlist_entry_safe(ptr, type, member) \
-	({ typeof(ptr) ____ptr = (ptr); \
-	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
-	})
-
-#define hlist_for_each_entry4(tpos, pos, head, member)			\
-	for (pos = (head)->first;					\
-	     pos &&							\
-		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
-	     pos = pos->next)
-
-#define hlist_for_each_entry_safe5(tpos, pos, n, head, member)		\
-	for (pos = (head)->first;					\
-	     pos && ({ n = pos->next; 1; }) &&				\
-		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
-	     pos = n)
-
-#define hlist_for_each_entry3(pos, head, member)				\
-	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);	\
-	     pos;								\
-	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-#define hlist_for_each_entry_safe4(pos, n, head, member) 			\
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);	\
-	     pos && ({ n = pos->member.next; 1; });				\
-	     pos = hlist_entry_safe(n, typeof(*pos), member))
-
-#undef hlist_for_each_entry
-#define hlist_for_each_entry(...) \
-	macro_dispatcher(hlist_for_each_entry, __VA_ARGS__)(__VA_ARGS__)
-#undef hlist_for_each_entry_safe
-#define hlist_for_each_entry_safe(...) \
-	macro_dispatcher(hlist_for_each_entry_safe, __VA_ARGS__)(__VA_ARGS__)
-
-#endif
-
-#ifndef list_first_entry_or_null
-/**
- * list_first_entry_or_null - get the first element from a list
- * @ptr:	the list head to take the element from.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
- *
- * Note that if the list is empty, it returns NULL.
- */
-#define list_first_entry_or_null(ptr, type, member) \
-	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
-#endif /* list_first_entry_or_null */
-
-#ifndef list_next_entry
-/**
- * list_next_entry - get the next element in list
- * @pos:	the type * to cursor
- * @member:	the name of the list_struct within the struct.
- */
-#define list_next_entry(pos, member) \
-	list_entry((pos)->member.next, typeof(*(pos)), member)
-#endif /* list_next_entry */
-
-#ifndef list_last_entry
-/**
- * list_last_entry - get the last element from a list
- * @ptr:	the list head to take the element from.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
- *
- * Note, that list is expected to be not empty.
- */
-#define list_last_entry(ptr, type, member) \
-	list_entry((ptr)->prev, type, member)
-#endif
-
-#endif /* __BACKPORT_LIST_H */
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 17c8ea16..7cf38b23 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -3,21 +3,6 @@
 #include_next <linux/lockdep.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define lock_acquire_exclusive(l, s, t, n, i)          lock_acquire(l, s, t, 0, 1, n, i)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#undef lockdep_assert_held
-#ifdef CONFIG_LOCKDEP
-#define lockdep_assert_held(l)	do {				\
-		WARN_ON(debug_locks && !lockdep_is_held(l));	\
-	} while (0)
-#else
-#define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#endif /* CONFIG_LOCKDEP */
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
 #if LINUX_VERSION_IS_LESS(4,15,0)
 #ifndef CONFIG_LOCKDEP
 struct lockdep_map { };
diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
deleted file mode 100644
index 4aeb0dfb..00000000
--- a/backport/backport-include/linux/math64.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __BACKPORT_LINUX_MATH64_H
-#define __BACKPORT_LINUX_MATH64_H
-#include_next <linux/math64.h>
-
-#if LINUX_VERSION_IS_LESS(3,12,0)
-
-#if BITS_PER_LONG == 64
-/**
- * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
- */
-#define div64_u64_rem LINUX_BACKPORT(div64_u64_rem)
-static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
-{
-	*remainder = dividend % divisor;
-	return dividend / divisor;
-}
-#elif BITS_PER_LONG == 32
-#ifndef div64_u64_rem
-#define div64_u64_rem LINUX_BACKPORT(div64_u64_rem)
-#define backports_div64_u64_rem_add 1
-extern u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder);
-#endif
-
-#endif /* BITS_PER_LONG */
-#endif /* < 3.12 */
-
-#endif /* __BACKPORT_LINUX_MATH64_H */
diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
deleted file mode 100644
index e12f4467..00000000
--- a/backport/backport-include/linux/mdio.h
+++ /dev/null
@@ -1,87 +0,0 @@
-#ifndef __BACKPORT_LINUX_MDIO_H
-#define __BACKPORT_LINUX_MDIO_H
-#include_next <linux/mdio.h>
-
-#ifndef MDIO_EEE_100TX
-/* EEE Supported/Advertisement/LP Advertisement registers.
- *
- * EEE capability Register (3.20), Advertisement (7.60) and
- * Link partner ability (7.61) registers have and can use the same identical
- * bit masks.
- */
-#define MDIO_AN_EEE_ADV_100TX	0x0002	/* Advertise 100TX EEE cap */
-#define MDIO_AN_EEE_ADV_1000T	0x0004	/* Advertise 1000T EEE cap */
-/* Note: the two defines above can be potentially used by the user-land
- * and cannot remove them now.
- * So, we define the new generic MDIO_EEE_100TX and MDIO_EEE_1000T macros
- * using the previous ones (that can be considered obsolete).
- */
-#define MDIO_EEE_100TX		MDIO_AN_EEE_ADV_100TX	/* 100TX EEE cap */
-#define MDIO_EEE_1000T		MDIO_AN_EEE_ADV_1000T	/* 1000T EEE cap */
-#define MDIO_EEE_10GT		0x0008	/* 10GT EEE cap */
-#define MDIO_EEE_1000KX		0x0010	/* 1000KX EEE cap */
-#define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
-#define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
-#endif /* MDIO_EEE_100TX */
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-/**
- * mmd_eee_adv_to_ethtool_adv_t
- * @eee_adv: value of the MMD EEE Advertisement/Link Partner Ability registers
- *
- * A small helper function that translates the MMD EEE Advertisment (7.60)
- * and MMD EEE Link Partner Ability (7.61) bits to ethtool advertisement
- * settings.
- */
-#define mmd_eee_adv_to_ethtool_adv_t LINUX_BACKPORT(mmd_eee_adv_to_ethtool_adv_t)
-static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
-{
-	u32 adv = 0;
-
-	if (eee_adv & MDIO_EEE_100TX)
-		adv |= ADVERTISED_100baseT_Full;
-	if (eee_adv & MDIO_EEE_1000T)
-		adv |= ADVERTISED_1000baseT_Full;
-	if (eee_adv & MDIO_EEE_10GT)
-		adv |= ADVERTISED_10000baseT_Full;
-	if (eee_adv & MDIO_EEE_1000KX)
-		adv |= ADVERTISED_1000baseKX_Full;
-	if (eee_adv & MDIO_EEE_10GKX4)
-		adv |= ADVERTISED_10000baseKX4_Full;
-	if (eee_adv & MDIO_EEE_10GKR)
-		adv |= ADVERTISED_10000baseKR_Full;
-
-	return adv;
-}
-
-#define ethtool_adv_to_mmd_eee_adv_t LINUX_BACKPORT(ethtool_adv_to_mmd_eee_adv_t)
-/**
- * ethtool_adv_to_mmd_eee_adv_t
- * @adv: the ethtool advertisement settings
- *
- * A small helper function that translates ethtool advertisement settings
- * to EEE advertisements for the MMD EEE Advertisement (7.60) and
- * MMD EEE Link Partner Ability (7.61) registers.
- */
-static inline u16 ethtool_adv_to_mmd_eee_adv_t(u32 adv)
-{
-	u16 reg = 0;
-
-	if (adv & ADVERTISED_100baseT_Full)
-		reg |= MDIO_EEE_100TX;
-	if (adv & ADVERTISED_1000baseT_Full)
-		reg |= MDIO_EEE_1000T;
-	if (adv & ADVERTISED_10000baseT_Full)
-		reg |= MDIO_EEE_10GT;
-	if (adv & ADVERTISED_1000baseKX_Full)
-		reg |= MDIO_EEE_1000KX;
-	if (adv & ADVERTISED_10000baseKX4_Full)
-		reg |= MDIO_EEE_10GKX4;
-	if (adv & ADVERTISED_10000baseKR_Full)
-		reg |= MDIO_EEE_10GKR;
-
-	return reg;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-
-#endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
index e5aad0f6..06bdc9b8 100644
--- a/backport/backport-include/linux/mii.h
+++ b/backport/backport-include/linux/mii.h
@@ -3,146 +3,6 @@
 #include_next <linux/mii.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#include <linux/ethtool.h>
-
-#define ethtool_adv_to_mii_adv_t LINUX_BACKPORT(ethtool_adv_to_mii_adv_t)
-static inline u32 ethtool_adv_to_mii_adv_t(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_10baseT_Half)
-		result |= ADVERTISE_10HALF;
-	if (ethadv & ADVERTISED_10baseT_Full)
-		result |= ADVERTISE_10FULL;
-	if (ethadv & ADVERTISED_100baseT_Half)
-		result |= ADVERTISE_100HALF;
-	if (ethadv & ADVERTISED_100baseT_Full)
-		result |= ADVERTISE_100FULL;
-	if (ethadv & ADVERTISED_Pause)
-		result |= ADVERTISE_PAUSE_CAP;
-	if (ethadv & ADVERTISED_Asym_Pause)
-		result |= ADVERTISE_PAUSE_ASYM;
-
-	return result;
-}
-
-#define mii_adv_to_ethtool_adv_t LINUX_BACKPORT(mii_adv_to_ethtool_adv_t)
-static inline u32 mii_adv_to_ethtool_adv_t(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_10HALF)
-		result |= ADVERTISED_10baseT_Half;
-	if (adv & ADVERTISE_10FULL)
-		result |= ADVERTISED_10baseT_Full;
-	if (adv & ADVERTISE_100HALF)
-		result |= ADVERTISED_100baseT_Half;
-	if (adv & ADVERTISE_100FULL)
-		result |= ADVERTISED_100baseT_Full;
-	if (adv & ADVERTISE_PAUSE_CAP)
-		result |= ADVERTISED_Pause;
-	if (adv & ADVERTISE_PAUSE_ASYM)
-		result |= ADVERTISED_Asym_Pause;
-
-	return result;
-}
-
-#define ethtool_adv_to_mii_ctrl1000_t LINUX_BACKPORT(ethtool_adv_to_mii_ctrl1000_t)
-static inline u32 ethtool_adv_to_mii_ctrl1000_t(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_1000baseT_Half)
-		result |= ADVERTISE_1000HALF;
-	if (ethadv & ADVERTISED_1000baseT_Full)
-		result |= ADVERTISE_1000FULL;
-
-	return result;
-}
-
-#define mii_ctrl1000_to_ethtool_adv_t LINUX_BACKPORT(mii_ctrl1000_to_ethtool_adv_t)
-static inline u32 mii_ctrl1000_to_ethtool_adv_t(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_1000HALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (adv & ADVERTISE_1000FULL)
-		result |= ADVERTISED_1000baseT_Full;
-
-	return result;
-}
-
-#define mii_lpa_to_ethtool_lpa_t LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_t)
-static inline u32 mii_lpa_to_ethtool_lpa_t(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_LPACK)
-		result |= ADVERTISED_Autoneg;
-
-	return result | mii_adv_to_ethtool_adv_t(lpa);
-}
-
-#define mii_stat1000_to_ethtool_lpa_t LINUX_BACKPORT(mii_stat1000_to_ethtool_lpa_t)
-static inline u32 mii_stat1000_to_ethtool_lpa_t(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_1000HALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (lpa & LPA_1000FULL)
-		result |= ADVERTISED_1000baseT_Full;
-
-	return result;
-}
-
-#define ethtool_adv_to_mii_adv_x LINUX_BACKPORT(ethtool_adv_to_mii_adv_x)
-static inline u32 ethtool_adv_to_mii_adv_x(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_1000baseT_Half)
-		result |= ADVERTISE_1000XHALF;
-	if (ethadv & ADVERTISED_1000baseT_Full)
-		result |= ADVERTISE_1000XFULL;
-	if (ethadv & ADVERTISED_Pause)
-		result |= ADVERTISE_1000XPAUSE;
-	if (ethadv & ADVERTISED_Asym_Pause)
-		result |= ADVERTISE_1000XPSE_ASYM;
-
-	return result;
-}
-
-#define mii_adv_to_ethtool_adv_x LINUX_BACKPORT(mii_adv_to_ethtool_adv_x)
-static inline u32 mii_adv_to_ethtool_adv_x(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_1000XHALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (adv & ADVERTISE_1000XFULL)
-		result |= ADVERTISED_1000baseT_Full;
-	if (adv & ADVERTISE_1000XPAUSE)
-		result |= ADVERTISED_Pause;
-	if (adv & ADVERTISE_1000XPSE_ASYM)
-		result |= ADVERTISED_Asym_Pause;
-
-	return result;
-}
-
-#define mii_lpa_to_ethtool_lpa_x LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_x)
-static inline u32 mii_lpa_to_ethtool_lpa_x(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_LPACK)
-		result |= ADVERTISED_Autoneg;
-
-	return result | mii_adv_to_ethtool_adv_x(lpa);
-}
-#endif
 
 #if LINUX_VERSION_IN_RANGE(4,6,0, 4,11,0)
 extern int mii_ethtool_get_link_ksettings(
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 8ff7d6a6..30eedfde 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -7,11 +7,6 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 
-#if LINUX_VERSION_IS_LESS(3,15,0)
-#define kvfree LINUX_BACKPORT(kvfree)
-void kvfree(const void *addr);
-#endif /* < 3.15 */
-
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #define kvmalloc LINUX_BACKPORT(kvmalloc)
 static inline void *kvmalloc(size_t size, gfp_t flags)
diff --git a/backport/backport-include/linux/mmc/host.h b/backport/backport-include/linux/mmc/host.h
deleted file mode 100644
index 2a60cdec..00000000
--- a/backport/backport-include/linux/mmc/host.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _BACKPORTLINUX_MMC_HOST_H
-#define _BACKPORTLINUX_MMC_HOST_H
-#include_next <linux/mmc/host.h>
-#include <linux/version.h>
-#include <linux/mmc/card.h>
-
-#if LINUX_VERSION_IS_LESS(3,16,0)
-#define mmc_card_hs LINUX_BACKPORT(mmc_card_hs)
-static inline int mmc_card_hs(struct mmc_card *card)
-{
-	return card->host->ios.timing == MMC_TIMING_SD_HS ||
-		card->host->ios.timing == MMC_TIMING_MMC_HS;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,16,0) */
-
-#endif /* _BACKPORTLINUX_MMC_HOST_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index 675d8d77..cd342e0d 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -61,9 +61,4 @@ extern void backport_dependency_symbol(void);
 	void cleanup_module(void) __attribute__((cold,alias("__exit_compat")));
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#undef param_check_bool
-#define param_check_bool(name, p) __param_check(name, p, bool)
-#endif
-
 #endif /* __BACKPORT_LINUX_MODULE_H */
diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 914baadc..0c358609 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -15,27 +15,6 @@ static inline void kernel_param_unlock(struct module *mod)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,8,0)
-#undef __MODULE_INFO
-#ifdef MODULE
-#define __MODULE_INFO(tag, name, info)					  \
-static const char __UNIQUE_ID(name)[]					  \
-  __used __attribute__((section(".modinfo"), unused, aligned(1)))	  \
-  = __stringify(tag) "=" info
-#else  /* !MODULE */
-/* This struct is here for syntactic coherency, it is not used */
-#define __MODULE_INFO(tag, name, info)					  \
-  struct __UNIQUE_ID(name) {}
-#endif
-#endif /* < 3.8 */
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-extern struct kernel_param_ops param_ops_ullong;
-extern int param_set_ullong(const char *val, const struct kernel_param *kp);
-extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
-#define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
-#endif
-
 #ifndef module_param_hw_array
 #define module_param_hw_array(name, type, hwtype, nump, perm) \
 	module_param_array(name, type, nump, perm)
diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 738ff8b1..3107a938 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -3,99 +3,6 @@
 #include_next <linux/net.h>
 #include <linux/static_key.h>
 
-/* This backports:
- *
- * commit 2033e9bf06f07e049bbc77e9452856df846714cc -- from v3.5
- * Author: Neil Horman <nhorman@tuxdriver.com>
- * Date:   Tue May 29 09:30:40 2012 +0000
- *
- *     net: add MODULE_ALIAS_NET_PF_PROTO_NAME
- */
-#ifndef MODULE_ALIAS_NET_PF_PROTO_NAME
-#define MODULE_ALIAS_NET_PF_PROTO_NAME(pf, proto, name) \
-	MODULE_ALIAS("net-pf-" __stringify(pf) "-proto-" __stringify(proto) \
-		     name)
-#endif
-
-#ifndef net_ratelimited_function
-#define net_ratelimited_function(function, ...)			\
-do {								\
-	if (net_ratelimit())					\
-		function(__VA_ARGS__);				\
-} while (0)
-
-#define net_emerg_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_emerg, fmt, ##__VA_ARGS__)
-#define net_alert_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_alert, fmt, ##__VA_ARGS__)
-#define net_crit_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_crit, fmt, ##__VA_ARGS__)
-#define net_err_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_err, fmt, ##__VA_ARGS__)
-#define net_notice_ratelimited(fmt, ...)			\
-	net_ratelimited_function(pr_notice, fmt, ##__VA_ARGS__)
-#define net_warn_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_warn, fmt, ##__VA_ARGS__)
-#define net_info_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
-#define net_dbg_ratelimited(fmt, ...)				\
-	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
-#endif
-
-#ifndef DECLARE_SOCKADDR
-#define DECLARE_SOCKADDR(type, dst, src)	\
-	type dst = ({ __sockaddr_check_size(sizeof(*dst)); (type) src; })
-#endif
-
-/*
- * Avoid backporting this if a distro did the work already, this
- * takes the check a bit further than just using LINUX_BACKPORT()
- * namespace, curious if any distro will hit a wall with this.
- * Also curious if any distro will be daring enough to even try
- * to backport this to a release older than 3.5.
- */
-#ifndef ___NET_RANDOM_STATIC_KEY_INIT
-/*
- * Backporting this before 3.5 is extremely tricky -- I tried, due
- * to the fact that it relies on static keys, which were refactored
- * and optimized through a series of generation of patches from jump
- * labels. These in turn have also been optimized through kernel revisions
- * and have architecture specific code, which if you commit to backporting
- * may affect tracing. My recommendation is that if you have a need for
- * static keys you just require at least 3.5 to remain sane.
- */
-#if LINUX_VERSION_IS_GEQ(3,5,0) && !defined(net_get_random_once)
-#define __BACKPORT_NET_GET_RANDOM_ONCE 1
-#endif
-#endif /* ___NET_RANDOM_STATIC_KEY_INIT */
-
-#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
-#define __net_get_random_once LINUX_BACKPORT(__net_get_random_once)
-bool __net_get_random_once(void *buf, int nbytes, bool *done,
-			   struct static_key *done_key);
-
-#ifdef HAVE_JUMP_LABEL
-#define ___NET_RANDOM_STATIC_KEY_INIT ((struct static_key) \
-		{ .enabled = ATOMIC_INIT(0), .entries = (void *)1 })
-#else /* !HAVE_JUMP_LABEL */
-#define ___NET_RANDOM_STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
-#endif /* HAVE_JUMP_LABEL */
-
-#define net_get_random_once(buf, nbytes)				\
-	({								\
-		bool ___ret = false;					\
-		static bool ___done = false;				\
-		static struct static_key ___done_key =			\
-			___NET_RANDOM_STATIC_KEY_INIT;			\
-		if (!static_key_true(&___done_key))			\
-			___ret = __net_get_random_once(buf,		\
-						       nbytes,		\
-						       &___done,	\
-						       &___done_key);	\
-		___ret;							\
-	})
-
-#endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
 
 #if LINUX_VERSION_IS_LESS(4,2,0)
 #define sock_create_kern(net, family, type, proto, res) \
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index 09568ce4..66d8a506 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -2,49 +2,8 @@
 #define __BACKPORT_NETDEV_FEATURES_H
 
 #include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#include <linux/netdevice.h>
-#include <linux/types.h>
-
-/* added via 9356b8fc */
-#define NETIF_F_HW_VLAN_CTAG_RX			NETIF_F_HW_VLAN_RX
-#define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
-
-/* added via d314774c */
-#define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
-
-/* c8f44aff made this u32 but later a861a8b2 changed it to u64 both on v3.3 */
-typedef u32 netdev_features_t;
-
-#else
 #include_next <linux/netdev_features.h>
 
-#if LINUX_VERSION_IS_LESS(3,10,0)
-/* See commit f646968f8f on next-20130423 */
-#define NETIF_F_HW_VLAN_CTAG_TX_BIT		NETIF_F_HW_VLAN_TX_BIT
-#define NETIF_F_HW_VLAN_CTAG_RX_BIT		NETIF_F_HW_VLAN_RX_BIT
-#define NETIF_F_HW_VLAN_CTAG_FILTER_BIT		NETIF_F_HW_VLAN_FILTER_BIT
-
-#define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
-#define NETIF_F_HW_VLAN_CTAG_RX			NETIF_F_HW_VLAN_RX
-#define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
-
-#if !defined(NETIF_F_RXCSUM)
-#define NETIF_F_RXCSUM 0
-#endif
-
-#if !defined(NETIF_F_RXALL)
-#define NETIF_F_RXALL 0
-#endif
-
-#if !defined(NETIF_F_RXFCS)
-#define NETIF_F_RXFCS 0
-#endif
-
 /* this was renamed in commit 53692b1de :  sctp: Rename NETIF_F_SCTP_CSUM to NETIF_F_SCTP_CRC */
 #ifndef NETIF_F_SCTP_CRC
 #define NETIF_F_SCTP_CRC __NETIF_F(SCTP_CSUM)
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index ed691961..496e2fb3 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -1,261 +1,9 @@
 #ifndef __BACKPORT_NETDEVICE_H
 #define __BACKPORT_NETDEVICE_H
 #include_next <linux/netdevice.h>
-#include <linux/netdev_features.h>
 #include <linux/version.h>
 #include <backport/magic.h>
 
-/*
- * This is declared implicitly in newer kernels by netdevice.h using
- * this pointer in struct net_device, but declare it here anyway so
- * pointers to it are accepted as function arguments without warning.
- */
-struct inet6_dev;
-
-/* older kernels don't include this here, we need it */
-#include <linux/ethtool.h>
-#include <linux/rculist.h>
-/*
- * new kernels include <net/netprio_cgroup.h> which
- * has this ... and some drivers rely on it :-(
- */
-#include <linux/hardirq.h>
-
-#if LINUX_VERSION_IS_LESS(3,14,0)
-/*
- * Backports note: if in-kernel support is provided we could then just
- * take the kernel's implementation of __dev_kfree_skb_irq() as it requires
- * raise_softirq_irqoff() which is not exported. For the backport case we
- * just use slightly less optimized version and we don't get the ability
- * to distinguish the two different reasons to free the skb -- whether it
- * was consumed or dropped.
- *
- * The upstream documentation for this:
- *
- * It is not allowed to call kfree_skb() or consume_skb() from hardware
- * interrupt context or with hardware interrupts being disabled.
- * (in_irq() || irqs_disabled())
- *
- * We provide four helpers that can be used in following contexts :
- *
- * dev_kfree_skb_irq(skb) when caller drops a packet from irq context,
- *  replacing kfree_skb(skb)
- *
- * dev_consume_skb_irq(skb) when caller consumes a packet from irq context.
- *  Typically used in place of consume_skb(skb) in TX completion path
- *
- * dev_kfree_skb_any(skb) when caller doesn't know its current irq context,
- *  replacing kfree_skb(skb)
- *
- * dev_consume_skb_any(skb) when caller doesn't know its current irq context,
- *  and consumed a packet. Used in place of consume_skb(skb)
- */
-#define skb_free_reason LINUX_BACKPORT(skb_free_reason)
-enum skb_free_reason {
-	SKB_REASON_CONSUMED,
-	SKB_REASON_DROPPED,
-};
-
-#define __dev_kfree_skb_irq LINUX_BACKPORT(__dev_kfree_skb_irq)
-static inline void __dev_kfree_skb_irq(struct sk_buff *skb,
-				       enum skb_free_reason reason)
-{
-	dev_kfree_skb_irq(skb);
-}
-
-#define __dev_kfree_skb_any LINUX_BACKPORT(__dev_kfree_skb_any)
-static inline void __dev_kfree_skb_any(struct sk_buff *skb,
-				       enum skb_free_reason reason)
-{
-	dev_kfree_skb_any(skb);
-}
-
-#define dev_consume_skb_irq LINUX_BACKPORT(dev_consume_skb_irq)
-static inline void dev_consume_skb_irq(struct sk_buff *skb)
-{
-	dev_kfree_skb_irq(skb);
-}
-
-#define dev_consume_skb_any LINUX_BACKPORT(dev_consume_skb_any)
-static inline void dev_consume_skb_any(struct sk_buff *skb)
-{
-	dev_kfree_skb_any(skb);
-}
-
-#if (LINUX_VERSION_CODE != KERNEL_VERSION(3,13,11) || UTS_UBUNTU_RELEASE_ABI < 24)
-struct pcpu_sw_netstats {
-	u64     rx_packets;
-	u64     rx_bytes;
-	u64     tx_packets;
-	u64     tx_bytes;
-	struct u64_stats_sync   syncp;
-};
-#endif
-
-#define netdev_tstats(dev)	((struct pcpu_sw_netstats *)dev->ml_priv)
-#define netdev_assign_tstats(dev, e)	dev->ml_priv = (e);
-#else
-#define netdev_tstats(dev)	dev->tstats
-#define netdev_assign_tstats(dev, e)	dev->tstats = (e);
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
-
-#if LINUX_VERSION_IS_LESS(3,7,8)
-#define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
-extern void netdev_set_default_ethtool_ops(struct net_device *dev,
-					   const struct ethtool_ops *ops);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-/*
- * BQL was added as of v3.3 but some Linux distributions
- * have backported BQL to their v3.2 kernels or older. To
- * address this we assume that they also enabled CONFIG_BQL
- * and test for that here and simply avoid adding the static
- * inlines if it was defined
- */
-#ifndef CONFIG_BQL
-#define netdev_tx_sent_queue LINUX_BACKPORT(netdev_tx_sent_queue)
-static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
-					unsigned int bytes)
-{
-}
-
-#define netdev_sent_queue LINUX_BACKPORT(netdev_sent_queue)
-static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
-{
-}
-
-#define netdev_tx_completed_queue LINUX_BACKPORT(netdev_tx_completed_queue)
-static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
-					     unsigned pkts, unsigned bytes)
-{
-}
-
-#define netdev_completed_queue LINUX_BACKPORT(netdev_completed_queue)
-static inline void netdev_completed_queue(struct net_device *dev,
-					  unsigned pkts, unsigned bytes)
-{
-}
-
-#define netdev_tx_reset_queue LINUX_BACKPORT(netdev_tx_reset_queue)
-static inline void netdev_tx_reset_queue(struct netdev_queue *q)
-{
-}
-
-#define netdev_reset_queue LINUX_BACKPORT(netdev_reset_queue)
-static inline void netdev_reset_queue(struct net_device *dev_queue)
-{
-}
-#endif /* CONFIG_BQL */
-#endif /* < 3.3 */
-
-#ifndef NETDEV_PRE_UP
-#define NETDEV_PRE_UP		0x000D
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,11,0)
-#define netdev_notifier_info_to_dev(ndev) ndev
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define netdev_notify_peers(dev) netif_notify_peers(dev)
-#define napi_gro_flush(napi, old) napi_gro_flush(napi)
-#endif
-
-#ifndef IFF_LIVE_ADDR_CHANGE
-#define IFF_LIVE_ADDR_CHANGE 0x100000
-#endif
-
-#ifndef IFF_SUPP_NOFCS
-#define IFF_SUPP_NOFCS	0x80000		/* device supports sending custom FCS */
-#endif
-
-#ifndef IFF_UNICAST_FLT
-#define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
-#endif
-
-#ifndef QUEUE_STATE_ANY_XOFF
-#define __QUEUE_STATE_DRV_XOFF __QUEUE_STATE_XOFF
-#define __QUEUE_STATE_STACK_XOFF __QUEUE_STATE_XOFF
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#ifndef NET_NAME_UNKNOWN
-#define NET_NAME_UNKNOWN	0
-#endif
-#ifndef NET_NAME_ENUM
-#define NET_NAME_ENUM		1
-#endif
-#ifndef NET_NAME_PREDICTABLE
-#define NET_NAME_PREDICTABLE	2
-#endif
-#ifndef NET_NAME_USER
-#define NET_NAME_USER		3
-#endif
-#ifndef NET_NAME_RENAMED
-#define NET_NAME_RENAMED	4
-#endif
-
-#define alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, txqs, rxqs) \
-	alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs)
-
-#undef alloc_netdev
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
-
-#undef alloc_netdev_mq
-#define alloc_netdev_mq(sizeof_priv, name, name_assign_type, setup, count) \
-	alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, count, \
-			 count)
-#endif /* LINUX_VERSION_IS_LESS(3,17,0) */
-
-/*
- * This backports this commit from upstream:
- * commit 87757a917b0b3c0787e0563c679762152be81312
- * net: force a list_del() in unregister_netdevice_many()
- */
-#if (!(LINUX_VERSION_IS_GEQ(3,10,45) && \
-       LINUX_VERSION_IS_LESS(3,11,0)) && \
-     !(LINUX_VERSION_IS_GEQ(3,12,23) && \
-       LINUX_VERSION_IS_LESS(3,13,0)) && \
-     !(LINUX_VERSION_IS_GEQ(3,14,9) && \
-       LINUX_VERSION_IS_LESS(3,15,0)) && \
-     !(LINUX_VERSION_IS_GEQ(3,15,2) && \
-       LINUX_VERSION_IS_LESS(3,16,0)) && \
-     LINUX_VERSION_IS_LESS(3,16,0))
-static inline void backport_unregister_netdevice_many(struct list_head *head)
-{
-	unregister_netdevice_many(head);
-
-	if (!(head->next == LIST_POISON1 && head->prev == LIST_POISON2))
-		list_del(head);
-}
-#define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define napi_alloc_frag(fragsz) netdev_alloc_frag(fragsz)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-/* RSS keys are 40 or 52 bytes long */
-#define NETDEV_RSS_KEY_LEN 52
-#define netdev_rss_key_fill LINUX_BACKPORT(netdev_rss_key_fill)
-void netdev_rss_key_fill(void *buffer, size_t len);
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define napi_alloc_skb LINUX_BACKPORT(napi_alloc_skb)
-static inline struct sk_buff *napi_alloc_skb(struct napi_struct *napi,
-					     unsigned int length)
-{
-	return netdev_alloc_skb_ip_align(napi->dev, length);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
-
-#ifndef IFF_TX_SKB_SHARING
-#define IFF_TX_SKB_SHARING 0
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,1,0)
 netdev_features_t passthru_features_check(struct sk_buff *skb,
@@ -295,11 +43,7 @@ static inline bool backport_napi_complete_done(struct napi_struct *n, int work_d
 	if (unlikely(test_bit(NAPI_STATE_NPSVC, &n->state)))
 		return false;
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
-	napi_complete(n);
-#else
 	napi_complete_done(n, work_done);
-#endif /* < 3.19 */
 	return true;
 }
 
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 0fb8e0f3..61d81bbf 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -43,13 +43,8 @@ struct netlink_ext_ack {
 #endif
 
 /* this is for patches we apply */
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define netlink_notify_portid(__notify) (__notify->pid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).pid
-#else
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
-#endif
 
 #ifndef NL_SET_BAD_ATTR
 #define NL_SET_BAD_ATTR(extack, attr) do {		\
diff --git a/backport/backport-include/linux/nl80211.h b/backport/backport-include/linux/nl80211.h
deleted file mode 100644
index d49057a6..00000000
--- a/backport/backport-include/linux/nl80211.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_NL80211_H
-#define __BACKPORT_LINUX_NL80211_H
-#include_next <linux/nl80211.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#define NL80211_FEATURE_SK_TX_STATUS 0
-#endif
-
-#endif /* __BACKPORT_LINUX_NL80211_H */
diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
deleted file mode 100644
index bbb5acd2..00000000
--- a/backport/backport-include/linux/of.h
+++ /dev/null
@@ -1,259 +0,0 @@
-#ifndef _COMPAT_LINUX_OF_H
-#define _COMPAT_LINUX_OF_H 1
-
-#include <linux/version.h>
-#include_next <linux/of.h>
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#ifdef CONFIG_OF
-extern struct device_node *of_get_child_by_name(const struct device_node *node,
-						const char *name);
-#else
-static inline struct device_node *of_get_child_by_name(
-					const struct device_node *node,
-					const char *name)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#ifndef CONFIG_OF
-static inline struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-
-#if LINUX_VERSION_IS_LESS(3,8,0)
-#define of_property_read_u8_array LINUX_BACKPORT(of_property_read_u8_array)
-#ifdef CONFIG_OF
-extern int of_property_read_u8_array(const struct device_node *np,
-			const char *propname, u8 *out_values, size_t sz);
-#else
-static inline int of_property_read_u8_array(const struct device_node *np,
-			const char *propname, u8 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define of_property_read_u32_array LINUX_BACKPORT(of_property_read_u32_array)
-#ifdef CONFIG_OF
-extern int of_property_read_u32_array(const struct device_node *np,
-				      const char *propname,
-				      u32 *out_values,
-				      size_t sz);
-#else
-static inline int of_property_read_u32_array(const struct device_node *np,
-					     const char *propname,
-					     u32 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
-#define of_property_read_u32 LINUX_BACKPORT(of_property_read_u32)
-static inline int of_property_read_u32(const struct device_node *np,
-				       const char *propname,
-				       u32 *out_value)
-{
-	return of_property_read_u32_array(np, propname, out_value, 1);
-}
-#ifndef CONFIG_OF
-#define of_get_property LINUX_BACKPORT(of_get_property)
-static inline const void *of_get_property(const struct device_node *node,
-				const char *name,
-				int *lenp)
-{
-	return NULL;
-}
-
-#endif
-#endif /* LINUX_VERSION_IS_LESS(3,1,0) */
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-#define of_property_read_u32_index LINUX_BACKPORT(of_property_read_u32_index)
-#ifdef CONFIG_OF
-extern int of_property_read_u32_index(const struct device_node *np,
-				       const char *propname,
-				       u32 index, u32 *out_value);
-#else
-static inline int of_property_read_u32_index(const struct device_node *np,
-			const char *propname, u32 index, u32 *out_value)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-#define of_property_count_elems_of_size LINUX_BACKPORT(of_property_count_elems_of_size)
-#ifdef CONFIG_OF
-extern int of_property_count_elems_of_size(const struct device_node *np,
-				const char *propname, int elem_size);
-#else
-static inline int of_property_count_elems_of_size(const struct device_node *np,
-			const char *propname, int elem_size)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
-
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-/**
- * of_property_count_u32_elems - Count the number of u32 elements in a property
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- *
- * Search for a property in a device node and count the number of u32 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
- * not exist or its length does not match a multiple of u32 and -ENODATA if the
- * property does not have a value.
- */
-#define of_property_count_u32_elems LINUX_BACKPORT(of_property_count_u32_elems)
-static inline int of_property_count_u32_elems(const struct device_node *np,
-				const char *propname)
-{
-	return of_property_count_elems_of_size(np, propname, sizeof(u32));
-}
-#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#ifndef CONFIG_OF
-#define of_node_get LINUX_BACKPORT(of_node_get)
-/* Dummy ref counting routines - to be implemented later */
-static inline struct device_node *of_node_get(struct device_node *node)
-{
-	return node;
-}
-static inline void of_node_put(struct device_node *node) { }
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
-
-#ifndef of_match_ptr
-#ifdef CONFIG_OF
-#define of_match_ptr(_ptr)	(_ptr)
-#else
-#define of_match_ptr(_ptr)	NULL
-#endif /* CONFIG_OF */
-#endif /* of_match_ptr */
-
-#ifndef for_each_compatible_node
-#define for_each_compatible_node(dn, type, compatible) \
-	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
-	     dn = of_find_compatible_node(dn, type, compatible))
-#endif /* for_each_compatible_node */
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#ifndef CONFIG_OF
-static inline struct device_node *of_find_compatible_node(
-						struct device_node *from,
-						const char *type,
-						const char *compat)
-{
-	return NULL;
-}
-#endif
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#define of_property_read_u64_array LINUX_BACKPORT(of_property_read_u64_array)
-#ifdef CONFIG_OF
-/* This is static in the kernel, but we need it in multiple places */
-void *of_find_property_value_of_size(const struct device_node *np,
-				     const char *propname, u32 len);
-extern int of_property_read_u64_array(const struct device_node *np,
-				      const char *propname,
-				      u64 *out_values,
-				      size_t sz);
-#else
-static inline int of_property_read_u64_array(const struct device_node *np,
-					     const char *propname,
-					     u64 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
-
-#if LINUX_VERSION_IS_LESS(3,6,0)
-#define of_node_full_name LINUX_BACKPORT(of_node_full_name)
-#ifdef CONFIG_OF
-static inline const char *of_node_full_name(const struct device_node *np)
-{
-	return np ? np->full_name : "<no-node>";
-}
-#else
-static inline const char* of_node_full_name(const struct device_node *np)
-{
-	return "<no-node>";
-}
-#endif /* CONFIG_OF */
-#endif /* < 3.6 */
-
-#ifndef for_each_child_of_node
-#define for_each_child_of_node(parent, child) \
-	while (0)
-#endif
-
-#ifndef CONFIG_OF
-#if LINUX_VERSION_IS_LESS(3,10,0)
-static inline int of_device_is_available(const struct device_node *device)
-{
-	return 0;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,6,0) && !LINUX_VERSION_IN_RANGE(3,2,70, 3,3,0)
-static inline int of_property_match_string(struct device_node *np,
-					   const char *propname,
-					   const char *string)
-{
-	return -ENOSYS;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-static inline struct property *of_find_property(const struct device_node *np,
-						const char *name, int *lenp)
-{
-	return NULL;
-}
-
-static inline int of_device_is_compatible(const struct device_node *device,
-					  const char *name)
-{
-	return 0;
-}
-
-static inline struct device_node *of_parse_phandle(struct device_node *np,
-						   const char *phandle_name,
-						   int index)
-{
-	return NULL;
-}
-
-#define of_match_node(_matches, _node)	NULL
-#endif
-
-#endif /* CONFIG_OF */
-
-#if LINUX_VERSION_IS_LESS(3,4,0) && !LINUX_VERSION_IN_RANGE(3,2,44, 3,3,0)
-static inline bool of_property_read_bool(const struct device_node *np,
-					 const char *propname)
-{
-	struct property *prop = of_find_property(np, propname, NULL);
-
-	return prop ? true : false;
-}
-#endif
-
-#endif	/* _COMPAT_LINUX_OF_H */
diff --git a/backport/backport-include/linux/of_irq.h b/backport/backport-include/linux/of_irq.h
deleted file mode 100644
index 58108e2c..00000000
--- a/backport/backport-include/linux/of_irq.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __BACKPORT_OF_IRQ_H
-#define __BACKPORT_OF_IRQ_H
-#include_next <linux/of_irq.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,5,0) && !defined(CONFIG_OF)
-#define irq_of_parse_and_map LINUX_BACKPORT(irq_of_parse_and_map)
-static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
-						int index)
-{
-	return 0;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,5,0) */
-
-#endif /* __BACKPORT_OF_IRQ_H */
diff --git a/backport/backport-include/linux/of_net.h b/backport/backport-include/linux/of_net.h
index 18becf5c..866aec57 100644
--- a/backport/backport-include/linux/of_net.h
+++ b/backport/backport-include/linux/of_net.h
@@ -3,15 +3,6 @@
 #include_next <linux/of_net.h>
 #include <linux/version.h>
 
-#ifndef CONFIG_OF
-#if LINUX_VERSION_IS_LESS(3,10,0)
-static inline const void *of_get_mac_address(struct device_node *np)
-{
-	return NULL;
-}
-#endif
-#endif
-
 /* The behavior of of_get_mac_address() changed in kernel 5.2, it now
  * returns an error code and not NULL in case of an error.
  */
diff --git a/backport/backport-include/linux/of_platform.h b/backport/backport-include/linux/of_platform.h
index 625ee9ed..8e522e24 100644
--- a/backport/backport-include/linux/of_platform.h
+++ b/backport/backport-include/linux/of_platform.h
@@ -2,25 +2,6 @@
 #define __BACKPORT_LINUX_OF_PLATFORM_H
 #include_next <linux/of_platform.h>
 #include <linux/version.h>
-#include <linux/of.h>
-/* upstream now includes this here and some people rely on it */
-#include <linux/of_device.h>
-
-#if LINUX_VERSION_IS_LESS(3,4,0) && !defined(CONFIG_OF_DEVICE)
-struct of_dev_auxdata;
-#define of_platform_populate LINUX_BACKPORT(of_platform_populate)
-static inline int of_platform_populate(struct device_node *root,
-					const struct of_device_id *matches,
-					const struct of_dev_auxdata *lookup,
-					struct device *parent)
-{
-	return -ENODEV;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,4,0) */
-
-#if LINUX_VERSION_IS_LESS(3,11,0) && !defined(CONFIG_OF_DEVICE)
-extern const struct of_device_id of_default_bus_match_table[];
-#endif /* LINUX_VERSION_IS_LESS(3,11,0) */
 
 #if LINUX_VERSION_IS_LESS(4,3,0) && !defined(CONFIG_OF_DEVICE)
 struct of_dev_auxdata;
diff --git a/backport/backport-include/linux/olpc-ec.h b/backport/backport-include/linux/olpc-ec.h
deleted file mode 100644
index 353107f6..00000000
--- a/backport/backport-include/linux/olpc-ec.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _COMPAT_LINUX_OLPC_EC_H
-#define _COMPAT_LINUX_OLPC_EC_H
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,6,0)
-#include_next <linux/olpc-ec.h>
-#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
-
-#endif	/* _COMPAT_LINUX_OLPC_EC_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 1cc5f281..caf15db3 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -7,136 +7,7 @@
 #include <linux/pci-aspm.h>
 #endif
 
-#ifndef module_pci_driver
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
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define pcie_capability_read_word LINUX_BACKPORT(pcie_capability_read_word)
-int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
-#define pcie_capability_read_dword LINUX_BACKPORT(pcie_capability_read_dword)
-int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-#define pcie_capability_write_word LINUX_BACKPORT(pcie_capability_write_word)
-int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
-#define pcie_capability_write_dword LINUX_BACKPORT(pcie_capability_write_dword)
-int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);
-#define pcie_capability_clear_and_set_word LINUX_BACKPORT(pcie_capability_clear_and_set_word)
-int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
-				       u16 clear, u16 set);
-#define pcie_capability_clear_and_set_dword LINUX_BACKPORT(pcie_capability_clear_and_set_dword)
-int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
-					u32 clear, u32 set);
-
-#define pcie_capability_set_word LINUX_BACKPORT(pcie_capability_set_word)
-static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
-					   u16 set)
-{
-	return pcie_capability_clear_and_set_word(dev, pos, 0, set);
-}
-
-#define pcie_capability_set_dword LINUX_BACKPORT(pcie_capability_set_dword)
-static inline int pcie_capability_set_dword(struct pci_dev *dev, int pos,
-					    u32 set)
-{
-	return pcie_capability_clear_and_set_dword(dev, pos, 0, set);
-}
-
-#define pcie_capability_clear_word LINUX_BACKPORT(pcie_capability_clear_word)
-static inline int pcie_capability_clear_word(struct pci_dev *dev, int pos,
-					     u16 clear)
-{
-	return pcie_capability_clear_and_set_word(dev, pos, clear, 0);
-}
-
-#define pcie_capability_clear_dword LINUX_BACKPORT(pcie_capability_clear_dword)
-static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
-					      u32 clear)
-{
-	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
-}
-#endif
-
-#ifndef PCI_DEVICE_SUB
-/**
- * PCI_DEVICE_SUB - macro used to describe a specific pci device with subsystem
- * @vend: the 16 bit PCI Vendor ID
- * @dev: the 16 bit PCI Device ID
- * @subvend: the 16 bit PCI Subvendor ID
- * @subdev: the 16 bit PCI Subdevice ID
- *
- * This macro is used to create a struct pci_device_id that matches a
- * specific device with subsystem information.
- */
-#define PCI_DEVICE_SUB(vend, dev, subvend, subdev) \
-	.vendor = (vend), .device = (dev), \
-	.subvendor = (subvend), .subdevice = (subdev)
-#endif /* PCI_DEVICE_SUB */
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#define pci_dev_flags LINUX_BACKPORT(pci_dev_flags)
-#define PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG LINUX_BACKPORT(PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG)
-#define PCI_DEV_FLAGS_NO_D3 LINUX_BACKPORT(PCI_DEV_FLAGS_NO_D3)
-#define PCI_DEV_FLAGS_ASSIGNED LINUX_BACKPORT(PCI_DEV_FLAGS_ASSIGNED)
-enum pci_dev_flags {
-	/* INTX_DISABLE in PCI_COMMAND register disables MSI
-	 * generation too.
-	 */
-	PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG = (__force pci_dev_flags_t) 1,
-	/* Device configuration is irrevocably lost if disabled into D3 */
-	PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) 2,
-	/* Provide indication device is assigned by a Virtual Machine Manager */
-	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
-};
-#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
-
-#if LINUX_VERSION_IS_LESS(3,8,0)
-#define pci_sriov_set_totalvfs LINUX_BACKPORT(pci_sriov_set_totalvfs)
-int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
 
-#if LINUX_VERSION_IS_LESS(3,10,0)
-/* Taken from drivers/pci/pci.h */
-struct pci_sriov {
-	int pos;		/* capability position */
-	int nres;		/* number of resources */
-	u32 cap;		/* SR-IOV Capabilities */
-	u16 ctrl;		/* SR-IOV Control */
-	u16 total_VFs;		/* total VFs associated with the PF */
-	u16 initial_VFs;	/* initial VFs associated with the PF */
-	u16 num_VFs;		/* number of VFs available */
-	u16 offset;		/* first VF Routing ID offset */
-	u16 stride;		/* following VF stride */
-	u32 pgsz;		/* page size for BAR alignment */
-	u8 link;		/* Function Dependency Link */
-	u16 driver_max_VFs;	/* max num VFs driver supports */
-	struct pci_dev *dev;	/* lowest numbered PF */
-	struct pci_dev *self;	/* this PF */
-	struct mutex lock;	/* lock for VF bus */
-	struct work_struct mtask; /* VF Migration task */
-	u8 __iomem *mstate;	/* VF Migration State Array */
-};
-
-#define pci_vfs_assigned LINUX_BACKPORT(pci_vfs_assigned)
-#ifdef CONFIG_PCI_IOV
-int pci_vfs_assigned(struct pci_dev *dev);
-#else
-static inline int pci_vfs_assigned(struct pci_dev *dev)
-{
-	return 0;
-}
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
 #if LINUX_VERSION_IS_LESS(4,8,0)
 #define pci_alloc_irq_vectors LINUX_BACKPORT(pci_alloc_irq_vectors)
@@ -157,58 +28,8 @@ static inline void pci_free_irq_vectors(struct pci_dev *dev)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
-#ifdef CONFIG_PCI_MSI
-int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
-#else
-static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
-				       int maxvec)
-{ return -ENOSYS; }
-#endif
-#endif
-
-#ifdef CONFIG_PCI
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define pci_enable_msix_range LINUX_BACKPORT(pci_enable_msix_range)
-#ifdef CONFIG_PCI_MSI
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-			  int minvec, int maxvec);
-#else
-static inline int pci_enable_msix_range(struct pci_dev *dev,
-		      struct msix_entry *entries, int minvec, int maxvec)
-{ return -ENOSYS; }
-#endif
-#endif
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#define pci_device_is_present LINUX_BACKPORT(pci_device_is_present)
-bool pci_device_is_present(struct pci_dev *pdev);
-#endif
-
-#ifdef CONFIG_PCI
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define pci_enable_msix_exact LINUX_BACKPORT(pci_enable_msix_exact)
-#ifdef CONFIG_PCI_MSI
-static inline int pci_enable_msix_exact(struct pci_dev *dev,
-					struct msix_entry *entries, int nvec)
-{
-	int rc = pci_enable_msix_range(dev, entries, nvec, nvec);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-#else
-static inline int pci_enable_msix_exact(struct pci_dev *dev,
-		      struct msix_entry *entries, int nvec)
-{ return -ENOSYS; }
-#endif /* CONFIG_PCI_MSI */
-#endif
-#endif /* CONFIG_PCI */
 
 #if LINUX_VERSION_IS_LESS(4,9,0) &&			\
-	!LINUX_VERSION_IN_RANGE(3,12,69, 3,13,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,4,37, 4,5,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
 
@@ -226,7 +47,7 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
-#endif/* <4.9.0 but not >= 3.12.69, 4.4.37, 4.8.13 */
+#endif/* <4.9.0 but not >= 4.4.37, 4.8.13 */
 
 #ifndef PCI_IRQ_LEGACY
 #define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
diff --git a/backport/backport-include/linux/percpu.h b/backport/backport-include/linux/percpu.h
deleted file mode 100644
index 10be03cb..00000000
--- a/backport/backport-include/linux/percpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (C) 2018 Intel Corporation
- */
-#ifndef __BACKPORT_PERCPU_H
-#define __BACKPORT_PERCPU_H
-#include_next <linux/percpu.h>
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-static inline void __percpu *__alloc_gfp_warn(void)
-{
-	WARN(1, "Cannot backport alloc_percpu_gfp");
-	return NULL;
-}
-
-#define alloc_percpu_gfp(type, gfp) \
-	({ (gfp == GFP_KERNEL) ? alloc_percpu(type) : __alloc_gfp_warn(); })
-#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
-
-#endif /* __BACKPORT_PERCPU_H */
diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index f331428b..8ffdbc8e 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -4,11 +4,6 @@
 #include <linux/compiler.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define phy_connect(dev, bus_id, handler, interface) \
-	phy_connect(dev, bus_id, handler, 0, interface)
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define phydev_name LINUX_BACKPORT(phydev_name)
 static inline const char *phydev_name(const struct phy_device *phydev)
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index 18cbbace..4b664e53 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -2,16 +2,7 @@
 #define _COMPAT_LINUX_PM_QOS_H 1
 
 #include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,2,0)
 #include_next <linux/pm_qos.h>
-#else
-#include <linux/pm_qos_params.h>
-#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-#ifndef PM_QOS_DEFAULT_VALUE
-#define PM_QOS_DEFAULT_VALUE -1
-#endif
 
 #if LINUX_VERSION_IS_LESS(5,7,0)
 static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
deleted file mode 100644
index e16cd30b..00000000
--- a/backport/backport-include/linux/pm_runtime.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef __BACKPORT_PM_RUNTIME_H
-#define __BACKPORT_PM_RUNTIME_H
-#include_next <linux/pm_runtime.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define pm_runtime_active LINUX_BACKPORT(pm_runtime_active)
-#ifdef CONFIG_PM
-static inline bool pm_runtime_active(struct device *dev)
-{
-	return dev->power.runtime_status == RPM_ACTIVE
-		|| dev->power.disable_depth;
-}
-#else
-static inline bool pm_runtime_active(struct device *dev) { return true; }
-#endif /* CONFIG_PM */
-
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-static inline int pm_runtime_force_suspend(struct device *dev)
-{
-#ifdef CONFIG_PM
-	/* cannot backport properly, I think */
-	WARN_ON_ONCE(1);
-	return -EINVAL;
-#endif
-	return 0;
-}
-static inline int pm_runtime_force_resume(struct device *dev)
-{
-#ifdef CONFIG_PM
-	/* cannot backport properly, I think */
-	WARN_ON_ONCE(1);
-	return -EINVAL;
-#endif
-	return 0;
-}
-#endif
-
-#endif /* __BACKPORT_PM_RUNTIME_H */
diff --git a/backport/backport-include/linux/poll.h b/backport/backport-include/linux/poll.h
index aea64048..725335f7 100644
--- a/backport/backport-include/linux/poll.h
+++ b/backport/backport-include/linux/poll.h
@@ -1,21 +1,7 @@
 #ifndef __BACKPORT_LINUX_POLL_H
 #define __BACKPORT_LINUX_POLL_H
 #include_next <linux/poll.h>
-#include <linux/version.h>
-#include <linux/eventpoll.h>
-
-#if  LINUX_VERSION_IS_LESS(3,4,0)
-#define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
-static inline bool poll_does_not_wait(const poll_table *p)
-{
-	return p == NULL || p->qproc == NULL;
-}
-
-#define poll_requested_events LINUX_BACKPORT(poll_requested_events)
-static inline unsigned long poll_requested_events(const poll_table *p)
-{
-	return p ? p->key : ~0UL;
-}
-#endif /* < 3.4 */
+/* This import is needed for <= 4.15 */
+#include <uapi/linux/eventpoll.h>
 
 #endif /* __BACKPORT_LINUX_POLL_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index 22851d7f..2527aeaa 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -4,140 +4,6 @@
 #include <linux/version.h>
 #include_next <linux/printk.h>
 
-/* see pr_fmt at end of file */
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/* backports 7a555613 */
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,     \
-			 groupsize, buf, len, ascii)            \
-do {                                                           \
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,               \
-	__builtin_constant_p(prefix_str) ? prefix_str : "hexdump");\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))  \
-		print_hex_dump(KERN_DEBUG, prefix_str,          \
-			       prefix_type, rowsize, groupsize, \
-			       buf, len, ascii);                \
-} while (0)
-#define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
-			     groupsize, buf, len, ascii)        \
-	dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
-			 groupsize, buf, len, ascii)
-#else
-#define print_hex_dump_debug(prefix_str, prefix_type, rowsize,         \
-			     groupsize, buf, len, ascii)                \
-	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,    \
-		       groupsize, buf, len, ascii)
-#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
-
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
-#ifndef pr_warn
-#define pr_warn pr_warning
-#endif
-
-#ifndef printk_once
-#define printk_once(x...) ({			\
-	static bool __print_once;		\
-						\
-	if (!__print_once) {			\
-		__print_once = true;		\
-		printk(x);			\
-	}					\
-})
-#endif
-
-#ifndef printk_ratelimited
-/*
- * ratelimited messages with local ratelimit_state,
- * no local ratelimit_state used in the !PRINTK case
- */
-#ifdef CONFIG_PRINTK
-#define printk_ratelimited(fmt, ...)					\
-({									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-									\
-	if (__ratelimit(&_rs))						\
-		printk(fmt, ##__VA_ARGS__);				\
-})
-#else
-#define printk_ratelimited(fmt, ...)					\
-	no_printk(fmt, ##__VA_ARGS__)
-#endif
-#endif /* printk_ratelimited */
-
-#ifndef pr_emerg_ratelimited
-#define pr_emerg_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_emerg_ratelimited */
-
-#ifndef pr_alert_ratelimited
-#define pr_alert_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_alert_ratelimited */
-
-#ifndef pr_crit_ratelimited
-#define pr_crit_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_crit_ratelimited */
-
-#ifndef pr_err_ratelimited
-#define pr_err_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_err_ratelimited */
-
-#ifndef pr_warn_ratelimited
-#define pr_warn_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_warn_ratelimited */
-
-#ifndef pr_notice_ratelimited
-#define pr_notice_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_notice_ratelimited */
-
-#ifndef pr_info_ratelimited
-#define pr_info_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
-#endif /* pr_info_ratelimited */
-
-/* no pr_cont_ratelimited, don't do that... */
-
-#ifndef pr_devel_ratelimited
-#if defined(DEBUG)
-#define pr_devel_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#else
-#define pr_devel_ratelimited(fmt, ...)					\
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#endif
-#endif /* pr_devel_ratelimited */
-
-#ifndef pr_debug_ratelimited
-/* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG)
-/* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define pr_debug_ratelimited(fmt, ...)					\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
-	    __ratelimit(&_rs))						\
-		__dynamic_pr_debug(&descriptor, fmt, ##__VA_ARGS__);	\
-} while (0)
-#elif defined(DEBUG)
-#define pr_debug_ratelimited(fmt, ...)					\
-	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#else
-#define pr_debug_ratelimited(fmt, ...) \
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#endif
-#endif /* pr_debug_ratelimited */
-
 /* replace hex_dump_to_buffer() with a version which returns the length */
 #if LINUX_VERSION_IS_LESS(4,0,0)
 #define hex_dump_to_buffer LINUX_BACKPORT(hex_dump_to_buffer)
@@ -147,8 +13,3 @@ extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 #endif
 
 #endif	/* _COMPAT_LINUX_PRINTK_H */
-
-/* This must be outside -- see also kernel.h */
-#ifndef pr_fmt
-#define pr_fmt(fmt) fmt
-#endif
diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
deleted file mode 100644
index be239bf8..00000000
--- a/backport/backport-include/linux/proc_fs.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_PROC_FS_H
-#define __BACKPORT_PROC_FS_H
-#include_next <linux/proc_fs.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-
-#ifdef CONFIG_PROC_FS
-/*
- * backport of:
- * procfs: new helper - PDE_DATA(inode)
- */
-#define PDE_DATA LINUX_BACKPORT(PDE_DATA)
-static inline void *PDE_DATA(const struct inode *inode)
-{
-	return PROC_I(inode)->pde->data;
-}
-extern void proc_set_size(struct proc_dir_entry *, loff_t);
-extern void proc_set_user(struct proc_dir_entry *, kuid_t, kgid_t);
-#else
-#define PDE_DATA LINUX_BACKPORT(PDE_DATA)
-static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
-static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
-static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
-#endif /* CONFIG_PROC_FS */
-
-#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
-
-#endif /* __BACKPORT_PROC_FS_H */
diff --git a/backport/backport-include/linux/property.h b/backport/backport-include/linux/property.h
index a0d7bed1..7f3c6fe6 100644
--- a/backport/backport-include/linux/property.h
+++ b/backport/backport-include/linux/property.h
@@ -1,9 +1,7 @@
 #ifndef __BACKPORT_LINUX_PROPERTY_H_
 #define __BACKPORT_LINUX_PROPERTY_H_
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,18,17)
 #include_next <linux/property.h>
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,3,0)
 
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
deleted file mode 100644
index e4483c0e..00000000
--- a/backport/backport-include/linux/ptp_clock_kernel.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef __BACKPORT_PTP_CLOCK_KERNEL_H
-#define __BACKPORT_PTP_CLOCK_KERNEL_H
-
-#include <linux/version.h>
-#include_next <linux/ptp_clock_kernel.h>
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-#include <linux/posix-clock.h>
-
-#define PTP_MAX_TIMESTAMPS 128
-#define PTP_BUF_TIMESTAMPS 30
-
-struct timestamp_event_queue {
-	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
-	int head;
-	int tail;
-	spinlock_t lock;
-};
-
-struct ptp_clock {
-	struct posix_clock clock;
-	struct device *dev;
-	struct ptp_clock_info *info;
-	dev_t devid;
-	int index; /* index into clocks.map */
-	struct pps_device *pps_source;
-	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
-	struct mutex tsevq_mux; /* one process at a time reading the fifo */
-	wait_queue_head_t tsev_wq;
-	int defunct; /* tells readers to go away when clock is being removed */
-};
-
-extern int ptp_clock_index(struct ptp_clock *ptp);
-#endif /* LINUX_VERSION_IS_LESS(3,5,0) */
-
-#if LINUX_VERSION_IS_LESS(3,7,0) && !defined(CONFIG_SUSE_KERNEL)
-#define ptp_clock_register(info,parent) ptp_clock_register(info)
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-
-#endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index 7d817d8b..f59ab8bc 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -3,44 +3,6 @@
 #include_next <linux/random.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_IS_GEQ(3,3,0) && LINUX_VERSION_IS_LESS(3,4,10)) || \
-    (LINUX_VERSION_IS_GEQ(3,1,0) && LINUX_VERSION_IS_LESS(3,2,27)) || \
-    LINUX_VERSION_IS_LESS(3,0,41)
-#define add_device_randomness LINUX_BACKPORT(add_device_randomness)
-static inline void add_device_randomness(const void *buf, unsigned int size)
-{
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,8,0)
-/* backports 496f2f9 */
-#define prandom_seed(_seed)		srandom32(_seed)
-#define prandom_u32()			random32()
-#define prandom_u32_state(_state)	prandom32(_state)
-/* backport 6582c665d6b882dad8329e05749fbcf119f1ab88 */
-#define prandom_bytes LINUX_BACKPORT(prandom_bytes)
-void prandom_bytes(void *buf, int bytes);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,14,0)
-/**
- * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
- * @ep_ro: right open interval endpoint
- *
- * Returns a pseudo-random number that is in interval [0, ep_ro). Note
- * that the result depends on PRNG being well distributed in [0, ~0U]
- * u32 space. Here we use maximally equidistributed combined Tausworthe
- * generator, that is, prandom_u32(). This is useful when requesting a
- * random index of an array containing ep_ro elements, for example.
- *
- * Returns: pseudo-random number in interval [0, ep_ro)
- */
-#define prandom_u32_max LINUX_BACKPORT(prandom_u32_max)
-static inline u32 prandom_u32_max(u32 ep_ro)
-{
-	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
 static inline u32 get_random_u32(void)
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 967cdb86..ccc82858 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -3,61 +3,8 @@
 #include_next <linux/rculist.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#include <backport/magic.h>
-#define hlist_for_each_entry_rcu4(tpos, pos, head, member)		\
-	for (pos = rcu_dereference_raw(hlist_first_rcu(head));		\
-	     pos &&							\
-		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });\
-	     pos = rcu_dereference_raw(hlist_next_rcu(pos)))
-
-#define hlist_for_each_entry_rcu3(pos, head, member)				\
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
-			typeof(*(pos)), member);				\
-		pos;								\
-		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
-			&(pos)->member)), typeof(*(pos)), member))
-
-#undef hlist_for_each_entry_rcu
-#define hlist_for_each_entry_rcu(...) \
-	macro_dispatcher(hlist_for_each_entry_rcu, __VA_ARGS__)(__VA_ARGS__)
-#endif /* < 3.9 */
-
-#ifndef list_for_each_entry_continue_rcu
-#define list_for_each_entry_continue_rcu(pos, head, member) 		\
-	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
-	     prefetch(pos->member.next), &pos->member != (head);	\
-	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
-#endif
-
-#ifndef list_entry_rcu
-#define list_entry_rcu(ptr, type, member) \
-	container_of(rcu_dereference(ptr), type, member)
-#endif
-
-#ifndef list_first_or_null_rcu
-/**
- * list_first_or_null_rcu - get the first element from a list
- * @ptr:        the list head to take the element from.
- * @type:       the type of the struct this is embedded in.
- * @member:     the name of the list_struct within the struct.
- *
- * Note that if the list is empty, it returns NULL.
- *
- * This primitive may safely run concurrently with the _rcu list-mutation
- * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
- */
-#define list_first_or_null_rcu(ptr, type, member) \
-({ \
-	struct list_head *__ptr = (ptr); \
-	struct list_head *__next = ACCESS_ONCE(__ptr->next); \
-	likely(__ptr != __next) ? list_entry_rcu(__next, type, member) : NULL; \
-})
-#endif /* list_first_or_null_rcu */
-
 
 #if LINUX_VERSION_IS_LESS(5,4,0)
-
 /**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
  * @pos:	the type * to use as a loop cursor.
diff --git a/backport/backport-include/linux/regmap.h b/backport/backport-include/linux/regmap.h
deleted file mode 100644
index 4b73c46b..00000000
--- a/backport/backport-include/linux/regmap.h
+++ /dev/null
@@ -1,51 +0,0 @@
-#ifndef __BACKPORT_LINUX_REGMAP_H
-#define __BACKPORT_LINUX_REGMAP_H
-#include_next <linux/regmap.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,5,0) && \
-    LINUX_VERSION_IS_GEQ(3,2,0)
-#define dev_get_regmap LINUX_BACKPORT(dev_get_regmap)
-static inline
-struct regmap *dev_get_regmap(struct device *dev, const char *name)
-{
-	return NULL;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,4,0) && \
-    LINUX_VERSION_IS_GEQ(3,2,0)
-#if defined(CONFIG_REGMAP)
-#define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				const struct regmap_config *config);
-#if defined(CONFIG_REGMAP_I2C)
-#define devm_regmap_init_i2c LINUX_BACKPORT(devm_regmap_init_i2c)
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config);
-#endif /* defined(CONFIG_REGMAP_I2C) */
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
-#endif /* 3.2 <= version < 3.4 */
-
-#endif /* __BACKPORT_LINUX_REGMAP_H */
diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
deleted file mode 100644
index 99015af7..00000000
--- a/backport/backport-include/linux/rfkill.h
+++ /dev/null
@@ -1,167 +0,0 @@
-#ifndef __COMPAT_RFKILL_H
-#define __COMPAT_RFKILL_H
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,10,0)
-#include_next <linux/rfkill.h>
-#else
-/* API only slightly changed since then */
-#define rfkill_type old_rfkill_type
-#define RFKILL_TYPE_ALL OLD_RFKILL_TYPE_ALL
-#define RFKILL_TYPE_WLAN OLD_RFKILL_TYPE_WLAN
-#define RFKILL_TYPE_BLUETOOTH OLD_RFKILL_TYPE_BLUETOOTH
-#define RFKILL_TYPE_UWB OLD_RFKILL_TYPE_UWB
-#define RFKILL_TYPE_WIMAX OLD_RFKILL_TYPE_WIMAX
-#define RFKILL_TYPE_WWAN OLD_RFKILL_TYPE_WWAN
-#define RFKILL_TYPE_GPS OLD_RFKILL_TYPE_GPS
-#define RFKILL_TYPE_FM OLD_RFKILL_TYPE_FM
-#define RFKILL_TYPE_NFC OLD_RFKILL_TYPE_NFC
-#define NUM_RFKILL_TYPES OLD_NUM_RFKILL_TYPES
-#include_next <linux/rfkill.h>
-#undef rfkill_type
-#undef RFKILL_TYPE_ALL
-#undef RFKILL_TYPE_WLAN
-#undef RFKILL_TYPE_BLUETOOTH
-#undef RFKILL_TYPE_UWB
-#undef RFKILL_TYPE_WIMAX
-#undef RFKILL_TYPE_WWAN
-#undef RFKILL_TYPE_GPS
-#undef RFKILL_TYPE_FM
-#undef RFKILL_TYPE_NFC
-#undef NUM_RFKILL_TYPES
-#define HAVE_OLD_RFKILL
-
-/* this changes infrequently, backport manually */
-enum rfkill_type {
-	RFKILL_TYPE_ALL = 0,
-	RFKILL_TYPE_WLAN,
-	RFKILL_TYPE_BLUETOOTH,
-	RFKILL_TYPE_UWB,
-	RFKILL_TYPE_WIMAX,
-	RFKILL_TYPE_WWAN,
-	RFKILL_TYPE_GPS,
-	RFKILL_TYPE_FM,
-	RFKILL_TYPE_NFC,
-	NUM_RFKILL_TYPES,
-};
-
-static inline struct rfkill * __must_check
-backport_rfkill_alloc(const char *name,
-		      struct device *parent,
-		      const enum rfkill_type type,
-		      const struct rfkill_ops *ops,
-		      void *ops_data)
-{
-#ifdef HAVE_OLD_RFKILL
-	if ((unsigned int)type >= (unsigned int)OLD_NUM_RFKILL_TYPES)
-		return ERR_PTR(-ENODEV);
-	return rfkill_alloc(name, parent, (enum old_rfkill_type)type,
-			    ops, ops_data);
-#else
-	return ERR_PTR(-ENODEV);
-#endif
-}
-#define rfkill_alloc backport_rfkill_alloc
-
-static inline int __must_check backport_rfkill_register(struct rfkill *rfkill)
-{
-	if (rfkill == ERR_PTR(-ENODEV))
-		return 0;
-#ifdef HAVE_OLD_RFKILL
-	return rfkill_register(rfkill);
-#else
-	return -EINVAL;
-#endif
-}
-#define rfkill_register backport_rfkill_register
-
-static inline void backport_rfkill_pause_polling(struct rfkill *rfkill)
-{
-#ifdef HAVE_OLD_RFKILL
-	rfkill_pause_polling(rfkill);
-#endif
-}
-#define rfkill_pause_polling backport_rfkill_pause_polling
-
-static inline void backport_rfkill_resume_polling(struct rfkill *rfkill)
-{
-#ifdef HAVE_OLD_RFKILL
-	rfkill_resume_polling(rfkill);
-#endif
-}
-#define rfkill_resume_polling backport_rfkill_resume_polling
-
-static inline void backport_rfkill_unregister(struct rfkill *rfkill)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill == ERR_PTR(-ENODEV))
-		return;
-	rfkill_unregister(rfkill);
-#endif
-}
-#define rfkill_unregister backport_rfkill_unregister
-
-static inline void backport_rfkill_destroy(struct rfkill *rfkill)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill == ERR_PTR(-ENODEV))
-		return;
-	rfkill_destroy(rfkill);
-#endif
-}
-#define rfkill_destroy backport_rfkill_destroy
-
-static inline bool backport_rfkill_set_hw_state(struct rfkill *rfkill,
-						bool blocked)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill != ERR_PTR(-ENODEV))
-		return rfkill_set_hw_state(rfkill, blocked);
-#endif
-	return blocked;
-}
-#define rfkill_set_hw_state backport_rfkill_set_hw_state
-
-static inline bool backport_rfkill_set_sw_state(struct rfkill *rfkill,
-						bool blocked)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill != ERR_PTR(-ENODEV))
-		return rfkill_set_sw_state(rfkill, blocked);
-#endif
-	return blocked;
-}
-#define rfkill_set_sw_state backport_rfkill_set_sw_state
-
-static inline void backport_rfkill_init_sw_state(struct rfkill *rfkill,
-						 bool blocked)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill != ERR_PTR(-ENODEV))
-		rfkill_init_sw_state(rfkill, blocked);
-#endif
-}
-#define rfkill_init_sw_state backport_rfkill_init_sw_state
-
-static inline void backport_rfkill_set_states(struct rfkill *rfkill,
-					      bool sw, bool hw)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill != ERR_PTR(-ENODEV))
-		rfkill_set_states(rfkill, sw, hw);
-#endif
-}
-#define rfkill_set_states backport_rfkill_set_states
-
-static inline bool backport_rfkill_blocked(struct rfkill *rfkill)
-{
-#ifdef HAVE_OLD_RFKILL
-	if (rfkill != ERR_PTR(-ENODEV))
-		return rfkill_blocked(rfkill);
-#endif
-	return false;
-}
-#define rfkill_blocked backport_rfkill_blocked
-#endif
-
-#endif
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
deleted file mode 100644
index 59beffa8..00000000
--- a/backport/backport-include/linux/rtnetlink.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_LINUX_RTNETLINK_H
-#define __BACKPORT_LINUX_RTNETLINK_H
-#include_next <linux/rtnetlink.h>
-
-#ifndef rtnl_dereference
-#define rtnl_dereference(p)                                     \
-        rcu_dereference_protected(p, lockdep_rtnl_is_held())
-#endif
-
-#ifndef rcu_dereference_rtnl
-#define rcu_dereference_rtnl(p)					\
-	rcu_dereference_check(p, rcu_read_lock_held() ||	\
-				 lockdep_rtnl_is_held())
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags) \
-	ndo_dflt_fdb_add(ndm, tb, dev, addr, flags)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,13,0) &&		\
-	!defined(CONFIG_PROVE_LOCKING)
-static inline bool lockdep_rtnl_is_held(void)
-{
-	return true;
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_RTNETLINK_H */
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index 06934b6b..bb0fb1a6 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -2,106 +2,6 @@
 #define __BACKPORT_SCATTERLIST_H
 #include_next <linux/scatterlist.h>
 
-#if LINUX_VERSION_IS_LESS(3,7,0)
-int sg_nents(struct scatterlist *sg);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3, 9, 0)
-
-/*
- * sg page iterator
- *
- * Iterates over sg entries page-by-page.  On each successful iteration,
- * @piter->page points to the current page, @piter->sg to the sg holding this
- * page and @piter->sg_pgoffset to the page's page offset within the sg. The
- * iteration will stop either when a maximum number of sg entries was reached
- * or a terminating sg (sg_last(sg) == true) was reached.
- */
-struct sg_page_iter {
-	struct page             *page;          /* current page */
-	struct scatterlist      *sg;            /* sg holding the page */
-	unsigned int            sg_pgoffset;    /* page offset within the sg */
-
-	/* these are internal states, keep away */
-	unsigned int            __nents;        /* remaining sg entries */
-	int                     __pg_advance;   /* nr pages to advance at the
-						 * next step */
-};
-
-struct backport_sg_mapping_iter {
-	/* the following three fields can be accessed directly */
-	struct page		*page;		/* currently mapped page */
-	void			*addr;		/* pointer to the mapped area */
-	size_t			length;		/* length of the mapped area */
-	size_t			consumed;	/* number of consumed bytes */
-	struct sg_page_iter	piter;		/* page iterator */
-
-	/* these are internal states, keep away */
-	unsigned int		__offset;	/* offset within page */
-	unsigned int		__remaining;	/* remaining bytes on page */
-	unsigned int		__flags;
-};
-#define sg_mapping_iter LINUX_BACKPORT(sg_mapping_iter)
-
-/**
- * sg_page_iter_page - get the current page held by the page iterator
- * @piter:	page iterator holding the page
- */
-static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
-{
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
-}
-
-bool __sg_page_iter_next(struct sg_page_iter *piter);
-void __sg_page_iter_start(struct sg_page_iter *piter,
-			  struct scatterlist *sglist, unsigned int nents,
-			  unsigned long pgoffset);
-
-void backport_sg_miter_start(struct sg_mapping_iter *miter, struct scatterlist *sgl,
-		    unsigned int nents, unsigned int flags);
-bool backport_sg_miter_next(struct sg_mapping_iter *miter);
-void backport_sg_miter_stop(struct sg_mapping_iter *miter);
-#define sg_miter_start LINUX_BACKPORT(sg_miter_start)
-#define sg_miter_next LINUX_BACKPORT(sg_miter_next)
-#define sg_miter_stop LINUX_BACKPORT(sg_miter_stop)
-
-/**
- * for_each_sg_page - iterate over the pages of the given sg list
- * @sglist:    sglist to iterate over
- * @piter:     page iterator to hold current page, sg, sg_pgoffset
- * @nents:     maximum number of sg entries to iterate over
- * @pgoffset:  starting page offset
- */
-#define for_each_sg_page(sglist, piter, nents, pgoffset)		\
-	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
-	     __sg_page_iter_next(piter);)
-
-#endif /* LINUX_VERSION_IS_LESS(3, 9, 0) */
-
-#if LINUX_VERSION_IS_LESS(3, 11, 0)
-size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
-		      size_t buflen, off_t skip, bool to_buffer);
-
-#define sg_pcopy_to_buffer LINUX_BACKPORT(sg_pcopy_to_buffer)
-
-static inline
-size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
-			  void *buf, size_t buflen, off_t skip)
-{
-	return sg_copy_buffer(sgl, nents, buf, buflen, skip, true);
-}
-
-#define sg_pcopy_from_buffer LINUX_BACKPORT(sg_pcopy_from_buffer)
-
-static inline
-size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
-			    void *buf, size_t buflen, off_t skip)
-{
-	return sg_copy_buffer(sgl, nents, buf, buflen, skip, false);
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 11, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 17, 0)
 
 #define sg_init_marker LINUX_BACKPORT(sg_init_marker)
diff --git a/backport/backport-include/linux/security.h b/backport/backport-include/linux/security.h
deleted file mode 100644
index 2dfb964b..00000000
--- a/backport/backport-include/linux/security.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __BACKPORT_LINUX_SECURITY_H
-#define __BACKPORT_LINUX_SECURITY_H
-#include_next <linux/security.h>
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-/*
- * This has been defined in include/linux/security.h for some time, but was
- * only given an EXPORT_SYMBOL for 3.1.  Add a compat_* definition to avoid
- * breaking the compile.
- */
-#define security_sk_clone(a, b) compat_security_sk_clone(a, b)
-
-static inline void security_sk_clone(const struct sock *sk, struct sock *newsk)
-{
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_SECURITY_H */
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 1d78bbbd..08c68ed7 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -3,44 +3,6 @@
 #include_next <linux/seq_file.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#include <linux/user_namespace.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#ifdef CONFIG_USER_NS
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
-	struct file *f = container_of((void *) seq, struct file, private_data);
-
-	return f->f_cred->user_ns;
-}
-#else
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
-	extern struct user_namespace init_user_ns;
-	return &init_user_ns;
-}
-#endif /* CONFIG_USER_NS */
-#endif /* < 3.7 */
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define seq_has_overflowed LINUX_BACKPORT(seq_has_overflowed)
-/**
- * seq_has_overflowed - check if the buffer has overflowed
- * @m: the seq_file handle
- *
- * seq_files have a buffer which may overflow. When this happens a larger
- * buffer is reallocated and all the data will be printed again.
- * The overflow state is true when m->count == m->size.
- *
- * Returns true if the buffer received more than it can hold.
- */
-static inline bool seq_has_overflowed(struct seq_file *m)
-{
-	return m->count == m->size;
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,3,0)
 #define seq_hex_dump LINUX_BACKPORT(seq_hex_dump)
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 338f6fdb..c039e810 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -2,303 +2,8 @@
 #define __BACKPORT_SKBUFF_H
 #include_next <linux/skbuff.h>
 #include <linux/version.h>
-#include <generated/utsrelease.h>
 
-#if LINUX_VERSION_IS_LESS(3,4,0) && \
-      (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)) && \
-      !(defined(CONFIG_SUSE_KERNEL) && LINUX_VERSION_IS_GEQ(3,0,0))
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	skb_add_rx_frag(skb, i, page, off, size)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#define __pskb_copy LINUX_BACKPORT(__pskb_copy)
-extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
-				   int headroom, gfp_t gfp_mask);
-
-#define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
-static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
-{
-	WARN_ON(1);
-}
-
-/* define to 0 so checks for it are always false */
-#define SKBTX_WIFI_STATUS 0
-#elif LINUX_VERSION_IS_LESS(3,18,0)
-#define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
-void skb_complete_wifi_ack(struct sk_buff *skb, bool acked);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#include <linux/dma-mapping.h>
-
-/* mask skb_frag_page as RHEL6 backports this */
-#define skb_frag_page LINUX_BACKPORT(skb_frag_page)
-static inline struct page *skb_frag_page(const skb_frag_t *frag)
-{
-	return frag->page;
-}
-
-#define skb_frag_size LINUX_BACKPORT(skb_frag_size)
-static inline unsigned int skb_frag_size(const skb_frag_t *frag)
-{
-	return frag->size;
-}
-
-/* mask skb_frag_dma_map as RHEL6 backports this */
-#define skb_frag_dma_map LINUX_BACKPORT(skb_frag_dma_map)
-static inline dma_addr_t skb_frag_dma_map(struct device *dev,
-					  const skb_frag_t *frag,
-					  size_t offset, size_t size,
-					  enum dma_data_direction dir)
-{
-	return dma_map_page(dev, skb_frag_page(frag),
-			    frag->page_offset + offset, size, dir);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-/* mask __netdev_alloc_skb_ip_align as RHEL6 backports this */
-#define __netdev_alloc_skb_ip_align(a,b,c) compat__netdev_alloc_skb_ip_align(a,b,c)
-static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev,
-							  unsigned int length, gfp_t gfp)
-{
-	struct sk_buff *skb = __netdev_alloc_skb(dev, length + NET_IP_ALIGN, gfp);
-
-	if (NET_IP_ALIGN && skb)
-		skb_reserve(skb, NET_IP_ALIGN);
-	return skb;
-}
-#endif
-
-#ifndef skb_walk_frags
-#define skb_walk_frags(skb, iter)	\
-	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#define skb_frag_size_sub LINUX_BACKPORT(skb_frag_size_sub)
-static inline void skb_frag_size_sub(skb_frag_t *frag, int delta)
-{
-	frag->size -= delta;
-}
-
-/**
- * skb_frag_address - gets the address of the data contained in a paged fragment
- * @frag: the paged fragment buffer
- *
- * Returns the address of the data within @frag. The page must already
- * be mapped.
- */
-#define skb_frag_address LINUX_BACKPORT(skb_frag_address)
-static inline void *skb_frag_address(const skb_frag_t *frag)
-{
-	return page_address(skb_frag_page(frag)) + frag->page_offset;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#ifndef NETDEV_FRAG_PAGE_MAX_ORDER
-#define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
-#endif
-#ifndef NETDEV_FRAG_PAGE_MAX_SIZE
-#define NETDEV_FRAG_PAGE_MAX_SIZE  (PAGE_SIZE << NETDEV_FRAG_PAGE_MAX_ORDER)
-#endif
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define skb_unclone LINUX_BACKPORT(skb_unclone)
-static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
-{
-	might_sleep_if(pri & __GFP_WAIT);
-	if (skb_cloned(skb))
-		return pskb_expand_head(skb, 0, 0, pri);
-       return 0;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-
-#define skb_frag_address_safe LINUX_BACKPORT(skb_frag_address_safe)
-/**
- * skb_frag_address_safe - gets the address of the data contained in a paged fragment
- * @frag: the paged fragment buffer
- *
- * Returns the address of the data within @frag. Checks that the page
- * is mapped and returns %NULL otherwise.
- */
-static inline void *skb_frag_address_safe(const skb_frag_t *frag)
-{
-	void *ptr = page_address(skb_frag_page(frag));
-	if (unlikely(!ptr))
-		return NULL;
-
-	return ptr + frag->page_offset;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
-
-#if LINUX_VERSION_IS_LESS(3,14,0) && \
-    RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) && \
-    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
-/*
- * Packet hash types specify the type of hash in skb_set_hash.
- *
- * Hash types refer to the protocol layer addresses which are used to
- * construct a packet's hash. The hashes are used to differentiate or identify
- * flows of the protocol layer for the hash type. Hash types are either
- * layer-2 (L2), layer-3 (L3), or layer-4 (L4).
- *
- * Properties of hashes:
- *
- * 1) Two packets in different flows have different hash values
- * 2) Two packets in the same flow should have the same hash value
- *
- * A hash at a higher layer is considered to be more specific. A driver should
- * set the most specific hash possible.
- *
- * A driver cannot indicate a more specific hash than the layer at which a hash
- * was computed. For instance an L3 hash cannot be set as an L4 hash.
- *
- * A driver may indicate a hash level which is less specific than the
- * actual layer the hash was computed on. For instance, a hash computed
- * at L4 may be considered an L3 hash. This should only be done if the
- * driver can't unambiguously determine that the HW computed the hash at
- * the higher layer. Note that the "should" in the second property above
- * permits this.
- */
-enum pkt_hash_types {
-	PKT_HASH_TYPE_NONE,	/* Undefined type */
-	PKT_HASH_TYPE_L2,	/* Input: src_MAC, dest_MAC */
-	PKT_HASH_TYPE_L3,	/* Input: src_IP, dst_IP */
-	PKT_HASH_TYPE_L4,	/* Input: src_IP, dst_IP, src_port, dst_port */
-};
-
-static inline void
-skb_set_hash(struct sk_buff *skb, __u32 hash, enum pkt_hash_types type)
-{
-#if LINUX_VERSION_IS_GEQ(3,2,0) /* 4031ae6edb */
-	skb->l4_rxhash = (type == PKT_HASH_TYPE_L4);
-#endif
-#if LINUX_VERSION_IS_GEQ(3,4,0) /* bdeab99191 */
-	skb->rxhash = hash;
-#endif
-}
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
-
-#if LINUX_VERSION_IS_LESS(3,16,0)
-#define __pskb_copy_fclone LINUX_BACKPORT(__pskb_copy_fclone)
-static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
-						 int headroom, gfp_t gfp_mask,
-						 bool fclone)
-{
-	return __pskb_copy(skb, headroom, gfp_mask);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#define skb_clone_sk LINUX_BACKPORT(skb_clone_sk)
-struct sk_buff *skb_clone_sk(struct sk_buff *skb);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-/**
- * __dev_alloc_pages - allocate page for network Rx
- * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
- * @order: size of the allocation
- *
- * Allocate a new page.
- *
- * %NULL is returned if there is no free memory.
-*/
-#define __dev_alloc_pages LINUX_BACKPORT(__dev_alloc_pages)
-static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
-					     unsigned int order)
-{
-	/* This piece of code contains several assumptions.
-	 * 1.  This is for device Rx, therefor a cold page is preferred.
-	 * 2.  The expectation is the user wants a compound page.
-	 * 3.  If requesting a order 0 page it will not be compound
-	 *     due to the check to see if order has a value in prep_new_page
-	 * 4.  __GFP_MEMALLOC is ignored if __GFP_NOMEMALLOC is set due to
-	 *     code in gfp_to_alloc_flags that should be enforcing this.
-	 */
-	gfp_mask |= __GFP_COLD | __GFP_COMP;
-#if LINUX_VERSION_IS_GEQ(3,6,0)
-	gfp_mask |= __GFP_MEMALLOC;
-#endif
-
-	return alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
-}
-
-#define dev_alloc_pages LINUX_BACKPORT(dev_alloc_pages)
-static inline struct page *dev_alloc_pages(unsigned int order)
-{
-	return __dev_alloc_pages(GFP_ATOMIC, order);
-}
-
-/**
- * __dev_alloc_page - allocate a page for network Rx
- * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
- *
- * Allocate a new page.
- *
- * %NULL is returned if there is no free memory.
- */
-#define __dev_alloc_page LINUX_BACKPORT(__dev_alloc_page)
-static inline struct page *__dev_alloc_page(gfp_t gfp_mask)
-{
-	return __dev_alloc_pages(gfp_mask, 0);
-}
-
-#define dev_alloc_page LINUX_BACKPORT(dev_alloc_page)
-static inline struct page *dev_alloc_page(void)
-{
-	return __dev_alloc_page(GFP_ATOMIC);
-}
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define skb_copy_datagram_msg LINUX_BACKPORT(skb_copy_datagram_msg)
-static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
-					struct msghdr *msg, int size)
-{
-	return skb_copy_datagram_iovec(from, offset, msg->msg_iov, size);
-}
-
-#define memcpy_from_msg LINUX_BACKPORT(memcpy_from_msg)
-static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
-{
-	return memcpy_fromiovec(data, msg->msg_iov, len);
-}
-
-/**
- *	skb_put_padto - increase size and pad an skbuff up to a minimal size
- *	@skb: buffer to pad
- *	@len: minimal length
- *
- *	Pads up a buffer to ensure the trailing bytes exist and are
- *	blanked. If the buffer already contains sufficient data it
- *	is untouched. Otherwise it is extended. Returns zero on
- *	success. The skb is freed on error.
- */
-#define skb_put_padto LINUX_BACKPORT(skb_put_padto)
-static inline int skb_put_padto(struct sk_buff *skb, unsigned int len)
-{
-	unsigned int size = skb->len;
-
-	if (unlikely(size < len)) {
-		len -= size;
-		if (skb_pad(skb, len))
-			return -ENOMEM;
-		__skb_put(skb, len);
-	}
-	return 0;
-}
-
-#define skb_ensure_writable LINUX_BACKPORT(skb_ensure_writable)
-int skb_ensure_writable(struct sk_buff *skb, int write_len);
-
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
 #if LINUX_VERSION_IS_LESS(4,2,0)
 static inline void skb_free_frag(void *data)
@@ -306,14 +11,6 @@ static inline void skb_free_frag(void *data)
 	put_page(virt_to_head_page(data));
 }
 
-#if LINUX_VERSION_IS_LESS(3,3,0)
-
-static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
-{
-	return 0;
-}
-
-#else
 #include <net/flow_keys.h>
 #include <linux/jhash.h>
 
@@ -326,7 +23,6 @@ static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
 			    (__force u32)keys.src ^ keys.ip_proto,
 			    (__force u32)keys.ports, key);
 }
-#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
 #endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
 #if LINUX_VERSION_IS_LESS(4,13,0)
diff --git a/backport/backport-include/linux/slab.h b/backport/backport-include/linux/slab.h
index f36dc40a..8d0cb25b 100644
--- a/backport/backport-include/linux/slab.h
+++ b/backport/backport-include/linux/slab.h
@@ -3,27 +3,6 @@
 #include_next <linux/slab.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,4,0)
-/* This backports:
- *
- * commit a8203725dfded5c1f79dca3368a4a273e24b59bb
- * Author: Xi Wang <xi.wang@gmail.com>
- * Date:   Mon Mar 5 15:14:41 2012 -0800
- *
- * 	slab: introduce kmalloc_array()
- */
-
-#include <linux/kernel.h> /* for SIZE_MAX */
-
-#define kmalloc_array LINUX_BACKPORT(kmalloc_array)
-static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
-{
-	if (size != 0 && n > SIZE_MAX / size)
-		return NULL;
-	return __kmalloc(n * size, flags);
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define kfree_sensitive(x)	kzfree(x)
 #endif
diff --git a/backport/backport-include/linux/spi/spi.h b/backport/backport-include/linux/spi/spi.h
deleted file mode 100644
index 6d2de15f..00000000
--- a/backport/backport-include/linux/spi/spi.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef _BACKPORTS_LINUX_SPI_H
-#define _BACKPORTS_LINUX_SPI_H 1
-
-#include_next <linux/spi/spi.h>
-
-#ifndef module_spi_driver
-/**
- * module_spi_driver() - Helper macro for registering a SPI driver
- * @__spi_driver: spi_driver struct
- *
- * Helper macro for SPI drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_spi_driver(__spi_driver) \
-	module_driver(__spi_driver, spi_register_driver, \
-			spi_unregister_driver)
-#endif
-
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/**
- * spi_message_init_with_transfers - Initialize spi_message and append transfers
- * @m: spi_message to be initialized
- * @xfers: An array of spi transfers
- * @num_xfers: Number of items in the xfer array
- *
- * This function initializes the given spi_message and adds each spi_transfer in
- * the given array to the message.
- */
-#define spi_message_init_with_transfers LINUX_BACKPORT(spi_message_init_with_transfers)
-static inline void
-spi_message_init_with_transfers(struct spi_message *m,
-struct spi_transfer *xfers, unsigned int num_xfers)
-{
-	unsigned int i;
-
-	spi_message_init(m);
-	for (i = 0; i < num_xfers; ++i)
-		spi_message_add_tail(&xfers[i], m);
-}
-
-/**
- * spi_sync_transfer - synchronous SPI data transfer
- * @spi: device with which data will be exchanged
- * @xfers: An array of spi_transfers
- * @num_xfers: Number of items in the xfer array
- * Context: can sleep
- *
- * Does a synchronous SPI data transfer of the given spi_transfer array.
- *
- * For more specific semantics see spi_sync().
- *
- * It returns zero on success, else a negative error code.
- */
-#define spi_sync_transfer LINUX_BACKPORT(spi_sync_transfer)
-static inline int
-spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
-	unsigned int num_xfers)
-{
-	struct spi_message msg;
-
-	spi_message_init_with_transfers(&msg, xfers, num_xfers);
-
-	return spi_sync(spi, &msg);
-}
-#endif /* < 3.9 */
-
-#endif /* _BACKPORTS_LINUX_SPI_H */
diff --git a/backport/backport-include/linux/spinlock.h b/backport/backport-include/linux/spinlock.h
index b27f9171..75083617 100644
--- a/backport/backport-include/linux/spinlock.h
+++ b/backport/backport-include/linux/spinlock.h
@@ -2,20 +2,6 @@
 #define __BACKPORT_SPINLOCK_H
 #include_next <linux/spinlock.h>
 
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
-#undef raw_spin_lock_nested
-/*
- * Always evaluate the 'subclass' argument to avoid that the compiler
- * warns about set-but-not-used variables when building with
- * CONFIG_DEBUG_LOCK_ALLOC=n and with W=1.
- */
-# define raw_spin_lock_nested(lock, subclass)		\
-	_raw_spin_lock(((void)(subclass), (lock)))
-# define raw_spin_lock_nest_lock(lock, nest_lock)	_raw_spin_lock(lock)
-#endif
-#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
-
 
 #if LINUX_VERSION_IS_LESS(4,16,0)
 int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
diff --git a/backport/backport-include/linux/static_key.h b/backport/backport-include/linux/static_key.h
deleted file mode 100644
index 4b82eec2..00000000
--- a/backport/backport-include/linux/static_key.h
+++ /dev/null
@@ -1,49 +0,0 @@
-#ifndef _BACKPORTS_LINUX_STATIC_KEY_H
-#define _BACKPORTS_LINUX_STATIC_KEY_H 1
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(3,3,0) /* kernels >= 3.3 */
-/*
- * XXX: NOTE!
- *
- * Some 3.3 kernels carry <linux/static.h> but some don't even though its
- * its including <linux/jump_label.h>. What makes it more confusing is that
- * later all this got shuffled. The safe thing to do then is to just assume
- * kernels 3.3..3.4 don't have it and include <linux/jump_label.h> instead,
- * and for newer kernels include <linux/static_key.h>.
- */
-#if LINUX_VERSION_IS_GEQ(3,5,0)
-#include_next <linux/static_key.h>
-#else
-#include <linux/jump_label.h>
-#endif
-
-#else /* kernels < 3.3 */
-/*
- * in between 2.6.37 - 3.5 there's a slew of changes that make
- * it hard to backport this properly. If you are interested in
- * trying you can use this as reference:
- *
- * http://drvbp1.linux-foundation.org/~mcgrof/examples/2014/04/01/backport-static-keys.patch
- *
- * And these notes:
- *
- *           < v2.6.37 - No tracing support
- * bf5438fc  - v2.6.37 - Jump label support added primarily for tracing but
- *                       tracing was broken, later kernels started sporting
- *                       functional tracing.
- * d430d3d7e - v3.0    - Static branch optimizations for jump labels
- * c5905afb  - v3.3    - Static keys split out, note on the below issue
- * c5905afb  - v3.5    - git describe --contains c5905afb claims but not true!
- * c4b2c0c5f - v3.13   - Adds static_key_initialized(), STATIC_KEY_CHECK_USE()
- *
- * Because all of this we skip 2.6.37 - 3.3 but and adding support for older
- * can be done by of carrying over the non-architecture optimized code.
- * Carrying new changes into this file is a burden though so if we really
- * find use for this we could just split the non optimized versions upstream
- * and copy that through an automatic process.
- */
-#endif /* kernels < 3.3 */
-
-#endif /* _BACKPORTS_LINUX_STATIC_KEY_H */
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 2bfdf747..f8efd9ed 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,23 +8,6 @@
 extern void *memdup_user_nul(const void __user *, size_t);
 #endif
 
-/* this was added in v3.2.65, v3.4.106, v3.10.60, v3.12.33, v3.14.24,
- * v3.17.3 and v3.18 */
-#if !(LINUX_VERSION_IS_GEQ(3,17,3) || \
-      (LINUX_VERSION_IS_GEQ(3,14,24) && \
-      LINUX_VERSION_IS_LESS(3,15,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,12,33) && \
-      LINUX_VERSION_IS_LESS(3,13,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,10,60) && \
-      LINUX_VERSION_IS_LESS(3,11,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,4,106) && \
-      LINUX_VERSION_IS_LESS(3,5,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,2,65) && \
-      LINUX_VERSION_IS_LESS(3,3,0)))
-#define memzero_explicit LINUX_BACKPORT(memzero_explicit)
-void memzero_explicit(void *s, size_t count);
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,3,0)
 ssize_t strscpy(char *dest, const char *src, size_t count);
 #endif
diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 8ffe12aa..68b78eab 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -4,41 +4,6 @@
 #include <linux/version.h>
 
 #ifdef CONFIG_THERMAL
-#if LINUX_VERSION_IS_LESS(3,8,0)
-#include <linux/errno.h>
-
-struct thermal_bind_params {
-	struct thermal_cooling_device *cdev;
-	int weight;
-	int trip_mask;
-	int (*match)(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev);
-};
-
-struct thermal_zone_params {
-	int num_tbps;
-	struct thermal_bind_params *tbp;
-};
-
-static inline struct thermal_zone_device *
-backport_thermal_zone_device_register(const char *type, int trips, int mask,
-				      void *devdata,
-				      struct thermal_zone_device_ops *ops,
-				      const struct thermal_zone_params *tzp,
-				      int passive_delay, int polling_delay)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-#define thermal_zone_device_register backport_thermal_zone_device_register
-
-static inline void thermal_notify_framework(struct thermal_zone_device *tz,
-	int trip)
-{ }
-#else /* < 3.8.0 */
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-#define thermal_notify_framework notify_thermal_framework
-#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
 #if LINUX_VERSION_IS_LESS(4,3,0)
 
@@ -110,7 +75,6 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
 	LINUX_BACKPORT(thermal_zone_device_unregister)
 
 #endif /* LINUX_VERSION_IS_LESS(4,3,0) */
-#endif /* ! < 3.8.0 */
 #endif /* CONFIG_THERMAL */
 
 #if LINUX_VERSION_IS_LESS(5,9,0)
diff --git a/backport/backport-include/linux/time64.h b/backport/backport-include/linux/time64.h
deleted file mode 100644
index 49805da9..00000000
--- a/backport/backport-include/linux/time64.h
+++ /dev/null
@@ -1,46 +0,0 @@
-#ifndef __BACKPORT_LINUX_TIME64_H
-#define __BACKPORT_LINUX_TIME64_H
-#if LINUX_VERSION_IS_GEQ(3,17,0)
-#include_next <linux/time64.h>
-#else
-#include <linux/time.h>
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#define timespec64_equal		timespec_equal
-#define timespec64_compare		timespec_compare
-#define set_normalized_timespec64	set_normalized_timespec
-#define timespec64_add_safe		timespec_add_safe
-#define timespec64_add			timespec_add
-#define timespec64_sub			timespec_sub
-#define timespec64_valid		timespec_valid
-#define timespec64_valid_strict		timespec_valid_strict
-#define timespec64_to_ns		timespec_to_ns
-#define ns_to_timespec64		ns_to_timespec
-#define timespec64_add_ns		timespec_add_ns
-#define timespec64			timespec
-#endif /* LINUX_VERSION_IS_LESS(3,17,0) */
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-static inline time64_t mktime64(const unsigned int year0, const unsigned int mon0,
-				const unsigned int day, const unsigned int hour,
-				const unsigned int min, const unsigned int sec)
-{
-	unsigned int mon = mon0, year = year0;
-
-	/* 1..12 -> 11,12,1..10 */
-	if (0 >= (int) (mon -= 2)) {
-		mon += 12;	/* Puts Feb last since it has leap day */
-		year -= 1;
-	}
-
-	return ((((time64_t)
-		  (year/4 - year/100 + year/400 + 367*mon/12 + day) +
-		  year*365 - 719499
-	    )*24 + hour /* now have hours - midnight tomorrow handled here */
-	  )*60 + min /* now have minutes */
-	)*60 + sec; /* finally seconds */
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_TIME64_H */
diff --git a/backport/backport-include/linux/timecounter.h b/backport/backport-include/linux/timecounter.h
deleted file mode 100644
index 596015b1..00000000
--- a/backport/backport-include/linux/timecounter.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __BACKPORT_LINUX_TIMECOUNTER_H
-#define __BACKPORT_LINUX_TIMECOUNTER_H
-
-#if LINUX_VERSION_IS_GEQ(3,20,0)
-#include_next <linux/timecounter.h>
-#else
-#include <linux/clocksource.h>
-
-/**
- * timecounter_adjtime - Shifts the time of the clock.
- * @delta:	Desired change in nanoseconds.
- */
-#define timecounter_adjtime LINUX_BACKPORT(timecounter_adjtime)
-static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
-{
-	tc->nsec += delta;
-}
-#endif
-
-#ifndef CYCLECOUNTER_MASK
-/* simplify initialization of mask field */
-#define CYCLECOUNTER_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
-#endif
-
-#endif /* __BACKPORT_LINUX_TIMECOUNTER_H */
diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 25ceaf3e..80c62556 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -3,98 +3,25 @@
 #include <linux/version.h>
 #include <linux/types.h>
 
-#if LINUX_VERSION_IS_GEQ(3,17,0)
 #include_next <linux/timekeeping.h>
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-#define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
-extern ktime_t ktime_get(void);
-#define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
-static inline u64 ktime_get_ns(void)
-{
-	return ktime_to_ns(ktime_get());
-}
 
-extern ktime_t ktime_get_boottime(void);
-#define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
-static inline u64 ktime_get_boottime_ns(void)
-{
-	return ktime_to_ns(ktime_get_boottime());
-}
-#elif LINUX_VERSION_IS_LESS(5,3,0)
+#if LINUX_VERSION_IS_LESS(5,3,0)
 #define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
 static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_get_boot_ns();
 }
-#endif /* < 3.17 */
+#endif /* < 5.3 */
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
 extern time64_t ktime_get_boottime_seconds(void);
 #endif /* < 4.18 */
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
-static inline time64_t ktime_get_seconds(void)
-{
-	struct timespec t;
-
-	ktime_get_ts(&t);
-
-	return t.tv_sec;
-}
-
-static inline time64_t ktime_get_real_seconds(void)
-{
-	struct timeval tv;
-
-	do_gettimeofday(&tv);
-
-	return tv.tv_sec;
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-static inline void ktime_get_ts64(struct timespec64 *ts)
-{
-	ktime_get_ts(ts);
-}
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,17,0)
-/* This was introduced in 4.15, but we only need it in the
- * ktime_get_raw_ts64 backport() for < 3.17.
- */
-#if __BITS_PER_LONG == 64
-static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
-{
-	return *(const struct timespec64 *)&ts;
-}
-
-#else
-static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
-{
-	struct timespec64 ret;
-
-	ret.tv_sec = ts.tv_sec;
-	ret.tv_nsec = ts.tv_nsec;
-	return ret;
-}
-#endif
-#endif /* < 3.17 */
-
 #if LINUX_VERSION_IS_LESS(4,18,0)
 #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
 static inline void ktime_get_raw_ts64(struct timespec64 *ts)
 {
-#if LINUX_VERSION_IS_LESS(3,19,0)
-	struct timespec64 ts64;
-
-	getrawmonotonic(&ts64);
-	*ts = timespec_to_timespec64(ts64);
-#else
 	return getrawmonotonic64(ts);
-#endif /* < 3.19 */
 }
 #endif
 
diff --git a/backport/backport-include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
deleted file mode 100644
index 6bb91ad3..00000000
--- a/backport/backport-include/linux/tracepoint.h
+++ /dev/null
@@ -1,142 +0,0 @@
-#include_next <linux/tracepoint.h>
-
-#ifndef __BACKPORT_LINUX_TRACEPOINT_H
-#define __BACKPORT_LINUX_TRACEPOINT_H
-
-#ifndef TRACE_DEFINE_ENUM
-#define TRACE_DEFINE_ENUM(a)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-#ifdef TRACEPOINTS_ENABLED
-#undef __DECLARE_TRACE
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
-	extern struct tracepoint __tracepoint_##name;			\
-	static inline void trace_##name(proto)				\
-	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
-				TP_PROTO(data_proto),			\
-				TP_ARGS(data_args),			\
-				TP_CONDITION(cond),,);			\
-	}								\
-	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
-	static inline int						\
-	register_trace_##name(void (*probe)(data_proto), void *data)	\
-	{								\
-		return tracepoint_probe_register(#name, (void *)probe,	\
-						 data);			\
-	}								\
-	static inline int						\
-	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
-	{								\
-		return tracepoint_probe_unregister(#name, (void *)probe, \
-						   data);		\
-	}								\
-	static inline void						\
-	check_trace_callback_type_##name(void (*cb)(data_proto))	\
-	{								\
-	}								\
-	static inline bool						\
-	trace_##name##_enabled(void)					\
-	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
-	}
-
-#else
-#undef __DECLARE_TRACE
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
-	static inline void trace_##name(proto)				\
-	{ }								\
-	static inline void trace_##name##_rcuidle(proto)		\
-	{ }								\
-	static inline int						\
-	register_trace_##name(void (*probe)(data_proto),		\
-			      void *data)				\
-	{								\
-		return -ENOSYS;						\
-	}								\
-	static inline int						\
-	unregister_trace_##name(void (*probe)(data_proto),		\
-				void *data)				\
-	{								\
-		return -ENOSYS;						\
-	}								\
-	static inline void check_trace_callback_type_##name(void (*cb)(data_proto)) \
-	{								\
-	}								\
-	static inline bool						\
-	trace_##name##_enabled(void)					\
-	{								\
-		return false;						\
-	}
-#endif /* TRACEPOINTS_ENABLED */
-#elif LINUX_VERSION_IS_LESS(3,16,0)
-#ifdef TRACEPOINTS_ENABLED
-#undef __DECLARE_TRACE
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
-	extern struct tracepoint __tracepoint_##name;			\
-	static inline void trace_##name(proto)				\
-	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
-				TP_PROTO(data_proto),			\
-				TP_ARGS(data_args),			\
-				TP_CONDITION(cond),,);			\
-	}								\
-	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
-	static inline int						\
-	register_trace_##name(void (*probe)(data_proto), void *data)	\
-	{								\
-		return tracepoint_probe_register(&__tracepoint_##name,	\
-						(void *)probe, data);	\
-	}								\
-	static inline int						\
-	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
-	{								\
-		return tracepoint_probe_unregister(&__tracepoint_##name,\
-						(void *)probe, data);	\
-	}								\
-	static inline void						\
-	check_trace_callback_type_##name(void (*cb)(data_proto))	\
-	{								\
-	}								\
-	static inline bool						\
-	trace_##name##_enabled(void)					\
-	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
-	}
-
-#else
-#undef __DECLARE_TRACE
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
-	static inline void trace_##name(proto)				\
-	{ }								\
-	static inline void trace_##name##_rcuidle(proto)		\
-	{ }								\
-	static inline int						\
-	register_trace_##name(void (*probe)(data_proto),		\
-			      void *data)				\
-	{								\
-		return -ENOSYS;						\
-	}								\
-	static inline int						\
-	unregister_trace_##name(void (*probe)(data_proto),		\
-				void *data)				\
-	{								\
-		return -ENOSYS;						\
-	}								\
-	static inline void check_trace_callback_type_##name(void (*cb)(data_proto)) \
-	{								\
-	}								\
-	static inline bool						\
-	trace_##name##_enabled(void)					\
-	{								\
-		return false;						\
-	}
-#endif /* TRACEPOINTS_ENABLED */
-#endif /* < 3.16 */
-
-#endif /* __BACKPORT_LINUX_TRACEPOINT_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 987a1157..9de8ad1a 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -2,28 +2,6 @@
 #define __BACKPORT_LINUX_TTY_H
 #include_next <linux/tty.h>
 
-/*
- * This really belongs into uapi/asm-generic/termbits.h but
- * that doesn't usually get included directly.
- */
-#ifndef EXTPROC
-#define EXTPROC	0200000
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-/* Backports tty_lock: Localise the lock */
-#define tty_lock(__tty) tty_lock()
-#define tty_unlock(__tty) tty_unlock()
-
-#define tty_port_register_device(port, driver, index, device) \
-	tty_register_device(driver, index, device)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-extern void tty_port_tty_wakeup(struct tty_port *port);
-extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
-#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
-
 #if LINUX_VERSION_IS_LESS(4,1,0) && \
     LINUX_VERSION_IS_GEQ(4,0,0)
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
diff --git a/backport/backport-include/linux/tty_flip.h b/backport/backport-include/linux/tty_flip.h
deleted file mode 100644
index e6c0684e..00000000
--- a/backport/backport-include/linux/tty_flip.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_TTY_FLIP_H
-#define __BACKPORT_TTY_FLIP_H
-#include_next <linux/tty_flip.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
-#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
-#endif
-
-#endif /* __BACKPORT_TTY_FLIP_H */
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index 0671e140..e6e03394 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -3,10 +3,6 @@
 #include <linux/version.h>
 #include_next <linux/types.h>
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
-typedef __s64 time64_t;
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,16,0)
 typedef unsigned __poll_t;
 #endif
diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 251373a7..e46685b6 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -3,153 +3,7 @@
 
 #include <linux/version.h>
 #include <generated/utsrelease.h>
-#if LINUX_VERSION_IS_GEQ(3,6,0)
 #include_next <linux/u64_stats_sync.h>
-#else
-
-/*
- * To properly implement 64bits network statistics on 32bit and 64bit hosts,
- * we provide a synchronization point, that is a noop on 64bit or UP kernels.
- *
- * Key points :
- * 1) Use a seqcount on SMP 32bits, with low overhead.
- * 2) Whole thing is a noop on 64bit arches or UP kernels.
- * 3) Write side must ensure mutual exclusion or one seqcount update could
- *    be lost, thus blocking readers forever.
- *    If this synchronization point is not a mutex, but a spinlock or
- *    spinlock_bh() or disable_bh() :
- * 3.1) Write side should not sleep.
- * 3.2) Write side should not allow preemption.
- * 3.3) If applicable, interrupts should be disabled.
- *
- * 4) If reader fetches several counters, there is no guarantee the whole values
- *    are consistent (remember point 1) : this is a noop on 64bit arches anyway)
- *
- * 5) readers are allowed to sleep or be preempted/interrupted : They perform
- *    pure reads. But if they have to fetch many values, it's better to not allow
- *    preemptions/interruptions to avoid many retries.
- *
- * 6) If counter might be written by an interrupt, readers should block interrupts.
- *    (On UP, there is no seqcount_t protection, a reader allowing interrupts could
- *     read partial values)
- *
- * 7) For softirq uses, readers can use u64_stats_fetch_begin_irq() and
- *    u64_stats_fetch_retry_irq() helpers
- *
- * Usage :
- *
- * Stats producer (writer) should use following template granted it already got
- * an exclusive access to counters (a lock is already taken, or per cpu
- * data is used [in a non preemptable context])
- *
- *   spin_lock_bh(...) or other synchronization to get exclusive access
- *   ...
- *   u64_stats_update_begin(&stats->syncp);
- *   stats->bytes64 += len; // non atomic operation
- *   stats->packets64++;    // non atomic operation
- *   u64_stats_update_end(&stats->syncp);
- *
- * While a consumer (reader) should use following template to get consistent
- * snapshot for each variable (but no guarantee on several ones)
- *
- * u64 tbytes, tpackets;
- * unsigned int start;
- *
- * do {
- *         start = u64_stats_fetch_begin(&stats->syncp);
- *         tbytes = stats->bytes64; // non atomic operation
- *         tpackets = stats->packets64; // non atomic operation
- * } while (u64_stats_fetch_retry(&stats->syncp, start));
- *
- *
- * Example of use in drivers/net/loopback.c, using per_cpu containers,
- * in BH disabled context.
- */
-#include <linux/seqlock.h>
-
-struct u64_stats_sync {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	seqcount_t	seq;
-#endif
-};
-
-static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	write_seqcount_begin(&syncp->seq);
-#endif
-}
-
-static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	write_seqcount_end(&syncp->seq);
-#endif
-}
-
-static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	return read_seqcount_begin(&syncp->seq);
-#else
-#if BITS_PER_LONG==32
-	preempt_disable();
-#endif
-	return 0;
-#endif
-}
-
-static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
-					 unsigned int start)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	return read_seqcount_retry(&syncp->seq, start);
-#else
-#if BITS_PER_LONG==32
-	preempt_enable();
-#endif
-	return false;
-#endif
-}
-
-#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
-
-#if LINUX_VERSION_IS_LESS(3,15,0) && \
-    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
-static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	return read_seqcount_begin(&syncp->seq);
-#else
-#if BITS_PER_LONG==32
-	local_irq_disable();
-#endif
-	return 0;
-#endif
-}
-
-static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
-					 unsigned int start)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	return read_seqcount_retry(&syncp->seq, start);
-#else
-#if BITS_PER_LONG==32
-	local_irq_enable();
-#endif
-	return false;
-#endif
-}
-
-#endif /* LINUX_VERSION_IS_GEQ(3,15,0) */
-
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-# define u64_stats_init(syncp)	seqcount_init(syncp.seq)
-#else
-# define u64_stats_init(syncp)	do { } while (0)
-#endif
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #if LINUX_VERSION_IS_LESS(4,16,0) && \
     !LINUX_VERSION_IN_RANGE(4,14,44, 4,15,0) && \
diff --git a/backport/backport-include/linux/uidgid.h b/backport/backport-include/linux/uidgid.h
deleted file mode 100644
index c2f3faa0..00000000
--- a/backport/backport-include/linux/uidgid.h
+++ /dev/null
@@ -1,221 +0,0 @@
-#if LINUX_VERSION_IS_GEQ(3,5,0)
-#include_next <linux/uidgid.h>
-#else
-
-#ifndef _LINUX_UIDGID_H
-#define _LINUX_UIDGID_H
-
-/*
- * A set of types for the internal kernel types representing uids and gids.
- *
- * The types defined in this header allow distinguishing which uids and gids in
- * the kernel are values used by userspace and which uid and gid values are
- * the internal kernel values.  With the addition of user namespaces the values
- * can be different.  Using the type system makes it possible for the compiler
- * to detect when we overlook these differences.
- *
- */
-#include <linux/types.h>
-#include <linux/highuid.h>
-
-struct user_namespace;
-extern struct user_namespace init_user_ns;
-
-#ifdef CONFIG_UIDGID_STRICT_TYPE_CHECKS
-
-typedef struct {
-	uid_t val;
-} kuid_t;
-
-
-typedef struct {
-	gid_t val;
-} kgid_t;
-
-#define KUIDT_INIT(value) (kuid_t){ value }
-#define KGIDT_INIT(value) (kgid_t){ value }
-
-static inline uid_t __kuid_val(kuid_t uid)
-{
-	return uid.val;
-}
-
-static inline gid_t __kgid_val(kgid_t gid)
-{
-	return gid.val;
-}
-
-#else
-
-typedef uid_t kuid_t;
-typedef gid_t kgid_t;
-
-static inline uid_t __kuid_val(kuid_t uid)
-{
-	return uid;
-}
-
-static inline gid_t __kgid_val(kgid_t gid)
-{
-	return gid;
-}
-
-#define KUIDT_INIT(value) ((kuid_t) value )
-#define KGIDT_INIT(value) ((kgid_t) value )
-
-#endif
-
-#define GLOBAL_ROOT_UID KUIDT_INIT(0)
-#define GLOBAL_ROOT_GID KGIDT_INIT(0)
-
-#define INVALID_UID KUIDT_INIT(-1)
-#define INVALID_GID KGIDT_INIT(-1)
-
-static inline bool uid_eq(kuid_t left, kuid_t right)
-{
-	return __kuid_val(left) == __kuid_val(right);
-}
-
-static inline bool gid_eq(kgid_t left, kgid_t right)
-{
-	return __kgid_val(left) == __kgid_val(right);
-}
-
-static inline bool uid_gt(kuid_t left, kuid_t right)
-{
-	return __kuid_val(left) > __kuid_val(right);
-}
-
-static inline bool gid_gt(kgid_t left, kgid_t right)
-{
-	return __kgid_val(left) > __kgid_val(right);
-}
-
-static inline bool uid_gte(kuid_t left, kuid_t right)
-{
-	return __kuid_val(left) >= __kuid_val(right);
-}
-
-static inline bool gid_gte(kgid_t left, kgid_t right)
-{
-	return __kgid_val(left) >= __kgid_val(right);
-}
-
-static inline bool uid_lt(kuid_t left, kuid_t right)
-{
-	return __kuid_val(left) < __kuid_val(right);
-}
-
-static inline bool gid_lt(kgid_t left, kgid_t right)
-{
-	return __kgid_val(left) < __kgid_val(right);
-}
-
-static inline bool uid_lte(kuid_t left, kuid_t right)
-{
-	return __kuid_val(left) <= __kuid_val(right);
-}
-
-static inline bool gid_lte(kgid_t left, kgid_t right)
-{
-	return __kgid_val(left) <= __kgid_val(right);
-}
-
-static inline bool uid_valid(kuid_t uid)
-{
-	return !uid_eq(uid, INVALID_UID);
-}
-
-static inline bool gid_valid(kgid_t gid)
-{
-	return !gid_eq(gid, INVALID_GID);
-}
-
-#ifdef CONFIG_USER_NS
-
-#define make_kuid LINUX_BACKPORT(make_kuid)
-extern kuid_t make_kuid(struct user_namespace *from, uid_t uid);
-#define make_kgid LINUX_BACKPORT(make_kgid)
-extern kgid_t make_kgid(struct user_namespace *from, gid_t gid);
-
-#define from_kuid LINUX_BACKPORT(from_kuid)
-extern uid_t from_kuid(struct user_namespace *to, kuid_t uid);
-#define from_kgid LINUX_BACKPORT(from_kgid)
-extern gid_t from_kgid(struct user_namespace *to, kgid_t gid);
-#define from_kuid_munged LINUX_BACKPORT(from_kuid_munged)
-extern uid_t from_kuid_munged(struct user_namespace *to, kuid_t uid);
-#define from_kgid_munged LINUX_BACKPORT(from_kgid_munged)
-extern gid_t from_kgid_munged(struct user_namespace *to, kgid_t gid);
-
-#define kuid_has_mapping LINUX_BACKPORT(kuid_has_mapping)
-static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
-{
-	return from_kuid(ns, uid) != (uid_t) -1;
-}
-
-#define kgid_has_mapping LINUX_BACKPORT(kgid_has_mapping)
-static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
-{
-	return from_kgid(ns, gid) != (gid_t) -1;
-}
-
-#else
-
-#define make_kuid LINUX_BACKPORT(make_kuid)
-static inline kuid_t make_kuid(struct user_namespace *from, uid_t uid)
-{
-	return KUIDT_INIT(uid);
-}
-
-#define make_kgid LINUX_BACKPORT(make_kgid)
-static inline kgid_t make_kgid(struct user_namespace *from, gid_t gid)
-{
-	return KGIDT_INIT(gid);
-}
-
-#define from_kuid LINUX_BACKPORT(from_kuid)
-static inline uid_t from_kuid(struct user_namespace *to, kuid_t kuid)
-{
-	return __kuid_val(kuid);
-}
-
-#define from_kgid LINUX_BACKPORT(from_kgid)
-static inline gid_t from_kgid(struct user_namespace *to, kgid_t kgid)
-{
-	return __kgid_val(kgid);
-}
-
-#define from_kuid_munged LINUX_BACKPORT(from_kuid_munged)
-static inline uid_t from_kuid_munged(struct user_namespace *to, kuid_t kuid)
-{
-	uid_t uid = from_kuid(to, kuid);
-	if (uid == (uid_t)-1)
-		uid = overflowuid;
-	return uid;
-}
-
-#define from_kgid_munged LINUX_BACKPORT(from_kgid_munged)
-static inline gid_t from_kgid_munged(struct user_namespace *to, kgid_t kgid)
-{
-	gid_t gid = from_kgid(to, kgid);
-	if (gid == (gid_t)-1)
-		gid = overflowgid;
-	return gid;
-}
-
-#define kuid_has_mapping LINUX_BACKPORT(kuid_has_mapping)
-static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
-{
-	return true;
-}
-
-#define kgid_has_mapping LINUX_BACKPORT(kgid_has_mapping)
-static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
-{
-	return true;
-}
-
-#endif /* CONFIG_USER_NS */
-
-#endif /* _LINUX_UIDGID_H */
-#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
deleted file mode 100644
index 1873a336..00000000
--- a/backport/backport-include/linux/usb.h
+++ /dev/null
@@ -1,95 +0,0 @@
-#ifndef __BACKPORT_USB_H
-#define __BACKPORT_USB_H
-
-#include_next <linux/usb.h>
-#include <linux/version.h>
-
-#ifndef module_usb_driver
-/**
- * module_usb_driver() - Helper macro for registering a USB driver
- * @__usb_driver: usb_driver struct
- *
- * Helper macro for USB drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_usb_driver(__usb_driver) \
-	module_driver(__usb_driver, usb_register, \
-		       usb_deregister)
-#endif
-
-#ifndef USB_VENDOR_AND_INTERFACE_INFO
-/**
- * Backports
- *
- * commit d81a5d1956731c453b85c141458d4ff5d6cc5366
- * Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
- * Date:   Tue Jul 10 19:10:06 2012 -0300
- *
- * 	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
- */
-#define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
-       .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
-               | USB_DEVICE_ID_MATCH_VENDOR, \
-       .idVendor = (vend), \
-       .bInterfaceClass = (cl), \
-       .bInterfaceSubClass = (sc), \
-       .bInterfaceProtocol = (pr)
-#endif /* USB_VENDOR_AND_INTERFACE_INFO */
-
-#ifndef USB_DEVICE_INTERFACE_NUMBER
-/**
- * USB_DEVICE_INTERFACE_NUMBER - describe a usb device with a specific interface number
- * @vend: the 16 bit USB Vendor ID
- * @prod: the 16 bit USB Product ID
- * @num: bInterfaceNumber value
- *
- * This macro is used to create a struct usb_device_id that matches a
- * specific interface number of devices.
- */
-#define USB_DEVICE_INTERFACE_NUMBER(vend, prod, num) \
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE, \
-	.idVendor = (vend), \
-	.idProduct = (prod)
-#endif /* USB_DEVICE_INTERFACE_NUMBER */
-
-#ifndef USB_DEVICE_INTERFACE_CLASS
-/**
- * USB_DEVICE_INTERFACE_CLASS - describe a usb device with a specific interface class
- * @vend: the 16 bit USB Vendor ID
- * @prod: the 16 bit USB Product ID
- * @cl: bInterfaceClass value
- *
- * This macro is used to create a struct usb_device_id that matches a
- * specific interface class of devices.
- */
-#define USB_DEVICE_INTERFACE_CLASS(vend, prod, cl) \
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
-		       USB_DEVICE_ID_MATCH_INT_CLASS, \
-	.idVendor = (vend), \
-	.idProduct = (prod), \
-	.bInterfaceClass = (cl)
-#endif /* USB_DEVICE_INTERFACE_CLASS */
-
-#ifndef USB_SUBCLASS_VENDOR_SPEC
-/* this is defined in usb/ch9.h, but we only need it through here */
-#define USB_SUBCLASS_VENDOR_SPEC	0xff
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#define usb_translate_errors LINUX_BACKPORT(usb_translate_errors)
-static inline int usb_translate_errors(int error_code)
-{
-	switch (error_code) {
-	case 0:
-	case -ENOMEM:
-	case -ENODEV:
-	case -EOPNOTSUPP:
-		return error_code;
-	default:
-		return -EIO;
-	}
-}
-#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
-
-#endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index c2f0120c..d8d9a48b 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -4,22 +4,6 @@
 #include <linux/version.h>
 #include_next <linux/usb/ch9.h>
 
-#if LINUX_VERSION_IS_LESS(3,2,0)
-#include <linux/types.h>    /* __u8 etc */
-#include <asm/byteorder.h>  /* le16_to_cpu */
-
-/**
- * usb_endpoint_maxp - get endpoint's max packet size
- * @epd: endpoint to be checked
- *
- * Returns @epd's max packet
- */
-#define usb_endpoint_maxp LINUX_BACKPORT(usb_endpoint_maxp)
-static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
-{
-	return __le16_to_cpu(epd->wMaxPacketSize);
-}
-#endif /* < 3.2 */
 
 #if LINUX_VERSION_IS_LESS(4,6,0)
 #define USB_SPEED_SUPER_PLUS	6
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 15a674cf..f07f6099 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -2,79 +2,6 @@
 #define __BACKPORT_LINUX_WAIT_H
 #include_next <linux/wait.h>
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
-extern int bit_wait(void *);
-extern int bit_wait_io(void *);
-
-static inline int
-backport_wait_on_bit(void *word, int bit, unsigned mode)
-{
-	return wait_on_bit(word, bit, bit_wait, mode);
-}
-
-static inline int
-backport_wait_on_bit_io(void *word, int bit, unsigned mode)
-{
-	return wait_on_bit(word, bit, bit_wait_io, mode);
-}
-
-#define wait_on_bit LINUX_BACKPORT(wait_on_bit)
-#define wait_on_bit_io LINUX_BACKPORT(wait_on_bit_io)
-
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,18,12)
-#define WQ_FLAG_WOKEN		0x02
-
-#define wait_woken LINUX_BACKPORT(wait_woken)
-long wait_woken(wait_queue_t *wait, unsigned mode, long timeout);
-#define wait_woken LINUX_BACKPORT(wait_woken)
-int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
-#endif
-
-/**
- * For wait_on_bit_timeout() an extra member in struct wait_bit_key is needed.
- * This was introuced in kernel 3.17 and we are only able to backport this
- * function on these kernel versions.
- */
-#if LINUX_VERSION_IS_GEQ(3,17,0)
-#if LINUX_VERSION_IS_LESS(3,18,0)
-#define out_of_line_wait_on_bit_timeout LINUX_BACKPORT(out_of_line_wait_on_bit_timeout)
-int out_of_line_wait_on_bit_timeout(void *, int, wait_bit_action_f *, unsigned, unsigned long);
-
-#define bit_wait_timeout LINUX_BACKPORT(bit_wait_timeout)
-extern int bit_wait_timeout(struct wait_bit_key *);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,20,0)
-#define wait_on_bit_timeout LINUX_BACKPORT(wait_on_bit_timeout)
-/**
- * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
- * @mode: the task state to sleep in
- * @timeout: timeout, in jiffies
- *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared. This is similar to wait_on_bit(), except also takes a
- * timeout parameter.
- *
- * Returned value will be zero if the bit was cleared before the
- * @timeout elapsed, or non-zero if the @timeout elapsed or process
- * received a signal and the mode permitted wakeup on that signal.
- */
-static inline int
-wait_on_bit_timeout(void *word, int bit, unsigned mode, unsigned long timeout)
-{
-	might_sleep();
-	if (!test_bit(bit, word))
-		return 0;
-	return out_of_line_wait_on_bit_timeout(word, bit,
-					       bit_wait_timeout,
-					       mode, timeout);
-}
-#endif
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,13,0)
 #define wait_queue_entry_t wait_queue_t
diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
deleted file mode 100644
index 598c8c48..00000000
--- a/backport/backport-include/linux/watchdog.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_WATCHDOG_H
-#define __BACKPORT_WATCHDOG_H
-#include_next <linux/watchdog.h>
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define watchdog_device LINUX_BACKPORT(watchdog_device)
-struct watchdog_device {
-};
-#endif
-
-#endif /* __BACKPORT_WATCHDOG_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
deleted file mode 100644
index ab68d217..00000000
--- a/backport/backport-include/linux/workqueue.h
+++ /dev/null
@@ -1,67 +0,0 @@
-#ifndef __BACKPORT_LINUX_WORKQUEUE_H
-#define __BACKPORT_LINUX_WORKQUEUE_H
-#include_next <linux/workqueue.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define mod_delayed_work LINUX_BACKPORT(mod_delayed_work)
-bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
-		      unsigned long delay);
-#endif
-
-#ifndef create_freezable_workqueue
-/* note freez_a_ble -> freez_ea_able */
-#define create_freezable_workqueue create_freezeable_workqueue
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#define __WQ_ORDERED	0
-/*
- * commit b196be89cdc14a88cc637cdad845a75c5886c82d
- * Author: Tejun Heo <tj@kernel.org>
- * Date:   Tue Jan 10 15:11:35 2012 -0800
- *
- *     workqueue: make alloc_workqueue() take printf fmt and args for name
- */
-struct workqueue_struct *
-backport_alloc_workqueue(const char *fmt, unsigned int flags,
-			 int max_active, struct lock_class_key *key,
-			 const char *lock_name, ...);
-#undef alloc_workqueue
-#ifdef CONFIG_LOCKDEP
-#define alloc_workqueue(fmt, flags, max_active, args...)		\
-({									\
-	static struct lock_class_key __key;				\
-	const char *__lock_name;					\
-									\
-	if (__builtin_constant_p(fmt))					\
-		__lock_name = (fmt);					\
-	else								\
-		__lock_name = #fmt;					\
-									\
-	backport_alloc_workqueue((fmt), (flags), (max_active),		\
-				 &__key, __lock_name, ##args);		\
-})
-#else
-#define alloc_workqueue(fmt, flags, max_active, args...)		\
-	backport_alloc_workqueue((fmt), (flags), (max_active),		\
-				 NULL, NULL, ##args)
-#endif
-#undef alloc_ordered_workqueue
-#define alloc_ordered_workqueue(fmt, flags, args...) \
-	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
-#define destroy_workqueue backport_destroy_workqueue
-void backport_destroy_workqueue(struct workqueue_struct *wq);
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,11,0)
-/* power efficient workqueues were added in commit 0668106ca386. */
-#define system_power_efficient_wq system_wq
-#define system_freezable_power_efficient_wq system_freezable_wq
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define drain_workqueue(wq) flush_workqueue(wq)
-#endif
-
-#endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
index 67d44e19..daf79a4b 100644
--- a/backport/backport-include/net/addrconf.h
+++ b/backport/backport-include/net/addrconf.h
@@ -5,23 +5,6 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,9,0)
-static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
-{
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
-	__u64 *p = (__u64 *)addr;
-	return ((p[0] ^ cpu_to_be64(0xff02000000000000UL)) |
-		((p[1] ^ cpu_to_be64(0x00000001ff000000UL)) &
-		 cpu_to_be64(0xffffffffff000000UL))) == 0UL;
-#else
-	return ((addr->s6_addr32[0] ^ htonl(0xff020000)) |
-		addr->s6_addr32[1] |
-		(addr->s6_addr32[2] ^ htonl(0x00000001)) |
-		(addr->s6_addr[12] ^ 0xff)) == 0;
-#endif
-}
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
 #if LINUX_VERSION_IS_LESS(4,2,0)
 static inline int ipv6_mc_check_mld(struct sk_buff *skb)
 {
diff --git a/backport/backport-include/net/flow_keys.h b/backport/backport-include/net/flow_keys.h
deleted file mode 100644
index 093bc80a..00000000
--- a/backport/backport-include/net/flow_keys.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#if LINUX_VERSION_IS_GEQ(3,3,0)
-#include_next <net/flow_keys.h>
-#else
-
-#ifndef _NET_FLOW_KEYS_H
-#define _NET_FLOW_KEYS_H
-
-struct flow_keys {
-	/* (src,dst) must be grouped, in the same way than in IP header */
-	__be32 src;
-	__be32 dst;
-	union {
-		__be32 ports;
-		__be16 port16[2];
-	};
-	u8 ip_proto;
-};
-
-extern bool skb_flow_dissect(const struct sk_buff *skb, struct flow_keys *flow);
-#endif
-#endif
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 326b9992..befb8ce0 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -51,25 +51,9 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 }
 
 /* this is for patches we apply */
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
-#else
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-#endif
 
-#if LINUX_VERSION_IS_LESS(3,13,0)
-#define __genl_const
-#else /* < 3.13 */
 #define __genl_const const
-#endif /* < 3.13 */
-
-#ifndef GENLMSG_DEFAULT_SIZE
-#define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-#define genl_dump_check_consistent(cb, user_hdr) do { } while (0)
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,10,0)
 #define __genl_ro_after_init
@@ -108,15 +92,13 @@ enum genl_validate_flags {
 	GENL_DONT_VALIDATE_DUMP_STRICT		= BIT(2),
 };
 
-#if LINUX_VERSION_IS_GEQ(3,13,0)
 struct backport_genl_ops {
 	void			*__dummy_was_policy_must_be_null;
 	int		       (*doit)(struct sk_buff *skb,
 				       struct genl_info *info);
 #if LINUX_VERSION_IS_GEQ(4,5,0) || \
     LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0) || \
-    LINUX_VERSION_IN_RANGE(3,18,86, 3,19,0)
+    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0)
 	int		       (*start)(struct netlink_callback *cb);
 #endif
 	int		       (*dumpit)(struct sk_buff *skb,
@@ -127,21 +109,6 @@ struct backport_genl_ops {
 	u8			flags;
 	u8			validate;
 };
-#else
-struct backport_genl_ops {
-	u8			cmd;
-	u8			internal_flags;
-	unsigned int		flags;
-	void			*__dummy_was_policy_must_be_null;
-	int		       (*doit)(struct sk_buff *skb,
-				       struct genl_info *info);
-	int		       (*dumpit)(struct sk_buff *skb,
-					 struct netlink_callback *cb);
-	int		       (*done)(struct netlink_callback *cb);
-	struct list_head	ops_list;
-	u8			validate;
-};
-#endif
 
 static inline int
 __real_backport_genl_register_family(struct genl_family *family)
@@ -152,8 +119,7 @@ __real_backport_genl_register_family(struct genl_family *family)
 	OPS_VALIDATE(doit);
 #if LINUX_VERSION_IS_GEQ(4,5,0) || \
     LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0) || \
-    LINUX_VERSION_IN_RANGE(3,18,86, 3,19,0)
+    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0)
 	OPS_VALIDATE(start);
 #endif
 	OPS_VALIDATE(dumpit);
diff --git a/backport/backport-include/net/ip.h b/backport/backport-include/net/ip.h
deleted file mode 100644
index 6893ba51..00000000
--- a/backport/backport-include/net/ip.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __BACKPORT_NET_IP_H
-#define __BACKPORT_NET_IP_H
-#include_next <net/ip.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,1,0)
-/* Backports 56f8a75c */
-static inline bool ip_is_fragment(const struct iphdr *iph)
-{
-	return (iph->frag_off & htons(IP_MF | IP_OFFSET)) != 0;
-}
-#endif
-
-#endif /* __BACKPORT_NET_IP_H */
diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
index 7416d6b0..2532710c 100644
--- a/backport/backport-include/net/ipv6.h
+++ b/backport/backport-include/net/ipv6.h
@@ -2,42 +2,7 @@
 #define __BACKPORT_NET_IPV6_H
 #include_next <net/ipv6.h>
 #include <linux/version.h>
-#include <net/addrconf.h>
-#include <net/inet_frag.h>
 
-#if LINUX_VERSION_IS_LESS(3,7,0)
-/*
- *	Equivalent of ipv4 struct ip
- */
-struct frag_queue {
-	struct inet_frag_queue  q;
-
-	__be32                  id;             /* fragment id          */
-	u32                     user;
-	struct in6_addr         saddr;
-	struct in6_addr         daddr;
-
-	int                     iif;
-	unsigned int            csum;
-	__u16                   nhoffset;
-};
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-
-#if LINUX_VERSION_IS_LESS(3,6,0)
-#define ipv6_addr_hash LINUX_BACKPORT(ipv6_addr_hash)
-static inline u32 ipv6_addr_hash(const struct in6_addr *a)
-{
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
-	const unsigned long *ul = (const unsigned long *)a;
-	unsigned long x = ul[0] ^ ul[1];
-
-	return (u32)(x ^ (x >> 32));
-#else
-	return (__force u32)(a->s6_addr32[0] ^ a->s6_addr32[1] ^
-			     a->s6_addr32[2] ^ a->s6_addr32[3]);
-#endif
-}
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define ipv6_addr_prefix_copy LINUX_BACKPORT(ipv6_addr_prefix_copy)
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index 84d63b30..8b5f1c60 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -29,11 +29,7 @@ iwe_stream_add_point_check(struct iw_request_info *info, char *stream,
 /* this was added in v3.2.79, v3.18.30, v4.1.21, v4.4.6 and 4.5 */
 #if !(LINUX_VERSION_IS_GEQ(4,4,6) || \
       (LINUX_VERSION_IS_GEQ(4,1,21) && \
-       LINUX_VERSION_IS_LESS(4,2,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,18,30) && \
-       LINUX_VERSION_IS_LESS(3,19,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,2,79) && \
-       LINUX_VERSION_IS_LESS(3,3,0)))
+       LINUX_VERSION_IS_LESS(4,2,0)))
 #define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
 static inline void wireless_nlevent_flush(void) {}
 #endif
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 1e84297c..47f6b3b5 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -3,16 +3,6 @@
 
 #include_next <net/net_namespace.h>
 
-#if LINUX_VERSION_IS_LESS(3,20,0)
-/*
- * In older kernels we simply fail this function.
- */
-#define get_net_ns_by_fd	LINUX_BACKPORT(get_net_ns_by_fd)
-static inline struct net *get_net_ns_by_fd(int fd)
-{
-	return ERR_PTR(-EINVAL);
-}
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,1,0)
 typedef struct {
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index c97f9abd..ba07a5ca 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -435,127 +435,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-#if LINUX_VERSION_IS_LESS(3,7,0)
-/**
- * nla_put_s8 - Add a s8 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-#define nla_put_s8 LINUX_BACKPORT(nla_put_s8)
-static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
-{
-	return nla_put(skb, attrtype, sizeof(s8), &value);
-}
-
-/**
- * nla_put_s16 - Add a s16 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-#define nla_put_s16 LINUX_BACKPORT(nla_put_s16)
-static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
-{
-	return nla_put(skb, attrtype, sizeof(s16), &value);
-}
-
-/**
- * nla_put_s32 - Add a s32 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-#define nla_put_s32 LINUX_BACKPORT(nla_put_s32)
-static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
-{
-	return nla_put(skb, attrtype, sizeof(s32), &value);
-}
-
-/**
- * nla_get_s32 - return payload of s32 attribute
- * @nla: s32 netlink attribute
- */
-#define nla_get_s32 LINUX_BACKPORT(nla_get_s32)
-static inline s32 nla_get_s32(const struct nlattr *nla)
-{
-	return *(s32 *) nla_data(nla);
-}
-
-/**
- * nla_get_s16 - return payload of s16 attribute
- * @nla: s16 netlink attribute
- */
-#define nla_get_s16 LINUX_BACKPORT(nla_get_s16)
-static inline s16 nla_get_s16(const struct nlattr *nla)
-{
-	return *(s16 *) nla_data(nla);
-}
-
-/**
- * nla_get_s8 - return payload of s8 attribute
- * @nla: s8 netlink attribute
- */
-#define nla_get_s8 LINUX_BACKPORT(nla_get_s8)
-static inline s8 nla_get_s8(const struct nlattr *nla)
-{
-	return *(s8 *) nla_data(nla);
-}
-
-/**
- * nla_get_s64 - return payload of s64 attribute
- * @nla: s64 netlink attribute
- */
-#define nla_get_s64 LINUX_BACKPORT(nla_get_s64)
-static inline s64 nla_get_s64(const struct nlattr *nla)
-{
-	s64 tmp;
-
-	nla_memcpy(&tmp, nla, sizeof(tmp));
-
-	return tmp;
-}
-#endif /* < 3.7.0 */
-
-#if LINUX_VERSION_IS_LESS(3,5,0)
-/*
- * This backports:
- * commit 569a8fc38367dfafd87454f27ac646c8e6b54bca
- * Author: David S. Miller <davem@davemloft.net>
- * Date:   Thu Mar 29 23:18:53 2012 -0400
- *
- *     netlink: Add nla_put_be{16,32,64}() helpers.
- */
-
-#define nla_put_be16 LINUX_BACKPORT(nla_put_be16)
-static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
-{
-	return nla_put(skb, attrtype, sizeof(__be16), &value);
-}
-
-#define nla_put_be32 LINUX_BACKPORT(nla_put_be32)
-static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
-{
-	return nla_put(skb, attrtype, sizeof(__be32), &value);
-}
-
-#define nla_put_be64 LINUX_BACKPORT(nla_put_be64)
-static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
-{
-	return nla_put(skb, attrtype, sizeof(__be64), &value);
-}
-#endif /* < 3.5 */
-
-#if LINUX_VERSION_IS_LESS(3,7,0)
-#define NLA_S8 (NLA_BINARY + 1)
-#define NLA_S16 (NLA_BINARY + 2)
-#define NLA_S32 (NLA_BINARY + 3)
-#define NLA_S64 (NLA_BINARY + 4)
-#define __NLA_TYPE_MAX (NLA_BINARY + 5)
-
-#undef NLA_TYPE_MAX
-#define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,1,0)
 #define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
deleted file mode 100644
index cabc6012..00000000
--- a/backport/backport-include/net/sch_generic.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef __BACKPORT_NET_SCH_GENERIC_H
-#define __BACKPORT_NET_SCH_GENERIC_H
-#include_next <net/sch_generic.h>
-
-#if LINUX_VERSION_IS_LESS(3,3,0)
-#if !((LINUX_VERSION_IS_GEQ(3,2,9) && LINUX_VERSION_IS_LESS(3,3,0)) || (LINUX_VERSION_IS_GEQ(3,0,23) && LINUX_VERSION_IS_LESS(3,1,0)))
-/* mask qdisc_cb_private_validate as RHEL6 backports this */
-#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
-static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
-{
-	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct qdisc_skb_cb) + sz);
-}
-#endif
-#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
-
-#ifndef TCQ_F_CAN_BYPASS
-#define TCQ_F_CAN_BYPASS        4
-#endif
-
-#endif /* __BACKPORT_NET_SCH_GENERIC_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 39bf0087..10c978fb 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -3,45 +3,6 @@
 #include_next <net/sock.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(3,9,0)
-#include <backport/magic.h>
-
-#define sk_for_each3(__sk, node, list) \
-	hlist_for_each_entry(__sk, node, list, sk_node)
-
-#define sk_for_each_safe4(__sk, node, tmp, list) \
-	hlist_for_each_entry_safe(__sk, node, tmp, list, sk_node)
-
-#define sk_for_each2(__sk, list) \
-	hlist_for_each_entry(__sk, list, sk_node)
-
-#define sk_for_each_safe3(__sk, tmp, list) \
-	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
-
-#undef sk_for_each
-#define sk_for_each(...) \
-	macro_dispatcher(sk_for_each, __VA_ARGS__)(__VA_ARGS__)
-#undef sk_for_each_safe
-#define sk_for_each_safe(...) \
-	macro_dispatcher(sk_for_each_safe, __VA_ARGS__)(__VA_ARGS__)
-
-#endif
-
-#if LINUX_VERSION_IS_LESS(3,10,0)
-/*
- * backport SOCK_SELECT_ERR_QUEUE -- see commit
- * "net: add option to enable error queue packets waking select"
- *
- * Adding 14 to SOCK_QUEUE_SHRUNK will reach a bet that can't be
- * set on older kernels, so sock_flag() will always return false.
- */
-#define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
-#endif
-
-#ifndef sock_skb_cb_check_size
-#define sock_skb_cb_check_size(size) \
-	BUILD_BUG_ON((size) > FIELD_SIZEOF(struct sk_buff, cb))
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,2,0)
 #define sk_alloc(net, family, priority, prot, kern) sk_alloc(net, family, priority, prot)
diff --git a/backport/backport-include/linux/eventpoll.h b/backport/backport-include/uapi/linux/eventpoll.h
similarity index 94%
rename from backport/backport-include/linux/eventpoll.h
rename to backport/backport-include/uapi/linux/eventpoll.h
index 7cc87aa0..fa638b60 100644
--- a/backport/backport-include/linux/eventpoll.h
+++ b/backport/backport-include/uapi/linux/eventpoll.h
@@ -1,6 +1,6 @@
 #ifndef __BACKPORT_LINUX_EVENTPOLL_H
 #define __BACKPORT_LINUX_EVENTPOLL_H
-#include_next <linux/eventpoll.h>
+#include_next <uapi/linux/eventpoll.h>
 
 #ifndef EPOLLIN
 #define EPOLLIN		0x00000001
diff --git a/backport/backport-include/uapi/linux/genetlink.h b/backport/backport-include/uapi/linux/genetlink.h
index 620626ae..5292892d 100644
--- a/backport/backport-include/uapi/linux/genetlink.h
+++ b/backport/backport-include/uapi/linux/genetlink.h
@@ -1,11 +1,6 @@
 #ifndef __BACKPORT_UAPI_LINUX_GENETLINK_H
 #define __BACKPORT_UAPI_LINUX_GENETLINK_H
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,7,0)
 #include_next <uapi/linux/genetlink.h>
-#else
-#include_next <linux/genetlink.h>
-#endif
 
 #ifndef GENL_UNS_ADMIN_PERM
 #define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM
diff --git a/backport/backport-include/uapi/linux/sockios.h b/backport/backport-include/uapi/linux/sockios.h
deleted file mode 100644
index 12a7dd6c..00000000
--- a/backport/backport-include/uapi/linux/sockios.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef __BACKPORT_LINUX_SOCKIOS_H
-#define __BACKPORT_LINUX_SOCKIOS_H
-#include_next <linux/sockios.h>
-#include <linux/version.h>
-
-/*
- * Kernel backports UAPI note:
- *
- * We carry UAPI headers for backports to enable compilation
- * of kernel / driver code to compile without any changes. If
- * it so happens that a feature is backported it can be added
- * here but notice that if full subsystems are backported you
- * should just include the respective full header onto the
- * copy-list file so that its copied intact. This strategy
- * is used to either backport a specific feature or to just
- * avoid having to do ifdef changes to compile.
- *
- * Userspace is not expected to copy over backports headers
- * to compile userspace programs, userspace programs can
- * and should consider carrying over a respective copy-list
- * of the latest UAPI kernel headers they need in their
- * upstream sources, the kernel the user uses, whether with
- * backports or not should be able to return -EOPNOTSUPP if
- * the feature is not available and let it through if its
- * supported and meats the expected form.
- */
-
-#if LINUX_VERSION_IS_LESS(3,14,0)
-#define SIOCGHWTSTAMP	0x89b1		/* get config			*/
-#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
-#endif /* __BACKPORT_LINUX_SOCKIOS_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 7e414365..f8256af8 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -67,18 +67,6 @@ config BPAUTO_BUILD_NLATTR
 	depends on KERNEL_5_2
 	#c-file lib/nlattr.c
 
-config BPAUTO_BUILD_CORDIC
-	tristate
-	depends on !CORDIC
-	depends on KERNEL_3_1
-	default m if BPAUTO_CORDIC
-	default m if BPAUTO_USERSEL_BUILD_ALL
-	#module-name cordic
-	#c-file lib/math/cordic.c
-
-config BPAUTO_CORDIC
-	bool
-
 config BPAUTO_MII
 	bool
 
@@ -150,7 +138,6 @@ config BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
 	bool
 	default y if BPAUTO_SYSTEM_DATA_VERIFICATION
 	depends on (KERNEL_4_7 || !SYSTEM_DATA_VERIFICATION) && CRYPTO_HASH_INFO
-	depends on !KERNEL_3_13
 	select BPAUTO_ASN1_DECODER
 	select BPAUTO_PUBLIC_KEY
 	select BPAUTO_PKCS7
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index b67ebc27..74602628 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,25 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_3_0) += compat-3.0.o
-compat-$(CPTCFG_KERNEL_3_1) += compat-3.1.o
-compat-$(CPTCFG_KERNEL_3_2) += backport-3.2.o
-compat-$(CPTCFG_KERNEL_3_3) += compat-3.3.o
-compat-$(CPTCFG_KERNEL_3_4) += compat-3.4.o
-compat-$(CPTCFG_KERNEL_3_5) += compat-3.5.o user_namespace.o
-compat-$(CPTCFG_KERNEL_3_6) += compat-3.6.o
-compat-$(CPTCFG_KERNEL_3_7) += compat-3.7.o
-compat-$(CPTCFG_KERNEL_3_8) += compat-3.8.o
-compat-$(CPTCFG_KERNEL_3_9) += compat-3.9.o
-compat-$(CPTCFG_KERNEL_3_10) += backport-3.10.o
-compat-$(CPTCFG_KERNEL_3_11) += backport-3.11.o
-compat-$(CPTCFG_KERNEL_3_12) += backport-3.12.o
-compat-$(CPTCFG_KERNEL_3_13) += backport-3.13.o memneq.o
-compat-$(CPTCFG_KERNEL_3_14) += backport-3.14.o
-compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
-compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
-compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
-compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
 compat-$(CPTCFG_KERNEL_4_0) += backport-4.0.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
deleted file mode 100644
index 0c0e2603..00000000
--- a/backport/compat/backport-3.10.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Linux backport symbols for kernels 3.10.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/proc_fs.h>
-#include <linux/random.h>
-#include <linux/tty.h>
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/of.h>
-#include <linux/mm.h>
-
-void proc_set_size(struct proc_dir_entry *de, loff_t size)
-{
-	de->size = size;
-}
-EXPORT_SYMBOL_GPL(proc_set_size);
-
-void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid)
-{
-	de->uid = uid;
-	de->gid = gid;
-}
-EXPORT_SYMBOL_GPL(proc_set_user);
-
-/* get_random_int() was not exported for module use until 3.10-rc.
-   Implement it here in terms of the more expensive get_random_bytes()
- */
-unsigned int get_random_int(void)
-{
-	unsigned int r;
-	get_random_bytes(&r, sizeof(r));
-
-	return r;
-}
-EXPORT_SYMBOL_GPL(get_random_int);
-
-#ifdef CONFIG_TTY
-/**
- * tty_port_tty_wakeup - helper to wake up a tty
- *
- * @port: tty port
- */
-void tty_port_tty_wakeup(struct tty_port *port)
-{
-	struct tty_struct *tty = tty_port_tty_get(port);
-
-	if (tty) {
-		tty_wakeup(tty);
-		tty_kref_put(tty);
-	}
-}
-EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
-
-/**
- * tty_port_tty_hangup - helper to hang up a tty
- *
- * @port: tty port
- * @check_clocal: hang only ttys with CLOCAL unset?
- */
-void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
-{
-	struct tty_struct *tty = tty_port_tty_get(port);
-
-	if (tty && (!check_clocal || !C_CLOCAL(tty)))
-		tty_hangup(tty);
-	tty_kref_put(tty);
-}
-EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
-#endif /* CONFIG_TTY */
-
-#ifdef CONFIG_PCI_IOV
-/*
- * pci_vfs_assigned - returns number of VFs are assigned to a guest
- * @dev: the PCI device
- *
- * Returns number of VFs belonging to this device that are assigned to a guest.
- * If device is not a physical function returns -ENODEV.
- */
-int pci_vfs_assigned(struct pci_dev *dev)
-{
-	struct pci_dev *vfdev;
-	unsigned int vfs_assigned = 0;
-	unsigned short dev_id;
-
-	/* only search if we are a PF */
-	if (!dev->is_physfn)
-		return 0;
-
-	/*
-	 * determine the device ID for the VFs, the vendor ID will be the
-	 * same as the PF so there is no need to check for that one
-	 */
-	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_VF_DID, &dev_id);
-
-	/* loop through all the VFs to see if we own any that are assigned */
-	vfdev = pci_get_device(dev->vendor, dev_id, NULL);
-	while (vfdev) {
-		/*
-		 * It is considered assigned if it is a virtual function with
-		 * our dev as the physical function and the assigned bit is set
-		 */
-		if (vfdev->is_virtfn && (vfdev->physfn == dev) &&
-		    (vfdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED))
-			vfs_assigned++;
-
-		vfdev = pci_get_device(dev->vendor, dev_id, vfdev);
-	}
-
-	return vfs_assigned;
-}
-EXPORT_SYMBOL_GPL(pci_vfs_assigned);
-#endif /* CONFIG_PCI_IOV */
-
-#ifdef CONFIG_OF
-/**
- * of_property_read_u32_index - Find and read a u32 from a multi-value property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @index:	index of the u32 in the list of values
- * @out_value:	pointer to return value, modified only if no error.
- *
- * Search for a property in a device node and read nth 32-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_value is modified only if a valid u32 value can be decoded.
- */
-int of_property_read_u32_index(const struct device_node *np,
-				       const char *propname,
-				       u32 index, u32 *out_value)
-{
-	const u32 *val = of_find_property_value_of_size(np, propname,
-					((index + 1) * sizeof(*out_value)));
-
-	if (IS_ERR(val))
-		return PTR_ERR(val);
-
-	*out_value = be32_to_cpup(((__be32 *)val) + index);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_property_read_u32_index);
-#endif /* CONFIG_OF */
-
-static inline void set_page_count(struct page *page, int v)
-{
-	atomic_set(&page->_count, v);
-}
-
-/*
- * Turn a non-refcounted page (->_count == 0) into refcounted with
- * a count of one.
- */
-static inline void set_page_refcounted(struct page *page)
-{
-	VM_BUG_ON(PageTail(page));
-	VM_BUG_ON(atomic_read(&page->_count));
-	set_page_count(page, 1);
-}
-
-/*
- * split_page takes a non-compound higher-order page, and splits it into
- * n (1<<order) sub-pages: page[0..n]
- * Each sub-page must be freed individually.
- *
- * Note: this is probably too low level an operation for use in drivers.
- * Please consult with lkml before using this in your driver.
- */
-void split_page(struct page *page, unsigned int order)
-{
-	int i;
-
-	VM_BUG_ON(PageCompound(page));
-	VM_BUG_ON(!page_count(page));
-
-#ifdef CONFIG_KMEMCHECK
-	/*
-	 * Split shadow pages too, because free(page[0]) would
-	 * otherwise free the whole shadow.
-	 */
-	if (kmemcheck_page_is_tracked(page))
-		split_page(virt_to_page(page[0].shadow), order);
-#endif
-
-	for (i = 1; i < (1 << order); i++)
-		set_page_refcounted(page + i);
-}
-EXPORT_SYMBOL_GPL(split_page);
-
-struct action_devres {
-	void *data;
-	void (*action)(void *);
-};
-
-static void devm_action_release(struct device *dev, void *res)
-{
-	struct action_devres *devres = res;
-
-	devres->action(devres->data);
-}
-
-/**
- * devm_add_action() - add a custom action to list of managed resources
- * @dev: Device that owns the action
- * @action: Function that should be called
- * @data: Pointer to data passed to @action implementation
- *
- * This adds a custom action to the list of managed resources so that
- * it gets executed as part of standard resource unwinding.
- */
-int devm_add_action(struct device *dev, void (*action)(void *), void *data)
-{
-	struct action_devres *devres;
-
-	devres = devres_alloc(devm_action_release,
-			      sizeof(struct action_devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
-	devres->data = data;
-	devres->action = action;
-
-	devres_add(dev, devres);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devm_add_action);
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
deleted file mode 100644
index 7f9ff341..00000000
--- a/backport/compat/backport-3.11.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * Copyright (c) 2016 Intel Deutschland GmbH
- *
- * Backport functionality introduced in Linux 3.11.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/scatterlist.h>
-
-static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
-{
-	if (!miter->__remaining) {
-		struct scatterlist *sg;
-		unsigned long pgoffset;
-
-		if (!__sg_page_iter_next(&miter->piter))
-			return false;
-
-		sg = miter->piter.sg;
-		pgoffset = miter->piter.sg_pgoffset;
-
-		miter->__offset = pgoffset ? 0 : sg->offset;
-		miter->__remaining = sg->offset + sg->length -
-				(pgoffset << PAGE_SHIFT) - miter->__offset;
-		miter->__remaining = min_t(unsigned long, miter->__remaining,
-					   PAGE_SIZE - miter->__offset);
-	}
-
-	return true;
-}
-
-/**
- * sg_miter_skip - reposition mapping iterator
- * @miter: sg mapping iter to be skipped
- * @offset: number of bytes to plus the current location
- *
- * Description:
- *   Sets the offset of @miter to its current location plus @offset bytes.
- *   If mapping iterator @miter has been proceeded by sg_miter_next(), this
- *   stops @miter.
- *
- * Context:
- *   Don't care if @miter is stopped, or not proceeded yet.
- *   Otherwise, preemption disabled if the SG_MITER_ATOMIC is set.
- *
- * Returns:
- *   true if @miter contains the valid mapping.  false if end of sg
- *   list is reached.
- */
-static bool sg_miter_skip(struct sg_mapping_iter *miter, off_t offset)
-{
-	sg_miter_stop(miter);
-
-	while (offset) {
-		off_t consumed;
-
-		if (!sg_miter_get_next_page(miter))
-			return false;
-
-		consumed = min_t(off_t, offset, miter->__remaining);
-		miter->__offset += consumed;
-		miter->__remaining -= consumed;
-		offset -= consumed;
-	}
-
-	return true;
-}
-
-/**
- * sg_copy_buffer - Copy data between a linear buffer and an SG list
- * @sgl:		 The SG list
- * @nents:		 Number of SG entries
- * @buf:		 Where to copy from
- * @buflen:		 The number of bytes to copy
- * @skip:		 Number of bytes to skip before copying
- * @to_buffer:		 transfer direction (true == from an sg list to a
- *			 buffer, false == from a buffer to an sg list
- *
- * Returns the number of copied bytes.
- *
- **/
-size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
-		      size_t buflen, off_t skip, bool to_buffer)
-{
-	unsigned int offset = 0;
-	struct sg_mapping_iter miter;
-	unsigned long flags;
-	unsigned int sg_flags = SG_MITER_ATOMIC;
-
-	if (to_buffer)
-		sg_flags |= SG_MITER_FROM_SG;
-	else
-		sg_flags |= SG_MITER_TO_SG;
-
-	sg_miter_start(&miter, sgl, nents, sg_flags);
-
-	if (!sg_miter_skip(&miter, skip))
-		return false;
-
-	local_irq_save(flags);
-
-	while (sg_miter_next(&miter) && offset < buflen) {
-		unsigned int len;
-
-		len = min(miter.length, buflen - offset);
-
-		if (to_buffer)
-			memcpy(buf + offset, miter.addr, len);
-		else
-			memcpy(miter.addr, buf + offset, len);
-
-		offset += len;
-	}
-
-	sg_miter_stop(&miter);
-
-	local_irq_restore(flags);
-	return offset;
-}
-EXPORT_SYMBOL_GPL(sg_copy_buffer);
diff --git a/backport/compat/backport-3.12.c b/backport/compat/backport-3.12.c
deleted file mode 100644
index c9b21e86..00000000
--- a/backport/compat/backport-3.12.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.12.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/export.h>
-#include <linux/hid.h>
-#include <linux/bug.h>
-#include <linux/math64.h>
-
-/*
- * Allocator for buffer that is going to be passed to hid_output_report()
- */
-u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
-{
-	/*
-	 * 7 extra bytes are necessary to achieve proper functionality
-	 * of implement() working on 8 byte chunks
-	 */
-
-	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0) + 7;
-
-	return kmalloc(len, flags);
-}
-EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
-
-#if BITS_PER_LONG == 32
-/**
- * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
- * @dividend:	64bit dividend
- * @divisor:	64bit divisor
- * @remainder:  64bit remainder
- *
- * This implementation is a comparable to algorithm used by div64_u64.
- * But this operation, which includes math for calculating the remainder,
- * is kept distinct to avoid slowing down the div64_u64 operation on 32bit
- * systems.
- */
-#ifndef backports_div64_u64_rem_add
-u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
-{
-	u32 high = divisor >> 32;
-	u64 quot;
-
-	if (high == 0) {
-		u32 rem32;
-		quot = div_u64_rem(dividend, divisor, &rem32);
-		*remainder = rem32;
-	} else {
-		int n = 1 + fls(high);
-		quot = div_u64(dividend >> n, divisor >> n);
-
-		if (quot != 0)
-			quot--;
-
-		*remainder = dividend - quot * divisor;
-		if (*remainder >= divisor) {
-			quot++;
-			*remainder -= divisor;
-		}
-	}
-
-	return quot;
-}
-EXPORT_SYMBOL_GPL(div64_u64_rem);
-#endif /* backports_div64_u64_rem_add */
-#endif /* BITS_PER_LONG */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
deleted file mode 100644
index 2b61711d..00000000
--- a/backport/compat/backport-3.13.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (c) 2013  Hannes Frederic Sowa <hannes@stressinduktion.org>
- * Copyright (c) 2014  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport functionality introduced in Linux 3.13.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/pci.h>
-#include <linux/device.h>
-#include <linux/hwmon.h>
-#include <linux/net.h>
-
-#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
-struct __net_random_once_work {
-	struct work_struct work;
-	struct static_key *key;
-};
-
-static void __net_random_once_deferred(struct work_struct *w)
-{
-	struct __net_random_once_work *work =
-		container_of(w, struct __net_random_once_work, work);
-	if (!static_key_enabled(work->key))
-		static_key_slow_inc(work->key);
-	kfree(work);
-}
-
-static void __net_random_once_disable_jump(struct static_key *key)
-{
-	struct __net_random_once_work *w;
-
-	w = kmalloc(sizeof(*w), GFP_ATOMIC);
-	if (!w)
-		return;
-
-	INIT_WORK(&w->work, __net_random_once_deferred);
-	w->key = key;
-	schedule_work(&w->work);
-}
-
-bool __net_get_random_once(void *buf, int nbytes, bool *done,
-			   struct static_key *done_key)
-{
-	static DEFINE_SPINLOCK(lock);
-	unsigned long flags;
-
-	spin_lock_irqsave(&lock, flags);
-	if (*done) {
-		spin_unlock_irqrestore(&lock, flags);
-		return false;
-	}
-
-	get_random_bytes(buf, nbytes);
-	*done = true;
-	spin_unlock_irqrestore(&lock, flags);
-
-	__net_random_once_disable_jump(done_key);
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(__net_get_random_once);
-#endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
-
-#ifdef CONFIG_PCI
-#define pci_bus_read_dev_vendor_id LINUX_BACKPORT(pci_bus_read_dev_vendor_id)
-static bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
-{
-	int delay = 1;
-
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-		return false;
-
-	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
-	    *l == 0x0000ffff || *l == 0xffff0000)
-		return false;
-
-	/*
-	 * Configuration Request Retry Status.  Some root ports return the
-	 * actual device ID instead of the synthetic ID (0xFFFF) required
-	 * by the PCIe spec.  Ignore the device ID and only check for
-	 * (vendor id == 1).
-	 */
-	while ((*l & 0xffff) == 0x0001) {
-		if (!crs_timeout)
-			return false;
-
-		msleep(delay);
-		delay *= 2;
-		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-			return false;
-		/* Card hasn't responded in 60 seconds?  Must be stuck. */
-		if (delay > crs_timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
-			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn));
-			return false;
-		}
-	}
-
-	return true;
-}
-
-bool pci_device_is_present(struct pci_dev *pdev)
-{
-	u32 v;
-
-	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
-}
-EXPORT_SYMBOL_GPL(pci_device_is_present);
-#endif /* CONFIG_PCI */
-
-#ifdef CONFIG_HWMON
-struct device*
-hwmon_device_register_with_groups(struct device *dev, const char *name,
-				  void *drvdata,
-				  const struct attribute_group **groups)
-{
-	struct device *hwdev;
-
-	hwdev = hwmon_device_register(dev);
-	hwdev->groups = groups;
-	dev_set_drvdata(hwdev, drvdata);
-	return hwdev;
-}
-
-static void devm_hwmon_release(struct device *dev, void *res)
-{
-	struct device *hwdev = *(struct device **)res;
-
-	hwmon_device_unregister(hwdev);
-}
-
-struct device *
-devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
-				       void *drvdata,
-				       const struct attribute_group **groups)
-{
-	struct device **ptr, *hwdev;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	hwdev = hwmon_device_register_with_groups(dev, name, drvdata, groups);
-	if (IS_ERR(hwdev))
-		goto error;
-
-	*ptr = hwdev;
-	devres_add(dev, ptr);
-	return hwdev;
-
-error:
-	devres_free(ptr);
-	return hwdev;
-}
-EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
-#endif
diff --git a/backport/compat/backport-3.14.c b/backport/compat/backport-3.14.c
deleted file mode 100644
index aeb30045..00000000
--- a/backport/compat/backport-3.14.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.14.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-
-#ifdef CONFIG_PCI_MSI
-/**
- * pci_enable_msi_range - configure device's MSI capability structure
- * @dev: device to configure
- * @minvec: minimal number of interrupts to configure
- * @maxvec: maximum number of interrupts to configure
- *
- * This function tries to allocate a maximum possible number of interrupts in a
- * range between @minvec and @maxvec. It returns a negative errno if an error
- * occurs. If it succeeds, it returns the actual number of interrupts allocated
- * and updates the @dev's irq member to the lowest new interrupt number;
- * the other interrupt numbers allocated to this device are consecutive.
- **/
-int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
-{
-	int nvec = maxvec;
-	int rc;
-
-	if (maxvec < minvec)
-		return -ERANGE;
-
-	do {
-		rc = pci_enable_msi_block(dev, nvec);
-		if (rc < 0) {
-			return rc;
-		} else if (rc > 0) {
-			if (rc < minvec)
-				return -ENOSPC;
-			nvec = rc;
-		}
-	} while (rc);
-
-	return nvec;
-}
-EXPORT_SYMBOL(pci_enable_msi_range);
-#endif
-
-#ifdef CONFIG_PCI_MSI
-/**
- * pci_enable_msix_range - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries
- * @minvec: minimum number of MSI-X irqs requested
- * @maxvec: maximum number of MSI-X irqs requested
- *
- * Setup the MSI-X capability structure of device function with a maximum
- * possible number of interrupts in the range between @minvec and @maxvec
- * upon its software driver call to request for MSI-X mode enabled on its
- * hardware device function. It returns a negative errno if an error occurs.
- * If it succeeds, it returns the actual number of interrupts allocated and
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X interrupts.
- **/
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-			       int minvec, int maxvec)
-{
-	int nvec = maxvec;
-	int rc;
-
-	if (maxvec < minvec)
-		return -ERANGE;
-
-	do {
-		rc = pci_enable_msix(dev, entries, nvec);
-		if (rc < 0) {
-			return rc;
-		} else if (rc > 0) {
-			if (rc < minvec)
-				return -ENOSPC;
-			nvec = rc;
-		}
-	} while (rc);
-
-	return nvec;
-}
-EXPORT_SYMBOL(pci_enable_msix_range);
-#endif
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
deleted file mode 100644
index c0023ac1..00000000
--- a/backport/compat/backport-3.15.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (c) 2015  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport functionality introduced in Linux 3.15.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/of.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <net/net_namespace.h>
-
-/**
- * devm_kstrdup - Allocate resource managed space and
- *                copy an existing string into that.
- * @dev: Device to allocate memory for
- * @s: the string to duplicate
- * @gfp: the GFP mask used in the devm_kmalloc() call when
- *       allocating memory
- * RETURNS:
- * Pointer to allocated string on success, NULL on failure.
- */
-char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
-{
-	size_t size;
-	char *buf;
-
-	if (!s)
-		return NULL;
-
-	size = strlen(s) + 1;
-	buf = devm_kmalloc(dev, size, gfp);
-	if (buf)
-		memcpy(buf, s, size);
-	return buf;
-}
-EXPORT_SYMBOL_GPL(devm_kstrdup);
-
-#ifdef CONFIG_OF
-/**
- * of_property_count_elems_of_size - Count the number of elements in a property
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @elem_size:	size of the individual element
- *
- * Search for a property in a device node and count the number of elements of
- * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
- * property does not exist or its length does not match a multiple of elem_size
- * and -ENODATA if the property does not have a value.
- */
-int of_property_count_elems_of_size(const struct device_node *np,
-				const char *propname, int elem_size)
-{
-	struct property *prop = of_find_property(np, propname, NULL);
-
-	if (!prop)
-		return -EINVAL;
-	if (!prop->value)
-		return -ENODATA;
-
-	if (prop->length % elem_size != 0) {
-		pr_err("size of %s in node %s is not a multiple of %d\n",
-		       propname, np->full_name, elem_size);
-		return -EINVAL;
-	}
-
-	return prop->length / elem_size;
-}
-EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
-#endif
-
-void kvfree(const void *addr)
-{
-	if (is_vmalloc_addr(addr))
-		vfree(addr);
-	else
-		kfree(addr);
-}
-EXPORT_SYMBOL_GPL(kvfree);
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
deleted file mode 100644
index bf6027cb..00000000
--- a/backport/compat/backport-3.17.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.17.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/device.h>
-#include <linux/export.h>
-#include <linux/ktime.h>
-#include <linux/jiffies.h>
-#include <linux/moduleparam.h>
-
-int bit_wait(void *word)
-{
-	schedule();
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bit_wait);
-
-int bit_wait_io(void *word)
-{
-	io_schedule();
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bit_wait_io);
-
-/**
- * ktime_get_raw - Returns the raw monotonic time in ktime_t format
- */
-ktime_t ktime_get_raw(void)
-{
-	struct timespec ts;
-
-	getrawmonotonic(&ts);
-	return timespec_to_ktime(ts);
-}
-EXPORT_SYMBOL_GPL(ktime_get_raw);
-
-
-/**
- * nsecs_to_jiffies64 - Convert nsecs in u64 to jiffies64
- *
- * @n:	nsecs in u64
- *
- * Unlike {m,u}secs_to_jiffies, type of input is not unsigned int but u64.
- * And this doesn't return MAX_JIFFY_OFFSET since this function is designed
- * for scheduler, not for use in device drivers to calculate timeout value.
- *
- * note:
- *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
- *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
- */
-static u64 backport_nsecs_to_jiffies64(u64 n)
-{
-#if (NSEC_PER_SEC % HZ) == 0
-	/* Common case, HZ = 100, 128, 200, 250, 256, 500, 512, 1000 etc. */
-	return div_u64(n, NSEC_PER_SEC / HZ);
-#elif (HZ % 512) == 0
-	/* overflow after 292 years if HZ = 1024 */
-	return div_u64(n * HZ / 512, NSEC_PER_SEC / 512);
-#else
-	/*
-	 * Generic case - optimized for cases where HZ is a multiple of 3.
-	 * overflow after 64.99 years, exact for HZ = 60, 72, 90, 120 etc.
-	 */
-	return div_u64(n * 9, (9ull * NSEC_PER_SEC + HZ / 2) / HZ);
-#endif
-}
-
-/**
- * nsecs_to_jiffies - Convert nsecs in u64 to jiffies
- *
- * @n:	nsecs in u64
- *
- * Unlike {m,u}secs_to_jiffies, type of input is not unsigned int but u64.
- * And this doesn't return MAX_JIFFY_OFFSET since this function is designed
- * for scheduler, not for use in device drivers to calculate timeout value.
- *
- * note:
- *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
- *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
- */
-unsigned long nsecs_to_jiffies(u64 n)
-{
-	return (unsigned long)backport_nsecs_to_jiffies64(n);
-}
-EXPORT_SYMBOL_GPL(nsecs_to_jiffies);
-
-/**
- * devm_kvasprintf - Allocate resource managed space
- *			for the formatted string.
- * @dev: Device to allocate memory for
- * @gfp: the GFP mask used in the devm_kmalloc() call when
- *       allocating memory
- * @fmt: the formatted string to duplicate
- * @ap: the list of tokens to be placed in the formatted string
- * RETURNS:
- * Pointer to allocated string on success, NULL on failure.
- */
-char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
-		      va_list ap)
-{
-	unsigned int len;
-	char *p;
-	va_list aq;
-
-	va_copy(aq, ap);
-	len = vsnprintf(NULL, 0, fmt, aq);
-	va_end(aq);
-
-	p = devm_kmalloc(dev, len+1, gfp);
-	if (!p)
-		return NULL;
-
-	vsnprintf(p, len+1, fmt, ap);
-
-	return p;
-}
-EXPORT_SYMBOL_GPL(devm_kvasprintf);
-
-/**
- * devm_kasprintf - Allocate resource managed space
- *		and copy an existing formatted string into that
- * @dev: Device to allocate memory for
- * @gfp: the GFP mask used in the devm_kmalloc() call when
- *       allocating memory
- * @fmt: the string to duplicate
- * RETURNS:
- * Pointer to allocated string on success, NULL on failure.
- */
-char *devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...)
-{
-	va_list ap;
-	char *p;
-
-	va_start(ap, fmt);
-	p = devm_kvasprintf(dev, gfp, fmt, ap);
-	va_end(ap);
-
-	return p;
-}
-EXPORT_SYMBOL_GPL(devm_kasprintf);
-
-#define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
-	int param_set_##name(const char *val, const struct kernel_param *kp) \
-	{								\
-		return strtolfn(val, 0, (type *)kp->arg);		\
-	}								\
-	int param_get_##name(char *buffer, const struct kernel_param *kp) \
-	{								\
-		return scnprintf(buffer, PAGE_SIZE, format,		\
-				*((type *)kp->arg));			\
-	}								\
-	struct kernel_param_ops param_ops_##name = {			\
-		.set = param_set_##name,				\
-		.get = param_get_##name,				\
-	};								\
-	EXPORT_SYMBOL(param_set_##name);				\
-	EXPORT_SYMBOL(param_get_##name);				\
-	EXPORT_SYMBOL(param_ops_##name)
-STANDARD_PARAM_DEF(ullong, unsigned long long, "%llu", kstrtoull);
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
deleted file mode 100644
index d2eceef7..00000000
--- a/backport/compat/backport-3.18.c
+++ /dev/null
@@ -1,332 +0,0 @@
-/*
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.18.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/if_ether.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <scsi/fc/fc_fcoe.h>
-#include <linux/skbuff.h>
-#include <linux/errqueue.h>
-#include <linux/wait.h>
-#include <linux/of.h>
-#include <linux/string.h>
-
-/**
- * eth_get_headlen - determine the the length of header for an ethernet frame
- * @data: pointer to start of frame
- * @len: total length of frame
- *
- * Make a best effort attempt to pull the length for all of the headers for
- * a given frame in a linear buffer.
- */
-int eth_get_headlen(unsigned char *data, unsigned int max_len)
-{
-	union {
-		unsigned char *network;
-		/* l2 headers */
-		struct ethhdr *eth;
-		struct vlan_hdr *vlan;
-		/* l3 headers */
-		struct iphdr *ipv4;
-		struct ipv6hdr *ipv6;
-	} hdr;
-	__be16 protocol;
-	u8 nexthdr = 0;	/* default to not TCP */
-	u8 hlen;
-
-	/* this should never happen, but better safe than sorry */
-	if (max_len < ETH_HLEN)
-		return max_len;
-
-	/* initialize network frame pointer */
-	hdr.network = data;
-
-	/* set first protocol and move network header forward */
-	protocol = hdr.eth->h_proto;
-	hdr.network += ETH_HLEN;
-
-	/* handle any vlan tag if present */
-	if (protocol == htons(ETH_P_8021Q)) {
-		if ((hdr.network - data) > (max_len - VLAN_HLEN))
-			return max_len;
-
-		protocol = hdr.vlan->h_vlan_encapsulated_proto;
-		hdr.network += VLAN_HLEN;
-	}
-
-	/* handle L3 protocols */
-	if (protocol == htons(ETH_P_IP)) {
-		if ((hdr.network - data) > (max_len - sizeof(struct iphdr)))
-			return max_len;
-
-		/* access ihl as a u8 to avoid unaligned access on ia64 */
-		hlen = (hdr.network[0] & 0x0F) << 2;
-
-		/* verify hlen meets minimum size requirements */
-		if (hlen < sizeof(struct iphdr))
-			return hdr.network - data;
-
-		/* record next protocol if header is present */
-		if (!(hdr.ipv4->frag_off & htons(IP_OFFSET)))
-			nexthdr = hdr.ipv4->protocol;
-	} else if (protocol == htons(ETH_P_IPV6)) {
-		if ((hdr.network - data) > (max_len - sizeof(struct ipv6hdr)))
-			return max_len;
-
-		/* record next protocol */
-		nexthdr = hdr.ipv6->nexthdr;
-		hlen = sizeof(struct ipv6hdr);
-	} else if (protocol == htons(ETH_P_FCOE)) {
-		if ((hdr.network - data) > (max_len - FCOE_HEADER_LEN))
-			return max_len;
-		hlen = FCOE_HEADER_LEN;
-	} else {
-		return hdr.network - data;
-	}
-
-	/* relocate pointer to start of L4 header */
-	hdr.network += hlen;
-
-	/* finally sort out TCP/UDP */
-	if (nexthdr == IPPROTO_TCP) {
-		if ((hdr.network - data) > (max_len - sizeof(struct tcphdr)))
-			return max_len;
-
-		/* access doff as a u8 to avoid unaligned access on ia64 */
-		hlen = (hdr.network[12] & 0xF0) >> 2;
-
-		/* verify hlen meets minimum size requirements */
-		if (hlen < sizeof(struct tcphdr))
-			return hdr.network - data;
-
-		hdr.network += hlen;
-	} else if (nexthdr == IPPROTO_UDP) {
-		if ((hdr.network - data) > (max_len - sizeof(struct udphdr)))
-			return max_len;
-
-		hdr.network += sizeof(struct udphdr);
-	}
-
-	/*
-	 * If everything has gone correctly hdr.network should be the
-	 * data section of the packet and will be the end of the header.
-	 * If not then it probably represents the end of the last recognized
-	 * header.
-	 */
-	if ((hdr.network - data) < max_len)
-		return hdr.network - data;
-	else
-		return max_len;
-}
-EXPORT_SYMBOL_GPL(eth_get_headlen);
-
-#define sock_efree LINUX_BACKPORT(sock_efree)
-static void sock_efree(struct sk_buff *skb)
-{
-	sock_put(skb->sk);
-}
-
-/**
- * skb_clone_sk - create clone of skb, and take reference to socket
- * @skb: the skb to clone
- *
- * This function creates a clone of a buffer that holds a reference on
- * sk_refcnt.  Buffers created via this function are meant to be
- * returned using sock_queue_err_skb, or free via kfree_skb.
- *
- * When passing buffers allocated with this function to sock_queue_err_skb
- * it is necessary to wrap the call with sock_hold/sock_put in order to
- * prevent the socket from being released prior to being enqueued on
- * the sk_error_queue.
- */
-struct sk_buff *skb_clone_sk(struct sk_buff *skb)
-{
-	struct sock *sk = skb->sk;
-	struct sk_buff *clone;
-
-	if (!sk || !atomic_inc_not_zero(&sk->sk_refcnt))
-		return NULL;
-
-	clone = skb_clone(skb, GFP_ATOMIC);
-	if (!clone) {
-		sock_put(sk);
-		return NULL;
-	}
-
-	clone->sk = sk;
-	clone->destructor = sock_efree;
-
-	return clone;
-}
-EXPORT_SYMBOL_GPL(skb_clone_sk);
-
-#if LINUX_VERSION_IS_GEQ(3,3,0)
-/*
- * skb_complete_wifi_ack() needs to get backported, because the version from
- * 3.18 added the sock_hold() and sock_put() calles missing in older versions.
- */
-void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
-{
-	struct sock *sk = skb->sk;
-	struct sock_exterr_skb *serr;
-	int err;
-
-	skb->wifi_acked_valid = 1;
-	skb->wifi_acked = acked;
-
-	serr = SKB_EXT_ERR(skb);
-	memset(serr, 0, sizeof(*serr));
-	serr->ee.ee_errno = ENOMSG;
-	serr->ee.ee_origin = SO_EE_ORIGIN_TXSTATUS;
-
-	/* take a reference to prevent skb_orphan() from freeing the socket */
-	sock_hold(sk);
-
-	err = sock_queue_err_skb(sk, skb);
-	if (err)
-		kfree_skb(skb);
-
-	sock_put(sk);
-}
-EXPORT_SYMBOL_GPL(skb_complete_wifi_ack);
-#endif
-
-#if LINUX_VERSION_IS_GEQ(3,17,0)
-int __sched out_of_line_wait_on_bit_timeout(
-	void *word, int bit, wait_bit_action_f *action,
-	unsigned mode, unsigned long timeout)
-{
-	wait_queue_head_t *wq = bit_waitqueue(word, bit);
-	DEFINE_WAIT_BIT(wait, word, bit);
-
-	wait.key.private = jiffies + timeout;
-	return __wait_on_bit(wq, &wait, action, mode);
-}
-EXPORT_SYMBOL_GPL(out_of_line_wait_on_bit_timeout);
-
-__sched int bit_wait_timeout(struct wait_bit_key *word)
-{
-	unsigned long now = ACCESS_ONCE(jiffies);
-	if (signal_pending_state(current->state, current))
-		return 1;
-	if (time_after_eq(now, word->private))
-		return -EAGAIN;
-	schedule_timeout(word->private - now);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bit_wait_timeout);
-#endif
-
-#ifdef CONFIG_OF
-/**
- * of_find_property_value_of_size
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @len:	requested length of property value
- *
- * Search for a property in a device node and valid the requested size.
- * Returns the property value on success, -EINVAL if the property does not
- *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- */
-void *of_find_property_value_of_size(const struct device_node *np,
-				     const char *propname, u32 len)
-{
-	struct property *prop = of_find_property(np, propname, NULL);
-
-	if (!prop)
-		return ERR_PTR(-EINVAL);
-	if (!prop->value)
-		return ERR_PTR(-ENODATA);
-	if (len > prop->length)
-		return ERR_PTR(-EOVERFLOW);
-
-	return prop->value;
-}
-
-/**
- * of_property_read_u64_array - Find and read an array of 64 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u64 value can be decoded.
- */
-int of_property_read_u64_array(const struct device_node *np,
-			       const char *propname, u64 *out_values,
-			       size_t sz)
-{
-	const __be32 *val = of_find_property_value_of_size(np, propname,
-						(sz * sizeof(*out_values)));
-
-	if (IS_ERR(val))
-		return PTR_ERR(val);
-
-	while (sz--) {
-		*out_values++ = of_read_number(val, 2);
-		val += 2;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_property_read_u64_array);
-#endif /* CONFIG_OF */
-
-#if !(LINUX_VERSION_IS_GEQ(3,17,3) || \
-      (LINUX_VERSION_IS_GEQ(3,14,24) && \
-      LINUX_VERSION_IS_LESS(3,15,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,12,33) && \
-      LINUX_VERSION_IS_LESS(3,13,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,10,60) && \
-      LINUX_VERSION_IS_LESS(3,11,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,4,106) && \
-      LINUX_VERSION_IS_LESS(3,5,0)) || \
-      (LINUX_VERSION_IS_GEQ(3,2,65) && \
-      LINUX_VERSION_IS_LESS(3,3,0)))
-/**
- * memzero_explicit - Fill a region of memory (e.g. sensitive
- *		      keying data) with 0s.
- * @s: Pointer to the start of the area.
- * @count: The size of the area.
- *
- * Note: usually using memset() is just fine (!), but in cases
- * where clearing out _local_ data at the end of a scope is
- * necessary, memzero_explicit() should be used instead in
- * order to prevent the compiler from optimising away zeroing.
- *
- * memzero_explicit() doesn't need an arch-specific version as
- * it just invokes the one of memset() implicitly.
- */
-void memzero_explicit(void *s, size_t count)
-{
-	memset(s, 0, count);
-	barrier_data(s);
-}
-EXPORT_SYMBOL_GPL(memzero_explicit);
-#endif
-
-char *bin2hex(char *dst, const void *src, size_t count)
-{
-	const unsigned char *_src = src;
-
-	while (count--)
-		dst = hex_byte_pack(dst, *_src++);
-	return dst;
-}
-EXPORT_SYMBOL(bin2hex);
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
deleted file mode 100644
index 019644df..00000000
--- a/backport/compat/backport-3.19.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.19.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/kthread.h>
-#include <linux/export.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/debugfs.h>
-
-#if LINUX_VERSION_IS_LESS(3,18,12)
-static inline bool is_kthread_should_stop(void)
-{
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
-}
-
-/*
- * DEFINE_WAIT_FUNC(wait, woken_wake_func);
- *
- * add_wait_queue(&wq, &wait);
- * for (;;) {
- *     if (condition)
- *         break;
- *
- *     p->state = mode;				condition = true;
- *     smp_mb(); // A				smp_wmb(); // C
- *     if (!wait->flags & WQ_FLAG_WOKEN)	wait->flags |= WQ_FLAG_WOKEN;
- *         schedule()				try_to_wake_up();
- *     p->state = TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
- *     wait->flags &= ~WQ_FLAG_WOKEN;		condition = true;
- *     smp_mb() // B				smp_wmb(); // C
- *						wait->flags |= WQ_FLAG_WOKEN;
- * }
- * remove_wait_queue(&wq, &wait);
- *
- */
-long wait_woken(wait_queue_t *wait, unsigned mode, long timeout)
-{
-	set_current_state(mode); /* A */
-	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
-	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
-	 * also observe all state before the wakeup.
-	 */
-	if (!(wait->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
-		timeout = schedule_timeout(timeout);
-	__set_current_state(TASK_RUNNING);
-
-	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
-	 * woken_wake_function() such that we must either observe the wait
-	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
-	 * an event.
-	 */
-	set_mb(wait->flags, wait->flags & ~WQ_FLAG_WOKEN); /* B */
-
-	return timeout;
-}
-EXPORT_SYMBOL(wait_woken);
-
-int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
-{
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with set_mb() in wait_woken().
-	 */
-	smp_wmb(); /* C */
-	wait->flags |= WQ_FLAG_WOKEN;
-
-	return default_wake_function(wait, mode, sync, key);
-}
-EXPORT_SYMBOL(woken_wake_function);
-#endif
-
-static u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
-
-void netdev_rss_key_fill(void *buffer, size_t len)
-{
-	BUG_ON(len > sizeof(netdev_rss_key));
-#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
-	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
-	memcpy(buffer, netdev_rss_key, len);
-#else
-	get_random_bytes(buffer, len);
-#endif
-}
-EXPORT_SYMBOL_GPL(netdev_rss_key_fill);
-
-#if defined(CONFIG_DEBUG_FS)
-struct debugfs_devm_entry {
-	int (*read)(struct seq_file *seq, void *data);
-	struct device *dev;
-};
-
-static int debugfs_devm_entry_open(struct inode *inode, struct file *f)
-{
-	struct debugfs_devm_entry *entry = inode->i_private;
-
-	return single_open(f, entry->read, entry->dev);
-}
-
-static const struct file_operations debugfs_devm_entry_ops = {
-	.owner = THIS_MODULE,
-	.open = debugfs_devm_entry_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
-
-/**
- * debugfs_create_devm_seqfile - create a debugfs file that is bound to device.
- *
- * @dev: device related to this debugfs file.
- * @name: name of the debugfs file.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *	directory dentry if set.  If this parameter is %NULL, then the
- *	file will be created in the root of the debugfs filesystem.
- * @read_fn: function pointer called to print the seq_file content.
- */
-struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
-					   struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data))
-{
-	struct debugfs_devm_entry *entry;
-
-	if (IS_ERR(parent))
-		return ERR_PTR(-ENOENT);
-
-	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return ERR_PTR(-ENOMEM);
-
-	entry->read = read_fn;
-	entry->dev = dev;
-
-	return debugfs_create_file(name, S_IRUGO, parent, entry,
-				   &debugfs_devm_entry_ops);
-}
-EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
-
-#endif /* CONFIG_DEBUG_FS */
-
-int skb_ensure_writable(struct sk_buff *skb, int write_len)
-{
-	if (!pskb_may_pull(skb, write_len))
-		return -ENOMEM;
-
-	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
-		return 0;
-
-	return pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
-}
-EXPORT_SYMBOL_GPL(skb_ensure_writable);
diff --git a/backport/compat/backport-3.2.c b/backport/compat/backport-3.2.c
deleted file mode 100644
index 601a1682..00000000
--- a/backport/compat/backport-3.2.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Linux backport symbols for kernels 3.2.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/export.h>
-
-int hex2bin(u8 *dst, const char *src, size_t count)
-{
-	while (count--) {
-		int hi = hex_to_bin(*src++);
-		int lo = hex_to_bin(*src++);
-
-		if ((hi < 0) || (lo < 0))
-			return -1;
-
-		*dst++ = (hi << 4) | lo;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hex2bin);
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index fbe0ddbc..f540594f 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -146,14 +146,6 @@ overflow1:
 }
 EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
-static inline unsigned char *
-trace_seq_buffer_ptr(struct trace_seq *s)
-{
-	return s->buffer + s->len;
-}
-#endif
-
 const char *
 ftrace_print_array_seq(struct trace_seq *p, const void *buf, int buf_len,
 		       size_t el_size)
diff --git a/backport/compat/backport-4.18.c b/backport/compat/backport-4.18.c
index 40551c76..b0b5a8fe 100644
--- a/backport/compat/backport-4.18.c
+++ b/backport/compat/backport-4.18.c
@@ -5,40 +5,6 @@
 
 #include <linux/hrtimer.h>
 
-/*
- * Before the commit 8b618628b2b the ktime_divns was non-exported function.
- * Add the simple implementation of ktime_divns() to use in
- * ktime_get_boottime_seconds().
- */
-#if LINUX_VERSION_IS_LESS(3,19,0)
-
-#include <linux/ktime.h>
-
-#if BITS_PER_LONG < 64
-/*
- * Divide a ktime value by a nanosecond value
- */
-u64 ktime_divns(const ktime_t kt, s64 div)
-{
-	int sft = 0;
-	s64 dclc;
-	u64 tmp;
-
-	dclc = ktime_to_ns(kt);
-	tmp = dclc < 0 ? -dclc : dclc;
-
-	/* Make sure the divisor is less than 2^32: */
-	while (div >> 32) {
-		sft++;
-		div >>= 1;
-	}
-	tmp >>= sft;
-	do_div(tmp, (unsigned long) div);
-	return dclc < 0 ? -tmp : tmp;
-}
-#endif /* BITS_PER_LONG >= 64 */
-#endif /* < 3.19 */
-
 time64_t ktime_get_boottime_seconds(void)
 {
 	return ktime_divns(ktime_get_boottime(), NSEC_PER_SEC);
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index 04698ad3..12cc6cf7 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 
 #ifdef CONFIG_THERMAL
-#if LINUX_VERSION_IS_GEQ(3,8,0)
 struct backport_thermal_ops_wrapper {
 	old_thermal_zone_device_ops_t ops;
 	struct thermal_zone_device_ops *driver_ops;
@@ -100,7 +99,6 @@ static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
 	return ret;
 }
 
-#if LINUX_VERSION_IS_GEQ(3, 19, 0)
 static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
 					  unsigned long temp)
 {
@@ -109,7 +107,6 @@ static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
 
 	return wrapper->driver_ops->set_emul_temp(dev, (int)temp);
 }
-#endif /* LINUX_VERSION_IS_GEQ(3, 19, 0) */
 
 struct thermal_zone_device *backport_thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
@@ -150,9 +147,7 @@ struct thermal_zone_device *backport_thermal_zone_device_register(
 	assign_ops(get_trip_hyst);
 	assign_ops(set_trip_hyst);
 	assign_ops(get_crit_temp);
-#if LINUX_VERSION_IS_GEQ(3, 19, 0)
 	assign_ops(set_emul_temp);
-#endif /* LINUX_VERSION_IS_GEQ(3, 19, 0) */
 #undef assign_ops
 
 	ret = old_thermal_zone_device_register(type, trips, mask, devdata,
@@ -174,7 +169,6 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *dev)
 }
 EXPORT_SYMBOL_GPL(backport_thermal_zone_device_unregister);
 
-#endif /* >= 3.8.0 */
 #endif /* CONFIG_THERMAL */
 
 static void seq_set_overflow(struct seq_file *m)
@@ -253,11 +247,7 @@ static void *device_get_mac_addr(struct device *dev,
 				 const char *name, char *addr,
 				 int alen)
 {
-#if LINUX_VERSION_IS_GEQ(3,18,0)
 	int ret = device_property_read_u8_array(dev, name, addr, alen);
-#else
-	int ret = of_property_read_u8_array(dev->of_node, name, addr, alen);
-#endif
 
 	if (ret == 0 && alen == ETH_ALEN && is_valid_ether_addr(addr))
 		return addr;
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index b4aae624..4b673845 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -20,7 +20,6 @@
 #include <asm/uaccess.h>
 #include <linux/io.h>
 
-#if LINUX_VERSION_IS_GEQ(3,19,0)
 int led_set_brightness_sync(struct led_classdev *led_cdev,
 			    enum led_brightness value)
 {
@@ -38,9 +37,7 @@ int led_set_brightness_sync(struct led_classdev *led_cdev,
 	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(led_set_brightness_sync);
-#endif /* >= 3.19 */
 
-#if LINUX_VERSION_IS_GEQ(3,2,0)
 /**
  * no_seek_end_llseek - llseek implementation for fixed-sized devices
  * @file:	file structure to seek on
@@ -52,19 +49,13 @@ loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
 {
 	switch (whence) {
 	case SEEK_SET: case SEEK_CUR:
-#if LINUX_VERSION_IS_GEQ(3,6,0)
 		return generic_file_llseek_size(file, offset, whence,
 						~0ULL, 0);
-#else
-		return generic_file_llseek_size(file, offset, whence,
-						~0ULL);
-#endif
 	default:
 		return -EINVAL;
 	}
 }
 EXPORT_SYMBOL_GPL(no_seek_end_llseek);
-#endif /* >= 3.2 */
 
 /**
  * memdup_user_nul - duplicate memory region from user space and NUL-terminate
diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
index 372951b6..b47764e6 100644
--- a/backport/compat/backport-4.7.c
+++ b/backport/compat/backport-4.7.c
@@ -120,8 +120,7 @@ EXPORT_SYMBOL_GPL(nla_put_64bit);
  * Below 3.18 or if the kernel has devcoredump disabled, we copied the
  * entire devcoredump, so no need to define these functions.
  */
-#if LINUX_VERSION_IS_GEQ(3,18,0) && \
-	!defined(CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP)
+#if !defined(CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP)
 #include <linux/devcoredump.h>
 #include <linux/scatterlist.h>
 
@@ -181,4 +180,4 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		      (void *)devcd_free_sgtable);
 }
 EXPORT_SYMBOL_GPL(dev_coredumpsg);
-#endif /* >= 3.18.0 */
+#endif /* !CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP */
diff --git a/backport/compat/backport-5.3.c b/backport/compat/backport-5.3.c
index 46e6a11d..c5f58fbf 100644
--- a/backport/compat/backport-5.3.c
+++ b/backport/compat/backport-5.3.c
@@ -2,7 +2,6 @@
 
 #include <linux/export.h>
 #include <linux/gpio.h>
-#if LINUX_VERSION_IS_GEQ(3,17,0)
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
@@ -82,4 +81,3 @@ struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip *gc,
 	return desc;
 }
 EXPORT_SYMBOL_GPL(backport_gpiochip_request_own_desc);
-#endif /* > 3.17 */
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 47078589..97d2c60e 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -256,23 +256,17 @@ int backport_genl_register_family(struct genl_family *family)
 	COPY(version);
 	COPY(maxattr);
 	COPY(netnsok);
-#if LINUX_VERSION_IS_GEQ(3,10,0)
 	COPY(parallel_ops);
-#endif
 	/* The casts are OK - we checked everything is the same offset in genl_ops */
 	family->family.pre_doit = (void *)backport_pre_doit;
 	family->family.post_doit = (void *)backport_post_doit;
 	/* attrbuf is output only */
 	family->copy_ops = (void *)ops;
-#if LINUX_VERSION_IS_GEQ(3,13,0)
 	family->family.ops = (void *)ops;
 	COPY(mcgrps);
 	COPY(n_ops);
 	COPY(n_mcgrps);
-#endif
-#if LINUX_VERSION_IS_GEQ(3,11,0)
 	COPY(module);
-#endif
 
 	err = __real_backport_genl_register_family(&family->family);
 
@@ -282,27 +276,7 @@ int backport_genl_register_family(struct genl_family *family)
 	if (err)
 		return err;
 
-#if LINUX_VERSION_IS_GEQ(3,13,0) || RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,0)
-	return 0;
-#else
-	for (i = 0; i < family->n_ops; i++) {
-		err = genl_register_ops(&family->family, ops + i);
-		if (err < 0)
-			goto error;
-	}
-
-	for (i = 0; i < family->n_mcgrps; i++) {
-		err = genl_register_mc_group(&family->family,
-					     &family->mcgrps[i]);
-		if (err)
-			goto error;
-	}
-
 	return 0;
- error:
-	genl_unregister_family(family);
-	return err;
-#endif /* LINUX_VERSION_IS_GEQ(3,13,0) || RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,0) */
 }
 EXPORT_SYMBOL_GPL(backport_genl_register_family);
 
@@ -319,11 +293,7 @@ static u32 __backport_genl_group(const struct genl_family *family,
 {
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return INVALID_GROUP;
-#if LINUX_VERSION_IS_LESS(3,13,0)
-	return family->mcgrps[group].id;
-#else
 	return family->family.mcgrp_offset + group;
-#endif
 }
 
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
diff --git a/backport/compat/compat-3.0.c b/backport/compat/compat-3.0.c
deleted file mode 100644
index 1bed6a6a..00000000
--- a/backport/compat/compat-3.0.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Copyright 2011    Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright 2011    Alexey Dobriyan <adobriyan@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.0.
- */
-
-#include <linux/compat.h>
-#include <linux/if_ether.h>
-
-int mac_pton(const char *s, u8 *mac)
-{
-	int i;
-
-	/* XX:XX:XX:XX:XX:XX */
-	if (strlen(s) < 3 * ETH_ALEN - 1)
-		return 0;
-
-	/* Don't dirty result unless string is valid MAC. */
-	for (i = 0; i < ETH_ALEN; i++) {
-		if (!strchr("0123456789abcdefABCDEF", s[i * 3]))
-			return 0;
-		if (!strchr("0123456789abcdefABCDEF", s[i * 3 + 1]))
-			return 0;
-		if (i != ETH_ALEN - 1 && s[i * 3 + 2] != ':')
-			return 0;
-	}
-	for (i = 0; i < ETH_ALEN; i++) {
-		mac[i] = (hex_to_bin(s[i * 3]) << 4) | hex_to_bin(s[i * 3 + 1]);
-	}
-	return 1;
-}
-EXPORT_SYMBOL_GPL(mac_pton);
-
-#define kstrto_from_user(f, g, type)					\
-int f(const char __user *s, size_t count, unsigned int base, type *res)	\
-{									\
-	/* sign, base 2 representation, newline, terminator */		\
-	char buf[1 + sizeof(type) * 8 + 1 + 1];				\
-									\
-	count = min(count, sizeof(buf) - 1);				\
-	if (copy_from_user(buf, s, count))				\
-		return -EFAULT;						\
-	buf[count] = '\0';						\
-	return g(buf, base, res);					\
-}									\
-EXPORT_SYMBOL_GPL(f)
-
-kstrto_from_user(kstrtoull_from_user,	kstrtoull,	unsigned long long);
-kstrto_from_user(kstrtoll_from_user,	kstrtoll,	long long);
-kstrto_from_user(kstrtoul_from_user,	kstrtoul,	unsigned long);
-kstrto_from_user(kstrtol_from_user,	kstrtol,	long);
-kstrto_from_user(kstrtouint_from_user,	kstrtouint,	unsigned int);
-kstrto_from_user(kstrtoint_from_user,	kstrtoint,	int);
-kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
-kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
-kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
-kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
-
-/**
- * strtobool - convert common user inputs into boolean values
- * @s: input string
- * @res: result
- *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0'.
- * Otherwise it will return -EINVAL.  Value pointed to by res is
- * updated upon finding a match.
- */
-int strtobool(const char *s, bool *res)
-{
-	switch (s[0]) {
-	case 'y':
-	case 'Y':
-	case '1':
-		*res = true;
-		break;
-	case 'n':
-	case 'N':
-	case '0':
-		*res = false;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(strtobool);
diff --git a/backport/compat/compat-3.1.c b/backport/compat/compat-3.1.c
deleted file mode 100644
index 26187809..00000000
--- a/backport/compat/compat-3.1.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright 2012    Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.1.
- */
-
-#include <linux/idr.h>
-#include <linux/cpufreq.h>
-#include <linux/of.h>
-
-static DEFINE_SPINLOCK(compat_simple_ida_lock);
-
-/**
- * ida_simple_get - get a new id.
- * @ida: the (initialized) ida.
- * @start: the minimum id (inclusive, < 0x8000000)
- * @end: the maximum id (exclusive, < 0x8000000 or 0)
- * @gfp_mask: memory allocation flags
- *
- * Allocates an id in the range start <= id < end, or returns -ENOSPC.
- * On memory allocation failure, returns -ENOMEM.
- *
- * Use ida_simple_remove() to get rid of an id.
- */
-int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
-		   gfp_t gfp_mask)
-{
-	int ret, id;
-	unsigned int max;
-	unsigned long flags;
-
-	BUG_ON((int)start < 0);
-	BUG_ON((int)end < 0);
-
-	if (end == 0)
-		max = 0x80000000;
-	else {
-		BUG_ON(end < start);
-		max = end - 1;
-	}
-
-again:
-	if (!ida_pre_get(ida, gfp_mask))
-		return -ENOMEM;
-
-	spin_lock_irqsave(&compat_simple_ida_lock, flags);
-	ret = ida_get_new_above(ida, start, &id);
-	if (!ret) {
-		if (id > max) {
-			ida_remove(ida, id);
-			ret = -ENOSPC;
-		} else {
-			ret = id;
-		}
-	}
-	spin_unlock_irqrestore(&compat_simple_ida_lock, flags);
-
-	if (unlikely(ret == -EAGAIN))
-		goto again;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ida_simple_get);
-
-/**
- * ida_simple_remove - remove an allocated id.
- * @ida: the (initialized) ida.
- * @id: the id returned by ida_simple_get.
- */
-void ida_simple_remove(struct ida *ida, unsigned int id)
-{
-	unsigned long flags;
-
-	BUG_ON((int)id < 0);
-	spin_lock_irqsave(&compat_simple_ida_lock, flags);
-	ida_remove(ida, id);
-	spin_unlock_irqrestore(&compat_simple_ida_lock, flags);
-}
-EXPORT_SYMBOL_GPL(ida_simple_remove);
-/* source lib/idr.c */
-
-#ifdef CONFIG_OF
-/**
- * of_property_read_u32_array - Find and read an array of 32 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u32 value can be decoded.
- */
-int of_property_read_u32_array(const struct device_node *np,
-			       const char *propname, u32 *out_values,
-			       size_t sz)
-{
-	const __be32 *val = of_find_property_value_of_size(np, propname,
-						(sz * sizeof(*out_values)));
-
-	if (IS_ERR(val))
-		return PTR_ERR(val);
-
-	while (sz--)
-		*out_values++ = be32_to_cpup(val++);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_property_read_u32_array);
-#endif
diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
deleted file mode 100644
index 1185a5d2..00000000
--- a/backport/compat/compat-3.3.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * Copyright 2012  Luis R. Rodriguez <mcgrof@frijolero.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.3.
- */
-
-#include <linux/kernel.h>
-#include <linux/version.h>
-#include <linux/skbuff.h>
-#include <linux/module.h>
-#include <linux/workqueue.h>
-#include <net/dst.h>
-#include <net/xfrm.h>
-
-static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
-{
-	new->tstamp		= old->tstamp;
-	new->dev		= old->dev;
-	new->transport_header	= old->transport_header;
-	new->network_header	= old->network_header;
-	new->mac_header		= old->mac_header;
-	skb_dst_copy(new, old);
-	new->rxhash		= old->rxhash;
-#if LINUX_VERSION_IS_GEQ(3,1,0)
-	new->ooo_okay		= old->ooo_okay;
-#endif
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-	new->l4_rxhash		= old->l4_rxhash;
-#endif
-#ifdef CONFIG_XFRM
-	new->sp			= secpath_get(old->sp);
-#endif
-	memcpy(new->cb, old->cb, sizeof(old->cb));
-	new->csum		= old->csum;
-	new->local_df		= old->local_df;
-	new->pkt_type		= old->pkt_type;
-	new->ip_summed		= old->ip_summed;
-	skb_copy_queue_mapping(new, old);
-	new->priority		= old->priority;
-#if IS_ENABLED(CONFIG_IP_VS)
-	new->ipvs_property	= old->ipvs_property;
-#endif
-	new->protocol		= old->protocol;
-	new->mark		= old->mark;
-	new->skb_iif		= old->skb_iif;
-	__nf_copy(new, old);
-#if IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TRACE)
-	new->nf_trace		= old->nf_trace;
-#endif
-#ifdef CONFIG_NET_SCHED
-	new->tc_index		= old->tc_index;
-#ifdef CONFIG_NET_CLS_ACT
-	new->tc_verd		= old->tc_verd;
-#endif
-#endif
-	new->vlan_tci		= old->vlan_tci;
-
-	skb_copy_secmark(new, old);
-}
-
-static void copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
-{
-#ifndef NET_SKBUFF_DATA_USES_OFFSET
-	/*
-	 *	Shift between the two data areas in bytes
-	 */
-	unsigned long offset = new->data - old->data;
-#endif
-
-	__copy_skb_header(new, old);
-
-#ifndef NET_SKBUFF_DATA_USES_OFFSET
-	/* {transport,network,mac}_header are relative to skb->head */
-	new->transport_header += offset;
-	new->network_header   += offset;
-	if (skb_mac_header_was_set(new))
-		new->mac_header	      += offset;
-#endif
-	skb_shinfo(new)->gso_size = skb_shinfo(old)->gso_size;
-	skb_shinfo(new)->gso_segs = skb_shinfo(old)->gso_segs;
-	skb_shinfo(new)->gso_type = skb_shinfo(old)->gso_type;
-}
-
-static void skb_clone_fraglist(struct sk_buff *skb)
-{
-	struct sk_buff *list;
-
-	skb_walk_frags(skb, list)
-		skb_get(list);
-}
-
-
-/**
- *	__pskb_copy	-	create copy of an sk_buff with private head.
- *	@skb: buffer to copy
- *	@headroom: headroom of new skb
- *	@gfp_mask: allocation priority
- *
- *	Make a copy of both an &sk_buff and part of its data, located
- *	in header. Fragmented data remain shared. This is used when
- *	the caller wishes to modify only header of &sk_buff and needs
- *	private copy of the header to alter. Returns %NULL on failure
- *	or the pointer to the buffer on success.
- *	The returned buffer has a reference count of 1.
- */
-
-struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom, gfp_t gfp_mask)
-{
-	unsigned int size = skb_headlen(skb) + headroom;
-	struct sk_buff *n = alloc_skb(size, gfp_mask);
-
-	if (!n)
-		goto out;
-
-	/* Set the data pointer */
-	skb_reserve(n, headroom);
-	/* Set the tail pointer and length */
-	skb_put(n, skb_headlen(skb));
-	/* Copy the bytes */
-	skb_copy_from_linear_data(skb, n->data, n->len);
-
-	n->truesize += skb->data_len;
-	n->data_len  = skb->data_len;
-	n->len	     = skb->len;
-
-	if (skb_shinfo(skb)->nr_frags) {
-		int i;
-
-/*
- * SKBTX_DEV_ZEROCOPY was added on 3.1 as well but requires ubuf
- * stuff added to the skb which we do not have
- */
-#if 0
-		if (skb_shinfo(skb)->tx_flags & SKBTX_DEV_ZEROCOPY) {
-			if (skb_copy_ubufs(skb, gfp_mask)) {
-				kfree_skb(n);
-				n = NULL;
-				goto out;
-			}
-		}
-#endif
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-			skb_shinfo(n)->frags[i] = skb_shinfo(skb)->frags[i];
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-			skb_frag_ref(skb, i);
-#else
-			get_page(skb_shinfo(skb)->frags[i].page);
-#endif
-		}
-		skb_shinfo(n)->nr_frags = i;
-	}
-
-	if (skb_has_frag_list(skb)) {
-		skb_shinfo(n)->frag_list = skb_shinfo(skb)->frag_list;
-		skb_clone_fraglist(n);
-	}
-
-	copy_skb_header(n, skb);
-out:
-	return n;
-}
-EXPORT_SYMBOL_GPL(__pskb_copy);
-
-static DEFINE_SPINLOCK(wq_name_lock);
-static LIST_HEAD(wq_name_list);
-
-struct wq_name {
-	struct list_head list;
-	struct workqueue_struct *wq;
-	char name[24];
-};
-
-struct workqueue_struct *
-backport_alloc_workqueue(const char *fmt, unsigned int flags,
-			 int max_active, struct lock_class_key *key,
-			 const char *lock_name, ...)
-{
-	struct workqueue_struct *wq;
-	struct wq_name *n = kzalloc(sizeof(*n), GFP_KERNEL);
-	va_list args;
-
-	if (!n)
-		return NULL;
-
-	va_start(args, lock_name);
-	vsnprintf(n->name, sizeof(n->name), fmt, args);
-	va_end(args);
-
-	wq = __alloc_workqueue_key(n->name, flags, max_active, key, lock_name);
-	if (!wq) {
-		kfree(n);
-		return NULL;
-	}
-
-	n->wq = wq;
-	spin_lock(&wq_name_lock);
-	list_add(&n->list, &wq_name_list);
-	spin_unlock(&wq_name_lock);
-
-	return wq;
-}
-EXPORT_SYMBOL_GPL(backport_alloc_workqueue);
-
-void backport_destroy_workqueue(struct workqueue_struct *wq)
-{
-	struct wq_name *n, *tmp;
-
-	/* call original */
-#undef destroy_workqueue
-	destroy_workqueue(wq);
-
-	spin_lock(&wq_name_lock);
-	list_for_each_entry_safe(n, tmp, &wq_name_list, list) {
-		if (n->wq == wq) {
-			list_del(&n->list);
-			kfree(n);
-			break;
-		}
-	}
-	spin_unlock(&wq_name_lock);
-}
-EXPORT_SYMBOL_GPL(backport_destroy_workqueue);
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
deleted file mode 100644
index 52753725..00000000
--- a/backport/compat/compat-3.4.c
+++ /dev/null
@@ -1,201 +0,0 @@
-/*
- * Copyright 2012  Luis R. Rodriguez <mcgrof@frijolero.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.4.
- */
-
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/wait.h>
-#include <linux/compat.h>
-#include <asm/uaccess.h>
-
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-#include <linux/regmap.h>
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
-#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-
-#if defined(CONFIG_REGMAP)
-static void devm_regmap_release(struct device *dev, void *res)
-{
-	regmap_exit(*(struct regmap **)res);
-}
-
-#if defined(CONFIG_REGMAP_I2C)
-static int regmap_i2c_write(
-			    struct device *dev,
-			    const void *data,
-			    size_t count)
-{
-	struct i2c_client *i2c = to_i2c_client(dev);
-	int ret;
-
-	ret = i2c_master_send(i2c, data, count);
-	if (ret == count)
-		return 0;
-	else if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-
-static int regmap_i2c_gather_write(
-				   struct device *dev,
-				   const void *reg, size_t reg_size,
-				   const void *val, size_t val_size)
-{
-	struct i2c_client *i2c = to_i2c_client(dev);
-	struct i2c_msg xfer[2];
-	int ret;
-
-	/* If the I2C controller can't do a gather tell the core, it
-	 * will substitute in a linear write for us.
-	 */
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
-		return -ENOTSUPP;
-
-	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = reg_size;
-	xfer[0].buf = (void *)reg;
-
-	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_NOSTART;
-	xfer[1].len = val_size;
-	xfer[1].buf = (void *)val;
-
-	ret = i2c_transfer(i2c->adapter, xfer, 2);
-	if (ret == 2)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-
-static int regmap_i2c_read(
-			   struct device *dev,
-			   const void *reg, size_t reg_size,
-			   void *val, size_t val_size)
-{
-	struct i2c_client *i2c = to_i2c_client(dev);
-	struct i2c_msg xfer[2];
-	int ret;
-
-	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = reg_size;
-	xfer[0].buf = (void *)reg;
-
-	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = val_size;
-	xfer[1].buf = val;
-
-	ret = i2c_transfer(i2c->adapter, xfer, 2);
-	if (ret == 2)
-		return 0;
-	else if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-
-static struct regmap_bus regmap_i2c = {
-	.write = regmap_i2c_write,
-	.gather_write = regmap_i2c_gather_write,
-	.read = regmap_i2c_read,
-};
-#endif /* defined(CONFIG_REGMAP_I2C) */
-
-/**
- * devm_regmap_init(): Initialise managed register map
- *
- * @dev: Device that will be interacted with
- * @bus: Bus-specific callbacks to use with device
- * @bus_context: Data passed to bus-specific callbacks
- * @config: Configuration for register map
- *
- * The return value will be an ERR_PTR() on error or a valid pointer
- * to a struct regmap.  This function should generally not be called
- * directly, it should be called by bus-specific init functions.  The
- * map will be automatically freed by the device management code.
- */
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				const struct regmap_config *config)
-{
-	struct regmap **ptr, *regmap;
-
-	ptr = devres_alloc(devm_regmap_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	regmap = regmap_init(dev,
-			     bus,
-			     config);
-	if (!IS_ERR(regmap)) {
-		*ptr = regmap;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return regmap;
-}
-EXPORT_SYMBOL_GPL(devm_regmap_init);
-
-#if defined(CONFIG_REGMAP_I2C)
-/**
- * devm_regmap_init_i2c(): Initialise managed register map
- *
- * @i2c: Device that will be interacted with
- * @config: Configuration for register map
- *
- * The return value will be an ERR_PTR() on error or a valid pointer
- * to a struct regmap.  The regmap will be automatically freed by the
- * device management code.
- */
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config)
-{
-	return devm_regmap_init(&i2c->dev, &regmap_i2c, config);
-}
-EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
-#endif /* defined(CONFIG_REGMAP_I2C) */
-
-#endif /* defined(CONFIG_REGMAP) */
-#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-int simple_open(struct inode *inode, struct file *file)
-{
-	if (inode->i_private)
-		file->private_data = inode->i_private;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(simple_open);
-
-#ifdef CONFIG_COMPAT
-static int __compat_put_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
-{
-	return (!access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
-			__put_user(ts->tv_sec, &cts->tv_sec) ||
-			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
-}
-
-int compat_put_timespec(const struct timespec *ts, void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_to_user(uts, ts, sizeof *ts) ? -EFAULT : 0;
-	else
-		return __compat_put_timespec(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_put_timespec);
-#endif
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
deleted file mode 100644
index de312283..00000000
--- a/backport/compat/compat-3.5.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Copyright 2012-2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.5.
- */
-
-#include <linux/module.h>
-#include <linux/highuid.h>
-#include <linux/ktime.h>
-#include <linux/hrtimer.h>
-#include <linux/gpio.h>
-#include <linux/ptp_clock_kernel.h>
-
-#if LINUX_VERSION_IS_GEQ(3,2,0)
-#include <linux/device.h>
-
-/**
- * devres_release - Find a device resource and destroy it, calling release
- * @dev: Device to find resource from
- * @release: Look for resources associated with this release function
- * @match: Match function (optional)
- * @match_data: Data for the match function
- *
- * Find the latest devres of @dev associated with @release and for
- * which @match returns 1.  If @match is NULL, it's considered to
- * match all.  If found, the resource is removed atomically, the
- * release function called and the resource freed.
- *
- * RETURNS:
- * 0 if devres is found and freed, -ENOENT if not found.
- */
-int devres_release(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data)
-{
-	void *res;
-
-	res = devres_remove(dev, release, match, match_data);
-	if (unlikely(!res))
-		return -ENOENT;
-
-	(*release)(dev, res);
-	devres_free(res);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devres_release);
-#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-/*
- * Commit 7a4e7408c5cadb240e068a662251754a562355e3
- * exported overflowuid and overflowgid for all
- * kernel configurations, prior to that we only
- * had it exported when CONFIG_UID16 was enabled.
- * We are technically redefining it here but
- * nothing seems to be changing it, except
- * kernel/ code does epose it via sysctl and
- * proc... if required later we can add that here.
- */
-#ifndef CONFIG_UID16
-int overflowuid = DEFAULT_OVERFLOWUID;
-int overflowgid = DEFAULT_OVERFLOWGID;
-
-EXPORT_SYMBOL_GPL(overflowuid);
-EXPORT_SYMBOL_GPL(overflowgid);
-#endif
-
-#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
-int ptp_clock_index(struct ptp_clock *ptp)
-{
-	return ptp->index;
-}
-EXPORT_SYMBOL(ptp_clock_index);
-#endif /* CONFIG_PTP_1588_CLOCK */
-
-#ifdef CONFIG_GPIOLIB
-static void devm_gpio_release(struct device *dev, void *res)
-{
-	unsigned *gpio = res;
-
-	gpio_free(*gpio);
-}
-
-/**
- *      devm_gpio_request - request a GPIO for a managed device
- *      @dev: device to request the GPIO for
- *      @gpio: GPIO to allocate
- *      @label: the name of the requested GPIO
- *
- *      Except for the extra @dev argument, this function takes the
- *      same arguments and performs the same function as
- *      gpio_request().  GPIOs requested with this function will be
- *      automatically freed on driver detach.
- *
- *      If an GPIO allocated with this function needs to be freed
- *      separately, devm_gpio_free() must be used.
- */
-
-int devm_gpio_request(struct device *dev, unsigned gpio, const char *label)
-{
-	unsigned *dr;
-	int rc;
-
-	dr = devres_alloc(devm_gpio_release, sizeof(unsigned), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	rc = gpio_request(gpio, label);
-	if (rc) {
-		devres_free(dr);
-		return rc;
-	}
-
-	*dr = gpio;
-	devres_add(dev, dr);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devm_gpio_request);
-
-/**
- *	devm_gpio_request_one - request a single GPIO with initial setup
- *	@dev:   device to request for
- *	@gpio:	the GPIO number
- *	@flags:	GPIO configuration as specified by GPIOF_*
- *	@label:	a literal description string of this GPIO
- */
-int devm_gpio_request_one(struct device *dev, unsigned gpio,
-			  unsigned long flags, const char *label)
-{
-	unsigned *dr;
-	int rc;
-
-	dr = devres_alloc(devm_gpio_release, sizeof(unsigned), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	rc = gpio_request_one(gpio, flags, label);
-	if (rc) {
-		devres_free(dr);
-		return rc;
-	}
-
-	*dr = gpio;
-	devres_add(dev, dr);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devm_gpio_request_one);
-
-static int devm_gpio_match(struct device *dev, void *res, void *data)
-{
-	unsigned *this = res, *gpio = data;
-
-	return *this == *gpio;
-}
-
-void devm_gpio_free(struct device *dev, unsigned int gpio)
-{
-	WARN_ON(devres_destroy(dev, devm_gpio_release, devm_gpio_match,
-		&gpio));
-	gpio_free(gpio);
-}
-EXPORT_SYMBOL_GPL(devm_gpio_free);
-#endif /* CONFIG_GPIOLIB */
diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
deleted file mode 100644
index ef364852..00000000
--- a/backport/compat/compat-3.6.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport compatibility file for Linux for kernels 3.6.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/export.h>
-#include <linux/clk.h>
-
-/* whoopsie ! */
-#ifndef CONFIG_COMMON_CLK
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL_GPL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL_GPL(clk_disable);
-#endif
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
deleted file mode 100644
index a70709c9..00000000
--- a/backport/compat/compat-3.7.c
+++ /dev/null
@@ -1,290 +0,0 @@
-/*
- * Copyright 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 3.7.
- */
-
-#include <linux/workqueue.h>
-#include <linux/export.h>
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/of.h>
-#include <linux/scatterlist.h>
-
-bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
-		      unsigned long delay)
-{
-	cancel_delayed_work(dwork);
-	queue_delayed_work(wq, dwork, delay);
-	return false;
-}
-EXPORT_SYMBOL_GPL(mod_delayed_work);
-
-#ifdef CONFIG_PCI
-/*
- * Kernels >= 3.7 get their PCI-E Capabilities Register cached
- * via the pci_dev->pcie_flags_reg so for older kernels we have
- * no other option but to read this every single time we need
- * it accessed. If we really cared to improve the efficiency
- * of this we could try to find an unused u16 varible on the
- * pci_dev but if we found it we likely would remove it from
- * the kernel anyway right? Bite me.
- */
-static inline u16 pcie_flags_reg(struct pci_dev *dev)
-{
-	int pos;
-	u16 reg16;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (!pos)
-		return 0;
-
-	pci_read_config_word(dev, pos + PCI_EXP_FLAGS, &reg16);
-
-	return reg16;
-}
-
-#define pci_pcie_type LINUX_BACKPORT(pci_pcie_type)
-static inline int pci_pcie_type(struct pci_dev *dev)
-{
-	return (pcie_flags_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
-}
-
-#define pcie_cap_version LINUX_BACKPORT(pcie_cap_version)
-static inline int pcie_cap_version(struct pci_dev *dev)
-{
-	return pcie_flags_reg(dev) & PCI_EXP_FLAGS_VERS;
-}
-
-static inline bool pcie_cap_has_lnkctl(struct pci_dev *dev)
-{
-	int type = pci_pcie_type(dev);
-
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_ENDPOINT ||
-	       type == PCI_EXP_TYPE_LEG_END;
-}
-
-static inline bool pcie_cap_has_sltctl(struct pci_dev *dev)
-{
-	int type = pci_pcie_type(dev);
-
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       (type == PCI_EXP_TYPE_DOWNSTREAM &&
-		pcie_flags_reg(dev) & PCI_EXP_FLAGS_SLOT);
-}
-
-static inline bool pcie_cap_has_rtctl(struct pci_dev *dev)
-{
-	int type = pci_pcie_type(dev);
-
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_RC_EC;
-}
-
-static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
-{
-	if (!pci_is_pcie(dev))
-		return false;
-
-	switch (pos) {
-	case PCI_EXP_FLAGS_TYPE:
-		return true;
-	case PCI_EXP_DEVCAP:
-	case PCI_EXP_DEVCTL:
-	case PCI_EXP_DEVSTA:
-		return true;
-	case PCI_EXP_LNKCAP:
-	case PCI_EXP_LNKCTL:
-	case PCI_EXP_LNKSTA:
-		return pcie_cap_has_lnkctl(dev);
-	case PCI_EXP_SLTCAP:
-	case PCI_EXP_SLTCTL:
-	case PCI_EXP_SLTSTA:
-		return pcie_cap_has_sltctl(dev);
-	case PCI_EXP_RTCTL:
-	case PCI_EXP_RTCAP:
-	case PCI_EXP_RTSTA:
-		return pcie_cap_has_rtctl(dev);
-	case PCI_EXP_DEVCAP2:
-	case PCI_EXP_DEVCTL2:
-	case PCI_EXP_LNKCAP2:
-	case PCI_EXP_LNKCTL2:
-	case PCI_EXP_LNKSTA2:
-		return pcie_cap_version(dev) > 1;
-	default:
-		return false;
-	}
-}
-
-/*
- * Note that these accessor functions are only for the "PCI Express
- * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
- * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
- */
-int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
-{
-	int ret;
-
-	*val = 0;
-	if (pos & 1)
-		return -EINVAL;
-
-	if (pcie_capability_reg_implemented(dev, pos)) {
-		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
-		/*
-		 * Reset *val to 0 if pci_read_config_word() fails, it may
-		 * have been written as 0xFFFF if hardware error happens
-		 * during pci_read_config_word().
-		 */
-		if (ret)
-			*val = 0;
-		return ret;
-	}
-
-	/*
-	 * For Functions that do not implement the Slot Capabilities,
-	 * Slot Status, and Slot Control registers, these spaces must
-	 * be hardwired to 0b, with the exception of the Presence Detect
-	 * State bit in the Slot Status register of Downstream Ports,
-	 * which must be hardwired to 1b.  (PCIe Base Spec 3.0, sec 7.8)
-	 */
-	if (pci_is_pcie(dev) && pos == PCI_EXP_SLTSTA &&
-		 pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
-		*val = PCI_EXP_SLTSTA_PDS;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcie_capability_read_word);
-
-int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
-{
-	int ret;
-
-	*val = 0;
-	if (pos & 3)
-		return -EINVAL;
-
-	if (pcie_capability_reg_implemented(dev, pos)) {
-		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-		/*
-		 * Reset *val to 0 if pci_read_config_dword() fails, it may
-		 * have been written as 0xFFFFFFFF if hardware error happens
-		 * during pci_read_config_dword().
-		 */
-		if (ret)
-			*val = 0;
-		return ret;
-	}
-
-	if (pci_is_pcie(dev) && pos == PCI_EXP_SLTCTL &&
-		 pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
-		*val = PCI_EXP_SLTSTA_PDS;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcie_capability_read_dword);
-
-int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
-{
-	if (pos & 1)
-		return -EINVAL;
-
-	if (!pcie_capability_reg_implemented(dev, pos))
-		return 0;
-
-	return pci_write_config_word(dev, pci_pcie_cap(dev) + pos, val);
-}
-EXPORT_SYMBOL_GPL(pcie_capability_write_word);
-
-int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
-{
-	if (pos & 3)
-		return -EINVAL;
-
-	if (!pcie_capability_reg_implemented(dev, pos))
-		return 0;
-
-	return pci_write_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-}
-EXPORT_SYMBOL_GPL(pcie_capability_write_dword);
-
-int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
-				       u16 clear, u16 set)
-{
-	int ret;
-	u16 val;
-
-	ret = pcie_capability_read_word(dev, pos, &val);
-	if (!ret) {
-		val &= ~clear;
-		val |= set;
-		ret = pcie_capability_write_word(dev, pos, val);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_word);
-
-int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
-					u32 clear, u32 set)
-{
-	int ret;
-	u32 val;
-
-	ret = pcie_capability_read_dword(dev, pos, &val);
-	if (!ret) {
-		val &= ~clear;
-		val |= set;
-		ret = pcie_capability_write_dword(dev, pos, val);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_dword);
-#endif
-
-#ifdef CONFIG_OF
-#if LINUX_VERSION_IS_LESS(3,7,0)
-/**
- *	of_get_child_by_name - Find the child node by name for a given parent
- *	@node:	parent node
- *	@name:	child name to look for.
- *
- *      This function looks for child node for given matching name
- *
- *	Returns a node pointer if found, with refcount incremented, use
- *	of_node_put() on it when done.
- *	Returns NULL if node is not found.
- */
-struct device_node *of_get_child_by_name(const struct device_node *node,
-				const char *name)
-{
-	struct device_node *child;
-
-	for_each_child_of_node(node, child)
-		if (child->name && (of_node_cmp(child->name, name) == 0))
-			break;
-	return child;
-}
-EXPORT_SYMBOL_GPL(of_get_child_by_name);
-#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
-#endif /* CONFIG_OF */
-
-int sg_nents(struct scatterlist *sg)
-{
-	int nents;
-	for (nents = 0; sg; sg = sg_next(sg))
-		nents++;
-	return nents;
-}
-EXPORT_SYMBOL_GPL(sg_nents);
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
deleted file mode 100644
index ff9cd493..00000000
--- a/backport/compat/compat-3.8.c
+++ /dev/null
@@ -1,455 +0,0 @@
-/*
- * Copyright (c) 1999 Andreas Gal
- * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
- * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
- * Copyright (c) 2006-2012 Jiri Kosina
- * Copyright (c) 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport functionality introduced in Linux 3.8.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/hid.h>
-#include <linux/module.h>
-#include "hid-ids.h"
-#include <linux/netdevice.h>
-#include <linux/random.h>
-#include <linux/of.h>
-#include <linux/mm.h>
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-
-#if LINUX_VERSION_IS_LESS(3,7,8)
-void netdev_set_default_ethtool_ops(struct net_device *dev,
-				    const struct ethtool_ops *ops)
-{
-	if (!dev->ethtool_ops)
-		dev->ethtool_ops = ops;
-}
-EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
-#endif
-
-/* a list of devices that shouldn't be handled by HID core at all */
-static const struct hid_device_id hid_ignore_list[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_FLAIR) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_302) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ADS_TECH, USB_DEVICE_ID_ADS_TECH_RADIO_SI470X) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_01) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_10) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_21) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_22) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_23) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_LCM)},
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_LCM2)},
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_ULTRAMOUSE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_16_16_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_8_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_7_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_PHIDGET_MOTORCONTROL) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_SUPER_Q2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_GOGOPEN) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_PENPOWER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GRETAGMACBETH, USB_DEVICE_ID_GRETAGMACBETH_HUEY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_RADIOSHARK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_90) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_100) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_101) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_103) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_104) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_105) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_106) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_107) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_108) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_200) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_201) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_202) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_203) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_204) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_205) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_206) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_207) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_300) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_301) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_302) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_303) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_304) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_305) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_306) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_307) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_308) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_309) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_400) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_401) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_503) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_504) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1000) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1001) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1002) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1003) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1005) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1006) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_GPEN_560) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CASSY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CASSY2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POCKETCASSY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POCKETCASSY2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MOBILECASSY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MOBILECASSY2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYVOLTAGE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYCURRENT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIC) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_XRAY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_XRAY2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_VIDEOCOM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MOTOR) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_COM3LAB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_TELEPORT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_NETWORKANALYSER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERCONTROL) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETEST) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MOSTANALYSER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MOSTANALYSER2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_ABSESP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_AUTODATABUS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MCT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_HYBRID) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_HEATCONTROL) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_BEATPAD) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1024LS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1208LS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT1) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR, USB_DEVICE_ID_N_S_HARMONY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 100) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 108) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 118) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 200) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0001) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0002) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0003) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PHILIPS, USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
-#if defined(CONFIG_MOUSE_SYNAPTICS_USB) || defined(CONFIG_MOUSE_SYNAPTICS_USB_MODULE)
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_INT_TP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_CPAD) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_STICK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_WP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_COMP_TP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_WTP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
-#endif
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LCSPEC) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WACOM, HID_ANY_ID) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
-	{ }
-};
-
-/**
- * hid_mouse_ignore_list - mouse devices which should not be handled by the hid layer
- *
- * There are composite devices for which we want to ignore only a certain
- * interface. This is a list of devices for which only the mouse interface will
- * be ignored. This allows a dedicated driver to take care of the interface.
- */
-static const struct hid_device_id hid_mouse_ignore_list[] = {
-	/* appletouch driver */
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
-	{ }
-};
-
-static bool hid_match_one_id(struct hid_device *hdev,
-		const struct hid_device_id *id)
-{
-	return (id->bus == HID_BUS_ANY || id->bus == hdev->bus) &&
-#if LINUX_VERSION_IS_GEQ(3,8,0)
-		(id->group == HID_GROUP_ANY || id->group == hdev->group) &&
-#endif
-		(id->vendor == HID_ANY_ID || id->vendor == hdev->vendor) &&
-		(id->product == HID_ANY_ID || id->product == hdev->product);
-}
-
-#define hid_match_id LINUX_BACKPORT(hid_match_id)
-static const struct hid_device_id *
-hid_match_id(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	for (; id->bus; id++)
-		if (hid_match_one_id(hdev, id))
-			return id;
-
-	return NULL;
-}
-
-bool hid_ignore(struct hid_device *hdev)
-{
-	if (hdev->quirks & HID_QUIRK_NO_IGNORE)
-		return false;
-	if (hdev->quirks & HID_QUIRK_IGNORE)
-		return true;
-
-	switch (hdev->vendor) {
-	case USB_VENDOR_ID_CODEMERCS:
-		/* ignore all Code Mercenaries IOWarrior devices */
-		if (hdev->product >= USB_DEVICE_ID_CODEMERCS_IOW_FIRST &&
-				hdev->product <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
-			return true;
-		break;
-	case USB_VENDOR_ID_LOGITECH:
-		if (hdev->product >= USB_DEVICE_ID_LOGITECH_HARMONY_FIRST &&
-				hdev->product <= USB_DEVICE_ID_LOGITECH_HARMONY_LAST)
-			return true;
-		/*
-		 * The Keene FM transmitter USB device has the same USB ID as
-		 * the Logitech AudioHub Speaker, but it should ignore the hid.
-		 * Check if the name is that of the Keene device.
-		 * For reference: the name of the AudioHub is
-		 * "HOLTEK  AudioHub Speaker".
-		 */
-		if (hdev->product == USB_DEVICE_ID_LOGITECH_AUDIOHUB &&
-			!strcmp(hdev->name, "HOLTEK  B-LINK USB Audio  "))
-				return true;
-		break;
-	case USB_VENDOR_ID_SOUNDGRAPH:
-		if (hdev->product >= USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST &&
-		    hdev->product <= USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST)
-			return true;
-		break;
-	case USB_VENDOR_ID_HANWANG:
-		if (hdev->product >= USB_DEVICE_ID_HANWANG_TABLET_FIRST &&
-		    hdev->product <= USB_DEVICE_ID_HANWANG_TABLET_LAST)
-			return true;
-		break;
-	case USB_VENDOR_ID_JESS:
-		if (hdev->product == USB_DEVICE_ID_JESS_YUREX &&
-				hdev->type == HID_TYPE_USBNONE)
-			return true;
-		break;
-	case USB_VENDOR_ID_DWAV:
-		/* These are handled by usbtouchscreen. hdev->type is probably
-		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
-		 * usbtouchscreen. */
-		if ((hdev->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER ||
-		     hdev->product == USB_DEVICE_ID_DWAV_TOUCHCONTROLLER) &&
-		    hdev->type != HID_TYPE_USBMOUSE)
-			return true;
-		break;
-	}
-
-	if (hdev->type == HID_TYPE_USBMOUSE &&
-			hid_match_id(hdev, hid_mouse_ignore_list))
-		return true;
-
-	return !!hid_match_id(hdev, hid_ignore_list);
-}
-EXPORT_SYMBOL_GPL(hid_ignore);
-
-/**
- *	prandom_bytes - get the requested number of pseudo-random bytes
- *	@buf: where to copy the pseudo-random bytes to
- *	@bytes: the requested number of bytes
- */
-void prandom_bytes(void *buf, int bytes)
-{
-	unsigned char *p = buf;
-	int i;
-
-	for (i = 0; i < round_down(bytes, sizeof(u32)); i += sizeof(u32)) {
-		u32 random = random32();
-		int j;
-
-		for (j = 0; j < sizeof(u32); j++) {
-			p[i + j] = random;
-			random >>= BITS_PER_BYTE;
-		}
-	}
-
-	if (i < bytes) {
-		u32 random = random32();
-
-		for (; i < bytes; i++) {
-			p[i] = random;
-			random >>= BITS_PER_BYTE;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(prandom_bytes);
-
-#ifdef CONFIG_OF
-/**
- * of_property_read_u8_array - Find and read an array of u8 from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
- *
- * The out_values is modified only if a valid u8 value can be decoded.
- */
-int of_property_read_u8_array(const struct device_node *np,
-			const char *propname, u8 *out_values, size_t sz)
-{
-	const u8 *val = of_find_property_value_of_size(np, propname,
-						(sz * sizeof(*out_values)));
-
-	if (IS_ERR(val))
-		return PTR_ERR(val);
-
-	while (sz--)
-		*out_values++ = *val++;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_property_read_u8_array);
-#endif /* CONFIG_OF */
-
-#ifdef CONFIG_PCI_IOV
-/**
- * pci_sriov_set_totalvfs -- reduce the TotalVFs available
- * @dev: the PCI PF device
- * @numvfs: number that should be used for TotalVFs supported
- *
- * Should be called from PF driver's probe routine with
- * device's mutex held.
- *
- * Returns 0 if PF is an SRIOV-capable device and
- * value of numvfs valid. If not a PF return -ENOSYS;
- * if numvfs is invalid return -EINVAL;
- * if VFs already enabled, return -EBUSY.
- */
-int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
-{
-	if (!dev->is_physfn)
-		return -ENOSYS;
-	if (numvfs > dev->sriov->total_VFs)
-		return -EINVAL;
-
-	/* Shouldn't change if VFs already enabled */
-	if (dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
-		return -EBUSY;
-	else
-		dev->sriov->driver_max_VFs = numvfs;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
-#endif /* CONFIG_PCI_IOV */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
deleted file mode 100644
index 6975a788..00000000
--- a/backport/compat/compat-3.9.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport functionality introduced in Linux 3.9.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/netdevice.h>
-#include <linux/if.h>
-#include <linux/if_ether.h>
-#include <linux/etherdevice.h>
-#include <linux/scatterlist.h>
-#include <linux/highmem.h>
-#include <net/inet_frag.h>
-#include <net/sock.h>
-
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
-{
-	void __iomem *dest_ptr;
-
-	dest_ptr = devm_ioremap_resource(dev, res);
-	if (!dest_ptr)
-		return (void __iomem *)ERR_PTR(-ENOMEM);
-	return dest_ptr;
-}
-EXPORT_SYMBOL_GPL(devm_ioremap_resource);
-
-/**
- * eth_prepare_mac_addr_change - prepare for mac change
- * @dev: network device
- * @p: socket address
- */
-int eth_prepare_mac_addr_change(struct net_device *dev, void *p)
-{
-	struct sockaddr *addr = p;
-
-	if (!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev))
-		return -EBUSY;
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_prepare_mac_addr_change);
-
-/**
- * eth_commit_mac_addr_change - commit mac change
- * @dev: network device
- * @p: socket address
- */
-void eth_commit_mac_addr_change(struct net_device *dev, void *p)
-{
-	struct sockaddr *addr = p;
-
-	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-}
-EXPORT_SYMBOL_GPL(eth_commit_mac_addr_change);
-
-void __sg_page_iter_start(struct sg_page_iter *piter,
-			  struct scatterlist *sglist, unsigned int nents,
-			  unsigned long pgoffset)
-{
-	piter->__pg_advance = 0;
-	piter->__nents = nents;
-
-	piter->page = NULL;
-	piter->sg = sglist;
-	piter->sg_pgoffset = pgoffset;
-}
-EXPORT_SYMBOL_GPL(__sg_page_iter_start);
-
-static int sg_page_count(struct scatterlist *sg)
-{
-	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
-}
-
-bool __sg_page_iter_next(struct sg_page_iter *piter)
-{
-	if (!piter->__nents || !piter->sg)
-		return false;
-
-	piter->sg_pgoffset += piter->__pg_advance;
-	piter->__pg_advance = 1;
-
-	while (piter->sg_pgoffset >= sg_page_count(piter->sg)) {
-		piter->sg_pgoffset -= sg_page_count(piter->sg);
-		piter->sg = sg_next(piter->sg);
-		if (!--piter->__nents || !piter->sg)
-			return false;
-	}
-	piter->page = nth_page(sg_page(piter->sg), piter->sg_pgoffset);
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(__sg_page_iter_next);
-
-static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
-{
-	if (!miter->__remaining) {
-		struct scatterlist *sg;
-		unsigned long pgoffset;
-
-		if (!__sg_page_iter_next(&miter->piter))
-			return false;
-
-		sg = miter->piter.sg;
-		pgoffset = miter->piter.sg_pgoffset;
-
-		miter->__offset = pgoffset ? 0 : sg->offset;
-		miter->__remaining = sg->offset + sg->length -
-				(pgoffset << PAGE_SHIFT) - miter->__offset;
-		miter->__remaining = min_t(unsigned long, miter->__remaining,
-					   PAGE_SIZE - miter->__offset);
-	}
-
-	return true;
-}
-
-/**
- * sg_miter_start - start mapping iteration over a sg list
- * @miter: sg mapping iter to be started
- * @sgl: sg list to iterate over
- * @nents: number of sg entries
- *
- * Description:
- *   Starts mapping iterator @miter.
- *
- * Context:
- *   Don't care.
- */
-void backport_sg_miter_start(struct sg_mapping_iter *miter, struct scatterlist *sgl,
-		    unsigned int nents, unsigned int flags)
-{
-	memset(miter, 0, sizeof(struct sg_mapping_iter));
-
-	__sg_page_iter_start(&miter->piter, sgl, nents, 0);
-	WARN_ON(!(flags & (SG_MITER_TO_SG | SG_MITER_FROM_SG)));
-	miter->__flags = flags;
-}
-EXPORT_SYMBOL_GPL(backport_sg_miter_start);
-
-/**
- * sg_miter_next - proceed mapping iterator to the next mapping
- * @miter: sg mapping iter to proceed
- *
- * Description:
- *   Proceeds @miter to the next mapping.  @miter should have been started
- *   using sg_miter_start().  On successful return, @miter->page,
- *   @miter->addr and @miter->length point to the current mapping.
- *
- * Context:
- *   Preemption disabled if SG_MITER_ATOMIC.  Preemption must stay disabled
- *   till @miter is stopped.  May sleep if !SG_MITER_ATOMIC.
- *
- * Returns:
- *   true if @miter contains the next mapping.  false if end of sg
- *   list is reached.
- */
-bool backport_sg_miter_next(struct sg_mapping_iter *miter)
-{
-	sg_miter_stop(miter);
-
-	/*
-	 * Get to the next page if necessary.
-	 * __remaining, __offset is adjusted by sg_miter_stop
-	 */
-	if (!sg_miter_get_next_page(miter))
-		return false;
-
-	miter->page = sg_page_iter_page(&miter->piter);
-	miter->consumed = miter->length = miter->__remaining;
-
-	if (miter->__flags & SG_MITER_ATOMIC)
-		miter->addr = kmap_atomic(miter->page) + miter->__offset;
-	else
-		miter->addr = kmap(miter->page) + miter->__offset;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(backport_sg_miter_next);
-
-/**
- * sg_miter_stop - stop mapping iteration
- * @miter: sg mapping iter to be stopped
- *
- * Description:
- *   Stops mapping iterator @miter.  @miter should have been started
- *   using sg_miter_start().  A stopped iteration can be resumed by
- *   calling sg_miter_next() on it.  This is useful when resources (kmap)
- *   need to be released during iteration.
- *
- * Context:
- *   Preemption disabled if the SG_MITER_ATOMIC is set.  Don't care
- *   otherwise.
- */
-void backport_sg_miter_stop(struct sg_mapping_iter *miter)
-{
-	WARN_ON(miter->consumed > miter->length);
-
-	/* drop resources from the last iteration */
-	if (miter->addr) {
-		miter->__offset += miter->consumed;
-		miter->__remaining -= miter->consumed;
-
-		if ((miter->__flags & SG_MITER_TO_SG) &&
-		    !PageSlab(miter->page))
-			flush_kernel_dcache_page(miter->page);
-
-		if (miter->__flags & SG_MITER_ATOMIC) {
-			WARN_ON_ONCE(preemptible());
-			kunmap_atomic(miter->addr);
-		} else
-			kunmap(miter->page);
-
-		miter->page = NULL;
-		miter->addr = NULL;
-		miter->length = 0;
-		miter->consumed = 0;
-	}
-}
-EXPORT_SYMBOL_GPL(backport_sg_miter_stop);
diff --git a/backport/compat/user_namespace.c b/backport/compat/user_namespace.c
deleted file mode 100644
index 6d014040..00000000
--- a/backport/compat/user_namespace.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Copyright 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux user_namespace.c
- */
-
-#include <linux/module.h>
-#include <linux/highuid.h>
-#include <linux/uidgid.h>
-#include <linux/user_namespace.h>
-
-#ifdef CONFIG_USER_NS
-
-kuid_t make_kuid(struct user_namespace *ns, uid_t uid)
-{
-	/* Map the uid to a global kernel uid */
-	return KUIDT_INIT(uid);
-}
-EXPORT_SYMBOL_GPL(make_kuid);
-
-uid_t from_kuid(struct user_namespace *targ, kuid_t kuid)
-{
-	/* Map the uid from a global kernel uid */
-	return __kuid_val(kuid);
-}
-EXPORT_SYMBOL_GPL(from_kuid);
-
-uid_t from_kuid_munged(struct user_namespace *targ, kuid_t kuid)
-{
-	uid_t uid;
-	uid = from_kuid(targ, kuid);
-
-	if (uid == (uid_t) -1)
-		uid = overflowuid;
-	return uid;
-}
-EXPORT_SYMBOL_GPL(from_kuid_munged);
-
-kgid_t make_kgid(struct user_namespace *ns, gid_t gid)
-{
-	/* Map the gid to a global kernel gid */
-	return KGIDT_INIT(gid);
-}
-EXPORT_SYMBOL_GPL(make_kgid);
-
-gid_t from_kgid(struct user_namespace *targ, kgid_t kgid)
-{
-	/* Map the gid from a global kernel gid */
-	return __kgid_val(kgid);
-}
-EXPORT_SYMBOL_GPL(from_kgid);
-
-gid_t from_kgid_munged(struct user_namespace *targ, kgid_t kgid)
-{
-	gid_t gid;
-	gid = from_kgid(targ, kgid);
-
-	if (gid == (gid_t) -1)
-		gid = overflowgid;
-	return gid;
-}
-EXPORT_SYMBOL_GPL(from_kgid_munged);
-
-#endif /* CONFIG_USER_NS */
-- 
2.30.2


--
To unsubscribe from this list: send the line "unsubscribe backports" in
