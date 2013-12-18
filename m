Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab3LRQJl (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 18 Dec 2013 11:09:41 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC v2 09/11] backports: igb fixes for linux-3.2
Date: Wed, 18 Dec 2013 17:08:23 +0100
Message-Id: <1387382905-14274-10-git-send-email-sassmann@kpanic.de> (sfid-20131218_170943_059149_04ECD60F)
In-Reply-To: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
- add patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/82-ethernet/0009-igb_vlan_rx_vid.patch | 64 ++++++++++++++++++++++
 .../network/82-ethernet/0010-igb_ethtool_ops.patch | 16 ++++++
 2 files changed, 80 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch

diff --git a/patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch b/patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
new file mode 100644
index 0000000..44ea22e
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
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
diff --git a/patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch
new file mode 100644
index 0000000..73504ab
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index b3c07d1..fcc7eb1 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -3012,9 +3012,11 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
+ #endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
+ 	.get_rxfh_indir		= igb_get_rxfh_indir,
+ 	.set_rxfh_indir		= igb_set_rxfh_indir,
++#endif
+ 	.get_channels		= igb_get_channels,
+ 	.set_channels		= igb_set_channels,
+ 	.begin			= igb_ethtool_begin,
-- 
1.8.3.1

