Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53478 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab3KSXQt (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2013 18:16:49 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so161418pad.31
        for <backports@vger.kernel.org>; Tue, 19 Nov 2013 15:16:49 -0800 (PST)
From: Jason Mobarak <jam@cozybit.com>
To: backports@vger.kernel.org
Cc: wcn36xx@lists.infradead.org, Jason Mobarak <jam@cozybit.com>
Subject: [PATCH v2] backports: add defconfig for wcn36xx
Date: Tue, 19 Nov 2013 15:16:15 -0800
Message-Id: <1384902975-26870-1-git-send-email-jam@cozybit.com> (sfid-20131120_001655_038936_E8220E79)
In-Reply-To: <528BDDF9.7080400@hauke-m.de>
References: <528BDDF9.7080400@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Jason Mobarak <jam@cozybit.com>
---

v2: Added CPTCFG_CFG80211_WEXT and Signed-of-by line.

 backport/defconfigs/wcn36xx |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/defconfigs/wcn36xx

diff --git a/backport/defconfigs/wcn36xx b/backport/defconfigs/wcn36xx
new file mode 100644
index 0000000..9430ff1
--- /dev/null
+++ b/backport/defconfigs/wcn36xx
@@ -0,0 +1,14 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_DEFAULT_PS=y
+CPTCFG_CFG80211_DEBUGFS=y
+CPTCFG_MAC80211=m
+# CPTCFG_MAC80211_RC_PID is not set
+# CPTCFG_MAC80211_RC_MINSTREL is not set
+# CPTCFG_MAC80211_RC_DEFAULT_MINSTREL is not set
+CPTCFG_MAC80211_DEBUGFS=y
+CPTCFG_MAC80211_MESSAGE_TRACING=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_WCN36XX=m
+CPTCFG_WCN36XX_DEBUGFS=y
+CPTCFG_CFG80211_WEXT=y
-- 
1.7.10.4

