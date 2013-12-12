Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab3LLJ3N (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:13 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 09/10] backports: igb fixes for linux-3.2
Date: Thu, 12 Dec 2013 10:28:01 +0100
Message-Id: <1386840482-585-10-git-send-email-sassmann@kpanic.de> (sfid-20131212_102915_296594_48115A6A)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- handle struct ethtool_ops changes
- add patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h          |  5 ++
 .../network/82-ethernet/igb_vlan_rx_vid.patch      | 64 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 9a7575f..c2ab04d 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -224,6 +224,11 @@ struct backport_ethtool_ops {
 				     struct ethtool_eeprom *, u8 *);
 	int	(*get_eee)(struct net_device *, struct ethtool_eee *);
 	int	(*set_eee)(struct net_device *, struct ethtool_eee *);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+	u32	(*get_rx_csum)(struct net_device *);
+	u32	(*get_flags)(struct net_device *);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 };
 #define ethtool_ops LINUX_BACKPORT(ethtool_ops)
 
diff --git a/patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch b/patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch
new file mode 100644
index 0000000..44ea22e
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch
@@ -0,0 +1,64 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 37e6062..6bf0a88 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -164,10 +164,13 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
+ static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
+-#else
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static int igb_vlan_rx_add_vid(struct net_device *, u16);
+ static int igb_vlan_rx_kill_vid(struct net_device *, u16);
+-#endif
++#else
++static void igb_vlan_rx_add_vid(struct net_device *, u16);
++static void igb_vlan_rx_kill_vid(struct net_device *, u16);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ static void igb_restore_vlan(struct igb_adapter *);
+ static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
+ static void igb_ping_all_vfs(struct igb_adapter *);
+@@ -6974,8 +6977,10 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_add_vid(struct net_device *netdev,
+ 			       __be16 proto, u16 vid)
+-#else
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
++#else
++static void igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
+ #endif
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+@@ -6990,15 +6995,19 @@ static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
+ 
+ 	set_bit(vid, adapter->active_vlans);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_kill_vid(struct net_device *netdev,
+ 				__be16 proto, u16 vid)
+-#else
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
+-#endif
++#else
++static void igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+ 	struct e1000_hw *hw = &adapter->hw;
+@@ -7014,7 +7023,9 @@ static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
+ 
+ 	clear_bit(vid, adapter->active_vlans);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
+ static void igb_restore_vlan(struct igb_adapter *adapter)
-- 
1.8.3.1

