Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44879 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbaFOVWZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 4FDF97E5B
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:24 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/19] backports: handle rename of ndo_set_vf_tx_rate to ndo_set_vf_rate
Date: Sun, 15 Jun 2014 23:21:40 +0200
Message-Id: <1402867307-31337-13-git-send-email-hauke@hauke-m.de> (sfid-20140615_232227_023448_F466AEFF)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This member of struct net_device_ops was renamed and the function
signature was also changed a bit.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0043-ndo_set_vf_rate/igb.patch         | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch

diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
new file mode 100644
index 0000000..59a22e5
--- /dev/null
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -0,0 +1,78 @@
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -177,7 +177,11 @@ static void igb_restore_vf_multicasts(st
+ static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
+ static int igb_ndo_set_vf_vlan(struct net_device *netdev,
+ 			       int vf, u16 vlan, u8 qos);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
++#else
++static int igb_ndo_set_vf_bw(struct net_device *, int, int);
++#endif
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
+ 				   bool setting);
+@@ -2102,7 +2106,11 @@ static const struct net_device_ops igb_n
+ 	.ndo_vlan_rx_kill_vid	= igb_vlan_rx_kill_vid,
+ 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
+ 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ 	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
++#else
++	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
++#endif
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+@@ -7929,8 +7937,12 @@ static void igb_check_vf_rate_limit(stru
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf,
+ 			     int min_tx_rate, int max_tx_rate)
++#else
++static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate)
++#endif
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+ 	struct e1000_hw *hw = &adapter->hw;
+@@ -7939,6 +7951,7 @@ static int igb_ndo_set_vf_bw(struct net_
+ 	if (hw->mac.type != e1000_82576)
+ 		return -EOPNOTSUPP;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ 	if (min_tx_rate)
+ 		return -EINVAL;
+ 
+@@ -7952,7 +7965,17 @@ static int igb_ndo_set_vf_bw(struct net_
+ 	adapter->vf_rate_link_speed = actual_link_speed;
+ 	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
+ 	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
++#else
++	actual_link_speed = igb_link_mbps(adapter->link_speed);
++	if ((vf >= adapter->vfs_allocated_count) ||
++	    (!(rd32(E1000_STATUS) & E1000_STATUS_LU)) ||
++	    (tx_rate < 0) || (tx_rate > actual_link_speed))
++		return -EINVAL;
+ 
++	adapter->vf_rate_link_speed = actual_link_speed;
++	adapter->vf_data[vf].tx_rate = (u16)tx_rate;
++	igb_set_vf_rate_limit(hw, vf, tx_rate, actual_link_speed);
++#endif
+ 	return 0;
+ }
+ 
+@@ -7993,8 +8016,12 @@ static int igb_ndo_get_vf_config(struct
+ 		return -EINVAL;
+ 	ivi->vf = vf;
+ 	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ 	ivi->max_tx_rate = adapter->vf_data[vf].tx_rate;
+ 	ivi->min_tx_rate = 0;
++#else
++	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
++#endif
+ 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
+ 	ivi->qos = adapter->vf_data[vf].pf_qos;
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
-- 
1.9.1

