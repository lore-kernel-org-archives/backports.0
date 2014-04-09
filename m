Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:42764 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbaDIL4Y (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Apr 2014 07:56:24 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add hwsim defconfig
Date: Wed,  9 Apr 2014 13:56:12 +0200
Message-Id: <1397044572-28066-1-git-send-email-johannes@sipsolutions.net> (sfid-20140409_135626_232234_08671C9E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This can be useful for pure testing scenarios.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/defconfigs/hwsim | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/defconfigs/hwsim

diff --git a/backport/defconfigs/hwsim b/backport/defconfigs/hwsim
new file mode 100644
index 000000000000..9d8006eaf4aa
--- /dev/null
+++ b/backport/defconfigs/hwsim
@@ -0,0 +1,12 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_DEFAULT_PS=y
+CPTCFG_CFG80211_DEBUGFS=y
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+# CPTCFG_MAC80211_RC_PID is not set
+# CPTCFG_MAC80211_RC_MINSTREL is not set
+# CPTCFG_MAC80211_RC_DEFAULT_MINSTREL is not set
+CPTCFG_MAC80211_DEBUGFS=y
+CPTCFG_MAC80211_MESSAGE_TRACING=y
+CPTCFG_WLAN=y
+CPTCFG_MAC80211_HWSIM=m
-- 
1.9.0

