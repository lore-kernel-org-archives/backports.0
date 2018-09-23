Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40852 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeIWXoA (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] backports: Remove ssb and bcma
Date: Sun, 23 Sep 2018 19:45:26 +0200
Message-Id: <20180923174535.16198-2-hauke@hauke-m.de> (sfid-20180923_194547_614863_47F61E59)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Use the versions shipped with the kernel instead.
bcma and ssb didn't change much in the last few years, most of the
changes were related to code only used on embedded devices. Removing
this reduces the number of parts we have to backport. b43, b43legacy and
brcmsmac work well with the in kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources                           |  3 ---
 backport/Makefile.kernel                           |  2 --
 .../linux/bcma/bcma_driver_chipcommon.h            | 23 +++++++++++++++++++++
 backport/defconfigs/b43                            |  7 -------
 backport/defconfigs/b43legacy                      |  5 -----
 backport/defconfigs/brcmsmac                       |  2 --
 backport/defconfigs/wifi                           |  6 ------
 copy-list                                          |  5 -----
 dependencies                                       | 14 -------------
 patches/0051-no-wakeup_path/ssb.patch              | 12 -----------
 patches/0069-remove-of_irq/bcma.patch              | 24 ----------------------
 11 files changed, 23 insertions(+), 80 deletions(-)
 create mode 100644 backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
 delete mode 100644 patches/0051-no-wakeup_path/ssb.patch
 delete mode 100644 patches/0069-remove-of_irq/bcma.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 93ca3cd8..3fc674e5 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -7,9 +7,6 @@ source "$BACKPORT_DIR/net/mac80211/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
-source "$BACKPORT_DIR/drivers/ssb/Kconfig"
-source "$BACKPORT_DIR/drivers/bcma/Kconfig"
-
 source "$BACKPORT_DIR/net/nfc/Kconfig"
 
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index a8aad0b1..e458f6d5 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -40,8 +40,6 @@ obj-y += compat/
 obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
-obj-$(CPTCFG_SSB) += drivers/ssb/
-obj-$(CPTCFG_BCMA) += drivers/bcma/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
 obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
diff --git a/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h b/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
new file mode 100644
index 00000000..47809853
--- /dev/null
+++ b/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT_LINUX_BCMA_DRIVER_CC_H_
+#define __BACKPORT_LINUX_BCMA_DRIVER_CC_H_
+#include_next <linux/bcma/bcma_driver_chipcommon.h>
+
+#ifndef BCMA_CC_PMU_CHIPCTL_ADDR
+#define BCMA_CC_PMU_CHIPCTL_ADDR	0x0650
+#define BCMA_CC_PMU_CHIPCTL_DATA	0x0654
+#define BCMA_CC_PMU_REGCTL_ADDR		0x0658
+#define BCMA_CC_PMU_REGCTL_DATA		0x065C
+#define BCMA_CC_PMU_PLLCTL_ADDR		0x0660
+#define BCMA_CC_PMU_PLLCTL_DATA		0x0664
+#endif
+
+#ifndef BCMA_CC_CAP_EXT_AOB_PRESENT
+#define  BCMA_CC_CAP_EXT_SECI_PRESENT  0x00000001
+#define  BCMA_CC_CAP_EXT_GSIO_PRESENT  0x00000002
+#define  BCMA_CC_CAP_EXT_GCI_PRESENT   0x00000004
+#define  BCMA_CC_CAP_EXT_SECI_PUART_PRESENT            0x00000008    /* UART present */
+#define  BCMA_CC_CAP_EXT_AOB_PRESENT   0x00000040
+#endif
+
+
+#endif /* __BACKPORT_LINUX_BCMA_DRIVER_CC_H_ */
diff --git a/backport/defconfigs/b43 b/backport/defconfigs/b43
index 27bfb9e2..c486ca1e 100644
--- a/backport/defconfigs/b43
+++ b/backport/defconfigs/b43
@@ -11,10 +11,3 @@ CPTCFG_B43_SDIO=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_PHY_LP=y
 CPTCFG_B43_PHY_HT=y
-CPTCFG_BCMA=m
-CPTCFG_BCMA_HOST_PCI=y
-CPTCFG_SSB=m
-CPTCFG_SSB_PCIHOST=y
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
-CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/b43legacy b/backport/defconfigs/b43legacy
index 71787081..552e13b2 100644
--- a/backport/defconfigs/b43legacy
+++ b/backport/defconfigs/b43legacy
@@ -6,8 +6,3 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_WLAN=y
 CPTCFG_WLAN_VENDOR_BROADCOM=y
 CPTCFG_B43LEGACY=m
