Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38200 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3LHPI3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:29 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: add LINUX_BACKPORT infront of functions
Date: Sun,  8 Dec 2013 16:08:09 +0100
Message-Id: <1386515294-26231-4-git-send-email-hauke@hauke-m.de> (sfid-20131208_160830_934639_30C590B4)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed to add support for SLES 11 SP3 support.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h      |    4 ++++
 backport/backport-include/linux/usb.h      |    1 +
 backport/backport-include/linux/usb/ch9.h  |    1 +
 backport/backport-include/linux/watchdog.h |    1 +
 backport/compat/compat-3.7.c               |    9 +++------
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 208278d..3a1815a 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -100,24 +100,28 @@ int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
 int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 					u32 clear, u32 set);
 
+#define pcie_capability_set_word LINUX_BACKPORT(pcie_capability_set_word)
 static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
 					   u16 set)
 {
 	return pcie_capability_clear_and_set_word(dev, pos, 0, set);
 }
 
+#define pcie_capability_set_dword LINUX_BACKPORT(pcie_capability_set_dword)
 static inline int pcie_capability_set_dword(struct pci_dev *dev, int pos,
 					    u32 set)
 {
 	return pcie_capability_clear_and_set_dword(dev, pos, 0, set);
 }
 
+#define pcie_capability_clear_word LINUX_BACKPORT(pcie_capability_clear_word)
 static inline int pcie_capability_clear_word(struct pci_dev *dev, int pos,
 					     u16 clear)
 {
 	return pcie_capability_clear_and_set_word(dev, pos, clear, 0);
 }
 
+#define pcie_capability_clear_dword LINUX_BACKPORT(pcie_capability_clear_dword)
 static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 					      u32 clear)
 {
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 7f5ba20..08ae0f2 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -144,6 +144,7 @@ extern int usb_anchor_empty(struct usb_anchor *anchor);
 #endif /* 2.6.23-2.6.27 */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#define usb_translate_errors LINUX_BACKPORT(usb_translate_errors)
 static inline int usb_translate_errors(int error_code)
 {
 	switch (error_code) {
diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index 222b3f9..33c5959 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -36,6 +36,7 @@ enum usb_device_speed {
  *
  * Returns @epd's max packet
  */
+#define usb_endpoint_maxp LINUX_BACKPORT(usb_endpoint_maxp)
 static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
 {
 	return __le16_to_cpu(epd->wMaxPacketSize);
diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
index fb68535..49f6669 100644
--- a/backport/backport-include/linux/watchdog.h
+++ b/backport/backport-include/linux/watchdog.h
@@ -4,6 +4,7 @@
 
 #if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define watchdog_device LINUX_BACKPORT(watchdog_device)
 struct watchdog_device {
 };
 #endif
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 2d739f9..f7e7848 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -47,21 +47,18 @@ static inline u16 pcie_flags_reg(struct pci_dev *dev)
 	return reg16;
 }
 
+#define pci_pcie_type LINUX_BACKPORT(pci_pcie_type)
 static inline int pci_pcie_type(struct pci_dev *dev)
 {
 	return (pcie_flags_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
 }
 
+#define pcie_cap_version LINUX_BACKPORT(pcie_cap_version)
 static inline int pcie_cap_version(struct pci_dev *dev)
 {
 	return pcie_flags_reg(dev) & PCI_EXP_FLAGS_VERS;
 }
 
-static inline bool pcie_cap_has_devctl(const struct pci_dev *dev)
-{
-	return true;
-}
-
 static inline bool pcie_cap_has_lnkctl(struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
@@ -102,7 +99,7 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_DEVSTA:
-		return pcie_cap_has_devctl(dev);
+		return true;
 	case PCI_EXP_LNKCAP:
 	case PCI_EXP_LNKCTL:
 	case PCI_EXP_LNKSTA:
-- 
1.7.10.4

