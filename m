Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F61C2E
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009033; cv=none; b=inC7ztBn1OHkl3NRD9L6LU6YIbC46dniWFDG2ak+mK91yGIOSBbBEpUoAschA2DOKW+6jv5JgZBdi5tAllYWh2e43JB9oZkZbINGl+FT9GyHMj4Lj7C7VudPi9UxB8lI4hflagUDOUu4IAndl+GaG+gN+FsAJVfV5452tnXihDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009033; c=relaxed/simple;
	bh=5DvN3CGEb8nE1zg0If7Crp7MPWWll9V8+kMV7qZKsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko80sdtrkJNlmUi8uYCvuO+qlX3ZFt5+WwdOBLSyVF+HOFrHFhz3btNloeHhkqExJ0QKKXsI4eL14wG7e8aPaE0qAmj2VJa8DcNSZzZM5OUP2e45K6vi0csM52VYIQzooUFPxyZ8S4nwgGOi+lIh5D9HRKZjVxc4BaFc3OD3ZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=FfBJy6nN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FfBJy6nN"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V7lQW1VKxz9sQb;
	Tue,  2 Apr 2024 00:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tSA7s4WmVjheRJtl62azfO4W9iTaCqlXxSKAows3/c=;
	b=FfBJy6nNp15S4jdZX9u36mn+kJPsWFTmNOBpmBHog0KLeQwQi9OINiTRqWZ+KggPkWnFbT
	b8Mxhy3VkCP3dKoog01QbqEVq3qSN9KYT6NiNNVgReSRqSQsxvepnbaXpLem+KhM+p4BHq
	Pivybo3gyRDBKL4+cs5TLoRj2YFT11R6U0om6QJmqNrCVUxYs5Fy2zIlyN0XsbyM8FIRGs
	xKhBIOS7z22OCqMlBJ6Cwjm0oXraSQyR6fpNTagz+Kcxptt4K5UdTrX1q2EI6W46V125lY
	PLnTKOWB01hc5o2JMe8P/9HDtnWD1tqrqR99QCYSxLCJ6k7tbtRToo0e7OOmYA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] backports: Remove support for kernel smaller than 4.5
Date: Tue,  2 Apr 2024 00:03:05 +0200
Message-ID: <20240401220314.2434455-2-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQW1VKxz9sQb

This removes all the code which is needed to support kernel 4.4.
---
 .github/workflows/create.yml                |   1 -
 README                                      |   2 +-
 backport/backport-include/linux/bits.h      |   3 +-
 backport/backport-include/linux/fs.h        |   5 -
 backport/backport-include/linux/io.h        |   5 -
 backport/backport-include/linux/kernel.h    |  28 ----
 backport/backport-include/linux/leds.h      |  29 ----
 backport/backport-include/linux/netdevice.h |  22 ---
 backport/backport-include/linux/nospec.h    |   3 +-
 backport/backport-include/linux/page_ref.h  |   2 -
 backport/backport-include/linux/pci.h       |   3 +-
 backport/backport-include/linux/phy.h       |  65 --------
 backport/backport-include/linux/skbuff.h    |   3 +-
 backport/backport-include/linux/string.h    |   5 -
 backport/backport-include/net/genetlink.h   |   6 -
 backport/backport-include/net/ipv6.h        |  25 ---
 backport/backport-include/net/iw_handler.h  |  11 --
 backport/backport-include/net/sock.h        |  17 --
 backport/compat/Makefile                    |   1 -
 backport/compat/backport-4.5.c              | 165 --------------------
 patches/0002-gpio-parent.cocci              |  25 ---
 patches/0067-mdio-addr.cocci                |   5 -
 22 files changed, 5 insertions(+), 426 deletions(-)
 delete mode 100644 backport/backport-include/linux/leds.h
 delete mode 100644 backport/backport-include/linux/phy.h
 delete mode 100644 backport/backport-include/net/ipv6.h
 delete mode 100644 backport/backport-include/net/iw_handler.h
 delete mode 100644 backport/compat/backport-4.5.c
 delete mode 100644 patches/0002-gpio-parent.cocci
 delete mode 100644 patches/0067-mdio-addr.cocci

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 3fa4628b..2c937b5c 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.4",
            "4.5",
            "4.6",
            "4.7",