-CPTCFG_SSB=m
-CPTCFG_SSB_PCIHOST=y
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
-CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/brcmsmac b/backport/defconfigs/brcmsmac
index 2c2edd23..20f429b6 100644
--- a/backport/defconfigs/brcmsmac
+++ b/backport/defconfigs/brcmsmac
@@ -5,5 +5,3 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_WLAN=y
 CPTCFG_WLAN_VENDOR_BROADCOM=y
 CPTCFG_BRCMSMAC=m
-CPTCFG_BCMA=m
-CPTCFG_BCMA_HOST_PCI=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 4034bb13..fb18e182 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -17,9 +17,6 @@ CPTCFG_B43=m
 CPTCFG_B43_PHY_HT=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_SDIO=y
-CPTCFG_BCMA_DRIVER_GPIO=y
-CPTCFG_BCMA_HOST_PCI=y
-CPTCFG_BCMA=m
 CPTCFG_BRCMFMAC=m
 CPTCFG_BRCMFMAC_PCIE=y
 CPTCFG_BRCMFMAC_USB=y
@@ -101,9 +98,6 @@ CPTCFG_RTL8723BE=m
 CPTCFG_RTL8821AE=m
 CPTCFG_RTL8XXXU=m
 CPTCFG_RTLWIFI=m
-CPTCFG_SSB=m
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
 CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
 CPTCFG_USB_ZD1201=m
diff --git a/copy-list b/copy-list
index f9f9396c..7f552b8d 100644
--- a/copy-list
+++ b/copy-list
@@ -37,7 +37,6 @@ include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
 include/linux/wl12xx.h
 include/linux/rndis.h
-include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
 include/linux/usb/cdc.h
 include/uapi/linux/usb/cdc.h
@@ -87,10 +86,6 @@ include/linux/mpls.h
 include/uapi/linux/mpls.h
 
 drivers/net/wireless/ath/
-drivers/ssb/
-include/linux/ssb/
-drivers/bcma/
-include/linux/bcma/
 drivers/net/wireless/cisco/
 drivers/net/wireless/atmel/
 drivers/net/wireless/broadcom/
diff --git a/dependencies b/dependencies
index 628f82bd..a87802ad 100644
--- a/dependencies
+++ b/dependencies
@@ -48,20 +48,6 @@ NFC_ST_NCI_I2C 3.19
 NFC_ST_NCI_SPI 3.19
 NFC_PN544_I2C 3.19
 
-BCMA_DRIVER_MIPS 3.3
-SSB_DRIVER_MIPS 3.3
-# needs GPIO stuff we didn't backport
-SSB_DRIVER_GPIO 4.5
-
-# the irq handler in the gpio driver uses 
-# irq_set_chip_and_handler_name() which gets exported starting with 
-# kernel 3.7. This code is only compiled if BCMA_DRIVER_GPIO and
-# BCMA_HOST_SOC are set.
-BCMA_HOST_SOC 3.7
-
-# Uses gpiochip_get_data()
-BCMA_DRIVER_GPIO 4.5
-
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
diff --git a/patches/0051-no-wakeup_path/ssb.patch b/patches/0051-no-wakeup_path/ssb.patch
deleted file mode 100644
index dcebbcdf..00000000
--- a/patches/0051-no-wakeup_path/ssb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/ssb/pcihost_wrapper.c
-+++ b/drivers/ssb/pcihost_wrapper.c
-@@ -33,7 +33,9 @@ static int ssb_pcihost_suspend(struct de
- 
- 	/* if there is a wakeup enabled child device on ssb bus,
- 	   enable pci wakeup posibility. */
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
- 	device_set_wakeup_enable(d, d->power.wakeup_path);
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
- 
- 	pci_prepare_to_sleep(dev);
- 
diff --git a/patches/0069-remove-of_irq/bcma.patch b/patches/0069-remove-of_irq/bcma.patch
deleted file mode 100644
index b8a05ae8..00000000
--- a/patches/0069-remove-of_irq/bcma.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/bcma/main.c
-+++ b/drivers/bcma/main.c
-@@ -156,6 +156,7 @@ static struct device_node *bcma_of_find_
- 	return NULL;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- static int bcma_of_irq_parse(struct device *parent,
- 			     struct bcma_device *core,
- 			     struct of_phandle_args *out_irq, int num)
-@@ -195,6 +196,13 @@ static unsigned int bcma_of_get_irq(stru
- 
- 	return irq_create_of_mapping(&out_irq);
- }
-+#else
-+static unsigned int bcma_of_get_irq(struct device *parent,
-+				    struct bcma_device *core, int num)
-+{
-+	return 0;
-+}
-+#endif
- 
- static void bcma_of_fill_device(struct device *parent,
- 				struct bcma_device *core)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
