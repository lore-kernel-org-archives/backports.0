Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] compat-drivers: fix section mismatch in ath5k
Date: Wed,  9 Jan 2013 17:27:26 +0100
Message-Id: <1357748847-4095-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357748847-4095-1-git-send-email-hauke@hauke-m.de>
References: <1357748847-4095-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Fix section mismatch introduced by removing __devinitconst usage from
the kernel.

WARNING: /home/hauke/compat-wireless/compat-wireless/drivers/net/wireless/ath/ath5k/ath5k.o(.text+0x13898): Section mismatch in reference from the function ath5k_init_leds() to the variable .devinit.rodata:ath5k_led_devices
The function ath5k_init_leds() references
the variable __devinitconst ath5k_led_devices.
This is often because ath5k_init_leds lacks a __devinitconst
annotation or the annotation of ath5k_led_devices is wrong.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/67-fix-section-mismatch.patch                   |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch.patch

diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch.patch b/patches/collateral-evolutions/network/67-fix-section-mismatch.patch
new file mode 100644
index 0000000..15126b6
--- /dev/null
+++ b/patches/collateral-evolutions/network/67-fix-section-mismatch.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/ath/ath5k/led.c
++++ b/drivers/net/wireless/ath/ath5k/led.c
+@@ -55,7 +55,7 @@
+ #define ATH_POLARITY(data) ((data) & 0xff)
+ 
+ /* Devices we match on for LED config info (typically laptops) */
+-static DEFINE_PCI_DEVICE_TABLE(ath5k_led_devices) = {
++static const struct pci_device_id ath5k_led_devices[] = {
+ 	/* AR5211 */
+ 	{ PCI_VDEVICE(ATHEROS, PCI_DEVICE_ID_ATHEROS_AR5211), ATH_LED(0, 0) },
+ 	/* HP Compaq nc6xx, nc4000, nx6000 */
-- 
1.7.10.4
