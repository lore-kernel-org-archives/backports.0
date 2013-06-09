Return-path: <backports-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:2571 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab3FITh4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 9 Jun 2013 15:37:56 -0400
From: "Arend van Spriel" <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
cc: backports@vger.kernel.org, "Arend van Spriel" <arend@broadcom.com>
Subject: [PATCH] compat-drivers: do not disable bcma when selecting
 brcmsmac
Date: Sun, 9 Jun 2013 21:37:39 +0200
Message-ID: <1370806659-2875-1-git-send-email-arend@broadcom.com> (sfid-20130609_213801_910088_09FD4FE7)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The brcmsmac driver depends on the bcma bus driver these days. However,
the driver-select script disabled bcma when selecting brcmsmac (or
the brcm80211 driver group). This leads to mismatch between kernel
bcma and backport brcmsmac. For the 3.9 backport this result in:

[10298.323094] brcmsmac: Unknown symbol bcma_pmu_spuravoid_pllupdate (err 0)

as this function was added to bcma.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 scripts/driver-select |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/driver-select b/scripts/driver-select
index 862f43b..c6afdfc 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -408,7 +408,10 @@ case $1 in
 		;;
 	brcm80211)
 		disable_staging
-		disable_bt_usb_ethernet_var
+		disable_bt_usb_ethernet
+		disable_ssb
+		disable_eeprom
+		disable_lib80211
 		select_drivers		CONFIG_BRCMUTIL \
 					CONFIG_BRCMFMAC \
 					CONFIG_BRCMSMAC
@@ -465,13 +468,17 @@ case $1 in
 		;;
 	brcmsmac)
 		disable_staging
-		disable_bt_usb_ethernet_var
+		disable_bt_usb_ethernet
+		disable_ssb
+		disable_eeprom
+		disable_lib80211
 		select_drivers		CONFIG_BRCMSMAC
 		select_brcm80211_driver	CONFIG_BRCMSMAC CONFIG_BRCMUTIL
 		;;
 	brcmfmac)
 		disable_staging
 		disable_bt_usb_ethernet_var
+		disable_lib80211
 		select_drivers		CONFIG_BRCMFMAC
 		select_brcm80211_driver	CONFIG_BRCMFMAC CONFIG_BRCMUTIL
 		;;
-- 
1.7.10.4


