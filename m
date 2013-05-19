Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59241 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3ESW46 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:56:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: add CPTCFG_CFG80211_WEXT
Date: Mon, 20 May 2013 00:56:49 +0200
Message-Id: <1369004209-21470-2-git-send-email-hauke@hauke-m.de> (sfid-20130520_005659_908553_F3F963A8)
In-Reply-To: <1369004209-21470-1-git-send-email-hauke@hauke-m.de>
References: <1369004209-21470-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Without wext support we will get lots of complains about iwconfig
not working.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/iwlwifi |    1 +
 backport/defconfigs/rtlwifi |    1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/defconfigs/iwlwifi b/backport/defconfigs/iwlwifi
index 6a5f4ba..9563c8b 100644
--- a/backport/defconfigs/iwlwifi
+++ b/backport/defconfigs/iwlwifi
@@ -1,6 +1,7 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_DEFAULT_PS=y
 CPTCFG_CFG80211_DEBUGFS=y
+CPTCFG_CFG80211_WEXT=y
 CPTCFG_MAC80211=m
 # CPTCFG_MAC80211_RC_PID is not set
 # CPTCFG_MAC80211_RC_MINSTREL is not set
diff --git a/backport/defconfigs/rtlwifi b/backport/defconfigs/rtlwifi
index c86d000..d9b5958 100644
--- a/backport/defconfigs/rtlwifi
+++ b/backport/defconfigs/rtlwifi
@@ -1,6 +1,7 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_DEFAULT_PS=y
 CPTCFG_CFG80211_DEBUGFS=y
+CPTCFG_CFG80211_WEXT=y
 CPTCFG_MAC80211=m
 # CPTCFG_MAC80211_RC_PID is not set
 # CPTCFG_MAC80211_RC_MINSTREL is not set
-- 
1.7.10.4

