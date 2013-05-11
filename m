Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41455 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab3EKSyw (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 May 2013 14:54:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so3502706pdi.15
        for <backports@vger.kernel.org>; Sat, 11 May 2013 11:54:51 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 4/5] backports: address vlan ethernet driver changes
Date: Sat, 11 May 2013 11:54:28 -0700
Message-Id: <1368298469-29143-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205453_723053_0EBE42B2)
In-Reply-To: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This addresses the last remaining components to
backport the ethernet vlan changes introduced by
9356b8fc d314774c and f646968f8f on next-20130423.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   14 +++---
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +--
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    6 +--
 .../drivers_net_ethernet_atheros_atlx_atl2.patch   |   49 +++++++++++++++-----
 4 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index f0e6f90..f673667 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -47,18 +47,18 @@
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2479,6 +2494,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2478,6 +2493,7 @@ static int atl1c_init_netdev(struct net_
+ 	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1c_set_ethtool_ops(netdev);
  
- 	/* TODO: add when ready */
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features =	NETIF_F_SG	   |
- 				NETIF_F_HW_CSUM	   |
- 				NETIF_F_HW_VLAN_RX |
+ 	/* TODO: add when ready */
+ 	netdev->hw_features =	NETIF_F_SG		|
+ 				NETIF_F_HW_CSUM		|
 @@ -2486,6 +2502,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
- 	netdev->features =	netdev->hw_features |
- 				NETIF_F_HW_VLAN_TX;
+ 	netdev->features =	netdev->hw_features	|
+ 				NETIF_F_HW_VLAN_CTAG_TX;
 +#else
 +	netdev->features =	NETIF_F_SG	   |
 +				NETIF_F_HW_CSUM	   |
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index 04eeb51..5a84c32 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -45,13 +45,13 @@
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
- 			      NETIF_F_HW_VLAN_RX;
+ 			      NETIF_F_HW_VLAN_CTAG_RX;
  	netdev->features = netdev->hw_features | NETIF_F_LLTX |
- 			   NETIF_F_HW_VLAN_TX;
+ 			   NETIF_F_HW_VLAN_CTAG_TX;
 +#else
 +	netdev->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
 +			   NETIF_F_HW_VLAN_RX | NETIF_F_LLTX | NETIF_F_HW_VLAN_TX;
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
++#endif
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index 2d36137..47dc6ae 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -11,13 +11,13 @@
  	.ndo_do_ioctl		= atlx_ioctl,
  	.ndo_tx_timeout		= atlx_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3023,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3020,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
  	netdev->features |= NETIF_F_SG;
- 	netdev->features |= (NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX);
+ 	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  	netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG | NETIF_F_TSO |
- 			      NETIF_F_HW_VLAN_RX;
+ 			      NETIF_F_HW_VLAN_CTAG_RX;
  
  	/* is this valid? see atl1_setup_mac_ctrl() */
  	netdev->features |= NETIF_F_RXCSUM;
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
index a9ce758..95b77e1 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
@@ -1,14 +1,31 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl2.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl2.c
-@@ -396,6 +396,7 @@ static void atl2_restore_vlan(struct atl
+@@ -365,6 +365,7 @@ static inline void atl2_irq_disable(stru
+     synchronize_irq(adapter->pdev->irq);
+ }
+ 
++#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
+ static void __atl2_vlan_mode(netdev_features_t features, u32 *ctrl)
+ {
+ 	if (features & NETIF_F_HW_VLAN_CTAG_RX) {
+@@ -390,12 +391,16 @@ static void atl2_vlan_mode(struct net_de
+ 
+ 	atl2_irq_enable(adapter);
+ }
++#endif
+ 
+ static void atl2_restore_vlan(struct atl2_adapter *adapter)
+ {
++#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  	atl2_vlan_mode(adapter->netdev, adapter->netdev->features);
++#endif
  }
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  static netdev_features_t atl2_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -421,6 +422,7 @@ static int atl2_set_features(struct net_
+@@ -421,6 +426,7 @@ static int atl2_set_features(struct net_
  
  	return 0;
  }
@@ -16,7 +33,17 @@
  
  static void atl2_intr_rx(struct atl2_adapter *adapter)
  {
-@@ -1319,8 +1321,10 @@ static const struct net_device_ops atl2_
+@@ -1154,7 +1160,9 @@ static void atl2_setup_mac_ctrl(struct a
+ 		MAC_CTRL_PRMLEN_SHIFT);
+ 
+ 	/* vlan */
++#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
+ 	__atl2_vlan_mode(netdev->features, &value);
++#endif
+ 
+ 	/* filter mode */
+ 	value |= MAC_CTRL_BC_EN;
+@@ -1319,8 +1327,10 @@ static const struct net_device_ops atl2_
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl2_set_mac,
  	.ndo_change_mtu		= atl2_change_mtu,
@@ -27,20 +54,20 @@
  	.ndo_do_ioctl		= atl2_ioctl,
  	.ndo_tx_timeout		= atl2_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -1417,8 +1421,12 @@ static int atl2_probe(struct pci_dev *pd
+@@ -1417,8 +1427,12 @@ static int atl2_probe(struct pci_dev *pd
  
  	err = -EIO;
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_VLAN_RX;
+ 	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_RX;
 +#endif
 +#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->features |= (NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX);
+ 	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
 +#endif
  
  	/* Init PHY as early as possible due to power saving issue  */
  	atl2_phy_init(&adapter->hw);
-@@ -1838,6 +1846,13 @@ static int atl2_set_settings(struct net_
+@@ -2092,6 +2106,13 @@ static int atl2_nway_reset(struct net_de
  	return 0;
  }
  
@@ -51,10 +78,10 @@
 +}
 +#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
 +
- static u32 atl2_get_msglevel(struct net_device *netdev)
- {
- 	return 0;
-@@ -2107,6 +2122,14 @@ static const struct ethtool_ops atl2_eth
+ static const struct ethtool_ops atl2_ethtool_ops = {
+ 	.get_settings		= atl2_get_settings,
+ 	.set_settings		= atl2_set_settings,
+@@ -2107,6 +2128,14 @@ static const struct ethtool_ops atl2_eth
  	.get_eeprom_len		= atl2_get_eeprom_len,
  	.get_eeprom		= atl2_get_eeprom,
  	.set_eeprom		= atl2_set_eeprom,
-- 
1.7.10.4

