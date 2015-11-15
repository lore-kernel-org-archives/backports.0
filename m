Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35562 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbbKOP5O (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/15] defconfigs: update wifi defconfigs
Date: Sun, 15 Nov 2015 16:56:57 +0100
Message-Id: <1447603019-11862-14-git-send-email-hauke@hauke-m.de> (sfid-20151115_171409_030684_0780F673)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the new driver CPTCFG_RTL8XXXU and removes the config option
for CPTCFG_B43_PCMCIA. pcmcia support in b43 is now done in ssb.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/b43     | 1 -
 backport/defconfigs/rtlwifi | 1 +
 backport/defconfigs/wifi    | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/defconfigs/b43 b/backport/defconfigs/b43
index dd2ba89..5001070 100644
--- a/backport/defconfigs/b43
+++ b/backport/defconfigs/b43
@@ -6,7 +6,6 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_WLAN=y
 CPTCFG_B43=m
 CPTCFG_B43_BCMA=y
-CPTCFG_B43_PCMCIA=y
 CPTCFG_B43_SDIO=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_PHY_LP=y
diff --git a/backport/defconfigs/rtlwifi b/backport/defconfigs/rtlwifi
index 6c465fc..121995d 100644
--- a/backport/defconfigs/rtlwifi
+++ b/backport/defconfigs/rtlwifi
@@ -21,3 +21,4 @@ CPTCFG_RTL8192CU=m
 CPTCFG_RTL8192C_COMMON=m
 CPTCFG_RTL8192EE=m
 CPTCFG_RTL8821AE=m
+CPTCFG_RTL8XXXU=m
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 933be4b..78d1453 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -15,7 +15,6 @@ CPTCFG_ATH_CARDS=m
 CPTCFG_ATMEL=m
 CPTCFG_B43LEGACY=m
 CPTCFG_B43=m
-CPTCFG_B43_PCMCIA=y
 CPTCFG_B43_PHY_HT=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_SDIO=y
@@ -101,6 +100,7 @@ CPTCFG_RTL8192SE=m
 CPTCFG_RTL8723AE=m
 CPTCFG_RTL8723BE=m
 CPTCFG_RTL8821AE=m
+CPTCFG_RTL8XXXU=m
 CPTCFG_RTLWIFI=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
