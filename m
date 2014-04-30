Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50150 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbaD3WLL (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 30 Apr 2014 18:11:11 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: select_queue patch: fix callback kernel version
Date: Thu,  1 May 2014 00:10:25 +0200
Message-Id: <1398895825-18420-1-git-send-email-johannes@sipsolutions.net> (sfid-20140501_001125_849085_C578BA53)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The callback argument has been passed since kernel 3.14, not
only 3.15 - fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../collateral-evolutions/network/0028-select_queue/mac80211.patch    | 4 ++--
 stack-auto.ini                                                        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 2e695f5b05f7..d21a56b7201b 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -6,7 +6,7 @@ index 088111a..dcf149a 100644
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
  					 void *accel_priv,
@@ -26,7 +26,7 @@ index 088111a..dcf149a 100644
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
  					  void *accel_priv,
diff --git a/stack-auto.ini b/stack-auto.ini
index 0412f8df60e4..4679a5cd52a7 100644
--- a/stack-auto.ini
+++ b/stack-auto.ini
@@ -1,5 +1,5 @@
 [DEFAULT]
-cachedir = .
+cachedir = /home/johannes/tmp/work/
 
 [iwlwifi]
 
-- 
1.9.0

