Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36146 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3KSUpw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2013 15:45:52 -0500
Received: by mail-pa0-f44.google.com with SMTP id fb1so7282756pad.3
        for <backports@vger.kernel.org>; Tue, 19 Nov 2013 12:45:51 -0800 (PST)
From: Jason Mobarak <jam@cozybit.com>
To: backports@vger.kernel.org
Cc: wcn36xx@lists.infradead.org, Jason Mobarak <jam@cozybit.com>
Subject: [PATCH] backports: add support for wcn36xx
Date: Tue, 19 Nov 2013 12:45:31 -0800
Message-Id: <1384893931-21178-1-git-send-email-jam@cozybit.com> (sfid-20131119_214554_495405_35ACC795)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

---
 backport/defconfigs/wcn36xx |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/defconfigs/wcn36xx

diff --git a/backport/defconfigs/wcn36xx b/backport/defconfigs/wcn36xx
new file mode 100644
index 0000000..374eb11
--- /dev/null
+++ b/backport/defconfigs/wcn36xx
@@ -0,0 +1,13 @@
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
-- 
1.7.10.4