diff --git a/README b/README
index f9cf7248..92512d5c 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.4 and above.
+for kernels 4.5 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/bits.h b/backport/backport-include/linux/bits.h
index db792196..7c66169f 100644
--- a/backport/backport-include/linux/bits.h
+++ b/backport/backport-include/linux/bits.h
@@ -4,8 +4,7 @@
 
 #if LINUX_VERSION_IS_GEQ(4,19,0) || \
     LINUX_VERSION_IN_RANGE(4,14,119, 4,15,0) || \
-    LINUX_VERSION_IN_RANGE(4,9,176, 4,10,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,180, 4,5,0)
+    LINUX_VERSION_IN_RANGE(4,9,176, 4,10,0)
 #include_next <linux/bits.h>
 #else
 #include <linux/bitops.h>
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 005c3564..98116793 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -4,11 +4,6 @@
 #include <linux/version.h>
 
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define no_seek_end_llseek LINUX_BACKPORT(no_seek_end_llseek)
-extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
-#endif /* < 4.5 */
-
 #if LINUX_VERSION_IS_LESS(5,5,0)
 #ifdef CONFIG_COMPAT
 #define compat_ptr_ioctl LINUX_BACKPORT(compat_ptr_ioctl)
diff --git a/backport/backport-include/linux/io.h b/backport/backport-include/linux/io.h
index e04305c3..72586527 100644
--- a/backport/backport-include/linux/io.h
+++ b/backport/backport-include/linux/io.h
@@ -6,11 +6,6 @@
 #define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define __ioread32_copy LINUX_BACKPORT(__ioread32_copy)
-void __ioread32_copy(void *to, const void __iomem *from, size_t count);
-#endif
-
 #ifndef writel_relaxed
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 36bb755e..23a451b9 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -13,32 +13,4 @@ int __must_check kstrtobool(const char *s, bool *res);
 int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-
-#undef abs
-/**
- * abs - return absolute value of an argument
- * @x: the value.  If it is unsigned type, it is converted to signed type first.
- *     char is treated as if it was signed (regardless of whether it really is)
- *     but the macro's return type is preserved as char.
- *
- * Return: an absolute value of x.
- */
-#define abs(x)	__abs_choose_expr(x, long long,				\
-		__abs_choose_expr(x, long,				\
-		__abs_choose_expr(x, int,				\
-		__abs_choose_expr(x, short,				\
-		__abs_choose_expr(x, char,				\
-		__builtin_choose_expr(					\
-			__builtin_types_compatible_p(typeof(x), char),	\
-			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
-			((void)0)))))))
-
-#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
-	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
-	__builtin_types_compatible_p(typeof(x), unsigned type),		\
-	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
-
-#endif
-
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
deleted file mode 100644
index dbafd413..00000000
--- a/backport/backport-include/linux/leds.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_LINUX_LEDS_H
-#define __BACKPORT_LINUX_LEDS_H
-#include_next <linux/leds.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define led_set_brightness_sync LINUX_BACKPORT(led_set_brightness_sync)
-/**
- * led_set_brightness_sync - set LED brightness synchronously
- * @led_cdev: the LED to set
- * @brightness: the brightness to set it to
- *
- * Set an LED's brightness immediately. This function will block
- * the caller for the time required for accessing device registers,
- * and it can sleep.
- *
- * Returns: 0 on success or negative error value on failure
- */
-extern int led_set_brightness_sync(struct led_classdev *led_cdev,
-				   enum led_brightness value);
-#endif /* < 4.5 */
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define devm_led_trigger_register LINUX_BACKPORT(devm_led_trigger_register)
-extern int devm_led_trigger_register(struct device *dev,
-				     struct led_trigger *trigger);
-#endif /* < 4.5 */
-
-#endif /* __BACKPORT_LINUX_LEDS_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index e1773190..f6d53f8a 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -23,28 +23,6 @@ static inline bool backport_napi_complete(struct napi_struct *n)
 #define napi_complete LINUX_BACKPORT(napi_complete)
 #endif /* < 4.10 */
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
-/**
- *	netif_tx_napi_add - initialize a napi context
- *	@dev:  network device
- *	@napi: napi context
- *	@poll: polling function
- *	@weight: default weight
- *
- * This variant of netif_napi_add() should be used from drivers using NAPI
- * to exclusively poll a TX queue.
- * This will avoid we add it into napi_hash[], thus polluting this hash table.
- */
-static inline void netif_tx_napi_add(struct net_device *dev,
-				     struct napi_struct *napi,
-				     int (*poll)(struct napi_struct *, int),
-				     int weight)
-{
-	netif_napi_add(dev, napi, poll, weight);
-}
-#endif /* < 4.5 */
-
 #ifndef NETIF_F_CSUM_MASK
 #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
 #endif
