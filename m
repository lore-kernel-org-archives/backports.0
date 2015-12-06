Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37437 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbbLFNSf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/12] copy: adapt to moving of wifi drivers into vendor directories
Date: Sun,  6 Dec 2015 14:18:19 +0100
Message-Id: <1449407908-15547-4-git-send-email-hauke@hauke-m.de> (sfid-20151206_141839_535946_D38E2ADA)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This also adds the hostap wifi driver to backports.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list                                          | 38 ++++++----------------
 .../0005-uapi-compromise/mwifiex.patch             |  8 ++---
 .../drivers_net_wireless_cw1200_sdio.patch         |  4 +--
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |  4 +--
 .../drivers_net_wireless_libertas_if_usb.patch     |  4 +--
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch   |  4 +--
 .../network/0028-select_queue/mwifiex.patch        |  4 +--
 .../network/0055-name_assign_type/brcmfmac.patch   |  6 ++--
 8 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/copy-list b/copy-list
index 0c77d99..bd99364 100644
--- a/copy-list
+++ b/copy-list
@@ -56,41 +56,23 @@ drivers/ssb/
 include/linux/ssb/
 drivers/bcma/
 include/linux/bcma/
-drivers/net/wireless/airo.c
-drivers/net/wireless/airo_cs.c
-drivers/net/wireless/airo.h
-drivers/net/wireless/atmel.c
-drivers/net/wireless/atmel_cs.c
-drivers/net/wireless/atmel.h
-drivers/net/wireless/atmel_pci.c
-drivers/net/wireless/b43/
-drivers/net/wireless/b43legacy/
-drivers/net/wireless/brcm80211/
-drivers/net/wireless/cw1200/
-drivers/net/wireless/iwlegacy/
-drivers/net/wireless/iwlwifi/
-drivers/net/wireless/rt2x00/
-drivers/net/wireless/zd1211rw/
-drivers/net/wireless/libertas/
-drivers/net/wireless/p54/
+drivers/net/wireless/cisco/
+drivers/net/wireless/atmel/
+drivers/net/wireless/broadcom/
+drivers/net/wireless/st/
+drivers/net/wireless/intel/
+drivers/net/wireless/ralink/
+drivers/net/wireless/zydas/
+drivers/net/wireless/marvell/
+drivers/net/wireless/intersil/
 drivers/net/wireless/realtek/
-drivers/net/wireless/libertas_tf/
-drivers/net/wireless/ipw2x00/
 drivers/net/wireless/ti/
-drivers/net/wireless/orinoco/
 drivers/net/wireless/mediatek/
-drivers/net/wireless/mwifiex/
-drivers/net/wireless/adm8211.c
-drivers/net/wireless/adm8211.h
-drivers/net/wireless/at76c50x-usb.c
-drivers/net/wireless/at76c50x-usb.h
+drivers/net/wireless/admtek/
 drivers/net/wireless/mac80211_hwsim.c
 drivers/net/wireless/mac80211_hwsim.h
-drivers/net/wireless/mwl8k.c
 drivers/net/wireless/rsi/
 drivers/net/wireless/rndis_wlan.c
-drivers/net/wireless/zd1201.c
-drivers/net/wireless/zd1201.h
 # rndis also requires some of the USB networking
 drivers/net/usb/Makefile
 drivers/net/usb/Kconfig
diff --git a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
index 717088d..c5d2a9a 100644
--- a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
+++ b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/mwifiex/decl.h
-+++ b/drivers/net/wireless/mwifiex/decl.h
+--- a/drivers/net/wireless/marvell/mwifiex/decl.h
++++ b/drivers/net/wireless/marvell/mwifiex/decl.h
 @@ -26,7 +26,7 @@
  #include <linux/wait.h>
  #include <linux/timer.h>
@@ -9,8 +9,8 @@
  #include <net/mac80211.h>
  
  #define MWIFIEX_BSS_COEX_COUNT	     2
---- a/drivers/net/wireless/mwifiex/sta_rx.c
-+++ b/drivers/net/wireless/mwifiex/sta_rx.c
+--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
++++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
 @@ -17,7 +17,7 @@
   * this warranty disclaimer.
   */
diff --git a/patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
index 0e18379..b7447c5 100644
--- a/patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/cw1200/cw1200_sdio.c
-+++ b/drivers/net/wireless/cw1200/cw1200_sdio.c
+--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
++++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
 @@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(str
  	else
  		size = sdio_align_size(self->func, size);
diff --git a/patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
index d000d91..922e1a0 100644
--- a/patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ b/patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/ipw2x00/ipw2100.c
-+++ b/drivers/net/wireless/ipw2x00/ipw2100.c
+--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
++++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
 @@ -175,7 +175,11 @@ that only one external action is invoked
  #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
  #define DRV_COPYRIGHT	"Copyright(c) 2003-2006 Intel Corporation"
diff --git a/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 229c5f7..e197d42 100644
--- a/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/libertas/if_usb.c
-+++ b/drivers/net/wireless/libertas/if_usb.c
+--- a/drivers/net/wireless/marvell/libertas/if_usb.c
++++ b/drivers/net/wireless/marvell/libertas/if_usb.c
 @@ -959,6 +959,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
diff --git a/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
index 2c6c660..dba0a1d 100644
--- a/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ b/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/iwlwifi/iwl-debug.c
-+++ b/drivers/net/wireless/iwlwifi/iwl-debug.c
+--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
++++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
 @@ -74,13 +74,16 @@ void __iwl_ ##fn(struct device *dev, con
  	struct va_format vaf = {				\
  		.fmt = fmt,					\
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 084771a..5376d33 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/mwifiex/main.c
-+++ b/drivers/net/wireless/mwifiex/main.c
+--- a/drivers/net/wireless/marvell/mwifiex/main.c
++++ b/drivers/net/wireless/marvell/mwifiex/main.c
 @@ -1185,9 +1185,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index c68e9d0..12f5586 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
---- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
-+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
-@@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+@@ -2197,7 +2197,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
