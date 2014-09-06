Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48071 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbaIFTog (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: remove ath5k section mismatch patch
Date: Sat,  6 Sep 2014 21:44:15 +0200
Message-Id: <1410032659-30404-2-git-send-email-hauke@hauke-m.de> (sfid-20140906_214440_510611_34924B23)
In-Reply-To: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
References: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This change was merge upstream in this commit:
commit 9baa3c34ac4e27f7e062f266f50cc5dbea26a6c1
Author: Benoit Taine <benoit.taine@lip6.fr>
Date:   Fri Aug 8 15:56:03 2014 +0200

    PCI: Remove DEFINE_PCI_DEVICE_TABLE macro use

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/67-fix-section-mismatch/INFO                      |  9 ---------
 .../drivers_net_wireless_ath_ath5k_led.patch                  | 11 -----------
 2 files changed, 20 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
 delete mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch

diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO b/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
deleted file mode 100644
index b545417..0000000
--- a/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
+++ /dev/null
@@ -1,9 +0,0 @@
-Without this patch backports will generate a section mismatch on kernel
-<= 3.3. This results in this error message:
-
-WARNING: drivers/net/wireless/ath/ath5k/ath5k.o(.text+0x157e8): Section mismatch in reference from the function ath5k_init_leds() to the variable .devinit.rodata:ath5k_led_devices
-The function ath5k_init_leds() references
-the variable __devinitconst ath5k_led_devices.
-This is often because ath5k_init_leds lacks a __devinitconst 
-annotation or the annotation of ath5k_led_devices is wrong.
-
diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
deleted file mode 100644
index 5b9583d..0000000
--- a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/led.c
-+++ b/drivers/net/wireless/ath/ath5k/led.c
-@@ -53,7 +53,7 @@
- #define ATH_POLARITY(data) ((data) & 0xff)
- 
- /* Devices we match on for LED config info (typically laptops) */
--static DEFINE_PCI_DEVICE_TABLE(ath5k_led_devices) = {
-+static const struct pci_device_id ath5k_led_devices[] = {
- 	/* AR5211 */
- 	{ PCI_VDEVICE(ATHEROS, PCI_DEVICE_ID_ATHEROS_AR5211), ATH_LED(0, 0) },
- 	/* HP Compaq nc6xx, nc4000, nx6000 */
-- 
1.9.1

