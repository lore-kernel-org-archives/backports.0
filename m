Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44247 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab3DMXz1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:27 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 11/42] backports: dissolve compat-3.8.h
Date: Sun, 14 Apr 2013 01:53:31 +0200
Message-Id: <1365897243-31214-12-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015529_095194_04686BE4)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h     |   1 -
 backport/backport-include/linux/compat-3.8.h      | 131 ----------------------
 backport/backport-include/linux/efi.h             |  66 +++++++++++
 backport/backport-include/linux/hid.h             |  11 ++
 backport/backport-include/linux/kref.h            |  22 ++++
 backport/backport-include/linux/mod_devicetable.h |  13 +++
 backport/backport-include/linux/netdevice.h       |   9 ++
 backport/backport-include/linux/pci_regs.h        |  29 +++++
 backport/backport-include/linux/random.h          |  13 +++
 9 files changed, 163 insertions(+), 132 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.8.h
 create mode 100644 backport/backport-include/linux/efi.h
 create mode 100644 backport/backport-include/linux/hid.h
 create mode 100644 backport/backport-include/linux/kref.h
 create mode 100644 backport/backport-include/linux/mod_devicetable.h
 create mode 100644 backport/backport-include/linux/pci_regs.h
 create mode 100644 backport/backport-include/linux/random.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index 2c86774..d8b2464 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -78,7 +78,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.5.h>
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
-#include <linux/compat-3.8.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/backport/backport-include/linux/compat-3.8.h b/backport/backport-include/linux/compat-3.8.h
deleted file mode 100644
index 55fdc16..0000000
--- a/backport/backport-include/linux/compat-3.8.h
+++ /dev/null
@@ -1,131 +0,0 @@
-#ifndef LINUX_3_8_COMPAT_H
-#define LINUX_3_8_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
-
-#include <linux/hid.h>
-#include <linux/netdevice.h>
-#include <linux/efi.h>
-#include <linux/random.h>
-
-/* backports 496f2f9 */
-#define prandom_seed(_seed)		srandom32(_seed)
-#define prandom_u32()			random32()
-#define prandom_u32_state(_state)	prandom32(_state)
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
-#define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
-extern void netdev_set_default_ethtool_ops(struct net_device *dev,
-					   const struct ethtool_ops *ops);
-#endif
-
-#define HID_BUS_ANY                            0xffff
-#define HID_GROUP_ANY                          0x0000
-
-#define  PCI_EXP_LNKCTL_ASPM_L0S  0x01 /* L0s Enable */
-#define  PCI_EXP_LNKCTL_ASPM_L1   0x02 /* L1 Enable */
-
-#define hid_ignore LINUX_BACKPORT(hid_ignore)
-extern bool hid_ignore(struct hid_device *);
-
-/* This backports:
- *
- * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
- * Author: Thomas Hellstrom <thellstrom@vmware.com>
- * Date:   Tue Nov 6 11:31:49 2012 +0000
- *
- *	kref: Implement kref_get_unless_zero v3
- */
-/**
- * kref_get_unless_zero - Increment refcount for object unless it is zero.
- * @kref: object.
- *
- * Return non-zero if the increment succeeded. Otherwise return 0.
- *
- * This function is intended to simplify locking around refcounting for
- * objects that can be looked up from a lookup structure, and which are
- * removed from that lookup structure in the object destructor.
- * Operations on such objects require at least a read lock around
- * lookup + kref_get, and a write lock around kref_put + remove from lookup
- * structure. Furthermore, RCU implementations become extremely tricky.
- * With a lookup followed by a kref_get_unless_zero *with return value check*
- * locking in the kref_put path can be deferred to the actual removal from
- * the lookup structure and RCU lookups become trivial.
- */
-static inline int __must_check kref_get_unless_zero(struct kref *kref)
-{
-	return atomic_add_unless(&kref->refcount, 1, 0);
-}
-
-/* This backports:
- *
- * commit 83e68189745ad931c2afd45d8ee3303929233e7f
- * Author: Matt Fleming <matt.fleming@intel.com>
- * Date:   Wed Nov 14 09:42:35 2012 +0000
- *
- *     efi: Make 'efi_enabled' a function to query EFI facilities
- *
- */
-/* check first if this was already backported */
-#ifndef EFI_BOOT
-/*
- * We play games with efi_enabled so that the compiler will, if
- * possible, remove EFI-related code altogether.
- */
-#define EFI_BOOT		0	/* Were we booted from EFI? */
-#define EFI_SYSTEM_TABLES	1	/* Can we use EFI system tables? */
-#define EFI_CONFIG_TABLES	2	/* Can we use EFI config tables? */
-#define EFI_RUNTIME_SERVICES	3	/* Can we use runtime services? */
-#define EFI_MEMMAP		4	/* Can we use EFI memory map? */
-#define EFI_64BIT		5	/* Is the firmware 64-bit? */
-
-#ifdef CONFIG_EFI
-# ifdef CONFIG_X86
-static inline int compat_efi_enabled(int facility)
-{
-	switch (facility) {
-	case EFI_BOOT:
-		return efi_enabled;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-	case EFI_64BIT:
-		return efi_64bit;
-#endif
-	default:
-		printk(KERN_ERR "can not translate efi_enabled() to old values completly\n");
-		return efi_enabled;
-	}
-}
-# else
-static inline int compat_efi_enabled(int facility)
-{
-	return 1;
-}
-# endif
-#else
-static inline int compat_efi_enabled(int facility)
-{
-	return 0;
-}
-#endif
-#ifdef efi_enabled
-#undef efi_enabled
-#endif
-#define efi_enabled(facility) compat_efi_enabled(facility)
-#endif /* EFI_BOOT */
-
-/* This backports:
- *
- * commit 130f1b8f35f14d27c43da755f3c9226318c17f57
- * Author: Bjorn Helgaas <bhelgaas@google.com>
- * Date:   Wed Dec 26 10:39:23 2012 -0700
- *
- *     PCI: Add PCIe Link Capability link speed and width names
- */
-#define  PCI_EXP_LNKCAP_SLS_2_5GB 0x1	/* LNKCAP2 SLS Vector bit 0 (2.5GT/s) */
-#define  PCI_EXP_LNKCAP_SLS_5_0GB 0x2	/* LNKCAP2 SLS Vector bit 1 (5.0GT/s) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
-
-#endif /* LINUX_3_8_COMPAT_H */
diff --git a/backport/backport-include/linux/efi.h b/backport/backport-include/linux/efi.h
new file mode 100644
index 0000000..2fc40e5
--- /dev/null
+++ b/backport/backport-include/linux/efi.h
@@ -0,0 +1,66 @@
+#ifndef __BACKPORT_EFI_H
+#define __BACKPORT_EFI_H
+#include_next <linux/efi.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
+
+/* This backports:
+ *
+ * commit 83e68189745ad931c2afd45d8ee3303929233e7f
+ * Author: Matt Fleming <matt.fleming@intel.com>
+ * Date:   Wed Nov 14 09:42:35 2012 +0000
+ *
+ *     efi: Make 'efi_enabled' a function to query EFI facilities
+ *
+ */
+/* check first if this was already backported */
+#ifndef EFI_BOOT
+/*
+ * We play games with efi_enabled so that the compiler will, if
+ * possible, remove EFI-related code altogether.
+ */
+#define EFI_BOOT		0	/* Were we booted from EFI? */
+#define EFI_SYSTEM_TABLES	1	/* Can we use EFI system tables? */
+#define EFI_CONFIG_TABLES	2	/* Can we use EFI config tables? */
+#define EFI_RUNTIME_SERVICES	3	/* Can we use runtime services? */
+#define EFI_MEMMAP		4	/* Can we use EFI memory map? */
+#define EFI_64BIT		5	/* Is the firmware 64-bit? */
+
+#ifdef CONFIG_EFI
+# ifdef CONFIG_X86
+static inline int compat_efi_enabled(int facility)
+{
+	switch (facility) {
+	case EFI_BOOT:
+		return efi_enabled;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
+	case EFI_64BIT:
+		return efi_64bit;
+#endif
+	default:
+		printk(KERN_ERR "can not translate efi_enabled() to old values completly\n");
+		return efi_enabled;
+	}
+}
+# else
+static inline int compat_efi_enabled(int facility)
+{
+	return 1;
+}
+# endif
+#else
+static inline int compat_efi_enabled(int facility)
+{
+	return 0;
+}
+#endif
+#ifdef efi_enabled
+#undef efi_enabled
+#endif
+#define efi_enabled(facility) compat_efi_enabled(facility)
+#endif /* EFI_BOOT */
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
+
+#endif /* __BACKPORT_EFI_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
new file mode 100644
index 0000000..bb7455f
--- /dev/null
+++ b/backport/backport-include/linux/hid.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_HID_H
+#define __BACKPORT_HID_H
+#include_next <linux/hid.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#define hid_ignore LINUX_BACKPORT(hid_ignore)
+extern bool hid_ignore(struct hid_device *);
+#endif
+
+#endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/kref.h b/backport/backport-include/linux/kref.h
new file mode 100644
index 0000000..40f3c77
--- /dev/null
+++ b/backport/backport-include/linux/kref.h
@@ -0,0 +1,22 @@
+#ifndef __BACKPORT_KREF_H
+#define __BACKPORT_KREF_H
+#include_next <linux/kref.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#include <linux/atomic.h>
+/* This backports:
+ *
+ * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
+ * Author: Thomas Hellstrom <thellstrom@vmware.com>
+ * Date:   Tue Nov 6 11:31:49 2012 +0000
+ *
+ *	kref: Implement kref_get_unless_zero v3
+ */
+static inline int __must_check kref_get_unless_zero(struct kref *kref)
+{
+	return atomic_add_unless(&kref->refcount, 1, 0);
+}
+#endif
+
+#endif /* __BACKPORT_KREF_H */
diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
new file mode 100644
index 0000000..5ad4c06
--- /dev/null
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_MOD_DEVICETABLE_H
+#define __BACKPORT_MOD_DEVICETABLE_H
+#include_next <linux/mod_devicetable.h>
+
+#ifndef HID_BUS_ANY
+#define HID_BUS_ANY                            0xffff
+#endif
+
+#ifndef HID_GROUP_ANY
+#define HID_GROUP_ANY                          0x0000
+#endif
+
+#endif /* __BACKPORT_MOD_DEVICETABLE_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 0b83dc4..cf38903 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -3,6 +3,15 @@
 #include_next <linux/netdevice.h>
 #include <linux/version.h>
 
