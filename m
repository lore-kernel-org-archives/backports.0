Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:51110 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbbEANqj (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 1 May 2015 09:46:39 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: mac80211: revert to old stats behaviour for older kernels
Date: Fri, 1 May 2015 15:46:34 +0200
Message-ID: <1430487994-20598-1-git-send-email-arend@broadcom.com> (sfid-20150501_154642_126166_7597CA83)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 5a490510ba5f ("mac80211: use per-CPU TX/RX statistics") introduced
the use of per-cpu statistics, ie. struct netdevice::tstats. This is not
supported in kernel 3.14 and older.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
I am not entirely sure whether 3.14 is the correct version to check for. The
functionality seems introduced there but there were some subsequent patches
on the per-cpu netdev stats functionality.

Regards,
Arend
---
 ...ac80211-revert-to-old-stats-behaviour-for.patch | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 patches/0000-upstream-backport-changes/0001-backports-mac80211-revert-to-old-stats-behaviour-for.patch

diff --git a/patches/0000-upstream-backport-changes/0001-backports-mac80211-revert-to-old-stats-behaviour-for.patch b/patches/0000-upstream-backport-changes/0001-backports-mac80211-revert-to-old-stats-behaviour-for.patch
new file mode 100644
index 0000000..2b91a11
--- /dev/null
+++ b/patches/0000-upstream-backport-changes/0001-backports-mac80211-revert-to-old-stats-behaviour-for.patch
@@ -0,0 +1,127 @@
+From 92115bd3d3c3988fafe29053e8bb28022e809ca5 Mon Sep 17 00:00:00 2001
+From: Arend van Spriel <arend@broadcom.com>
+Date: Thu, 30 Apr 2015 20:57:51 +0200
+Subject: [PATCH] backports: mac80211: revert to old stats behaviour for older
+ kernels
+
+The per_cpu stats were added since 3.15. Just revert to old behaviour
+for older kernels.
+
+Signed-off-by: Arend van Spriel <arend@broadcom.com>
+---
+ net/mac80211/iface.c | 15 +++++++++++----
+ net/mac80211/rx.c    |  5 +++++
+ net/mac80211/tx.c    |  5 +++++
+ 3 files changed, 21 insertions(+), 4 deletions(-)
+
+diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
+index 4ee8fea..60e446e 100644
+--- a/net/mac80211/iface.c
++++ b/net/mac80211/iface.c
+@@ -1096,6 +1096,7 @@ static u16 ieee80211_netdev_select_queue(struct net_device *dev,
+ 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static struct rtnl_link_stats64 *
+ ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+ {
+@@ -1124,6 +1125,10 @@ ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+ 
+ 	return stats;
+ }
++#define GET_STATS64(_fp)	_fp
++#else
++#define GET_STATS64(_fp)	NULL
++#endif
+ 
+ static const struct net_device_ops ieee80211_dataif_ops = {
+ 	.ndo_open		= ieee80211_open,
+@@ -1134,7 +1139,7 @@ static const struct net_device_ops ieee80211_dataif_ops = {
+ 	.ndo_change_mtu 	= ieee80211_change_mtu,
+ 	.ndo_set_mac_address 	= ieee80211_change_mac,
+ 	.ndo_select_queue	= ieee80211_netdev_select_queue,
+-	.ndo_get_stats64	= ieee80211_get_stats64,
++	.ndo_get_stats64	= GET_STATS64(ieee80211_get_stats64),
+ };
+ 
+ static u16 ieee80211_monitor_select_queue(struct net_device *dev,
+@@ -1168,12 +1173,14 @@ static const struct net_device_ops ieee80211_monitorif_ops = {
+ 	.ndo_change_mtu 	= ieee80211_change_mtu,
+ 	.ndo_set_mac_address 	= ieee80211_change_mac,
+ 	.ndo_select_queue	= ieee80211_monitor_select_queue,
+-	.ndo_get_stats64	= ieee80211_get_stats64,
++	.ndo_get_stats64	= GET_STATS64(ieee80211_get_stats64),
+ };
+ 
+ static void ieee80211_if_free(struct net_device *dev)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	free_percpu(dev->tstats);
++#endif
+ 	free_netdev(dev);
+ }
+ 
+@@ -1722,13 +1729,13 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
+ 		if (!ndev)
+ 			return -ENOMEM;
+ 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
+-
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+ 		if (!ndev->tstats) {
+ 			free_netdev(ndev);
+ 			return -ENOMEM;
+ 		}
+-
++#endif
+ 		ndev->needed_headroom = local->tx_headroom +
+ 					4*6 /* four MAC addresses */
+ 					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
+diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
+index e082535..0e15823 100644
+--- a/net/mac80211/rx.c
++++ b/net/mac80211/rx.c
+@@ -34,12 +34,17 @@
+ 
+ static inline void ieee80211_rx_stats(struct net_device *dev, u32 len)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+ 
+ 	u64_stats_update_begin(&tstats->syncp);
+ 	tstats->rx_packets++;
+ 	tstats->rx_bytes += len;
+ 	u64_stats_update_end(&tstats->syncp);
++#else
++	dev->stats.rx_packets++;
++	dev->stats.rx_bytes += len;
++#endif
+ }
+ 
+ /*
+diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
+index 745fdf5..7b77c93 100644
+--- a/net/mac80211/tx.c
++++ b/net/mac80211/tx.c
+@@ -39,12 +39,17 @@
+ 
+ static inline void ieee80211_tx_stats(struct net_device *dev, u32 len)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+ 
+ 	u64_stats_update_begin(&tstats->syncp);
+ 	tstats->tx_packets++;
+ 	tstats->tx_bytes += len;
+ 	u64_stats_update_end(&tstats->syncp);
++#else
++	dev->stats.tx_packets++;
++	dev->stats.tx_bytes += len;
++#endif
+ }
+ 
+ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
+-- 
+1.9.1
+
-- 
1.9.1

