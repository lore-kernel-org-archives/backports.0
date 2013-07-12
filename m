Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:54269 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3GLAzJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Jul 2013 20:55:09 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so8422064pbc.21
        for <backports@vger.kernel.org>; Thu, 11 Jul 2013 17:55:08 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: add ath10k defconfig
Date: Thu, 11 Jul 2013 17:55:03 -0700
Message-Id: <1373590503-14036-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130712_025511_579021_04B62EA0)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/defconfigs/ath10k |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/defconfigs/ath10k

diff --git a/backport/defconfigs/ath10k b/backport/defconfigs/ath10k
new file mode 100644
index 0000000..c791c99
--- /dev/null
+++ b/backport/defconfigs/ath10k
@@ -0,0 +1,11 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_ATH10K_PCI=m
+CPTCFG_ATH10K=m
+CPTCFG_ATH10K_DEBUG=y
+CPTCFG_ATH10K_DEBUGFS=y
-- 
1.7.10.4

