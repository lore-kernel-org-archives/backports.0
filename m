Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0355E72
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009039; cv=none; b=khuR7tw8P7DHkgS3eJC6NYB0q28x6W88gT+rbFXPeftHEhXCPE5gLB9Jj3ltLuKBupitBrTY5h5Q5N70gRymub6Kyu2NMN7DGudJX9V/1vzQm5ZEafS+TT8uAMqwm3uzzBZ+erg24qKkYWFweQSo5nkVxJJp0fXx9jAi2wA1Mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009039; c=relaxed/simple;
	bh=pKcvy+x2FGcizXTqgxJRUtXOYrP1/ZZM28Ozaq7P+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNAafN5nrG5ey2x3YK0XtxcX6knC0XIyVr+Lj/JmySU5YIs7nxSRqz6KvbGe98SxyGj7UD9RNemLNXvmMccTTUkPHJi+qN3W738dAQaF0JHoiJSt0K59dUcI9ugABf1QhOgtvmnVS4A93TAbevOmj+WzEqq9LdOS+iSzcMtFMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=luSw3X5z; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="luSw3X5z"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V7lQX4BzKz9snL;
	Tue,  2 Apr 2024 00:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGfxiaEr4E2lUIt/g5Y0/v8ashzfp0IFePo8eAT8KYg=;
	b=luSw3X5zAo5O4Pu/HawJQwclcarpfkywbrDtPjXJ/GtoKq2BQUdIh72M6NSZp5keKx830o
	LG4RI+vJxLLJlOlfR2PtGgANCy5VdDFuW61tNoUklV/bcnogv7h2epYa9EnVxty8Ud+kYO
	aM5ioc3i/GXdtryJ1YyFCZxT7FX7gXExoSH0bHz5l27+n2ZlOvz5UntPaTQZN/VhkneEy8
	JlIA792RmXkxnPsM+9JTfyY0ILYR+5VLG2sK03ol3kut1jHbnG1DjibK6+pxJLbVgRjgql
	5vn+GmDB4JXLNhJ08NeKjcnKo2UIgcRhuM/V+t8yOtwQ+MbEAz61zHK+VWT6+g==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] backports: Remove support for kernel smaller than 4.9
Date: Tue,  2 Apr 2024 00:03:09 +0200
Message-ID: <20240401220314.2434455-6-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes all the code which is needed to support kernel 4.8.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |  1 -
 README                                        |  2 +-
 backport/backport-include/linux/debugfs.h     | 13 ---------
 backport/backport-include/linux/pci.h         | 27 -------------------
 backport/backport-include/linux/thermal.h     | 23 ----------------
 backport/compat/Kconfig                       | 18 -------------
 .../0013-fix-makefile-includes/brcmfmac.patch | 13 ---------
 7 files changed, 1 insertion(+), 96 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/brcmfmac.patch

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 3bdbc2a8..fb85a0e9 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.8",
            "4.9",
            "4.10",
            "4.11",
diff --git a/README b/README
index e1f40943..994baa4d 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.8 and above.
+for kernels 4.9 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 5c671d2d..6020c210 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -4,19 +4,6 @@
 #include <linux/version.h>
 #include <linux/device.h>
 
-#if LINUX_VERSION_IS_LESS(4,9,0) && \
-    !LINUX_VERSION_IN_RANGE(4,8,4, 4,9,0)
-static inline const struct file_operations *
-debugfs_real_fops(const struct file *filp)
-{
-	/*
-	 * Neither the pointer to the struct file_operations, nor its
-	 * contents ever change -- srcu_dereference() is not needed here.
-	 */
-	return filp->f_path.dentry->d_fsdata;
-}
-#endif /* <4.9.0 but not >= 4.8.4 */
-
 #ifndef DEFINE_DEBUGFS_ATTRIBUTE
 #define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt) \
 	DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 2a5309d9..2c5d5dd9 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -7,33 +7,6 @@
 #include <linux/pci-aspm.h>
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,9,0) &&			\
-	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
-
-static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
-{
-	while (1) {
-		if (!pci_is_pcie(dev))
-			break;
-		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-			return dev;
-		if (!dev->bus->self)
-			break;
-		dev = dev->bus->self;
-	}
-	return NULL;
-}
-
-#endif/* <4.9.0 but not >= 4.8.13 */
-
-#ifndef PCI_IRQ_LEGACY
-#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
-#define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
-#define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
-#define PCI_IRQ_ALL_TYPES \
-	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
-#endif
-
 #if defined(CONFIG_PCI)
 #if LINUX_VERSION_IS_LESS(5,3,0)
 static inline int
diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 8210facf..d9b8153e 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -13,27 +13,4 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
-#if LINUX_VERSION_IS_LESS(4,9,0)
-/* Thermal notification reason */
-enum thermal_notify_event {
-	THERMAL_EVENT_UNSPECIFIED, /* Unspecified event */
-	THERMAL_EVENT_TEMP_SAMPLE, /* New Temperature sample */
-	THERMAL_TRIP_VIOLATED, /* TRIP Point violation */
-	THERMAL_TRIP_CHANGED, /* TRIP Point temperature changed */
-	THERMAL_DEVICE_DOWN, /* Thermal device is down */
-	THERMAL_DEVICE_UP, /* Thermal device is up after a down event */
-	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
-	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
-	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
-};
-
-static inline void
-backport_thermal_zone_device_update(struct thermal_zone_device *tz,
-				    enum thermal_notify_event event)
-{
-	thermal_zone_device_update(tz);
-}
-#define thermal_zone_device_update LINUX_BACKPORT(thermal_zone_device_update)
-#endif /* < 4.9 */
-
 #endif /* __BACKPORT_LINUX_THERMAL_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 174322d8..f7266780 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -79,24 +79,6 @@ config BPAUTO_USERSEL_BUILD_ALL
 config BPAUTO_WANT_DEV_COREDUMP
 	bool
 
-config BPAUTO_RHASHTABLE
-	bool
-	# current API of rhashtable was introduced in version 4.9
-	# (the one including rhltable)
-	depends on KERNEL_4_9
-	# not very nice - but better than always having it
-	default y if BACKPORTED_MAC80211
-	#h-file linux/rhashtable.h
-	#h-file linux/rhashtable-types.h
-	#c-file lib/rhashtable.c
-
-config BPAUTO_BUCKET_LOCKS
-	bool
-	# the API of bucket_locks that we need was introduced in version 4.16
-	depends on KERNEL_4_16
-	default y if BPAUTO_RHASHTABLE
-	#c-file lib/bucket_locks.c
-
 config BPAUTO_REFCOUNT
 	bool
 	default y
diff --git a/patches/0013-fix-makefile-includes/brcmfmac.patch b/patches/0013-fix-makefile-includes/brcmfmac.patch
deleted file mode 100644
index f4781c8e..00000000
--- a/patches/0013-fix-makefile-includes/brcmfmac.patch
+++ /dev/null
@@ -1,13 +0,0 @@
-brcmf_bus_ops.txdata() uses a paramater of type struct sk_buff which
-was not declared here when compiling against kernele 4.8 and older.
-
---- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
-+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
-@@ -6,6 +6,7 @@
- #ifndef BRCMFMAC_BUS_H
- #define BRCMFMAC_BUS_H
- 
-+#include <linux/skbuff.h>
- #include "debug.h"
- 
- /* IDs of the 6 default common rings of msgbuf protocol */
-- 
2.44.0

