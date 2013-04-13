Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44257 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzg (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:36 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 21/42] backports: dissolve compat-2.6.39.h
Date: Sun, 14 Apr 2013 01:53:41 +0200
Message-Id: <1365897243-31214-22-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015643_017221_AA99C2F6)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.39.h   | 183 ----------------------
 backport/backport-include/linux/err.h             |  16 ++
 backport/backport-include/linux/interrupt.h       |  13 ++
 backport/backport-include/linux/irq.h             |  85 ++++++++++
 backport/backport-include/linux/kernel.h          |  70 +++++++++
 backport/backport-include/linux/netdev_features.h |   4 +
 backport/backport-include/linux/tty.h             |   6 +
 7 files changed, 194 insertions(+), 183 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.39.h
 create mode 100644 backport/backport-include/linux/err.h
 create mode 100644 backport/backport-include/linux/interrupt.h
 create mode 100644 backport/backport-include/linux/irq.h

diff --git a/backport/backport-include/linux/compat-2.6.39.h b/backport/backport-include/linux/compat-2.6.39.h
deleted file mode 100644
index 863afa4..0000000
--- a/backport/backport-include/linux/compat-2.6.39.h
+++ /dev/null
@@ -1,183 +0,0 @@
-#ifndef LINUX_26_39_COMPAT_H
-#define LINUX_26_39_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-
-#include <linux/tty.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-
-static inline int __must_check PTR_RET(const void *ptr)
-{
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
-	else
-		return 0;
-}
-
-#if !defined(NETIF_F_RXCSUM)
-#define NETIF_F_RXCSUM 0
-#endif
-
-#define tiocmget(tty) tiocmget(tty, NULL)
-#define tiocmset(tty, set, clear) tiocmset(tty, NULL, set, clear)
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-#define tty_set_termios LINUX_BACKPORT(tty_set_termios)
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)) */
-
-static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
-{
-	return set_irq_wake(irq, on);
-}
-static inline int irq_set_chip(unsigned int irq, struct irq_chip *chip)
-{
-	return set_irq_chip(irq, chip);
-}
-static inline int irq_set_handler_data(unsigned int irq, void *data)
-{
-	return set_irq_data(irq, data);
-}
-static inline int irq_set_chip_data(unsigned int irq, void *data)
-{
-	return set_irq_chip_data(irq, data);
-}
-static inline int irq_set_irq_type(unsigned int irq, unsigned int type)
-{
-	return set_irq_type(irq, type);
-}
-static inline int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
-{
-	return set_irq_msi(irq, entry);
-}
-static inline struct irq_chip *irq_get_chip(unsigned int irq)
-{
-	return get_irq_chip(irq);
-}
-static inline void *irq_get_chip_data(unsigned int irq)
-{
-	return get_irq_chip_data(irq);
-}
-static inline void *irq_get_handler_data(unsigned int irq)
-{
-	return get_irq_data(irq);
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
-{
-	return irq_data_get_irq_data(d);
-}
-#endif
-
-static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
-{
-	return get_irq_msi(irq);
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
-static inline void irq_set_noprobe(unsigned int irq)
-{
-	set_irq_noprobe(irq);
-}
-static inline void irq_set_probe(unsigned int irq)
-{
-	set_irq_probe(irq);
-}
-#endif
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
-static inline struct irq_chip *irq_desc_get_chip(struct irq_desc *desc)
-{
-	return get_irq_desc_chip(desc);
-}
-static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
-{
-	return get_irq_desc_data(desc);
-}
-
-static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
-{
-	return get_irq_desc_chip_data(desc);
-}
-
-static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
-{
-	return get_irq_desc_msi(desc);
-}
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)) */
-
-/* 
- * kstrto* was included in kernel 2.6.38.4 and causes conflicts with the
- * version included in compat-drivers. We use strict_strtol to check if
- * kstrto* is already available.
- */
-#ifndef strict_strtoull
-/* Internal, do not use. */
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
-int __must_check _kstrtol(const char *s, unsigned int base, long *res);
-
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
-	 */
-	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
-	    __alignof__(unsigned long) == __alignof__(unsigned long long))
-		return kstrtoull(s, base, (unsigned long long *)res);
-	else
-		return _kstrtoul(s, base, res);
-}
-
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(long, long long) = 0.
-	 */
-	if (sizeof(long) == sizeof(long long) &&
-	    __alignof__(long) == __alignof__(long long))
-		return kstrtoll(s, base, (long long *)res);
-	else
-		return _kstrtol(s, base, res);
-}
-
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
-int __must_check kstrtoint(const char *s, unsigned int base, int *res);
-
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
-{
-	return kstrtoull(s, base, res);
-}
-
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
-{
-	return kstrtoll(s, base, res);
-}
-
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
-{
-	return kstrtouint(s, base, res);
-}
-
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
-{
-	return kstrtoint(s, base, res);
-}
-
-int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
-int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
-int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
-int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
-#endif /* ifndef strict_strtol */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
-
-#endif /* LINUX_26_39_COMPAT_H */
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
new file mode 100644
index 0000000..cf63ea0
--- /dev/null
+++ b/backport/backport-include/linux/err.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_LINUX_ERR_H
+#define __BACKPORT_LINUX_ERR_H
+#include_next <linux/err.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+static inline int __must_check PTR_RET(const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_ERR_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
new file mode 100644
index 0000000..79937a6
--- /dev/null
+++ b/backport/backport-include/linux/interrupt.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_INTERRUPT_H
+#define __BACKPORT_LINUX_INTERRUPT_H
+#include_next <linux/interrupt.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
+{
+	return set_irq_wake(irq, on);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_INTERRUPT_H */
diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
new file mode 100644
index 0000000..357d688
--- /dev/null
+++ b/backport/backport-include/linux/irq.h
@@ -0,0 +1,85 @@
+#ifndef __BACKPORT_LINUX_IRQ_H
+#define __BACKPORT_LINUX_IRQ_H
+#include_next <linux/irq.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+static inline int irq_set_chip(unsigned int irq, struct irq_chip *chip)
+{
+	return set_irq_chip(irq, chip);
+}
+static inline int irq_set_handler_data(unsigned int irq, void *data)
+{
+	return set_irq_data(irq, data);
+}
+static inline int irq_set_chip_data(unsigned int irq, void *data)
+{
+	return set_irq_chip_data(irq, data);
+}
+static inline int irq_set_irq_type(unsigned int irq, unsigned int type)
+{
+	return set_irq_type(irq, type);
+}
+static inline int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
+{
+	return set_irq_msi(irq, entry);
+}
+static inline struct irq_chip *irq_get_chip(unsigned int irq)
+{
+	return get_irq_chip(irq);
+}
+static inline void *irq_get_chip_data(unsigned int irq)
+{
+	return get_irq_chip_data(irq);
+}
+static inline void *irq_get_handler_data(unsigned int irq)
+{
+	return get_irq_data(irq);
+}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
+static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
+{
+	return irq_data_get_irq_data(d);
+}
+#endif
+
+static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
+{
+	return get_irq_msi(irq);
+}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
+static inline void irq_set_noprobe(unsigned int irq)
+{
+	set_irq_noprobe(irq);
+}
+static inline void irq_set_probe(unsigned int irq)
+{
+	set_irq_probe(irq);
+}
+#endif
+#endif
+
+/* This is really in irqdesc.h, but nothing includes that directly */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)
+static inline struct irq_chip *irq_desc_get_chip(struct irq_desc *desc)
+{
+	return get_irq_desc_chip(desc);
+}
+static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
+{
+	return get_irq_desc_data(desc);
+}
+static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
+{
+	return get_irq_desc_chip_data(desc);
+}
+static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
+{
+	return get_irq_desc_msi(desc);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_IRQ_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 7d22b74..c41ea1b 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -92,4 +92,74 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+/* 
+ * kstrto* was included in kernel 2.6.38.4 and causes conflicts with the
+ * version included in compat-drivers. We use strict_strtol to check if
+ * kstrto* is already available.
+ */
+#ifndef strict_strtoull
+/* Internal, do not use. */
+int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+int __must_check _kstrtol(const char *s, unsigned int base, long *res);
+
+int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
+static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
+
+static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(long, long long) = 0.
+	 */
+	if (sizeof(long) == sizeof(long long) &&
+	    __alignof__(long) == __alignof__(long long))
+		return kstrtoll(s, base, (long long *)res);
+	else
+		return _kstrtol(s, base, res);
+}
+
+int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+int __must_check kstrtoint(const char *s, unsigned int base, int *res);
+
+static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
+{
+	return kstrtoull(s, base, res);
+}
+
+static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
+{
+	return kstrtoll(s, base, res);
+}
+
+static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
+{
+	return kstrtouint(s, base, res);
+}
+
+static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
+{
+	return kstrtoint(s, base, res);
+}
+
+int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
+int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
+int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
+int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
+#endif /* ifndef strict_strtol */
+
+#endif /* < 2.6.39 */
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index a7394f4..bac3a3e 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -12,4 +12,8 @@ typedef u32 netdev_features_t;
 #include_next <linux/netdev_features.h>
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
+#if !defined(NETIF_F_RXCSUM)
+#define NETIF_F_RXCSUM 0
+#endif
+
 #endif /* __BACKPORT_NETDEV_FEATURES_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 0424dc7..ec73e06 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -2,6 +2,12 @@
 #define __BACKPORT_LINUX_TTY_H
 #include_next <linux/tty.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
+#define tty_set_termios LINUX_BACKPORT(tty_set_termios)
+extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /* Backports tty_lock: Localise the lock */
 #define tty_lock(__tty) tty_lock()
-- 
1.8.0

