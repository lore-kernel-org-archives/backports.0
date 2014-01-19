Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58380 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaASQsj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/16] backports: fix unused atl1e_rx_mode() warning
Date: Sun, 19 Jan 2014 17:47:35 +0100
Message-Id: <1390150057-11652-15-git-send-email-hauke@hauke-m.de> (sfid-20140119_174922_073912_47FDFCF1)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

/drivers/net/ethernet/atheros/atl1e/atl1e_main.c:328:13: warning: ‘atl1e_rx_mode’ defined but not used [-Wunused-function]
 static void atl1e_rx_mode(struct net_device *netdev,
             ^

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |   26 ++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index 6927a57..72488f9 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -1,6 +1,22 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -399,6 +399,7 @@ static int atl1e_set_mac_addr(struct net
+@@ -313,6 +313,7 @@ static void atl1e_set_multi(struct net_d
+ 	}
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
+ static void __atl1e_rx_mode(netdev_features_t features, u32 *mac_ctrl_data)
+ {
+ 
+@@ -339,6 +340,7 @@ static void atl1e_rx_mode(struct net_dev
+ 	AT_WRITE_REG(&adapter->hw, REG_MAC_CTRL, mac_ctrl_data);
+ 	atl1e_irq_enable(adapter);
+ }
++#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
+ 
+ 
+ static void __atl1e_vlan_mode(netdev_features_t features, u32 *mac_ctrl_data)
+@@ -399,6 +401,7 @@ static int atl1e_set_mac_addr(struct net
  	return 0;
  }
  
@@ -8,7 +24,7 @@
  static netdev_features_t atl1e_fix_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -428,6 +429,7 @@ static int atl1e_set_features(struct net
+@@ -428,6 +431,7 @@ static int atl1e_set_features(struct net
  
  	return 0;
  }
@@ -16,7 +32,7 @@
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1987,7 +1989,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1995,7 +1999,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -28,7 +44,7 @@
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2257,8 +2263,10 @@ static const struct net_device_ops atl1e
+@@ -2265,8 +2273,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -39,7 +55,7 @@
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2278,12 +2286,17 @@ static int atl1e_init_netdev(struct net_
+@@ -2286,12 +2296,17 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
-- 
1.7.10.4

