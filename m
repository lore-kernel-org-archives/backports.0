Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60890 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab3HRXj7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:39:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 15/19] backports: use genl_info_snd_portid() at an other place.
Date: Mon, 19 Aug 2013 01:38:00 +0200
Message-Id: <1376869084-16513-16-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_441870_8232264F)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0005-netlink-portid/nl80211.patch               |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 4664bc1..478c4e4 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -189,7 +189,16 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8098,7 +8098,7 @@ static int nl80211_register_unexpected_f
+@@ -8152,7 +8152,7 @@ static int nl80211_get_coalesce(struct s
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_GET_COALESCE);
+ 	if (!hdr)
+ 		goto nla_put_failure;
+@@ -8405,7 +8405,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
-- 
1.7.10.4

