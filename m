Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44202 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab3GKWMe (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 08/19] backports: add defconfigs for Atheros wifi drivers
Date: Fri, 12 Jul 2013 00:11:31 +0200
Message-Id: <1373580702-24752-10-git-send-email-hauke@hauke-m.de> (sfid-20130712_001239_097989_4898540C)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 88f8c8b255e4fec946f2a8ecd70f0d28ad82d16a

This adds default configs for Atheros wifi drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/defconfigs/ar5523   |    8 ++++++++
 backport/defconfigs/ath5k    |    8 ++++++++
 backport/defconfigs/ath6kl   |    7 +++++++
 backport/defconfigs/ath9k    |    9 +++++++++
 backport/defconfigs/carl9170 |    8 ++++++++
 backport/defconfigs/wil6210  |    5 +++++
 6 files changed, 45 insertions(+)
 create mode 100644 backport/defconfigs/ar5523
 create mode 100644 backport/defconfigs/ath5k
 create mode 100644 backport/defconfigs/ath6kl
 create mode 100644 backport/defconfigs/ath9k
 create mode 100644 backport/defconfigs/carl9170
 create mode 100644 backport/defconfigs/wil6210

diff --git a/backport/defconfigs/ar5523 b/backport/defconfigs/ar5523
new file mode 100644
index 0000000..b218d9a
--- /dev/null
+++ b/backport/defconfigs/ar5523
@@ -0,0 +1,8 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_AR5523=m
diff --git a/backport/defconfigs/ath5k b/backport/defconfigs/ath5k
new file mode 100644
index 0000000..df95c57
--- /dev/null
+++ b/backport/defconfigs/ath5k
@@ -0,0 +1,8 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_ATH5K=m
diff --git a/backport/defconfigs/ath6kl b/backport/defconfigs/ath6kl
new file mode 100644
index 0000000..a372127
--- /dev/null
+++ b/backport/defconfigs/ath6kl
@@ -0,0 +1,7 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_ATH6KL=m
+CPTCFG_ATH6KL_SDIO=m
+CPTCFG_ATH6KL_USB=m
diff --git a/backport/defconfigs/ath9k b/backport/defconfigs/ath9k
new file mode 100644
index 0000000..0e935cc
--- /dev/null
+++ b/backport/defconfigs/ath9k
@@ -0,0 +1,9 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_ATH9K=m
+CPTCFG_ATH9K_HTC=m
diff --git a/backport/defconfigs/carl9170 b/backport/defconfigs/carl9170
new file mode 100644
index 0000000..cc94e37
--- /dev/null
+++ b/backport/defconfigs/carl9170
@@ -0,0 +1,8 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_CARL9170=m
diff --git a/backport/defconfigs/wil6210 b/backport/defconfigs/wil6210
new file mode 100644
index 0000000..3fa29b8
--- /dev/null
+++ b/backport/defconfigs/wil6210
@@ -0,0 +1,5 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_WLAN=y
+CPTCFG_ATH_CARDS=m
+CPTCFG_WIL6210=m
-- 
1.7.10.4

