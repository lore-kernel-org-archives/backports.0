Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44275 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXzx (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:53 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 34/42] backports: dissolve compat-2.6.26.h
Date: Sun, 14 Apr 2013 01:53:54 +0200
Message-Id: <1365897243-31214-35-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015644_342765_79AF4BFF)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm/unaligned.h       | 213 +++++++++++
 backport/backport-include/linux/compat-2.6.26.h | 456 ------------------------
 backport/backport-include/linux/device.h        |  14 +
 backport/backport-include/linux/input.h         |   4 +
 backport/backport-include/linux/jiffies.h       |  21 ++
 backport/backport-include/linux/kernel.h        |  35 ++
 backport/backport-include/linux/list.h          |   7 +
 backport/backport-include/linux/math64.h        |  31 ++
 backport/backport-include/linux/netdevice.h     |  17 +
 backport/backport-include/linux/pci-aspm.h      |  10 +
 backport/backport-include/net/net_namespace.h   |  35 ++
 11 files changed, 387 insertions(+), 456 deletions(-)
 create mode 100644 backport/backport-include/asm/unaligned.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.26.h
 create mode 100644 backport/backport-include/linux/jiffies.h

diff --git a/backport/backport-include/asm/unaligned.h b/backport/backport-include/asm/unaligned.h
new file mode 100644
index 0000000..7f552b8
--- /dev/null
+++ b/backport/backport-include/asm/unaligned.h
@@ -0,0 +1,213 @@
+#ifndef __BACKPORT_ASM_UNALIGNED_H
+#define __BACKPORT_ASM_UNALIGNED_H
+#include_next <asm/unaligned.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+/*
+ * 2.6.26 added its own unaligned API which the
+ * new drivers can use. Lets port it here by including it in older
+ * kernels and also deal with the architecture handling here.
+ */
+#ifdef CONFIG_ALPHA
+
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* alpha */
+#ifdef CONFIG_ARM
+
+/* arm */
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* arm */
+#ifdef CONFIG_AVR32
+
+/*
+ * AVR32 can handle some unaligned accesses, depending on the
+ * implementation.  The AVR32 AP implementation can handle unaligned
+ * words, but halfwords must be halfword-aligned, and doublewords must
+ * be word-aligned.
+ *
+ * However, swapped word loads must be word-aligned so we can't
+ * optimize word loads in general.
+ */
+
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif
+#ifdef CONFIG_BLACKFIN
+
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* blackfin */
+#ifdef CONFIG_CRIS
+
+/*
+ * CRIS can do unaligned accesses itself.
+ */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* cris */
+#ifdef CONFIG_FRV
+
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* frv */
+#ifdef CONFIG_H8300
+
+#include <linux/unaligned/be_memmove.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* h8300 */
+#ifdef  CONFIG_IA64
+
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* ia64 */
+#ifdef CONFIG_M32R
+
+#if defined(__LITTLE_ENDIAN__)
+# include <linux/unaligned/le_memmove.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+#else
+# include <linux/unaligned/be_memmove.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+#endif
+
+#endif /* m32r */
+#ifdef CONFIG_M68K /* this handles both m68k and m68knommu */
+
+#ifdef CONFIG_COLDFIRE
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+#else
+
+/*
+ * The m68k can do unaligned accesses itself.
+ */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+#endif
+
+#endif /* m68k and m68knommu */
+#ifdef CONFIG_MIPS
+
+#if defined(__MIPSEB__)
+# include <linux/unaligned/be_struct.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned  __get_unaligned_be
+# define put_unaligned  __put_unaligned_be
+#elif defined(__MIPSEL__)
+# include <linux/unaligned/le_struct.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+#endif
+
+#endif /* mips */
+#ifdef CONFIG_MN10300
+
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* mn10300 */
+#ifdef CONFIG_PARISC
+
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* parisc */
+#ifdef CONFIG_PPC
+/*
+ * The PowerPC can do unaligned accesses itself in big endian mode.
+ */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* ppc */
+#ifdef CONFIG_S390
+
+/*
+ * The S390 can do unaligned accesses itself.
+ */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* s390 */
+#ifdef CONFIG_SUPERH
+
+/* SH can't handle unaligned accesses. */
+#ifdef __LITTLE_ENDIAN__
+# include <linux/unaligned/le_struct.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+#else
+# include <linux/unaligned/be_struct.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+#endif
+
+#endif /* sh - SUPERH */
+#ifdef CONFIG_SPARC
+
+/* sparc and sparc64 */
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif  /* sparc */
+#ifdef CONFIG_UML
+
+#include "asm/arch/unaligned.h"
+
+#endif /* um - uml */
+#ifdef CONFIG_V850
+
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* v850 */
+#ifdef CONFIG_X86
+/*
+ * The x86 can do unaligned accesses itself.
+ */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#endif /* x86 */
+#ifdef CONFIG_XTENSA
+
+#ifdef __XTENSA_EL__
+# include <linux/unaligned/le_memmove.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+#elif defined(__XTENSA_EB__)
+# include <linux/unaligned/be_memmove.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+#else
+# error processor byte order undefined!
+#endif
+
+#endif /* xtensa */
+#endif /* < 2.6.26 */
+
+#endif /* __BACKPORT_ASM_UNALIGNED_H */
diff --git a/backport/backport-include/linux/compat-2.6.26.h b/backport/backport-include/linux/compat-2.6.26.h
deleted file mode 100644
index b8d9dc6..0000000
--- a/backport/backport-include/linux/compat-2.6.26.h
+++ /dev/null
@@ -1,456 +0,0 @@
-#ifndef LINUX_26_26_COMPAT_H
-#define LINUX_26_26_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26))
-
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <net/sock.h>
-#include <linux/fs.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-#include <net/net_namespace.h>
-#endif
-#include <linux/fs.h>
-#include <linux/types.h>
-#include <asm/div64.h>
-
-/* These jiffie helpers added as of 2.6.26 */
-
-/*
- * These four macros compare jiffies and 'a' for convenience.
- */
-
-/* time_is_before_jiffies(a) return true if a is before jiffies */
-#define time_is_before_jiffies(a) time_after(jiffies, a)
-
-/* time_is_after_jiffies(a) return true if a is after jiffies */
-#define time_is_after_jiffies(a) time_before(jiffies, a)
-
-/* time_is_before_eq_jiffies(a) return true if a is before or equal to jiffies*/
-#define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
-
-/* time_is_after_eq_jiffies(a) return true if a is after or equal to jiffies*/
-#define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
-
-/* This comes from include/linux/input.h */
-#define SW_RFKILL_ALL           0x03  /* rfkill master switch, type "any"
-					 set = radio enabled */
-
-/* From kernel.h */
-#define USHORT_MAX      ((u16)(~0U))
-#define SHORT_MAX       ((s16)(USHORT_MAX>>1))
-#define SHORT_MIN       (-SHORT_MAX - 1)
-
-#define dev_set_name LINUX_BACKPORT(dev_set_name)
-extern int dev_set_name(struct device *dev, const char *name, ...)
-			__attribute__((format(printf, 2, 3)));
-
-/**
- * clamp - return a value clamped to a given range with strict typechecking
- * @val: current value
- * @min: minimum allowable value
- * @max: maximum allowable value
- *
- * This macro does strict typechecking of min/max to make sure they are of the
- * same type as val.  See the unnecessary pointer comparisons.
- */
-#define clamp(val, min, max) ({			\
-	typeof(val) __val = (val);		\
-	typeof(min) __min = (min);		\
-	typeof(max) __max = (max);		\
-	(void) (&__val == &__min);		\
-	(void) (&__val == &__max);		\
-	__val = __val < __min ? __min: __val;	\
-	__val > __max ? __max: __val; })
-
-/**
- * clamp_t - return a value clamped to a given range using a given type
- * @type: the type of variable to use
- * @val: current value
- * @min: minimum allowable value
- * @max: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of type
- * 'type' to make all the comparisons.
- */
-#define clamp_t(type, val, min, max) ({		\
-	type __val = (val);			\
-	type __min = (min);			\
-	type __max = (max);			\
-	__val = __val < __min ? __min: __val;	\
-	__val > __max ? __max: __val; })
-
-
-/* from include/linux/device.h */
-/* device_create_drvdata() is new */
-extern struct device *device_create_drvdata(struct class *cls,
-	struct device *parent,
-	dev_t devt,
-	void *drvdata,
-	const char *fmt, ...)
-__attribute__((format(printf, 5, 6)));
-
-/* This is from include/linux/list.h */
-
-/**
- * list_is_singular - tests whether a list has just one entry.
- * @head: the list to test.
- */
-static inline int list_is_singular(const struct list_head *head)
-{
-	return !list_empty(head) && (head->next == head->prev);
-}
-
-/* This is from include/linux/device.h, which was added as of 2.6.26 */
-static inline const char *dev_name(struct device *dev)
-{
-	/* will be changed into kobject_name(&dev->kobj) in the near future */
-	return dev->bus_id;
-}
-
-/* This is from include/linux/kernel.h, which was added as of 2.6.26 */
-
-/**
- * clamp_val - return a value clamped to a given range using val's type
- * @val: current value
- * @min: minimum allowable value
- * @max: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of whatever
- * type the input argument 'val' is.  This is useful when val is an unsigned
- * type and min and max are literals that will otherwise be assigned a signed
- * integer type.
- */
-
-#define clamp_val(val, min, max) ({             \
-	typeof(val) __val = (val);              \
-	typeof(val) __min = (min);              \
-	typeof(val) __max = (max);              \
-	__val = __val < __min ? __min: __val;   \
-	__val > __max ? __max: __val; })
-
-/* This comes from include/net/net_namespace.h */
-
-#ifdef CONFIG_NET_NS
-static inline
-int net_eq(const struct net *net1, const struct net *net2)
-{
-	return net1 == net2;
-}
-#else
-static inline
-int net_eq(const struct net *net1, const struct net *net2)
-{
-	return 1;
-}
-#endif
-
-static inline
-void dev_net_set(struct net_device *dev, struct net *net)
-{
-#ifdef CONFIG_NET_NS
-	release_net(dev->nd_net);
-	dev->nd_net = hold_net(net);
-#endif
-}
-
-static inline
-struct net *sock_net(const struct sock *sk)
-{
-#ifdef CONFIG_NET_NS
-	return sk->sk_net;
-#else
-	return &init_net;
-#endif
-}
-
-/* This comes from include/linux/netdevice.h */
-
-/*
- * Net namespace inlines
- */
-static inline
-struct net *dev_net(const struct net_device *dev)
-{
-#ifdef CONFIG_NET_NS
-	/*
-	 * compat-wirelss backport note:
-	 * For older kernels we may just need to always return init_net,
-	 * not sure when we added dev->nd_net.
-	 */
-	return dev->nd_net;
-#else
-	return &init_net;
-#endif
-}
-
-
-/*
- * 2.6.26 added its own unaligned API which the
- * new drivers can use. Lets port it here by including it in older
- * kernels and also deal with the architecture handling here.
- */
-
-#ifdef CONFIG_ALPHA
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* alpha */
-#ifdef CONFIG_ARM
-
-/* arm */
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* arm */
-#ifdef CONFIG_AVR32
-
-/*
- * AVR32 can handle some unaligned accesses, depending on the
- * implementation.  The AVR32 AP implementation can handle unaligned
- * words, but halfwords must be halfword-aligned, and doublewords must
- * be word-aligned.
- *
- * However, swapped word loads must be word-aligned so we can't
- * optimize word loads in general.
- */
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif
-#ifdef CONFIG_BLACKFIN
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* blackfin */
-#ifdef CONFIG_CRIS
-
-/*
- * CRIS can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* cris */
-#ifdef CONFIG_FRV
-
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* frv */
-#ifdef CONFIG_H8300
-
-#include <linux/unaligned/be_memmove.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* h8300 */
-#ifdef  CONFIG_IA64
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* ia64 */
-#ifdef CONFIG_M32R
-
-#if defined(__LITTLE_ENDIAN__)
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* m32r */
-#ifdef CONFIG_M68K /* this handles both m68k and m68knommu */
-
-#ifdef CONFIG_COLDFIRE
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#else
-
-/*
- * The m68k can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-#endif
-
-#endif /* m68k and m68knommu */
-#ifdef CONFIG_MIPS
-
-#if defined(__MIPSEB__)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned  __get_unaligned_be
-# define put_unaligned  __put_unaligned_be
-#elif defined(__MIPSEL__)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* mips */
-#ifdef CONFIG_MN10300
-
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* mn10300 */
-#ifdef CONFIG_PARISC
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* parisc */
-#ifdef CONFIG_PPC
-/*
- * The PowerPC can do unaligned accesses itself in big endian mode.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* ppc */
-#ifdef CONFIG_S390
-
-/*
- * The S390 can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* s390 */
-#ifdef CONFIG_SUPERH
-
-/* SH can't handle unaligned accesses. */
-#ifdef __LITTLE_ENDIAN__
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* sh - SUPERH */
-#ifdef CONFIG_SPARC
-
-/* sparc and sparc64 */
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif  /* sparc */
-#ifdef CONFIG_UML
-
-#include "asm/arch/unaligned.h"
-
-#endif /* um - uml */
-#ifdef CONFIG_V850
-
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* v850 */
-#ifdef CONFIG_X86
-/*
- * The x86 can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* x86 */
-#ifdef CONFIG_XTENSA
-
-#ifdef __XTENSA_EL__
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#elif defined(__XTENSA_EB__)
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# error processor byte order undefined!
-#endif
-
-#endif /* xtensa */
-
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
-
-static inline void pci_disable_link_state(struct pci_dev *pdev, int state)
-{
-}
-/* source: include/linux/pci-aspm.h */
-
-
-#if BITS_PER_LONG == 64
-
-/**
- * div_u64_rem - unsigned 64bit divide with 32bit divisor with remainder
- *
- * This is commonly provided by 32bit archs to provide an optimized 64bit
- * divide.
- */
-static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
-{
-	*remainder = dividend % divisor;
-	return dividend / divisor;
-}
-
-#elif BITS_PER_LONG == 32
-
-#ifndef div_u64_rem
-static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
-{
-	*remainder = do_div(dividend, divisor);
-	return dividend;
-}
-#endif
-
-#endif /* BITS_PER_LONG */
-
-/**
- * div_u64 - unsigned 64bit divide with 32bit divisor
- *
- * This is the most common 64bit divide and should be used if possible,
- * as many 32bit archs can optimize this variant better than a full 64bit
- * divide.
- */
-#ifndef div_u64
-static inline u64 div_u64(u64 dividend, u32 divisor)
-{
-	u32 remainder;
-	return div_u64_rem(dividend, divisor, &remainder);
-}
-#endif
-/* source: include/math64.h */
-
-#define hex_asc_lo(x)	hex_asc((x) & 0x0f)
-#define hex_asc_hi(x)	hex_asc(((x) & 0xf0) >> 4)
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)) */
-
-#endif /* LINUX_26_26_COMPAT_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 07ebe9f..f672a99 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -122,6 +122,14 @@ static inline void device_unlock(struct device *dev)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+static inline const char *dev_name(struct device *dev)
+{
+	/* will be changed into kobject_name(&dev->kobj) in the near future */
+	return dev->bus_id;
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 static inline void dev_set_uevent_suppress(struct device *dev, int val)
 {
@@ -141,4 +149,10 @@ static inline void dev_set_uevent_suppress(struct device *dev, int val)
 #define dev_name(dev) dev_name((struct device *)dev)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+#define dev_set_name LINUX_BACKPORT(dev_set_name)
+extern int dev_set_name(struct device *dev, const char *name, ...)
+			__attribute__((format(printf, 2, 3)));
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/input.h b/backport/backport-include/linux/input.h
index fa95263..3442db0 100644
--- a/backport/backport-include/linux/input.h
+++ b/backport/backport-include/linux/input.h
@@ -14,4 +14,8 @@
 #define KEY_RFKILL		247
 #endif
 
+#ifndef SW_RFKILL_ALL
+#define SW_RFKILL_ALL           0x03
+#endif
+
 #endif /* __BACKPORT_INPUT_H */
diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
new file mode 100644
index 0000000..9e74e6a
--- /dev/null
+++ b/backport/backport-include/linux/jiffies.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_LNIUX_JIFFIES_H
+#define __BACKPORT_LNIUX_JIFFIES_H
+#include_next <linux/jiffies.h>
+
+#ifndef time_is_before_jiffies
+#define time_is_before_jiffies(a) time_after(jiffies, a)
+#endif
+
+#ifndef time_is_after_jiffies
+#define time_is_after_jiffies(a) time_before(jiffies, a)
+#endif
+
+#ifndef time_is_before_eq_jiffies
+#define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
+#endif
+
+#ifndef time_is_after_eq_jiffies
+#define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
+#endif
+
+#endif /* __BACKPORT_LNIUX_JIFFIES_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index b0ab089..24755b0 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -206,4 +206,39 @@ int hex_to_bin(char ch);
 #define lower_32_bits(n) ((u32)(n))
 #endif
 
+#ifndef USHORT_MAX
+#define USHORT_MAX      ((u16)(~0U))
+#define SHORT_MAX       ((s16)(USHORT_MAX>>1))
+#define SHORT_MIN       (-SHORT_MAX - 1)
+#endif
+
+#ifndef clamp
+#define clamp(val, min, max) ({			\
+	typeof(val) __val = (val);		\
+	typeof(min) __min = (min);		\
+	typeof(max) __max = (max);		\
+	(void) (&__val == &__min);		\
+	(void) (&__val == &__max);		\
+	__val = __val < __min ? __min: __val;	\
+	__val > __max ? __max: __val; })
+#endif
+
+#ifndef clamp_t
+#define clamp_t(type, val, min, max) ({		\
+	type __val = (val);			\
+	type __min = (min);			\
+	type __max = (max);			\
+	__val = __val < __min ? __min: __val;	\
+	__val > __max ? __max: __val; })
+#endif
+
+#ifndef clamp_val
+#define clamp_val(val, min, max) ({             \
+	typeof(val) __val = (val);              \
+	typeof(val) __min = (min);              \
+	typeof(val) __max = (max);              \
+	__val = __val < __min ? __min: __val;   \
+	__val > __max ? __max: __val; })
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 8ad0b28..fb5ee4b 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -50,6 +50,13 @@
 
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+static inline int list_is_singular(const struct list_head *head)
+{
+	return !list_empty(head) && (head->next == head->prev);
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
 static inline void __list_cut_position(struct list_head *list,
 		struct list_head *head, struct list_head *entry)
diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
index eb9e8e1..7f3a81b 100644
--- a/backport/backport-include/linux/math64.h
+++ b/backport/backport-include/linux/math64.h
@@ -7,4 +7,35 @@
 #include_next <linux/math64.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+#if BITS_PER_LONG == 64
+
+static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+
+#elif BITS_PER_LONG == 32
+
+#ifndef div_u64_rem
+static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
+{
+	*remainder = do_div(dividend, divisor);
+	return dividend;
+}
+#endif
+
+#endif /* BITS_PER_LONG */
+
+#ifndef div_u64
+static inline u64 div_u64(u64 dividend, u32 divisor)
+{
+	u32 remainder;
+	return div_u64_rem(dividend, divisor, &remainder);
+}
+#endif
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26) */
+
 #endif	/* _COMPAT_LINUX_MATH64_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index ca2baf7..74230d9 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -435,4 +435,21 @@ static inline void netif_tx_stop_all_queues(struct net_device *dev)
 #define netif_wake_subqueue netif_start_subqueue
 #endif /* < 2.6.27 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+static inline
