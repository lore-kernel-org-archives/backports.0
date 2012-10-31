Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat-drivers: add ar5523 driver
Date: Wed, 31 Oct 2012 23:09:05 +0100
Message-Id: <1351721345-12336-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk               |    2 ++
 scripts/admin-update.sh |    1 +
 2 files changed, 3 insertions(+)

diff --git a/config.mk b/config.mk
index f743e05..7316d7b 100644
--- a/config.mk
+++ b/config.mk
@@ -519,6 +519,8 @@ export CONFIG_ATH9K_HTC=m
 
 export CONFIG_ATH6KL_USB=m
 
+export CONFIG_AR5523=m
+
 export CONFIG_BRCMFMAC_USB=y
 
 # RT2500USB does not require firmware
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 68a5b27..ec5592c 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -374,6 +374,7 @@ NET_BT_DIRS="net/bluetooth
 # Drivers that have their own directory
 DRIVERS_WLAN="drivers/net/wireless/ath
 	      drivers/net/wireless/ath/carl9170
+	      drivers/net/wireless/ath/ar5523
 	      drivers/net/wireless/ath/ath5k
 	      drivers/net/wireless/ath/ath6kl
 	      drivers/net/wireless/ath/ath9k
-- 
1.7.10.4
