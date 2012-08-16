Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50441 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab2HPR0V (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2012 13:26:21 -0400
Received: by weyx8 with SMTP id x8so1893130wey.19
        for <backports@vger.kernel.org>; Thu, 16 Aug 2012 10:26:19 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/2] compat-drivers: Add ability to select drivers to fetch
Date: Thu, 16 Aug 2012 20:26:10 +0300
Message-Id: <1345137971-12169-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add a last command line parameter to define which subsystems will
be fetched into the tree.

Currently the script supports network and/or drm keywords as the
last argument.

network is currently enabled by default to retain compatibility with
the previous compat-wireless tree.

Move around code and use the previously added 2 helper functions
to copy files/folders conditionally, according to the values of
ENABLE_NETWORK (and ENABLE_DRM which will follow).

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/admin-update.sh | 378 +++++++++++++++++++++---------------------------
 1 file changed, 163 insertions(+), 215 deletions(-)

diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 69b5287..4828efa 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -74,7 +74,8 @@ patchRefresh() {
 # usage() function
 ###
 usage() {
-	printf "Usage: $0 [refresh] [ --help | -h | -s | -n | -p | -c ]\n"
+	printf "Usage: $0 [refresh] [ --help | -h | -s | -n | -p | -c ] [subsystems]
+       where subsystems can be network, drm or both. Network is enabled by default.\n\n"
 
 	printf "${GREEN}%10s${NORMAL} - Update all your patch offsets using quilt\n" "refresh"
 	printf "${GREEN}%10s${NORMAL} - Get and apply pending-stable/ fixes purging old files there\n" "-s"
@@ -186,22 +187,29 @@ copyDirectories() {
 #
 # Release tags (with corresponding cmdline switches):
 # ---------------------------------------------------
-# 	s: Include pending-stable/*.patch		(-s)
-# 	n: Include linux-next-cherry-picks/*.patch	(-n)
-# 	p: Include linux-next-pending/*.patch		(-p)
-# 	c: Include crap/*.patch				(-c)
-# Note that the patches under patches/ are applied by default.
+# 	s: Include pending-stable/ patches		(-s)
+# 	n: Include linux-next-cherry-picks/ patches	(-n)
+# 	p: Include linux-next-pending/ patches		(-p)
+# 	c: Include crap/ patches			(-c)
+# Note that the patches under patches/{subsystem} are applied by default.
 #
 # If "refresh" is given as a cmdline argument, the script
 # uses quilt to refresh the patches. This is useful if patches
 # can not be applied correctly after a code update in $GIT_URL.
+#
+# A final parameter drm, wlan or both determines which subsystem
+# drivers will be fetched in from the GIT repository. To retain
+# compatibility with compat-wireless, wlan/bt/eth drivers are
+# fetched in by default.
+ENABLE_NETWORK=1
+ENABLE_DRM=0
 
 EXTRA_PATCHES="patches"
 REFRESH="n"
 GET_STABLE_PENDING="n"
 POSTFIX_RELEASE_TAG=""
 if [ $# -ge 1 ]; then
-	if [ $# -gt 4 ]; then
+	if [ $# -gt 6 ]; then
 		usage $0
 		exit
 	fi
@@ -233,6 +241,14 @@ if [ $# -ge 1 ]; then
 				REFRESH="y"
 				shift
 				;;
+			"network")
+				ENABLE_NETWORK=1
+				shift
+				;;
+			"drm")
+				ENABLE_DRM=1
+				shift
+				;;
 			"-h" | "--help")
 				usage $0
 				exit
@@ -298,27 +314,27 @@ INCLUDE_NET_BT="hci_core.h
 		smp.h
 		a2mp.h"
 
-# Bluetooth related directories
-NET_BT_DIRS="bluetooth
-	     bluetooth/bnep
-	     bluetooth/cmtp
-	     bluetooth/rfcomm
-	     bluetooth/hidp"
-
-# Required headers from include/linux
-INCLUDE_LINUX="ieee80211.h
-	       nl80211.h
-	       pci_ids.h
-	       eeprom_93cx6.h
-	       ath9k_platform.h
-	       wl12xx.h
-	       rndis.h"
+# Required wlan headers from include/linux
+INCLUDE_LINUX_WLAN="ieee80211.h
+		    nl80211.h
+		    pci_ids.h
+		    eeprom_93cx6.h
+		    ath9k_platform.h
+		    wl12xx.h
+		    rndis.h"
 
 # For rndis_wext
-INCLUDE_LINUX_USB="usbnet.h
-		   rndis_host.h"
+INCLUDE_LINUX_USB_WLAN="usbnet.h
+		        rndis_host.h"
 
-INCLUDE_LINUX_SPI="libertas_spi.h"
+# For rndis_wlan, we need a new rndis_host.ko, cdc_ether.ko and usbnet.ko
+RNDIS_REQUIREMENTS="Makefile
+		    rndis_host.c
+		    cdc_ether.c
+		    usbnet.c"
+
+# For libertas driver
+INCLUDE_LINUX_LIBERTAS_WLAN="libertas_spi.h"
 
 # 802.11 related headers
 INCLUDE_NET="cfg80211.h
@@ -328,178 +344,142 @@ INCLUDE_NET="cfg80211.h
 	     mac80211.h
 	     regulatory.h"
 
-NET_DIRS="wireless
-	  mac80211
-	  rfkill"
+# Network related directories
+NET_WLAN_DIRS="net/wireless
+	       net/mac80211
+	       net/rfkill"
+
+# Bluetooth related directories
+NET_BT_DIRS="net/bluetooth
+	     net/bluetooth/bnep
+	     net/bluetooth/cmtp
+	     net/bluetooth/rfcomm
+	     net/bluetooth/hidp"
 
 # Drivers that have their own directory
-DRIVERS="drivers/net/wireless/ath
-	 drivers/net/wireless/ath/carl9170
-	 drivers/net/wireless/ath/ath5k
-	 drivers/net/wireless/ath/ath6kl
-	 drivers/net/wireless/ath/ath9k
-	 drivers/ssb
-	 drivers/bcma
-	 drivers/net/wireless/b43
-	 drivers/net/wireless/b43legacy
-	 drivers/net/wireless/brcm80211
-	 drivers/net/wireless/brcm80211/brcmfmac
-	 drivers/net/wireless/brcm80211/brcmsmac
-	 drivers/net/wireless/brcm80211/brcmsmac/phy
-	 drivers/net/wireless/brcm80211/brcmutil
-	 drivers/net/wireless/brcm80211/include
-	 drivers/net/wireless/iwlegacy
-	 drivers/net/wireless/iwlwifi
-	 drivers/net/wireless/iwlwifi/pcie
-	 drivers/net/wireless/iwlwifi/dvm
-	 drivers/net/wireless/rt2x00
-	 drivers/net/wireless/zd1211rw
-	 drivers/net/wireless/libertas
-	 drivers/net/wireless/p54
-	 drivers/net/wireless/rtl818x
-	 drivers/net/wireless/rtl818x/rtl8180
-	 drivers/net/wireless/rtl818x/rtl8187
-	 drivers/net/wireless/rtlwifi
-	 drivers/net/wireless/rtlwifi/rtl8192c
-	 drivers/net/wireless/rtlwifi/rtl8192ce
-	 drivers/net/wireless/rtlwifi/rtl8192cu
-	 drivers/net/wireless/rtlwifi/rtl8192se
-	 drivers/net/wireless/rtlwifi/rtl8192de
-	 drivers/net/wireless/libertas_tf
-	 drivers/net/wireless/ipw2x00
-	 drivers/net/wireless/ti
-	 drivers/net/wireless/ti/wl12xx
-	 drivers/net/wireless/ti/wl1251
-	 drivers/net/wireless/ti/wlcore
-	 drivers/net/wireless/ti/wl18xx
-	 drivers/net/wireless/orinoco
-	 drivers/net/wireless/mwifiex"
+DRIVERS_WLAN="drivers/net/wireless/ath
+	      drivers/net/wireless/ath/carl9170
+	      drivers/net/wireless/ath/ath5k
+	      drivers/net/wireless/ath/ath6kl
+	      drivers/net/wireless/ath/ath9k
+	      drivers/ssb
+	      drivers/bcma
+	      drivers/net/wireless/b43
+	      drivers/net/wireless/b43legacy
+	      drivers/net/wireless/brcm80211
+	      drivers/net/wireless/brcm80211/brcmfmac
+	      drivers/net/wireless/brcm80211/brcmsmac
+	      drivers/net/wireless/brcm80211/brcmsmac/phy
+	      drivers/net/wireless/brcm80211/brcmutil
+	      drivers/net/wireless/brcm80211/include
+	      drivers/net/wireless/iwlegacy
+	      drivers/net/wireless/iwlwifi
+	      drivers/net/wireless/iwlwifi/pcie
+	      drivers/net/wireless/iwlwifi/dvm
+	      drivers/net/wireless/rt2x00
+	      drivers/net/wireless/zd1211rw
+	      drivers/net/wireless/libertas
+	      drivers/net/wireless/p54
+	      drivers/net/wireless/rtl818x
+	      drivers/net/wireless/rtl818x/rtl8180
+	      drivers/net/wireless/rtl818x/rtl8187
+	      drivers/net/wireless/rtlwifi
+	      drivers/net/wireless/rtlwifi/rtl8192c
+	      drivers/net/wireless/rtlwifi/rtl8192ce
+	      drivers/net/wireless/rtlwifi/rtl8192cu
+	      drivers/net/wireless/rtlwifi/rtl8192se
+	      drivers/net/wireless/rtlwifi/rtl8192de
+	      drivers/net/wireless/libertas_tf
+	      drivers/net/wireless/ipw2x00
+	      drivers/net/wireless/ti
+	      drivers/net/wireless/ti/wl12xx
+	      drivers/net/wireless/ti/wl1251
+	      drivers/net/wireless/ti/wlcore
+	      drivers/net/wireless/ti/wl18xx
+	      drivers/net/wireless/orinoco
+	      drivers/net/wireless/mwifiex"
 
 # Staging drivers
 STAGING_DRIVERS=""
 
-# Ethernet drivers
-DRIVERS="$DRIVERS drivers/net/ethernet/atheros"
-DRIVERS="$DRIVERS drivers/net/ethernet/atheros/atl1c"
-DRIVERS="$DRIVERS drivers/net/ethernet/atheros/atl1e"
-DRIVERS="$DRIVERS drivers/net/ethernet/atheros/atlx"
-DRIVERS="$DRIVERS drivers/net/ethernet/atheros/alx"
+# Ethernet drivers having their own directory
+DRIVERS_ETH="drivers/net/ethernet/atheros
+	     drivers/net/ethernet/atheros/atl1c
+	     drivers/net/ethernet/atheros/atl1e
+	     drivers/net/ethernet/atheros/atlx
+	     drivers/net/ethernet/atheros/alx"
 
 # Bluetooth drivers
 DRIVERS_BT="drivers/bluetooth"
 
 # Drivers that belong the the wireless directory
-DRIVER_FILES="adm8211.c
-	      adm8211.h
-	      at76c50x-usb.c
-	      at76c50x-usb.h
-	      mac80211_hwsim.c
-	      mac80211_hwsim.h
-	      mwl8k.c
-	      rndis_wlan.c"
+DRIVERS_WLAN_FILES="adm8211.c
+		    adm8211.h
+		    at76c50x-usb.c
+		    at76c50x-usb.h
+		    mac80211_hwsim.c
+		    mac80211_hwsim.h
+		    mwl8k.c
+		    rndis_wlan.c"
 
 rm -rf drivers/
 
-mkdir -p include/linux/ \
-	include/net/ \
-	include/net/bluetooth \
-	include/linux/usb \
-	include/linux/unaligned \
-	include/linux/spi \
-	include/trace \
-	include/pcmcia \
-	include/crypto \
-	net/mac80211/ \
-	net/wireless/ \
-	net/rfkill/ \
-	drivers/ssb/ \
-	drivers/bcma/ \
-	drivers/net/usb/ \
-	drivers/net/wireless/ \
-	drivers/net/ethernet/atheros \
-	drivers/net/ethernet/broadcom
-
-# include/linux
-DIR="include/linux"
-for i in $INCLUDE_LINUX; do
-	echo "Copying $GIT_TREE/$DIR/$i"
-	cp "$GIT_TREE/$DIR/$i" $DIR/
-done
-
-cp -a $GIT_TREE/include/linux/ssb include/linux/
-cp -a $GIT_TREE/include/linux/bcma include/linux/
-cp -a $GIT_TREE/include/linux/rfkill.h include/linux/rfkill_backport.h
-
-# include/net
-DIR="include/net"
-for i in $INCLUDE_NET; do
-	echo "Copying $GIT_TREE/$DIR/$i"
-	cp "$GIT_TREE/$DIR/$i" $DIR/
-done
-
-DIR="include/net/bluetooth"
-for i in $INCLUDE_NET_BT; do
-  echo "Copying $GIT_TREE/$DIR/$i"
-  cp $GIT_TREE/$DIR/$i $DIR/
-done
-
-DIR="include/linux/usb"
-for i in $INCLUDE_LINUX_USB; do
-	echo "Copying $GIT_TREE/$DIR/$i"
-	cp $GIT_TREE/$DIR/$i $DIR/
-done
-
-DIR="include/linux/spi"
-for i in $INCLUDE_LINUX_SPI; do
-	echo "Copying $GIT_TREE/$DIR/$i"
-	cp $GIT_TREE/$DIR/$i $DIR/
-done
-
-# net/wireless and net/mac80211
-for i in $NET_DIRS; do
-	echo "Copying $GIT_TREE/net/$i/*.[ch]"
-	cp $GIT_TREE/net/$i/*.[ch] net/$i/
-	cp $GIT_TREE/net/$i/Makefile net/$i/
-	cp $GIT_TREE/net/$i/Kconfig net/$i/
-done
-
-cp $GIT_TREE/MAINTAINERS ./
-
-# Copy files needed for statically compiled regulatory rules database
-cp $GIT_TREE/net/wireless/db.txt net/wireless/
-cp $GIT_TREE/net/wireless/genregdb.awk net/wireless/
-
-# net/bluetooth
-for i in $NET_BT_DIRS; do
-	mkdir -p net/$i
-	echo "Copying $GIT_TREE/net/$i/*.[ch]"
-	cp $GIT_TREE/net/$i/*.[ch] net/$i/
-	cp $GIT_TREE/net/$i/Makefile net/$i/
-done
-
-# Drivers in their own directory
-for i in $DRIVERS; do
-	mkdir -p $i
-
-	# -print -quit will just print once, so we don't burden
-	# this script with searching for further files if one is
-	# found
-	FILES_FOUND=$(find $GIT_TREE/$i/ -maxdepth 1 -type f -name \*.[ch] -print -quit | wc -l)
-	if [ $FILES_FOUND -eq 1 ]; then
-		echo "Copying $GIT_TREE/$i/*.[ch]"
-		cp $GIT_TREE/$i/*.[ch] $i/
-	fi
-	if [ -f $GIT_TREE/$i/Makefile ]; then
-		cp $GIT_TREE/$i/Makefile $i/
-	fi
-	if [ -f $GIT_TREE/$i/Kconfig ]; then
-		cp $GIT_TREE/$i/Kconfig $i/
-	fi
-done
+mkdir -p include/net/bluetooth \
+	 include/linux/usb \
+	 include/linux/unaligned \
+	 include/linux/spi \
+	 include/trace \
+	 include/pcmcia \
+	 include/crypto \
+	 drivers/bcma \
+	 drivers/misc/eeprom \
+	 drivers/net/usb \
+	 drivers/net/ethernet/broadcom \
+	 drivers/ssb \
+	 drivers/staging \
+	 $NET_WLAN_DIRS \
+	 $NET_BT_DIRS \
+	 $DRIVERS_WLAN \
+	 $DRIVERS_ETH \
+	 $DRIVERS_BT
+
+if [[ -n "$ENABLE_NETWORK" ]]; then
+	# WLAN and bluetooth files
+	copyFiles "$INCLUDE_LINUX_WLAN"			"include/linux"
+	copyFiles "$INCLUDE_NET"			"include/net"
+	copyFiles "$INCLUDE_NET_BT" 			"include/net/bluetooth"
+	copyFiles "$INCLUDE_LINUX_USB_WLAN"		"include/linux/usb"
+	copyFiles "$INCLUDE_LINUX_LIBERTAS_WLAN"	"include/linux/spi"
+	copyFiles "$DRIVERS_WLAN_FILES"			"drivers/net/wireless"
+	copyFiles "$RNDIS_REQUIREMENTS"			"drivers/net/usb"
+
+	copyDirectories "$NET_WLAN_DIRS"
+	copyDirectories "$NET_BT_DIRS"
+	copyDirectories "$DRIVERS_BT"
+	copyDirectories "$DRIVERS_WLAN"
+	copyDirectories "$DRIVERS_ETH"
+
+	cp -a $GIT_TREE/include/linux/ssb include/linux/
+	cp -a $GIT_TREE/include/linux/bcma include/linux/
+	cp -a $GIT_TREE/include/linux/rfkill.h include/linux/rfkill_backport.h
+
+	# Misc
+	cp $GIT_TREE/drivers/misc/eeprom/{Makefile,eeprom_93cx6.c} drivers/misc/eeprom/
+
+	# Copy files needed for statically compiled regulatory rules database
+	cp $GIT_TREE/net/wireless/{db.txt,genregdb.awk} net/wireless/
+
+	# Top level wireless driver Makefile
+	cp $GIT_TREE/drivers/net/wireless/Makefile drivers/net/wireless
+
+	# Broadcom case
+	DIR="drivers/net/ethernet/broadcom"
+	cp $GIT_TREE/$DIR/b44.[ch] drivers/net/ethernet/broadcom
+	# Not yet
+	echo "obj-\$(CONFIG_B44) += b44.o" > drivers/net/ethernet/broadcom/Makefile
+fi
 
 # Staging drivers in their own directory
-rm -rf drivers/staging/
-mkdir -p drivers/staging/
 for i in $STAGING_DRIVERS; do
 	if [ ! -d $GIT_TREE/$i ]; then
 		continue
@@ -510,40 +490,8 @@ for i in $STAGING_DRIVERS; do
 	cp -a $GIT_TREE/$i drivers/staging/
 done
 
-for i in $DRIVERS_BT; do
-	mkdir -p $i
-	echo "Copying $GIT_TREE/$i/*.[ch]"
-	cp $GIT_TREE/$i/*.[ch] $i/
-	cp $GIT_TREE/$i/Makefile $i/
-done
-
-# For rndis_wlan, we need a new rndis_host.ko, cdc_ether.ko and usbnet.ko
-RNDIS_REQS="Makefile rndis_host.c cdc_ether.c usbnet.c"
-DIR="drivers/net/usb"
-for i in $RNDIS_REQS; do
-	echo "Copying $GIT_TREE/$DIR/$i"
-	cp $GIT_TREE/$DIR/$i $DIR/
-done
-
-DIR="drivers/net/ethernet/broadcom"
-echo > $DIR/Makefile
-cp $GIT_TREE/$DIR/b44.[ch] $DIR
-# Not yet
-echo "obj-\$(CONFIG_B44) += b44.o" >> $DIR/Makefile
-
-# Misc
-mkdir -p drivers/misc/eeprom/
-cp $GIT_TREE/drivers/misc/eeprom/eeprom_93cx6.c drivers/misc/eeprom/
-cp $GIT_TREE/drivers/misc/eeprom/Makefile drivers/misc/eeprom/
-
-DIR="drivers/net/wireless"
-# Drivers part of the wireless directory
-for i in $DRIVER_FILES; do
-	cp $GIT_TREE/$DIR/$i $DIR/
-done
-
-# Top level wireless driver Makefile
-cp $GIT_TREE/$DIR/Makefile $DIR
+# Finally copy MAINTAINERS file
+cp $GIT_TREE/MAINTAINERS ./
 
 # Compat stuff
 COMPAT="compat"
-- 
1.7.11.2

