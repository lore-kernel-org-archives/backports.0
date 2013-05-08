Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57017 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3EHHKj (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 03:10:39 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: adjust snd_portid patch for nl80211 update
Date: Wed,  8 May 2013 09:10:31 +0200
Message-Id: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net> (sfid-20130508_091041_345759_FBA0FAA9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The new code for the "critical protocol indication" uses
snd_portid and must be adjusted in the backport patches.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/0005-netlink-portid/nl80211.patch                    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 0e2b981..bde418d 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -232,6 +232,15 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
+@@ -8261,7 +8261,7 @@ static int nl80211_crit_protocol_start(struct sk_buff *skb,
+ 
+ 	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
+ 	if (!ret)
+-		rdev->crit_proto_nlportid = info->snd_portid;
++		rdev->crit_proto_nlportid = genl_info_snd_portid(info);
+ 
+ 	return ret;
+ }
 @@ -10565,12 +10565,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
-- 
1.8.0

