Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44161 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab3GKWMR (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/19] backports: add CPTCFG_CFG80211_WEXT
Date: Fri, 12 Jul 2013 00:11:26 +0200
Message-Id: <1373580702-24752-5-git-send-email-hauke@hauke-m.de> (sfid-20130712_001233_144330_72058053)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit e753851dda4afd9efe5cdd88bc6bf306b550f506

Without wext support we will get lots of complains about iwconfig
not working.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
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

