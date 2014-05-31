Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56014 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id C3BCE7E5B
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:50 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/13] backports: add patch to prevent section mismatch again
Date: Sat, 31 May 2014 19:16:05 +0200
Message-Id: <1401556570-3363-9-git-send-email-hauke@hauke-m.de> (sfid-20140531_191654_068256_19D90D65)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch was removed in:
commit be4a0f9ad7e17670d7a30c9e94d5dd918425f90a
Author: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Date:   Fri Apr 11 01:45:20 2014 +0000

    backports: nuke support for kernels < 3.0

It is still needed for some still supported kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/67-fix-section-mismatch/INFO                      |  9 +++++++++
 .../drivers_net_wireless_ath_ath5k_led.patch                  | 11 +++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
 create mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch

diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO b/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
new file mode 100644
index 0000000..b545417
--- /dev/null
+++ b/patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
@@ -0,0 +1,9 @@
+Without this patch backports will generate a section mismatch on kernel
+<= 3.3. This results in this error message:
+
+WARNING: drivers/net/wireless/ath/ath5k/ath5k.o(.text+0x157e8): Section mismatch in reference from the function ath5k_init_leds() to the variable .devinit.rodata:ath5k_led_devices
+The function ath5k_init_leds() references
+the variable __devinitconst ath5k_led_devices.
+This is often because ath5k_init_leds lacks a __devinitconst 
+annotation or the annotation of ath5k_led_devices is wrong.
+
diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
new file mode 100644
index 0000000..5b9583d
--- /dev/null
+++ b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/ath/ath5k/led.c
++++ b/drivers/net/wireless/ath/ath5k/led.c
+@@ -53,7 +53,7 @@
+ #define ATH_POLARITY(data) ((data) & 0xff)
+ 
+ /* Devices we match on for LED config info (typically laptops) */
+-static DEFINE_PCI_DEVICE_TABLE(ath5k_led_devices) = {
++static const struct pci_device_id ath5k_led_devices[] = {
+ 	/* AR5211 */
+ 	{ PCI_VDEVICE(ATHEROS, PCI_DEVICE_ID_ATHEROS_AR5211), ATH_LED(0, 0) },
+ 	/* HP Compaq nc6xx, nc4000, nx6000 */
-- 
1.9.1

