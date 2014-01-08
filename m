Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbaAHKou (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:44:50 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 09/11] backports: igb fixes for linux-3.2
Date: Wed,  8 Jan 2014 11:44:12 +0100
Message-Id: <1389177854-24292-10-git-send-email-sassmann@kpanic.de> (sfid-20140108_114451_662938_9EB496F6)
In-Reply-To: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
- add patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/82-ethernet/0009-igb_vlan_rx_vid.patch | 64 ++++++++++++++++++++++
 .../network/82-ethernet/0010-igb_ethtool_ops.patch | 48 ++++++++++++++++
 2 files changed, 112 insertions(+)
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
index 0000000..9035d92
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch
@@ -0,0 +1,48 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 3cf9600..5e519ce 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2812,6 +2812,7 @@ static void igb_ethtool_complete(struct net_device *netdev)
+ 	pm_runtime_put(&adapter->pdev->dev);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
+ {
+ 	return IGB_RETA_SIZE;
+@@ -2827,6 +2828,7 @@ static int igb_get_rxfh_indir(struct net_device *netdev, u32 *indir)
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ 
+ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
+ {
+@@ -2863,6 +2865,7 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+@@ -2895,6 +2898,7 @@ static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ 
+ static unsigned int igb_max_channels(struct igb_adapter *adapter)
+ {
+@@ -3017,9 +3021,11 @@ static const struct ethtool_ops igb_ethtool_ops = {
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
1.8.4.2

