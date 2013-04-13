Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44263 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzl (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:41 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 30/42] backports: dissolve compat-2.6.30.h
Date: Sun, 14 Apr 2013 01:53:50 +0200
Message-Id: <1365897243-31214-31-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015639_338454_8FEA066C)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.30.h | 53 -------------------------
 backport/backport-include/linux/device.h        |  7 ++++
 backport/backport-include/linux/hid.h           |  4 +-
 backport/backport-include/linux/interrupt.h     |  4 ++
 backport/backport-include/linux/pci_regs.h      |  8 ++++
 backport/backport-include/linux/pm.h            |  9 +++++
 backport/backport-include/linux/printk.h        | 11 +++++
 7 files changed, 42 insertions(+), 54 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.30.h

diff --git a/backport/backport-include/linux/compat-2.6.30.h b/backport/backport-include/linux/compat-2.6.30.h
deleted file mode 100644
index 5841b6c..0000000
--- a/backport/backport-include/linux/compat-2.6.30.h
+++ /dev/null
@@ -1,53 +0,0 @@
-#ifndef LINUX_26_30_COMPAT_H
-#define LINUX_26_30_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30))
-
-#include <linux/device.h>
-#include <linux/pci_regs.h>
-
-#define HID_QUIRK_IGNORE                       0x00000004
-
-#ifndef TP_PROTO
-#define TP_PROTO(args...)	TPPROTO(args)
-#endif
-#ifndef TP_ARGS
-#define TP_ARGS(args...)	TPARGS(args)
-#endif
-
-#define IRQ_WAKE_THREAD	(2)
-
-/* From : include/linux/pm.h */
-/* How to reorder dpm_list after device_move() */
-enum dpm_order {
-	DPM_ORDER_NONE,
-	DPM_ORDER_DEV_AFTER_PARENT,
-	DPM_ORDER_PARENT_BEFORE_DEV,
-	DPM_ORDER_DEV_LAST,
-};
-
-static inline void dev_set_uevent_suppress(struct device *dev, int val)
-{
-	dev->uevent_suppress = val;
-}
-
-/*
- * Print a one-time message (analogous to WARN_ONCE() et al):
- */
-#define printk_once(x...) ({			\
-	static bool __print_once;		\
-						\
-	if (!__print_once) {			\
-		__print_once = true;		\
-		printk(x);			\
-	}					\
-})
-
-#define PCI_EXP_LNKCTL2			48      /* Link Control 2 */
-#define PCI_EXP_SLTCTL2			56      /* Slot Control 2 */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)) */
-
-#endif /* LINUX_26_30_COMPAT_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 0e45c1b..516cc31 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -122,4 +122,11 @@ static inline void device_unlock(struct device *dev)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+static inline void dev_set_uevent_suppress(struct device *dev, int val)
+{
+	dev->uevent_suppress = val;
+}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index b642ece..4ad740a 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -20,6 +20,8 @@ extern bool hid_ignore(struct hid_device *);
 #define HID_QUIRK_HIDDEV_FORCE                 0x00000010
 #endif
 
-
+#ifndef HID_QUIRK_IGNORE
+#define HID_QUIRK_IGNORE                       0x00000004
+#endif
 
 #endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 546a7fb..9e51303 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -25,6 +25,10 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+#define IRQ_WAKE_THREAD	(2)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 struct compat_threaded_irq {
 	unsigned int irq;
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index d97e57f..f7bfd9a 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -95,4 +95,12 @@
 #define  PCI_MSIX_ENTRY_VECTOR_CTRL    12
 #endif
 
+#ifndef PCI_EXP_LNKCTL2
+#define PCI_EXP_LNKCTL2			48      /* Link Control 2 */
+#endif
+
+#ifndef PCI_EXP_SLTCTL2
+#define PCI_EXP_SLTCTL2			56      /* Slot Control 2 */
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 4e30652..a78477c 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -55,4 +55,13 @@ struct dev_pm_ops name = { \
 #endif /* >= 2.6.29 */
 #endif /* < 2.6.32 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+enum dpm_order {
+	DPM_ORDER_NONE,
+	DPM_ORDER_DEV_AFTER_PARENT,
+	DPM_ORDER_PARENT_BEFORE_DEV,
+	DPM_ORDER_DEV_LAST,
+};
+#endif
+
 #endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index c110888..b97f51e 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -39,6 +39,17 @@ do {                                                           \
 #define pr_warn pr_warning
 #endif
 
+#ifndef printk_once
+#define printk_once(x...) ({			\
+	static bool __print_once;		\
+						\
+	if (!__print_once) {			\
+		__print_once = true;		\
+		printk(x);			\
+	}					\
+})
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
 #define pr_emerg_once(fmt, ...)					\
 	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
-- 
1.8.0

