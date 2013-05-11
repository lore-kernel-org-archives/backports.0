Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60609 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab3EKAd4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:33:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so9239179iea.18
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:33:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [RFC 2/5] backports: adjust snd_portid patch for nl80211 update
Date: Fri, 10 May 2013 17:33:38 -0700
Message-Id: <1368232421-24123-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_023358_425507_6196EF3E)
In-Reply-To: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The new code for the "critical protocol indication" uses
snd_portid and must be adjusted in the backport patches.
This is required as of next-20130423.

commit 5de17984898c5758fc6ebe08eccea9f4b6548914
Author: Arend van Spriel <arend@broadcom.com>
Date:   Thu Apr 18 15:49:00 2013 +0200

    cfg80211: introduce critical protocol indication from user-space

    Some protocols need a more reliable connection to complete
    successful in reasonable time. This patch adds a user-space
    API to indicate the wireless driver that a critical protocol
    is about to commence and when it is done, using nl80211 primitives
    NL80211_CMD_CRIT_PROTOCOL_START and NL80211_CRIT_PROTOCOL_STOP.

    There can be only on critical protocol session started per
    registered cfg80211 device.

    The driver can support this by implementing the cfg80211 callbacks
    .crit_proto_start() and .crit_proto_stop(). Examples of protocols
    that can benefit from this are DHCP, EAPOL, APIPA. Exactly how the
    link can/should be made more reliable is up to the driver. Things
    to consider are avoid scanning, no multi-channel operations, and
    alter coexistence schemes.

    Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
    Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
    Signed-off-by: Arend van Spriel <arend@broadcom.com>
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

[mcgrof@do-not-panic.com]: Required as of next-20130423
 and provided commit log message that introduced this
 change.
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/0005-netlink-portid/nl80211.patch                 |    9 +++++++++
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
1.7.10.4

