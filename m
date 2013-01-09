Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] compat-drivers: add new mac80211 debug options
Date: Wed,  9 Jan 2013 17:27:27 +0100
Message-Id: <1357748847-4095-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357748847-4095-1-git-send-email-hauke@hauke-m.de>
References: <1357748847-4095-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/config.mk b/config.mk
index 084a21f..6af57a4 100644
--- a/config.mk
+++ b/config.mk
@@ -152,15 +152,20 @@ endif #CONFIG_COMPAT_KERNEL_2_6_33
 # export CONFIG_MAC80211_DEBUGFS=y
 # export CONFIG_MAC80211_NOINLINE=y
 # export CONFIG_MAC80211_VERBOSE_DEBUG=y
-# export CONFIG_MAC80211_HT_DEBUG=y
-# export CONFIG_MAC80211_TKIP_DEBUG=y
-# export CONFIG_MAC80211_IBSS_DEBUG=y
-# export CONFIG_MAC80211_VERBOSE_PS_DEBUG=y
-# export CONFIG_MAC80211_VERBOSE_MPL_DEBUG=y
-# export CONFIG_MAC80211_VERBOSE_MHWMP_DEBUG=y
-# export CONFIG_MAC80211_VERBOSE_TDLS_DEBUG
+# export CONFIG_MAC80211_MESSAGE_TRACING=y
 # export CONFIG_MAC80211_DEBUG_COUNTERS=y
 
+# export CONFIG_MAC80211_IBSS_DEBUG=y
+# export CONFIG_MAC80211_PS_DEBUG=y
+# export CONFIG_MAC80211_HT_DEBUG=y
+# export CONFIG_MAC80211_MPL_DEBUG=y
+# export CONFIG_MAC80211_MPATH_DEBUG=y
+# export CONFIG_MAC80211_MHWMP_DEBUG=y
+# export CONFIG_MAC80211_MESH_SYNC_DEBUG=y
+# export CONFIG_MAC80211_TDLS_DEBUG=y
+# export CONFIG_MAC80211_STA_DEBUG=y
+# export CONFIG_MAC80211_MLME_DEBUG=y
+
 # choose between pid and minstrel as default rate control algorithm
 export CONFIG_MAC80211_RC_DEFAULT=minstrel_ht
 export CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
-- 
1.7.10.4
