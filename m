Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34466 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964789Ab2HPQMF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 12:12:05 -0400
Received: by wibhr14 with SMTP id hr14so849207wib.1
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 09:12:03 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/2] compat-drivers: List everything vertically without concatenating
Date: Thu, 16 Aug 2012 19:11:52 +0300
Message-Id: <1345133513-4592-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This looks much readable. No functional change.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 146 +++++++++++++++++++++++++++++-------------------
 1 file changed, 87 insertions(+), 59 deletions(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 0b09708..bf5fb8e 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -266,68 +266,93 @@ else
 fi
 
 # Now define what files to copy from $GIT_URL
-INCLUDE_NET_BT="hci_core.h l2cap.h bluetooth.h rfcomm.h hci.h hci_mon.h mgmt.h sco.h smp.h a2mp.h"
-NET_BT_DIRS="bluetooth bluetooth/bnep bluetooth/cmtp bluetooth/rfcomm bluetooth/hidp"
-
-INCLUDE_LINUX="ieee80211.h nl80211.h"
-INCLUDE_LINUX="$INCLUDE_LINUX pci_ids.h eeprom_93cx6.h"
-INCLUDE_LINUX="$INCLUDE_LINUX ath9k_platform.h"
-INCLUDE_LINUX="$INCLUDE_LINUX wl12xx.h"
-INCLUDE_LINUX="$INCLUDE_LINUX rndis.h"
+INCLUDE_NET_BT="hci_core.h
+		l2cap.h
+		bluetooth.h
+		rfcomm.h
+		hci.h
+		hci_mon.h
+		mgmt.h
+		sco.h
+		smp.h
+		a2mp.h"
+
+# Bluetooth related directories
+NET_BT_DIRS="bluetooth
+	     bluetooth/bnep
+	     bluetooth/cmtp
+	     bluetooth/rfcomm
+	     bluetooth/hidp"
+
+# Required headers from include/linux
+INCLUDE_LINUX="ieee80211.h
+	       nl80211.h
+	       pci_ids.h
+	       eeprom_93cx6.h
+	       ath9k_platform.h
+	       wl12xx.h
+	       rndis.h"
 
 # For rndis_wext
-INCLUDE_LINUX_USB="usbnet.h rndis_host.h"
+INCLUDE_LINUX_USB="usbnet.h
+		   rndis_host.h"
 
 INCLUDE_LINUX_SPI="libertas_spi.h"
 
-# The good new yummy stuff
-INCLUDE_NET="cfg80211.h ieee80211_radiotap.h cfg80211-wext.h"
-INCLUDE_NET="$INCLUDE_NET mac80211.h lib80211.h regulatory.h"
+# 802.11 related headers
+INCLUDE_NET="cfg80211.h
+	     cfg80211-wext.h
+	     ieee80211_radiotap.h
+	     lib80211.h
+	     mac80211.h
+	     regulatory.h"
 
-NET_DIRS="wireless mac80211 rfkill"
+NET_DIRS="wireless
+	  mac80211
+	  rfkill"
 
 # Drivers that have their own directory
-DRIVERS="drivers/net/wireless/ath"
-DRIVERS="$DRIVERS drivers/net/wireless/ath/carl9170"
-DRIVERS="$DRIVERS drivers/net/wireless/ath/ath5k"
-DRIVERS="$DRIVERS drivers/net/wireless/ath/ath6kl"
-DRIVERS="$DRIVERS drivers/net/wireless/ath/ath9k"
-DRIVERS="$DRIVERS drivers/ssb"
-DRIVERS="$DRIVERS drivers/bcma"
-DRIVERS="$DRIVERS drivers/net/wireless/b43"
-DRIVERS="$DRIVERS drivers/net/wireless/b43legacy"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211/brcmfmac"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211/brcmsmac"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211/brcmsmac/phy"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211/brcmutil"
-DRIVERS="$DRIVERS drivers/net/wireless/brcm80211/include"
-DRIVERS="$DRIVERS drivers/net/wireless/iwlegacy"
-DRIVERS="$DRIVERS drivers/net/wireless/iwlwifi"
-DRIVERS="$DRIVERS drivers/net/wireless/iwlwifi/pcie"
-DRIVERS="$DRIVERS drivers/net/wireless/iwlwifi/dvm"
-DRIVERS="$DRIVERS drivers/net/wireless/rt2x00"
-DRIVERS="$DRIVERS drivers/net/wireless/zd1211rw"
-DRIVERS="$DRIVERS drivers/net/wireless/libertas"
-DRIVERS="$DRIVERS drivers/net/wireless/p54"
-DRIVERS="$DRIVERS drivers/net/wireless/rtl818x"
-DRIVERS="$DRIVERS drivers/net/wireless/rtl818x/rtl8180"
-DRIVERS="$DRIVERS drivers/net/wireless/rtl818x/rtl8187"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi/rtl8192c"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi/rtl8192ce"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi/rtl8192cu"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi/rtl8192se"
-DRIVERS="$DRIVERS drivers/net/wireless/rtlwifi/rtl8192de"
-DRIVERS="$DRIVERS drivers/net/wireless/libertas_tf"
-DRIVERS="$DRIVERS drivers/net/wireless/ipw2x00"
-DRIVERS="$DRIVERS drivers/net/wireless/ti"
-DRIVERS="$DRIVERS drivers/net/wireless/ti/wl12xx"
-DRIVERS="$DRIVERS drivers/net/wireless/ti/wl1251"
-DRIVERS="$DRIVERS drivers/net/wireless/ti/wlcore"
-DRIVERS="$DRIVERS drivers/net/wireless/ti/wl18xx"
-DRIVERS="$DRIVERS drivers/net/wireless/orinoco"
-DRIVERS="$DRIVERS drivers/net/wireless/mwifiex"
+DRIVERS="drivers/net/wireless/ath
+	 drivers/net/wireless/ath/carl9170
+	 drivers/net/wireless/ath/ath5k
+	 drivers/net/wireless/ath/ath6kl
+	 drivers/net/wireless/ath/ath9k
+	 drivers/ssb
+	 drivers/bcma
+	 drivers/net/wireless/b43
+	 drivers/net/wireless/b43legacy
+	 drivers/net/wireless/brcm80211
+	 drivers/net/wireless/brcm80211/brcmfmac
+	 drivers/net/wireless/brcm80211/brcmsmac
+	 drivers/net/wireless/brcm80211/brcmsmac/phy
+	 drivers/net/wireless/brcm80211/brcmutil
+	 drivers/net/wireless/brcm80211/include
+	 drivers/net/wireless/iwlegacy
+	 drivers/net/wireless/iwlwifi
+	 drivers/net/wireless/iwlwifi/pcie
+	 drivers/net/wireless/iwlwifi/dvm
+	 drivers/net/wireless/rt2x00
+	 drivers/net/wireless/zd1211rw
+	 drivers/net/wireless/libertas
+	 drivers/net/wireless/p54
+	 drivers/net/wireless/rtl818x
+	 drivers/net/wireless/rtl818x/rtl8180
+	 drivers/net/wireless/rtl818x/rtl8187
+	 drivers/net/wireless/rtlwifi
+	 drivers/net/wireless/rtlwifi/rtl8192c
+	 drivers/net/wireless/rtlwifi/rtl8192ce
+	 drivers/net/wireless/rtlwifi/rtl8192cu
+	 drivers/net/wireless/rtlwifi/rtl8192se
+	 drivers/net/wireless/rtlwifi/rtl8192de
+	 drivers/net/wireless/libertas_tf
+	 drivers/net/wireless/ipw2x00
+	 drivers/net/wireless/ti
+	 drivers/net/wireless/ti/wl12xx
+	 drivers/net/wireless/ti/wl1251
+	 drivers/net/wireless/ti/wlcore
+	 drivers/net/wireless/ti/wl18xx
+	 drivers/net/wireless/orinoco
+	 drivers/net/wireless/mwifiex"
 
 # Staging drivers
 STAGING_DRIVERS=""
@@ -343,11 +368,14 @@ DRIVERS="$DRIVERS drivers/net/ethernet/atheros/alx"
 DRIVERS_BT="drivers/bluetooth"
 
 # Drivers that belong the the wireless directory
-DRIVER_FILES="adm8211.c  adm8211.h"
-DRIVER_FILES="$DRIVER_FILES rndis_wlan.c"
-DRIVER_FILES="$DRIVER_FILES mac80211_hwsim.c mac80211_hwsim.h"
-DRIVER_FILES="$DRIVER_FILES at76c50x-usb.c at76c50x-usb.h"
-DRIVER_FILES="$DRIVER_FILES mwl8k.c"
+DRIVER_FILES="adm8211.c
+	      adm8211.h
+	      at76c50x-usb.c
+	      at76c50x-usb.h
+	      mac80211_hwsim.c
+	      mac80211_hwsim.h
+	      mwl8k.c
+	      rndis_wlan.c"
 
 rm -rf drivers/
 
-- 
1.7.11.2

