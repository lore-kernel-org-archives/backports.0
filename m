Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbbBYOWJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:09 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 08/10] backports: replace struct net_device_ops set_vf_rate changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:52 +0100
Message-Id: <1424874054-22956-9-git-send-email-sassmann@kpanic.de> (sfid-20150225_152218_485341_187462A0)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0043-ndo_set_vf_rate/INFO              | 17 +++++
 .../network/0043-ndo_set_vf_rate/igb.patch         | 78 ----------------------
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     | 28 ++++++++
 .../network/0043-ndo_set_vf_rate/set_vf_rate.cocci | 50 ++++++++++++++
 4 files changed, 95 insertions(+), 78 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/INFO
 delete mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
 create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/set_vf_rate.cocci

diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/INFO b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/INFO
new file mode 100644
index 0000000..a8f0c49
--- /dev/null
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/INFO
@@ -0,0 +1,17 @@
+In kernel 3.16 struct net_device_ops changed and renamed pointer
+ndo_set_vf_tx_rate to ndo_set_vf_rate.
+
+commit ed616689a3d95eb6c9bdbb1ef74b0f50cbdf276a
+Author: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
+Date:   Thu May 22 09:59:05 2014 -0400
+
+    net-next:v4: Add support to configure SR-IOV VF minimum and maximum Tx rate through ip tool.
+
+commit 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
+Author: Greg Rose <gregory.v.rose@intel.com>
+Date:   Sat Oct 8 03:05:24 2011 +0000
+
+    if_link: Add additional parameter to IFLA_VF_INFO for spoof checking
+
+git describe --contains ed616689a3d95eb6c9bdbb1ef74b0f50cbdf276a
+v3.16-rc1~27^2~151
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
deleted file mode 100644
index 191218a..0000000
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ /dev/null
@@ -1,78 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -177,7 +177,11 @@ static void igb_restore_vf_multicasts(st
- static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
- static int igb_ndo_set_vf_vlan(struct net_device *netdev,
- 			       int vf, u16 vlan, u8 qos);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
-+#else
-+static int igb_ndo_set_vf_bw(struct net_device *, int, int);
-+#endif
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
- 				   bool setting);
-@@ -2105,7 +2109,11 @@ static const struct net_device_ops igb_n
- 	.ndo_vlan_rx_kill_vid	= igb_vlan_rx_kill_vid,
- 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
- 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- 	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
-+#else
-+	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
-+#endif
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7900,8 +7908,12 @@ static void igb_check_vf_rate_limit(stru
- 	}
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf,
- 			     int min_tx_rate, int max_tx_rate)
-+#else
-+static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7910,6 +7922,7 @@ static int igb_ndo_set_vf_bw(struct net_
- 	if (hw->mac.type != e1000_82576)
- 		return -EOPNOTSUPP;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- 	if (min_tx_rate)
- 		return -EINVAL;
- 
-@@ -7923,7 +7936,17 @@ static int igb_ndo_set_vf_bw(struct net_
- 	adapter->vf_rate_link_speed = actual_link_speed;
- 	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
- 	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
-+#else
-+	actual_link_speed = igb_link_mbps(adapter->link_speed);
-+	if ((vf >= adapter->vfs_allocated_count) ||
-+	    (!(rd32(E1000_STATUS) & E1000_STATUS_LU)) ||
-+	    (tx_rate < 0) || (tx_rate > actual_link_speed))
-+		return -EINVAL;
- 
-+	adapter->vf_rate_link_speed = actual_link_speed;
-+	adapter->vf_data[vf].tx_rate = (u16)tx_rate;
-+	igb_set_vf_rate_limit(hw, vf, tx_rate, actual_link_speed);
-+#endif
- 	return 0;
- }
- 
-@@ -7964,8 +7987,12 @@ static int igb_ndo_get_vf_config(struct
- 		return -EINVAL;
- 	ivi->vf = vf;
- 	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- 	ivi->max_tx_rate = adapter->vf_data[vf].tx_rate;
- 	ivi->min_tx_rate = 0;
-+#else
-+	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
-+#endif
- 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
- 	ivi->qos = adapter->vf_data[vf].pf_qos;
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
new file mode 100644
index 0000000..4c59522
--- /dev/null
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -7863,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
+ 	if (hw->mac.type != e1000_82576)
+ 		return -EOPNOTSUPP;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ 	if (min_tx_rate)
+ 		return -EINVAL;
+ 
+@@ -7876,7 +7889,17 @@ static int igb_ndo_set_vf_bw(struct net_
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
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
+ 	return 0;
+ }
+ 
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/set_vf_rate.cocci b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/set_vf_rate.cocci
new file mode 100644
index 0000000..c8c3af0
--- /dev/null
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/set_vf_rate.cocci
@@ -0,0 +1,50 @@
+@r1@
+identifier s, func;
+@@
+
+struct net_device_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+.ndo_set_vf_rate = func,
++#else
++.ndo_set_vf_tx_rate = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
+};
+
+@r2@
+identifier s, func2;
+@@
+
+struct net_device_ops s = {
+.ndo_get_vf_config = func2,
+};
+
+// ----------------------------------------------------------------------
+
+@@
+identifier r1.func, min_tx_rate, max_tx_rate;
+@@
+
+func(...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ ,int min_tx_rate, int max_tx_rate
++#else
++,int tx_rate
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
+ ) { ... }
+
+@@
+identifier r2.func2, ivi;
+expression assign, assign2;
+@@
+
+func2(...  ,struct ifla_vf_info *ivi)
+{
+ <...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ ivi->max_tx_rate = assign;
+ ivi->min_tx_rate = assign2;
++#else
++ivi->tx_rate = assign;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
+ ...>
+}
-- 
2.1.0

