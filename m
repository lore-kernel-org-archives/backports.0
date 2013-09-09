Return-path: <backports-owner@vger.kernel.org>
Received: from s72.web-hosting.com ([198.187.29.21]:41618 "EHLO
	s72.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3IIMqH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Sep 2013 08:46:07 -0400
From: Sujith Manoharan <sujith@msujith.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Subject: [PATCH] backports: Add a defconfig for ath9k debugging
Date: Mon,  9 Sep 2013 18:12:14 +0530
Message-Id: <1378730534-19736-1-git-send-email-sujith@msujith.org> (sfid-20130909_144610_162519_EED78F18)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Sujith Manoharan <c_manoha@qca.qualcomm.com>

Signed-off-by: Sujith Manoharan <c_manoha@qca.qualcomm.com>
---
 backport/defconfigs/ath9k-debug | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/defconfigs/ath9k-debug

diff --git a/backport/defconfigs/ath9k-debug b/backport/defconfigs/ath9k-debug
new file mode 100644
index 0000000..b7baedd
--- /dev/null
+++ b/backport/defconfigs/ath9k-debug
@@ -0,0 +1,19 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_MAC80211_DEBUGFS=y
+CPTCFG_MAC80211_DEBUG_MENU=y
+CPTCFG_MAC80211_VERBOSE_DEBUG=y
+CPTCFG_MAC80211_MLME_DEBUG=y
+CPTCFG_MAC80211_STA_DEBUG=y
+CPTCFG_MAC80211_HT_DEBUG=y
+CPTCFG_MAC80211_IBSS_DEBUG=y
+CPTCFG_MAC80211_PS_DEBUG=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_ATH9K=m
+CPTCFG_ATH9K_HTC=m
+CPTCFG_ATH_DEBUG=y
+CPTCFG_ATH9K_DEBUGFS=y
-- 
1.8.4

