Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55711 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964849AbbENTYp (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 14 May 2015 15:24:45 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix netdev->tstats backport
Date: Thu, 14 May 2015 21:24:42 +0200
Message-Id: <1431631482-5810-1-git-send-email-johannes@sipsolutions.net> (sfid-20150514_212447_623176_FA10FB2E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Given a correct spatch, there's no need for the other manual
patch. Thanks to Julia for pointing out my error in building
the original spatch, and how to fix it.

Change-Id: I0226a6c4d0fb7630abee315f1839ba63534aacbb
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../collateral-evolutions/network/0055-netdev-tstats-tx.patch | 11 -----------
 ...55-netdev-tstats-assign.cocci => 0055-netdev-tstats.cocci} |  9 +++++----
 .../collateral-evolutions/network/0056-netdev-tstats.cocci    |  9 ---------
 3 files changed, 5 insertions(+), 24 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
 rename patches/collateral-evolutions/network/{0055-netdev-tstats-assign.cocci => 0055-netdev-tstats.cocci} (61%)
 delete mode 100644 patches/collateral-evolutions/network/0056-netdev-tstats.cocci

diff --git a/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch b/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
deleted file mode 100644
index aa79e0298cb1..000000000000
--- a/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/mac80211/tx.c
-+++ b/net/mac80211/tx.c
-@@ -39,7 +39,7 @@
- 
- static inline void ieee80211_tx_stats(struct net_device *dev, u32 len)
- {
--	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
-+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(netdev_tstats(dev));
- 
- 	u64_stats_update_begin(&tstats->syncp);
- 	tstats->tx_packets++;
diff --git a/patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci b/patches/collateral-evolutions/network/0055-netdev-tstats.cocci
similarity index 61%
rename from patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
rename to patches/collateral-evolutions/network/0055-netdev-tstats.cocci
index b41b4f17e654..d7500b61140e 100644
--- a/patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
+++ b/patches/collateral-evolutions/network/0055-netdev-tstats.cocci
@@ -1,10 +1,11 @@
-@nd@
-identifier dev;
 @@
 struct net_device *dev;
-@@
-identifier nd.dev;
 expression E;
 @@
 -dev->tstats = E;
 +netdev_assign_tstats(dev, E);
+@@
+struct net_device *dev;
+@@
+-dev->tstats
++netdev_tstats(dev)
diff --git a/patches/collateral-evolutions/network/0056-netdev-tstats.cocci b/patches/collateral-evolutions/network/0056-netdev-tstats.cocci
deleted file mode 100644
index 99d71c05713e..000000000000
--- a/patches/collateral-evolutions/network/0056-netdev-tstats.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@nd@
-identifier dev;
-@@
-struct net_device *dev;
-@@
-identifier nd.dev;
-@@
--dev->tstats
-+netdev_tstats(dev)
-- 
2.1.4