diff --git a/backport/backport-include/linux/nospec.h b/backport/backport-include/linux/nospec.h
index 07647241..d4de80a4 100644
--- a/backport/backport-include/linux/nospec.h
+++ b/backport/backport-include/linux/nospec.h
@@ -3,8 +3,7 @@
 
 #if LINUX_VERSION_IS_GEQ(4,15,2) || \
     LINUX_VERSION_IN_RANGE(4,14,18, 4,15,0) || \
-    LINUX_VERSION_IN_RANGE(4,9,81, 4,10,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,118, 4,5,0)
+    LINUX_VERSION_IN_RANGE(4,9,81, 4,10,0)
 #include_next <linux/nospec.h>
 #else
 #define array_index_nospec(index, size)	(index)
diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
index 12fd86c9..e45734ec 100644
--- a/backport/backport-include/linux/page_ref.h
+++ b/backport/backport-include/linux/page_ref.h
@@ -9,12 +9,10 @@ static inline void page_ref_inc(struct page *page)
 	atomic_inc(&page->_count);
 }
 
-#if !LINUX_VERSION_IN_RANGE(4,4,216, 4,5,0)
 static inline int page_ref_count(struct page *page)
 {
 	return atomic_read(&page->_count);
 }
-#endif /* 4.4.216 <= x < 4.5 */
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index caf15db3..75eb2359 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -30,7 +30,6 @@ static inline void pci_free_irq_vectors(struct pci_dev *dev)
 
 
 #if LINUX_VERSION_IS_LESS(4,9,0) &&			\
