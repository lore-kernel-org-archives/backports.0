Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56145 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757351AbcGJVPE (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/19] defconfig: update defconfigs, some options changed in the kernel.
Date: Sun, 10 Jul 2016 23:14:45 +0200
Message-Id: <1468185285-28265-20-git-send-email-hauke@hauke-m.de> (sfid-20160711_013912_700993_B96F4BA8)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/ar5523      |  2 +-
 backport/defconfigs/ath10k      |  2 +-
 backport/defconfigs/ath5k       |  2 +-
 backport/defconfigs/ath6kl      |  2 +-
 backport/defconfigs/ath9k       |  2 +-
 backport/defconfigs/ath9k-debug |  2 +-
 backport/defconfigs/carl9170    |  2 +-
 backport/defconfigs/media       |  5 -----
 backport/defconfigs/wcn36xx     |  2 +-
 backport/defconfigs/wifi        | 18 +++++++++++++++---
 backport/defconfigs/wil6210     |  2 +-
 11 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/backport/defconfigs/ar5523 b/backport/defconfigs/ar5523
index b218d9a..101c3a2 100644
--- a/backport/defconfigs/ar5523
+++ b/backport/defconfigs/ar5523
@@ -4,5 +4,5 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_AR5523=m
diff --git a/backport/defconfigs/ath10k b/backport/defconfigs/ath10k
index c791c99..b7be617 100644
--- a/backport/defconfigs/ath10k
+++ b/backport/defconfigs/ath10k
@@ -4,7 +4,7 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH10K_PCI=m
 CPTCFG_ATH10K=m
 CPTCFG_ATH10K_DEBUG=y
diff --git a/backport/defconfigs/ath5k b/backport/defconfigs/ath5k
index df95c57..920c6c6 100644
--- a/backport/defconfigs/ath5k
+++ b/backport/defconfigs/ath5k
@@ -4,5 +4,5 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH5K=m
diff --git a/backport/defconfigs/ath6kl b/backport/defconfigs/ath6kl
index a372127..a1a1fdd 100644
--- a/backport/defconfigs/ath6kl
+++ b/backport/defconfigs/ath6kl
@@ -1,7 +1,7 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_WEXT=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH6KL=m
 CPTCFG_ATH6KL_SDIO=m
 CPTCFG_ATH6KL_USB=m
diff --git a/backport/defconfigs/ath9k b/backport/defconfigs/ath9k
index 0e935cc..c7097f9 100644
--- a/backport/defconfigs/ath9k
+++ b/backport/defconfigs/ath9k
@@ -4,6 +4,6 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH9K=m
 CPTCFG_ATH9K_HTC=m
diff --git a/backport/defconfigs/ath9k-debug b/backport/defconfigs/ath9k-debug
index b7baedd..d9cf94f 100644
--- a/backport/defconfigs/ath9k-debug
+++ b/backport/defconfigs/ath9k-debug
@@ -12,7 +12,7 @@ CPTCFG_MAC80211_HT_DEBUG=y
 CPTCFG_MAC80211_IBSS_DEBUG=y
 CPTCFG_MAC80211_PS_DEBUG=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH9K=m
 CPTCFG_ATH9K_HTC=m
 CPTCFG_ATH_DEBUG=y
diff --git a/backport/defconfigs/carl9170 b/backport/defconfigs/carl9170
index cc94e37..002e0f1 100644
--- a/backport/defconfigs/carl9170
+++ b/backport/defconfigs/carl9170
@@ -4,5 +4,5 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_CARL9170=m
diff --git a/backport/defconfigs/media b/backport/defconfigs/media
index c8f2e4d..a044583 100644
--- a/backport/defconfigs/media
+++ b/backport/defconfigs/media
@@ -404,12 +404,8 @@ CPTCFG_VIDEO_MT9P031=m
 CPTCFG_VIDEO_MT9T001=m
 CPTCFG_VIDEO_MT9V011=m
 CPTCFG_VIDEO_MT9V032=m
-CPTCFG_VIDEO_MX2=m
-CPTCFG_VIDEO_MX2_EMMAPRP=m
-CPTCFG_VIDEO_MX3=m
 CPTCFG_VIDEO_MXB=m
 CPTCFG_VIDEO_NOON010PC30=m
-CPTCFG_VIDEO_OMAP1=m
 CPTCFG_VIDEO_OMAP2_VOUT=m
 CPTCFG_VIDEO_OMAP3=m
 CPTCFG_VIDEO_OV7640=m
@@ -464,7 +460,6 @@ CPTCFG_VIDEO_TDA9840=m
 CPTCFG_VIDEO_TEA6415C=m
 CPTCFG_VIDEO_TEA6420=m
 CPTCFG_VIDEO_THS7303=m
-CPTCFG_VIDEO_TIMBERDALE=m
 CPTCFG_VIDEO_TLV320AIC23B=m
 CPTCFG_VIDEO_TM6000=m
 CPTCFG_VIDEO_TM6000_ALSA=m
diff --git a/backport/defconfigs/wcn36xx b/backport/defconfigs/wcn36xx
index 374eb11..a0ed809 100644
--- a/backport/defconfigs/wcn36xx
+++ b/backport/defconfigs/wcn36xx
@@ -8,6 +8,6 @@ CPTCFG_MAC80211=m
 CPTCFG_MAC80211_DEBUGFS=y
 CPTCFG_MAC80211_MESSAGE_TRACING=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_WCN36XX=m
 CPTCFG_WCN36XX_DEBUGFS=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 78d1453..4034bb1 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -11,7 +11,6 @@ CPTCFG_ATH6KL_SDIO=m
 CPTCFG_ATH6KL_USB=m
 CPTCFG_ATH9K_HTC=m
 CPTCFG_ATH9K=m
-CPTCFG_ATH_CARDS=m
 CPTCFG_ATMEL=m
 CPTCFG_B43LEGACY=m
 CPTCFG_B43=m
@@ -119,6 +118,19 @@ CPTCFG_WLAN=y
 CPTCFG_WLCORE=m
 CPTCFG_WLCORE_SDIO=m
 CPTCFG_WLCORE_SPI=m
-CPTCFG_WL_MEDIATEK=y
-CPTCFG_WL_TI=y
+CPTCFG_WLAN_VENDOR_ADMTEK=y
+CPTCFG_WLAN_VENDOR_ATH=y
+CPTCFG_WLAN_VENDOR_ATMEL=y
+CPTCFG_WLAN_VENDOR_BROADCOM=y
+CPTCFG_WLAN_VENDOR_CISCO=y
+CPTCFG_WLAN_VENDOR_INTEL=y
+CPTCFG_WLAN_VENDOR_INTERSIL=y
+CPTCFG_WLAN_VENDOR_MARVELL=y
+CPTCFG_WLAN_VENDOR_MEDIATEK=y
+CPTCFG_WLAN_VENDOR_RALINK=y
+CPTCFG_WLAN_VENDOR_REALTEK=y
+CPTCFG_WLAN_VENDOR_RSI=y
+CPTCFG_WLAN_VENDOR_ST=y
+CPTCFG_WLAN_VENDOR_TI=y
+CPTCFG_WLAN_VENDOR_ZYDAS=y
 CPTCFG_ZD1211RW=m
diff --git a/backport/defconfigs/wil6210 b/backport/defconfigs/wil6210
index 3fa29b8..e449a69 100644
--- a/backport/defconfigs/wil6210
+++ b/backport/defconfigs/wil6210
@@ -1,5 +1,5 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_WEXT=y
 CPTCFG_WLAN=y
-CPTCFG_ATH_CARDS=m
+CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_WIL6210=m
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
