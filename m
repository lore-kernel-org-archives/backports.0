Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45746 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751822AbeD3LQF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 Apr 2018 07:16:05 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: backports@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/3] patches: update patches for v4.17-rc1
Date: Mon, 30 Apr 2018 13:15:44 +0200
Message-Id: <1525086946-6352-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20180430_131606_628611_5DAE829A)
In-Reply-To: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Few patches do not apply to source code in v4.17-rc1 so updating
those.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/0004-disable-wext-kconfig.patch | 4 ++--
 patches/0070-mac80211-fils.patch        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/0004-disable-wext-kconfig.patch b/patches/0004-disable-wext-kconfig.patch
index 313ea90..1ed420a 100644
--- a/patches/0004-disable-wext-kconfig.patch
+++ b/patches/0004-disable-wext-kconfig.patch
@@ -25,10 +25,10 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -191,7 +173,7 @@ config CFG80211_CRDA_SUPPORT
+@@ -187,7 +169,7 @@ config CFG80211_CRDA_SUPPORT
+
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
- 	depends on CFG80211
 -	select WEXT_CORE
 +	depends on WEXT_CORE
  	default y if CFG80211_WEXT_EXPORT
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index 345e707..d7274e5 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -5,7 +5,7 @@
  /*
   * FILS AEAD for (Re)Association Request/Response frames
   * Copyright 2016, Qualcomm Atheros, Inc.
-@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee8
+@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
  	*frame_len -= AES_BLOCK_SIZE;
  	return 0;
  }
@@ -42,13 +42,13 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -553,7 +553,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -553,7 +553,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
 +#if LINUX_VERSION_IS_GEQ(4,3,0)
  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
 +#endif
+ 	wiphy_ext_feature_set(wiphy,
+ 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
  
- 	if (!ops->hw_scan)
- 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
