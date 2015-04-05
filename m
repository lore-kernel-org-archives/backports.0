Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40007 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbbDEWNb (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] backports: add Cisco/Aironet (AIRO) driver
Date: Mon,  6 Apr 2015 00:13:17 +0200
Message-Id: <1428272000-19929-5-git-send-email-hauke@hauke-m.de> (sfid-20150406_001336_181555_292BEB96)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This wifi driver was missing before.
This driver uses the cfg80211 so we should ship it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 2 ++
 copy-list                | 3 +++
 dependencies             | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 96496ed..7e79612 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -1,5 +1,7 @@
 CPTCFG_ADM8211=m
 CPTCFG_AR5523=m
+CPTCFG_AIRO=m
+CPTCFG_AIRO_CS=m
 CPTCFG_AT76C50X_USB=m
 CPTCFG_ATH10K=m
 CPTCFG_ATH10K_PCI=m
diff --git a/copy-list b/copy-list
index b581e26..7c01a43 100644
--- a/copy-list
+++ b/copy-list
@@ -54,6 +54,9 @@ drivers/ssb/
 include/linux/ssb/
 drivers/bcma/
 include/linux/bcma/
+drivers/net/wireless/airo.c
+drivers/net/wireless/airo_cs.c
+drivers/net/wireless/airo.h
 drivers/net/wireless/b43/
 drivers/net/wireless/b43legacy/
 drivers/net/wireless/brcm80211/
diff --git a/dependencies b/dependencies
index eead0c5..ba41d25 100644
--- a/dependencies
+++ b/dependencies
@@ -9,6 +9,10 @@ WL1251_SPI 3.5
 WL1251_SDIO 3.15
 WLCORE_SDIO 3.15
 
+# This driver uses the remove_proc_subtree() function.
+AIRO 3.9
+AIRO_CS 3.9
+
 # Media
 MEDIA_SUPPORT 3.2
 USB_GSPCA_OV534 3.5
-- 
1.9.1

