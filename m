Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58318 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbaASQr6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:47:58 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/16] backports: adapt to changes in netdev select_queue call
Date: Sun, 19 Jan 2014 17:47:22 +0100
Message-Id: <1390150057-11652-2-git-send-email-hauke@hauke-m.de> (sfid-20140119_174802_812995_8161EBB4)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch reverts the changes done in the following commit for older
kernel versions:
commit f663dd9aaf9ed124f25f0f8452edf238f087ad50
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri Jan 10 16:18:26 2014 +0800

    net: core: explicitly select a txq before doing l2 forwarding

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../network/83-select_queue/INFO                   |    9 ++++++
 .../network/83-select_queue/mac80211.patch         |   34 ++++++++++++++++++++
 .../network/83-select_queue/mwifiex.patch          |   19 +++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/INFO
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/mac80211.patch
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/83-select_queue/INFO b/patches/collateral-evolutions/network/83-select_queue/INFO
new file mode 100644
index 0000000..6925ef7
--- /dev/null
+++ b/patches/collateral-evolutions/network/83-select_queue/INFO
@@ -0,0 +1,9 @@
+backports: adapt to changes in netdev select_queue call
+
+This patch reverts the changes done in the following commit for older
+kernel versions:
+commit f663dd9aaf9ed124f25f0f8452edf238f087ad50
+Author: Jason Wang <jasowang@redhat.com>
+Date:   Fri Jan 10 16:18:26 2014 +0800
+
+    net: core: explicitly select a txq before doing l2 forwarding
diff --git a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
new file mode 100644
index 0000000..0e61876
--- /dev/null
+++ b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
@@ -0,0 +1,34 @@
+diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
+index 3dfd20a..0696aec 100644
+--- a/net/mac80211/iface.c
++++ b/net/mac80211/iface.c
+@@ -1054,9 +1054,14 @@ static void ieee80211_uninit(struct net_
+ 	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ static u16 ieee80211_netdev_select_queue(struct net_device *dev,
+ 					 struct sk_buff *skb,
+ 					 void *accel_priv)
++#else
++static u16 ieee80211_netdev_select_queue(struct net_device *dev,
++					 struct sk_buff *skb)
++#endif
+ {
+ 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
+ }
+@@ -1072,9 +1077,14 @@ static const struct net_device_ops ieee8
+ 	.ndo_select_queue	= ieee80211_netdev_select_queue,
+ };
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ static u16 ieee80211_monitor_select_queue(struct net_device *dev,
+ 					  struct sk_buff *skb,
+ 					  void *accel_priv)
++#else
++static u16 ieee80211_monitor_select_queue(struct net_device *dev,
++					  struct sk_buff *skb)
++#endif
+ {
+ 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+ 	struct ieee80211_local *local = sdata->local;
diff --git a/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
new file mode 100644
index 0000000..78292d2
--- /dev/null
+++ b/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
@@ -0,0 +1,19 @@
+diff --git a/drivers/net/wireless/mwifiex/main.c b/drivers/net/wireless/mwifiex/main.c
+index 4d79761..8bd0316 100644
+--- a/drivers/net/wireless/mwifiex/main.c
++++ b/drivers/net/wireless/mwifiex/main.c
+@@ -746,9 +746,14 @@ static struct net_device_stats *mwifiex_
+ 	return &priv->stats;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ static u16
+ mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
+ 				void *accel_priv)
++#else
++static u16
++mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb)
++#endif
+ {
+ 	skb->priority = cfg80211_classify8021d(skb, NULL);
+ 	return mwifiex_1d_to_wmm_queue[skb->priority];
-- 
1.7.10.4

