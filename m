Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33452 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaDVTEF (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 22 Apr 2014 15:04:05 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: alex.bluesman.smirnov@gmail.com, dbaryshkov@gmail.com,
	linux-zigbee-devel@lists.sourceforge.net, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] 6lowpan: nuke net_ieee802154_lowpan() accessor when 6lowpan is disabled
Date: Tue, 22 Apr 2014 12:03:58 -0700
Message-Id: <1398193438-23805-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140422_210826_786314_0F7DC4F8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Johannes noted this is not needed, all of the fragment
accessors don't need CONFIG_NET_NS. This goes test compiled with
CONFIG_BT_6LOWPAN=y and a disabled CONFIG_NET_NS.

CC: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Cc: David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 include/net/net_namespace.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 066cf60..ea3cede 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -386,15 +386,8 @@ net_ieee802154_lowpan(struct net *net)
 {
 	return &net->ieee802154_lowpan;
 }
-#else
-static inline struct netns_ieee802154_lowpan *
-net_ieee802154_lowpan(struct net *net)
-{
-	return NULL;
-}
 #endif
 
-
 /* For callers who don't really care about whether it's IPv4 or IPv6 */
 static inline void rt_genid_bump_all(struct net *net)
 {
-- 
1.9.0

