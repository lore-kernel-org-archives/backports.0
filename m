Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48697 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbbCBICT (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 2 Mar 2015 03:02:19 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: update cfg80211 wext Kconfig disable patch
Date: Mon,  2 Mar 2015 09:02:15 +0100
Message-Id: <1425283335-4079-1-git-send-email-johannes@sipsolutions.net> (sfid-20150302_090221_486984_A7E42190)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The context change, update the patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index a6b09b39c3b4..658f2d81dcc3 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -31,6 +31,6 @@ so remove the Kconfig options for them.
  	depends on CFG80211
 -	select WEXT_CORE
 +	depends on WEXT_CORE
+ 	default y if CFG80211_WEXT_EXPORT
  	help
  	  Enable this option if you need old userspace for wireless
- 	  extensions with cfg80211-based drivers.
-- 
2.1.4

