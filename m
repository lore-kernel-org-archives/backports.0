Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39790 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBer (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:34:47 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6087643pbc.35
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:34:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/10] backports: add hwsim defconfig
Date: Fri, 11 Apr 2014 18:34:26 -0700
Message-Id: <1397266475-14442-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033452_422151_62C1500C)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This can be useful for pure testing scenarios.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/defconfigs/hwsim | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/defconfigs/hwsim

diff --git a/backport/defconfigs/hwsim b/backport/defconfigs/hwsim
new file mode 100644
index 0000000..9d8006e
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
1.9.1

