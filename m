Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 6/9] compat: add efi_enabled()
Date: Tue, 26 Feb 2013 22:03:09 +0100
Message-Id: <1361912592-29591-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
References: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 3e1afb65a6fa6d964c1bbc9b2f4fc89c31d42d1a

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.8.h |   55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index 942b4cb..3af253b 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -7,6 +7,7 @@
 
 #include <linux/hid.h>
 #include <linux/netdevice.h>
+#include <linux/efi.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,5))
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
@@ -49,6 +50,60 @@ static inline int __must_check kref_get_unless_zero(struct kref *kref)
 {
 	return atomic_add_unless(&kref->refcount, 1, 0);
 }
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
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
 
 #endif /* LINUX_3_8_COMPAT_H */
-- 
1.7.10.4