-	!LINUX_VERSION_IN_RANGE(4,4,37, 4,5,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
 
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
@@ -47,7 +46,7 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
-#endif/* <4.9.0 but not >= 4.4.37, 4.8.13 */
+#endif/* <4.9.0 but not >= 4.8.13 */
 
 #ifndef PCI_IRQ_LEGACY
 #define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
deleted file mode 100644
index 4d6f37e8..00000000
--- a/backport/backport-include/linux/phy.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#ifndef __BACKPORT_LINUX_PHY_H
-#define __BACKPORT_LINUX_PHY_H
-#include_next <linux/phy.h>
-#include <linux/compiler.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define phydev_name LINUX_BACKPORT(phydev_name)
-static inline const char *phydev_name(const struct phy_device *phydev)
-{
-	return dev_name(&phydev->dev);
-}
-
-#define mdiobus_is_registered_device LINUX_BACKPORT(mdiobus_is_registered_device)
-static inline bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
-{
-	return bus->phy_map[addr];
-}
-
-#define phy_attached_print LINUX_BACKPORT(phy_attached_print)
-void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
-	__printf(2, 3);
-#define phy_attached_info LINUX_BACKPORT(phy_attached_info)
-void phy_attached_info(struct phy_device *phydev);
-
-static inline int backport_mdiobus_register(struct mii_bus *bus)
-{
-	bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
-	if (!bus->irq) {
-		pr_err("mii_bus irq allocation failed\n");
-		return -ENOMEM;
-	}
-
-	memset(bus->irq, PHY_POLL, sizeof(int) * PHY_MAX_ADDR);
-
-	return __mdiobus_register(bus, THIS_MODULE);
-}
-#ifdef mdiobus_register
-#undef mdiobus_register
-#endif
-#define mdiobus_register LINUX_BACKPORT(mdiobus_register)
-
-static inline void backport_mdiobus_unregister(struct mii_bus *bus)
-{
-	kfree(bus->irq);
-	mdiobus_unregister(bus);
-}
-#define mdiobus_unregister LINUX_BACKPORT(mdiobus_unregister)
-#endif /* < 4.5 */
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define phydev_get_addr LINUX_BACKPORT(phydev_get_addr)
-static inline int phydev_get_addr(struct phy_device *phydev)
-{
-	return phydev->addr;
-}
-#else
-#define phydev_get_addr LINUX_BACKPORT(phydev_get_addr)
-static inline int phydev_get_addr(struct phy_device *phydev)
-{
-	return phydev->mdio.addr;
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_PHY_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index fffe2345..b8a16ed3 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -108,8 +108,7 @@ static inline void nf_reset_ct(struct sk_buff *skb)
 	!LINUX_VERSION_IN_RANGE(5,4,69, 5,5,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,19,149, 4,20,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,14,200, 4,15,0) &&	\
-	!LINUX_VERSION_IN_RANGE(4,9,238, 4,10,0) &&	\
-	!LINUX_VERSION_IN_RANGE(4,4,238, 4,5,0)
+	!LINUX_VERSION_IN_RANGE(4,9,238, 4,10,0)
 /**
  *	skb_queue_len_lockless	- get queue length
  *	@list_: list to measure
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 39257e5f..bbb076e0 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -3,11 +3,6 @@
 #include_next <linux/string.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define memdup_user_nul LINUX_BACKPORT(memdup_user_nul)
-extern void *memdup_user_nul(const void __user *, size_t);
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,6,0)
 int match_string(const char * const *array, size_t n, const char *string);
 #endif /* LINUX_VERSION_IS_LESS(4,5,0) */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 3b75b47d..3ad8ebe8 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -91,10 +91,7 @@ struct backport_genl_ops {
 	void			*__dummy_was_policy_must_be_null;
 	int		       (*doit)(struct sk_buff *skb,
 				       struct genl_info *info);
-#if LINUX_VERSION_IS_GEQ(4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0)
 	int		       (*start)(struct netlink_callback *cb);
-#endif
 	int		       (*dumpit)(struct sk_buff *skb,
 					 struct netlink_callback *cb);
 	int		       (*done)(struct netlink_callback *cb);
@@ -111,10 +108,7 @@ __real_backport_genl_register_family(struct genl_family *family)
 	BUILD_BUG_ON(offsetof(struct genl_ops, f) != \
 		     offsetof(struct backport_genl_ops, f))
 	OPS_VALIDATE(doit);
-#if LINUX_VERSION_IS_GEQ(4,5,0) || \
-    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0)
 	OPS_VALIDATE(start);
-#endif
 	OPS_VALIDATE(dumpit);
 	OPS_VALIDATE(done);
 	OPS_VALIDATE(cmd);
diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
deleted file mode 100644
index 2532710c..00000000
--- a/backport/backport-include/net/ipv6.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __BACKPORT_NET_IPV6_H
-#define __BACKPORT_NET_IPV6_H
-#include_next <net/ipv6.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define ipv6_addr_prefix_copy LINUX_BACKPORT(ipv6_addr_prefix_copy)
-static inline void ipv6_addr_prefix_copy(struct in6_addr *addr,
-					 const struct in6_addr *pfx,
-					 int plen)
-{
-	/* caller must guarantee 0 <= plen <= 128 */
-	int o = plen >> 3,
-	    b = plen & 0x7;
-
-	memcpy(addr->s6_addr, pfx, o);
-	if (b != 0) {
-		addr->s6_addr[o] &= ~(0xff00 >> b);
-		addr->s6_addr[o] |= (pfx->s6_addr[o] & (0xff00 >> b));
-	}
-}
-#endif
-
-#endif /* __BACKPORT_NET_IPV6_H */
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
deleted file mode 100644
index 7deca730..00000000
--- a/backport/backport-include/net/iw_handler.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_IW_HANDLER_H
-#define __BACKPORT_IW_HANDLER_H
-#include_next <net/iw_handler.h>
-
-
-/* this was added in v3.2.79, v3.18.30, v4.1.21, v4.4.6 and 4.5 */
-#if !LINUX_VERSION_IS_GEQ(4,4,6)
-#define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
-static inline void wireless_nlevent_flush(void) {}
-#endif
-#endif /* __BACKPORT_IW_HANDLER_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 80e0f117..2a872b64 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -3,23 +3,6 @@
 #include_next <net/sock.h>
 #include <linux/version.h>
 
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define sk_set_bit LINUX_BACKPORT(sk_set_bit)
-static inline void sk_set_bit(int nr, struct sock *sk)
-{
-	set_bit(nr, &sk->sk_socket->flags);
-}
-#endif /* < 4.5 */
-
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define sk_clear_bit LINUX_BACKPORT(sk_clear_bit)
-static inline void sk_clear_bit(int nr, struct sock *sk)
-{
-	clear_bit(nr, &sk->sk_socket->flags);
-}
-#endif /* < 4.5 */
-
 #if LINUX_VERSION_IS_LESS(4,16,0)
 #define sk_pacing_shift_update LINUX_BACKPORT(sk_pacing_shift_update)
 static inline void sk_pacing_shift_update(struct sock *sk, int val)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index a1be9e83..dfd72d2d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
deleted file mode 100644
index 4b673845..00000000
--- a/backport/compat/backport-4.5.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright(c) 2015 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.5.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/device.h>
-#include <linux/export.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/leds.h>
-#include <linux/phy.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <asm/uaccess.h>
-#include <linux/io.h>
-
-int led_set_brightness_sync(struct led_classdev *led_cdev,
-			    enum led_brightness value)
-{
-	if (led_cdev->blink_delay_on || led_cdev->blink_delay_off)
-		return -EBUSY;
-
-	led_cdev->brightness = min(value, led_cdev->max_brightness);
-
-	if (led_cdev->flags & LED_SUSPENDED)
-		return 0;
-
-	if (led_cdev->brightness_set_sync)
-		return led_cdev->brightness_set_sync(led_cdev,
-							 led_cdev->brightness);
-	return -ENOTSUPP;
-}
-EXPORT_SYMBOL_GPL(led_set_brightness_sync);
-
-/**
- * no_seek_end_llseek - llseek implementation for fixed-sized devices
- * @file:	file structure to seek on
- * @offset:	file offset to seek to
- * @whence:	type of seek
- *
- */
-loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
-{
-	switch (whence) {
-	case SEEK_SET: case SEEK_CUR:
-		return generic_file_llseek_size(file, offset, whence,
-						~0ULL, 0);
-	default:
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL_GPL(no_seek_end_llseek);
-
-/**
- * memdup_user_nul - duplicate memory region from user space and NUL-terminate
- *
- * @src: source address in user space
- * @len: number of bytes to copy
- *
- * Returns an ERR_PTR() on failure.
- */
-void *memdup_user_nul(const void __user *src, size_t len)
-{
-	char *p;
-
-	/*
-	 * Always use GFP_KERNEL, since copy_from_user() can sleep and
-	 * cause pagefault, which makes it pointless to use GFP_NOFS
-	 * or GFP_ATOMIC.
-	 */
-	p = kmalloc(len + 1, GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(p, src, len)) {
-		kfree(p);
-		return ERR_PTR(-EFAULT);
-	}
-	p[len] = '\0';
-
-	return p;
-}
-EXPORT_SYMBOL_GPL(memdup_user_nul);
-
-void phy_attached_info(struct phy_device *phydev)
-{
-	phy_attached_print(phydev, NULL);
-}
-EXPORT_SYMBOL_GPL(phy_attached_info);
-
-#define ATTACHED_FMT "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)"
-void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
-{
-	if (!fmt) {
-		dev_info(&phydev->dev, ATTACHED_FMT "\n",
-			 phydev->drv->name, phydev_name(phydev),
-			 phydev->irq);
-	} else {
-		va_list ap;
-
-		dev_info(&phydev->dev, ATTACHED_FMT,
-			 phydev->drv->name, phydev_name(phydev),
-			 phydev->irq);
-
-		va_start(ap, fmt);
-		vprintk(fmt, ap);
-		va_end(ap);
-	}
-}
-EXPORT_SYMBOL_GPL(phy_attached_print);
-
-static void devm_led_trigger_release(struct device *dev, void *res)
-{
-	led_trigger_unregister(*(struct led_trigger **)res);
-}
-
-int devm_led_trigger_register(struct device *dev,
-			      struct led_trigger *trig)
-{
-	struct led_trigger **dr;
-	int rc;
-
-	dr = devres_alloc(devm_led_trigger_release, sizeof(*dr),
-			  GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	*dr = trig;
-
-	rc = led_trigger_register(trig);
-	if (rc)
-		devres_free(dr);
-	else
-		devres_add(dev, dr);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(devm_led_trigger_register);
-
-/**
- * __ioread32_copy - copy data from MMIO space, in 32-bit units
- * @to: destination (must be 32-bit aligned)
- * @from: source, in MMIO space (must be 32-bit aligned)
- * @count: number of 32-bit quantities to copy
- *
- * Copy data from MMIO space to kernel space, in units of 32 bits at a
- * time.  Order of access is not guaranteed, nor is a memory barrier
- * performed afterwards.
- */
-void __ioread32_copy(void *to, const void __iomem *from, size_t count)
-{
-	u32 *dst = to;
-	const u32 __iomem *src = from;
-	const u32 __iomem *end = src + count;
-
-	while (src < end)
-		*dst++ = __raw_readl(src++);
-}
-EXPORT_SYMBOL_GPL(__ioread32_copy);
diff --git a/patches/0002-gpio-parent.cocci b/patches/0002-gpio-parent.cocci
deleted file mode 100644
index fd953447..00000000
--- a/patches/0002-gpio-parent.cocci
+++ /dev/null
@@ -1,25 +0,0 @@
-/* convert gpio: change member .dev to .parent
- *
- * add semantic patch which uses the dev member of struct gpio_chip on
- * kenrel version < 4.5 This change was done in upstream kernel commit
- * 58383c78 "gpio: change member .dev to .parent".
- */
-
-@r1@
-struct gpio_chip *chip;
-expression E1;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,5,0)
- chip->parent = E1;
-+#else
-+chip->dev = E1;
-+#endif /* LINUX_VERSION_IS_GEQ(4,5,0) */
-@r2@
-struct gpio_chip chip;
-expression E2;
-@@
-+#if LINUX_VERSION_IS_GEQ(4,5,0)
- chip.parent = E2;
-+#else
-+chip.dev = E2;
-+#endif /* LINUX_VERSION_IS_GEQ(4,5,0) */
diff --git a/patches/0067-mdio-addr.cocci b/patches/0067-mdio-addr.cocci
deleted file mode 100644
index 1346585c..00000000
--- a/patches/0067-mdio-addr.cocci
+++ /dev/null
@@ -1,5 +0,0 @@
-@ r1 @
-struct phy_device *phydev;
-@@
--phydev->mdio.addr
-+phydev_get_addr(phydev)
-- 
2.44.0

