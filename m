Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51897 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422884AbbEENWK (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 5 May 2015 09:22:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: arend@broadcom.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: handle netdev->tstats
Date: Tue,  5 May 2015 15:22:05 +0200
Message-Id: <1430832125-3195-1-git-send-email-johannes@sipsolutions.net> (sfid-20150505_152212_145164_5119F395)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This adds the necessary backporting to handle netdev->tstats which
was introduced in 3.14 (and some helper macros in 3.15).

For some reason my spatch isn't reliably patching the occurrence
in net/mac80211/tx.c, so for now I'm including a manual patch.

Change-Id: Ib22e307a9bd31f6c31372ef8cc2828ca6e14fce4
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h        | 30 ++++++++++++++++++++++
 .../network/0055-netdev-tstats-assign.cocci        | 10 ++++++++
 .../network/0055-netdev-tstats-tx.patch            | 11 ++++++++
 .../network/0056-netdev-tstats.cocci               |  9 +++++++
 4 files changed, 60 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
 create mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
 create mode 100644 patches/collateral-evolutions/network/0056-netdev-tstats.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index abbfe1d43b7e..b99816a44dd3 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -80,6 +80,20 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 {
 	dev_kfree_skb_any(skb);
 }
+
+struct pcpu_sw_netstats {
+	u64     rx_packets;
+	u64     rx_bytes;
+	u64     tx_packets;
+	u64     tx_bytes;
+	struct u64_stats_sync   syncp;
+};
+
+#define netdev_tstats(dev)	((struct pcpu_sw_netstats *)dev->ml_priv)
+#define netdev_assign_tstats(dev, e)	dev->ml_priv = (e);
+#else
+#define netdev_tstats(dev)	dev->tstats
+#define netdev_assign_tstats(dev, e)	dev->tstats = (e);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8)
@@ -254,4 +268,20 @@ static inline struct sk_buff *napi_alloc_skb(struct napi_struct *napi,
 #define IFF_TX_SKB_SHARING 0
 #endif
 
+#ifndef netdev_alloc_pcpu_stats
+#define netdev_alloc_pcpu_stats(type)				\
+({								\
+	typeof(type) __percpu *pcpu_stats = alloc_percpu(type); \
+	if (pcpu_stats)	{					\
+		int i;						\
+		for_each_possible_cpu(i) {			\
+			typeof(type) *stat;			\
+			stat = per_cpu_ptr(pcpu_stats, i);	\
+			u64_stats_init(&stat->syncp);		\
+		}						\
+	}							\
+	pcpu_stats;						\
+})
+#endif /* netdev_alloc_pcpu_stats */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci b/patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
new file mode 100644
index 000000000000..b41b4f17e654
--- /dev/null
+++ b/patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
@@ -0,0 +1,10 @@
+@nd@
+identifier dev;
+@@
+struct net_device *dev;
+@@
+identifier nd.dev;
+expression E;
+@@
+-dev->tstats = E;
++netdev_assign_tstats(dev, E);
diff --git a/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch b/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
new file mode 100644
index 000000000000..aa79e0298cb1
--- /dev/null
+++ b/patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
@@ -0,0 +1,11 @@
+--- a/net/mac80211/tx.c
++++ b/net/mac80211/tx.c
+@@ -39,7 +39,7 @@
+ 
+ static inline void ieee80211_tx_stats(struct net_device *dev, u32 len)
+ {
+-	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
++	struct pcpu_sw_netstats *tstats = this_cpu_ptr(netdev_tstats(dev));
+ 
+ 	u64_stats_update_begin(&tstats->syncp);
+ 	tstats->tx_packets++;
diff --git a/patches/collateral-evolutions/network/0056-netdev-tstats.cocci b/patches/collateral-evolutions/network/0056-netdev-tstats.cocci
new file mode 100644
index 000000000000..99d71c05713e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0056-netdev-tstats.cocci
@@ -0,0 +1,9 @@
+@nd@
+identifier dev;
+@@
+struct net_device *dev;
+@@
+identifier nd.dev;
+@@
+-dev->tstats
++netdev_tstats(dev)
-- 
2.1.4