+struct net *dev_net(const struct net_device *dev)
+{
+#ifdef CONFIG_NET_NS
+	/*
+	 * compat-wirelss backport note:
+	 * For older kernels we may just need to always return init_net,
+	 * not sure when we added dev->nd_net.
+	 */
+	return dev->nd_net;
+#else
+	return &init_net;
+#endif
+}
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pci-aspm.h b/backport/backport-include/linux/pci-aspm.h
index 2bc6efb..367112e 100644
--- a/backport/backport-include/linux/pci-aspm.h
+++ b/backport/backport-include/linux/pci-aspm.h
@@ -3,3 +3,13 @@
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 #include_next <linux/pci-aspm.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+#define PCIE_LINK_STATE_L0S	1
+#define PCIE_LINK_STATE_L1	2
+#define PCIE_LINK_STATE_CLKPM	4
+
+static inline void pci_disable_link_state(struct pci_dev *pdev, int state)
+{
+}
+#endif
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index edd02ff..f23702f 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -25,4 +25,39 @@ static inline struct net *read_pnet(struct net * const *pnet)
 #endif
 #endif /* < 2.6.29 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+#ifdef CONFIG_NET_NS
+static inline
+int net_eq(const struct net *net1, const struct net *net2)
+{
+	return net1 == net2;
+}
+#else
+static inline
+int net_eq(const struct net *net1, const struct net *net2)
+{
+	return 1;
+}
+#endif
+
+static inline
+void dev_net_set(struct net_device *dev, struct net *net)
+{
+#ifdef CONFIG_NET_NS
+	release_net(dev->nd_net);
+	dev->nd_net = hold_net(net);
+#endif
+}
+
+static inline
+struct net *sock_net(const struct sock *sk)
+{
+#ifdef CONFIG_NET_NS
+	return sk->sk_net;
+#else
+	return &init_net;
+#endif
+}
+#endif /* < 2.6.26 */
+
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
-- 
1.8.0

