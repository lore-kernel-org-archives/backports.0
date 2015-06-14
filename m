Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41045 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbbFNO3j (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/21] backports: add mediatek mt7601u driver
Date: Sun, 14 Jun 2015 16:29:19 +0200
Message-Id: <1434292162-2261-19-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_662535_A8C54827)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 2 ++
 copy-list                | 1 +
 2 files changed, 3 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 3d26444..933be4b 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -58,6 +58,7 @@ CPTCFG_MAC80211_HWSIM=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211=m
 CPTCFG_MAC80211_MESH=y
+CPTCFG_MT7601U=m
 CPTCFG_MWIFIEX=m
 CPTCFG_MWIFIEX_PCIE=m
 CPTCFG_MWIFIEX_SDIO=m
@@ -118,5 +119,6 @@ CPTCFG_WLAN=y
 CPTCFG_WLCORE=m
 CPTCFG_WLCORE_SDIO=m
 CPTCFG_WLCORE_SPI=m
+CPTCFG_WL_MEDIATEK=y
 CPTCFG_WL_TI=y
 CPTCFG_ZD1211RW=m
diff --git a/copy-list b/copy-list
index 7cfeedf..a679c77 100644
--- a/copy-list
+++ b/copy-list
@@ -78,6 +78,7 @@ drivers/net/wireless/libertas_tf/
 drivers/net/wireless/ipw2x00/
 drivers/net/wireless/ti/
 drivers/net/wireless/orinoco/
+drivers/net/wireless/mediatek/
 drivers/net/wireless/mwifiex/
 drivers/net/wireless/adm8211.c
 drivers/net/wireless/adm8211.h
-- 
2.1.4

