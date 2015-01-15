Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:3196 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbbAOUPt (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Jan 2015 15:15:49 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH V2] patches: genl-const: fix nl80211.patch
Date: Thu, 15 Jan 2015 21:15:42 +0100
Message-ID: <1421352942-21625-1-git-send-email-arend@broadcom.com> (sfid-20150115_211552_467265_F71FCF92)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

nl80211.c recently changed using defined strings instead of hard-coded in
multi-cast group definitions:

  commit 71b836eca7f380fbd4c025f8c4371f9a071bc909
  Author: Johannes Berg <johannes.berg@intel.com>
  Date:   Tue Dec 23 17:17:38 2014 +0100

      nl80211: define multicast group names in header

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
V2:
 - remove whitespace changes.
---
 patches/collateral-evolutions/network/0027-genl-const/nl80211.patch | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index d8d67bb..21c2a86 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -18,9 +18,9 @@
  
 -static const struct genl_multicast_group nl80211_mcgrps[] = {
 +static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
- 	[NL80211_MCGRP_CONFIG] = { .name = "config", },
- 	[NL80211_MCGRP_SCAN] = { .name = "scan", },
- 	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
+ 	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
+ 	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
+ 	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
 @@ -9938,7 +9938,7 @@ static int nl80211_tdls_cancel_channel_s
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
-- 
1.9.1

