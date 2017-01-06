Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:58874 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966720AbdAFKkh (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 6 Jan 2017 05:40:37 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: replace select_queue changes by an spatch
Date: Fri,  6 Jan 2017 11:40:32 +0100
Message-Id: <20170106104032.7301-1-johannes@sipsolutions.net> (sfid-20170106_114144_091521_C5E5A2D6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This hasn't really been a problem, but if we may want to add
more uses in the future, or change things around (e.g. with
the proposed 802.3 format addition to mac80211) then we may
want to have this more maintainable.

The output looks a bit worse, but I think we can live with that.

Change-Id: I0d1fa6d1d3560c720ff710c89aea846740eb2173
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/0028-select_queue.cocci                | 24 ++++++++++++
 .../network/0028-select_queue/INFO                 | 12 ------
 .../network/0028-select_queue/mac80211.patch       | 44 ----------------------
 .../network/0028-select_queue/mwifiex.patch        | 22 -----------
 4 files changed, 24 insertions(+), 78 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0028-select_queue.cocci
 delete mode 100644 patches/collateral-evolutions/network/0028-select_queue/INFO
 delete mode 100644 patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
 delete mode 100644 patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/0028-select_queue.cocci b/patches/collateral-evolutions/network/0028-select_queue.cocci
new file mode 100644
index 000000000000..224d0ca34d95
--- /dev/null
+++ b/patches/collateral-evolutions/network/0028-select_queue.cocci
@@ -0,0 +1,24 @@
+@ndo@
+identifier ops, select_queue;
+@@
+struct net_device_ops ops = {
+ .ndo_select_queue = select_queue,
+ ...
+};
+
+@@
+identifier ndo.select_queue;
+identifier dev, skb, accel_priv, fallback;
+type select_queue_fallback_t;
+type u16;
+@@
+u16 select_queue(
+ struct net_device *dev, struct sk_buff *skb
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ , void *accel_priv
++#endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
+ , select_queue_fallback_t fallback
++#endif
+ )
+ {...}
diff --git a/patches/collateral-evolutions/network/0028-select_queue/INFO b/patches/collateral-evolutions/network/0028-select_queue/INFO
deleted file mode 100644
index 519e4fcfa671..000000000000
--- a/patches/collateral-evolutions/network/0028-select_queue/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-backports: adapt to changes in netdev select_queue call
-
-This patch reverts the changes done in the following commit for older
-kernel versions:
-commit f663dd9aaf9ed124f25f0f8452edf238f087ad50
-Author: Jason Wang <jasowang@redhat.com>
-Date:   Fri Jan 10 16:18:26 2014 +0800
-
-    net: core: explicitly select a txq before doing l2 forwarding
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains f663dd9aaf9ed124f25f0f8452edf238f087ad50
-v3.13-rc8~4^2~2
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
deleted file mode 100644
index 39a9d4aa6737..000000000000
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ /dev/null
@@ -1,44 +0,0 @@
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -1101,10 +1101,20 @@ static void ieee80211_uninit(struct net_
- 	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
- static u16 ieee80211_netdev_select_queue(struct net_device *dev,
- 					 struct sk_buff *skb,
- 					 void *accel_priv,
- 					 select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb,
-+					 void *accel_priv)
-+#else
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb)
-+#endif
- {
- 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
- }
-@@ -1150,10 +1160,20 @@ static const struct net_device_ops ieee8
- 	.ndo_get_stats64	= ieee80211_get_stats64,
- };
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
- static u16 ieee80211_monitor_select_queue(struct net_device *dev,
- 					  struct sk_buff *skb,
- 					  void *accel_priv,
- 					  select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
-+static u16 ieee80211_monitor_select_queue(struct net_device *dev,
-+					  struct sk_buff *skb,
-+					  void *accel_priv)
-+#else
-+static u16 ieee80211_monitor_select_queue(struct net_device *dev,
-+					  struct sk_buff *skb)
-+#endif
- {
- 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
- 	struct ieee80211_local *local = sdata->local;
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
deleted file mode 100644
index 61a091b5c606..000000000000
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/wireless/marvell/mwifiex/main.c
-+++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1199,9 +1199,19 @@ static struct net_device_stats *mwifiex_
- 	return &priv->stats;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
- static u16
- mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
- 				void *accel_priv, select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
-+static u16
-+mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
-+				void *accel_priv)
-+#else
-+static u16
-+mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb)
-+#endif
- {
- 	skb->priority = cfg80211_classify8021d(skb, NULL);
- 	return mwifiex_1d_to_wmm_queue[skb->priority];
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
