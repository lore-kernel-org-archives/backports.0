Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40762 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaKFLCQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 6 Nov 2014 06:02:16 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: genl: add __genl_const for new hwsim mcast group
Date: Thu,  6 Nov 2014 12:02:10 +0100
Message-Id: <1415271730-19194-1-git-send-email-johannes@sipsolutions.net> (sfid-20141106_120218_843030_933E108E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../collateral-evolutions/network/0027-genl-const/hwsim.patch | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 33cba175dda6..d6cb0350f1d1 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -1,5 +1,16 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
+@@ -491,7 +491,7 @@ enum hwsim_multicast_groups {
+ 	HWSIM_MCGRP_CONFIG,
+ };
+ 
+-static const struct genl_multicast_group hwsim_mcgrps[] = {
++static __genl_const struct genl_multicast_group hwsim_mcgrps[] = {
+ 	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
+ };
+ 
+--- a/drivers/net/wireless/mac80211_hwsim.c
++++ b/drivers/net/wireless/mac80211_hwsim.c
 @@ -2483,7 +2483,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
-- 
2.1.1