+/* older kernels don't include this here, we need it */
+#include <linux/ethtool.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
+#define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
+extern void netdev_set_default_ethtool_ops(struct net_device *dev,
+					   const struct ethtool_ops *ops);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
 #define __dev_addr_sync LINUX_BACKPORT(__dev_addr_sync)
 extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
new file mode 100644
index 0000000..ec8c59f
--- /dev/null
+++ b/backport/backport-include/linux/pci_regs.h
@@ -0,0 +1,29 @@
+#ifndef __BACKPORT_UAPI_PCI_REGS_H
+#define __BACKPORT_UAPI_PCI_REGS_H
+#include_next <linux/pci_regs.h>
+
+#ifndef PCI_EXP_LNKCTL_ASPM_L0S
+#define  PCI_EXP_LNKCTL_ASPM_L0S  0x01 /* L0s Enable */
+#endif
+
+#ifndef PCI_EXP_LNKCTL_ASPM_L1
+#define  PCI_EXP_LNKCTL_ASPM_L1   0x02 /* L1 Enable */
+#endif
+
+/* This backports:
+ *
+ * commit 130f1b8f35f14d27c43da755f3c9226318c17f57
+ * Author: Bjorn Helgaas <bhelgaas@google.com>
+ * Date:   Wed Dec 26 10:39:23 2012 -0700
+ *
+ *     PCI: Add PCIe Link Capability link speed and width names
+ */
+#ifndef PCI_EXP_LNKCAP_SLS_2_5GB
+#define  PCI_EXP_LNKCAP_SLS_2_5GB 0x1	/* LNKCAP2 SLS Vector bit 0 (2.5GT/s) */
+#endif
+
+#ifndef PCI_EXP_LNKCAP_SLS_5_0GB
+#define  PCI_EXP_LNKCAP_SLS_5_0GB 0x2	/* LNKCAP2 SLS Vector bit 1 (5.0GT/s) */
+#endif
+
+#endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
new file mode 100644
index 0000000..812ce7f
--- /dev/null
+++ b/backport/backport-include/linux/random.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_RANDOM_H
+#define __BACKPORT_RANDOM_H
+#include_next <linux/random.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+/* backports 496f2f9 */
+#define prandom_seed(_seed)		srandom32(_seed)
+#define prandom_u32()			random32()
+#define prandom_u32_state(_state)	prandom32(_state)
+#endif
+
+#endif /* __BACKPORT_RANDOM_H */
-- 
1.8.0

