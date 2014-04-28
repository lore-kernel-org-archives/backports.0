Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39806 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaD1MHJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 28 Apr 2014 08:07:09 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: remove mac80211.h
Date: Mon, 28 Apr 2014 14:06:58 +0200
Message-Id: <1398686818-16234-1-git-send-email-johannes@sipsolutions.net> (sfid-20140428_140711_600977_952F89BD)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

As support for old kernels has been removed, there's no need to keep
around the mac80211.h file that redefines the ieee80211_rx() symbol;
In 2.6.32 this name was changed to belong to mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/mac80211.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 backport/backport-include/net/mac80211.h

diff --git a/backport/backport-include/net/mac80211.h b/backport/backport-include/net/mac80211.h
deleted file mode 100644
index c31b46298d85..000000000000
--- a/backport/backport-include/net/mac80211.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __BACKPORT_NET_MAC80211_H
-#define __BACKPORT_NET_MAC80211_H
-
-/* on some kernels, libipw also uses this, so override */
-#define ieee80211_rx mac80211_ieee80211_rx
-#include_next <net/mac80211.h>
-
-#endif /* __BACKPORT_NET_MAC80211_H */
-- 
1.9.0

