Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60865 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3HRXip (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 12/19] backports: add defconfig for cw1200
Date: Mon, 19 Aug 2013 01:37:57 +0200
Message-Id: <1376869084-16513-13-git-send-email-hauke@hauke-m.de> (sfid-20130819_013909_028065_D035EB0E)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/cw1200 |    9 +++++++++
 backport/defconfigs/wifi   |    3 +++
 2 files changed, 12 insertions(+)
 create mode 100644 backport/defconfigs/cw1200

diff --git a/backport/defconfigs/cw1200 b/backport/defconfigs/cw1200
new file mode 100644
index 0000000..ba03143
--- /dev/null
+++ b/backport/defconfigs/cw1200
@@ -0,0 +1,9 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_CW1200=m
+CPTCFG_CW1200_WLAN_SDIO=m
+CPTCFG_CW1200_WLAN_SPI=m
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index d55849b..5c9f293 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -23,6 +23,9 @@ CPTCFG_BRCMSMAC=m
 CPTCFG_CARL9170=m
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_WEXT=y
+CPTCFG_CW1200=m
+CPTCFG_CW1200_WLAN_SDIO=m
+CPTCFG_CW1200_WLAN_SPI=m
 CPTCFG_HERMES=m
 CPTCFG_HERMES_PRISM=y
 CPTCFG_IPW2100=m
-- 
1.7.10.4

