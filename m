Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:58183 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3LVKI1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 05:08:27 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] network: mac80211: rework multicast patches for mac80211
Date: Sun, 22 Dec 2013 11:08:22 +0100
Message-ID: <1387706902-12322-1-git-send-email-arend@broadcom.com> (sfid-20131222_110836_368323_821C7D89)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Fixing up the patches for mac80211 that were located under
collateral-evolutions/network/25-multicast-list_head.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 gen-brcm-backport.sh                               |    1 -
 .../include_net_mac80211.patch                     |   14 +--------
 .../net_mac80211_driver-ops.patch                  |   33 +-------------------
 .../net_mac80211_iface.patch                       |   16 +++-------
 4 files changed, 6 insertions(+), 58 deletions(-)

diff --git a/gen-brcm-backport.sh b/gen-brcm-backport.sh
index 34001c2..90a99a7 100755
--- a/gen-brcm-backport.sh
+++ b/gen-brcm-backport.sh
@@ -34,7 +34,6 @@ function get_sha1ref() {
 }
 
 parse_cmdline $*
-echo ${GITTREE}
 SHA1REF=$(get_sha1ref)
 BACKPORT_RELEASE=brcm-backports${REPOTAG}-g$(get_sha1ref)
 TMPDIR=/tmp/${BACKPORT_RELEASE}
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index 1635cd0..ae30fe1 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2719,14 +2719,24 @@ struct ieee80211_ops {
+@@ -2719,8 +2719,12 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -13,15 +13,3 @@
  				 unsigned int changed_flags,
  				 unsigned int *total_flags,
  				 u64 multicast);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	void (*set_multicast_list)(struct ieee80211_hw *hw,
- 				   struct ieee80211_vif *vif, bool allmulti,
- 				   struct netdev_hw_addr_list *mc_list);
-+#else
-+	void (*set_multicast_list)(struct ieee80211_hw *hw,
-+				   struct ieee80211_vif *vif, bool allmulti,
-+				   int mc_count, struct dev_addr_list *ha);
-+#endif
- 
- 	int (*set_tim)(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
- 		       bool set);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
index 042cca7..0332c91 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -228,20 +228,35 @@ static inline void drv_bss_info_changed(
+@@ -228,14 +228,28 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -29,34 +29,3 @@
  
  	trace_drv_return_u64(local, ret);
  
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static inline void drv_set_multicast_list(struct ieee80211_local *local,
- 					  struct ieee80211_sub_if_data *sdata,
- 					  struct netdev_hw_addr_list *mc_list)
-@@ -257,6 +272,23 @@ static inline void drv_set_multicast_lis
- 					       allmulti, mc_list);
- 	trace_drv_return_void(local);
- }
-+#else
-+static inline void drv_set_multicast_list(struct ieee80211_local *local,
-+					  struct ieee80211_sub_if_data *sdata,
-+					  int mc_count, struct dev_addr_list *ha)
-+{
-+	bool allmulti = sdata->flags & IEEE80211_SDATA_ALLMULTI;
-+
-+	trace_drv_set_multicast_list(local, sdata, mc_count);
-+
-+	check_sdata_in_driver(sdata);
-+
-+	if (local->ops->set_multicast_list)
-+		local->ops->set_multicast_list(&local->hw, &sdata->vif,
-+					       allmulti, mc_count, ha);
-+	trace_drv_return_void(local);
-+}
-+#endif
- 
- static inline void drv_configure_filter(struct ieee80211_local *local,
- 					unsigned int changed_flags,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index d196bca..e03645b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -807,8 +807,13 @@ static void ieee80211_do_stop(struct iee
+@@ -808,8 +808,13 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,17 +14,9 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1022,10 +1027,20 @@ static void ieee80211_set_multicast_list
- 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		drv_set_multicast_list(local, sdata, &dev->mc);
-+#else
-+		drv_set_multicast_list(local, sdata, dev->mc_count,
-+				       dev->mc_list);
-+#endif
- 
+@@ -1009,7 +1014,12 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
+ 		sdata->flags ^= IEEE80211_SDATA_PROMISC;
+ 	}
  	spin_lock_bh(&local->filter_lock);
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
-- 
1.7.10.4

