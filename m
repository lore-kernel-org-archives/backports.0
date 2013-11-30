Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55229 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3K3Tyw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Nov 2013 14:54:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: check for define in module_driver and not kernel version
Date: Sat, 30 Nov 2013 20:54:39 +0100
Message-Id: <1385841283-10277-1-git-send-email-hauke@hauke-m.de> (sfid-20131130_205500_032692_690BD8A3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In some places backports checked for the kernel version on weather to
add a own define for module_driver or not. This patch makes it check if
there is already one or not.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h          |    2 +-
 backport/backport-include/linux/pci.h             |    2 +-
 backport/backport-include/linux/platform_device.h |    2 +-
 backport/backport-include/linux/usb.h             |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index e1d7bb7..198aec4 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -29,7 +29,7 @@ backport_device_move(struct device *dev, struct device *new_parent,
 #define device_move LINUX_BACKPORT(device_move)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#ifndef module_driver
 /**
  * module_driver() - Helper macro for drivers that don't do anything
  * special in module init/exit. This eliminates a lot of boilerplate.
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index e309586..208278d 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -70,7 +70,7 @@
 #define compat_pci_resume(fn)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#ifndef module_pci_driver
 /**
  * module_pci_driver() - Helper macro for registering a PCI driver
  * @__pci_driver: pci_driver struct
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index d93f04b..3735cc8 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -4,7 +4,7 @@
 #include_next <linux/platform_device.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#ifndef module_platform_driver_probe
 #define module_platform_driver_probe(__platform_driver, __platform_probe) \
 static int __init __platform_driver##_init(void) \
 { \
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index a5c2f2b..7f5ba20 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -4,7 +4,7 @@
 #include_next <linux/usb.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#ifndef module_usb_driver
 /**
  * module_usb_driver() - Helper macro for registering a USB driver
  * @__usb_driver: usb_driver struct
-- 
1.7.10.4

