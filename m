Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbaASJHm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 04:07:42 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: add support for
Date: Sun, 19 Jan 2014 11:06:03 +0200
Message-Id: <1390122363-27130-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140119_100753_667500_64575331)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

commit f663dd9aaf9ed124f25f0f8452edf238f087ad50
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri Jan 10 16:18:26 2014 +0800

    net: core: explicitly select a txq before doing l2 forwarding

Change-Id: I0a03c7ddc29acef9e573b70232e51c512f65e453
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
I am not a backport expert - and there might be other nicer ways to do this.
At least it worked for me.
---
 backport/backport-include/linux/netdevice.h        |  3 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |  2 +-
 .../82-l2-fwd_offload/net_mac80211_iface.patch     | 32 ++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/82-l2-fwd_offload/net_mac80211_iface.patch

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 3d6b7b3..137aa77 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -47,7 +47,8 @@ struct net_device_ops {
 	netdev_tx_t		(*ndo_start_xmit) (struct sk_buff *skb,
 						   struct net_device *dev);
 	u16			(*ndo_select_queue)(struct net_device *dev,
-						    struct sk_buff *skb);
+						    struct sk_buff *skb,
+						    void *accel_priv);
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 23e3c9b..179d797 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -6,7 +6,7 @@
  
 +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27))
 +	/* Older kernels do not have the select_queue callback */
-+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
++	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb, NULL));
 +#endif
  	ieee80211_set_qos_hdr(sdata, skb);
  	ieee80211_tx(sdata, skb, false, band);
diff --git a/patches/collateral-evolutions/network/82-l2-fwd_offload/net_mac80211_iface.patch b/patches/collateral-evolutions/network/82-l2-fwd_offload/net_mac80211_iface.patch
new file mode 100644
index 0000000..124e841
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-l2-fwd_offload/net_mac80211_iface.patch
@@ -0,0 +1,32 @@
+diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
+index 0fd2e9f..6af9bbf 100644
+--- a/net/mac80211/iface.c
++++ b/net/mac80211/iface.c
+@@ -1050,8 +1050,12 @@ static void ieee80211_uninit(struct net_device *dev)
+ }
+ 
+ static u16 ieee80211_netdev_select_queue(struct net_device *dev,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14, 0)
++					 struct sk_buff *skb)
++#else
+ 					 struct sk_buff *skb,
+ 					 void *accel_priv)
++#endif
+ {
+ 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
+ }
+@@ -1068,8 +1072,12 @@ static const struct net_device_ops ieee80211_dataif_ops = {
+ };
+ 
+ static u16 ieee80211_monitor_select_queue(struct net_device *dev,
+-					  struct sk_buff *skb,
+-					  void *accel_priv)
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14, 0)
++					 struct sk_buff *skb)
++#else
++					 struct sk_buff *skb,
++					 void *accel_priv)
++#endif
+ {
+ 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+ 	struct ieee80211_local *local = sdata->local;
-- 
1.8.3.2

