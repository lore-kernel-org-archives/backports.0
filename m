Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbaEPLW3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:29 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 03/13] backports: handle changes to vlan_rx_add/kill pointers in struct net_device_ops
Date: Fri, 16 May 2014 13:21:14 +0200
Message-Id: <1400239284-2916-4-git-send-email-sassmann@kpanic.de> (sfid-20140516_132233_691731_F2562EF3)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.3 and 3.10 struct net_device_ops function pointers
ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid changed.
Address this by putting ifdef around the code.

commit 8e586137e6b63af1e881b328466ab5ffbe562510
Author: Jiri Pirko <jpirko@redhat.com>
Date:   Thu Dec 8 19:52:37 2011 -0500

    net: make vlan ndo_vlan_rx_[add/kill]_vid return error value

git describe --contains 8e586137e6b63af1e881b328466ab5ffbe562510
v3.3-rc1~182^2~291

commit 80d5c3689b886308247da295a228a54df49a44f6
Author: Patrick McHardy <kaber@trash.net>
Date:   Fri Apr 19 02:04:28 2013 +0000

    net: vlan: prepare for 802.1ad VLAN filtering offload

git describe --contains 80d5c3689b886308247da295a228a54df49a44f6
v3.10-rc1~66^2~97^2~4

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0033-ndo_vlan_rx_vid/INFO              | 23 +++++++
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 78 ++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/INFO
 create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch

diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/INFO b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/INFO
new file mode 100644
index 0000000..9a61253
--- /dev/null
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/INFO
@@ -0,0 +1,23 @@
+In kernel 3.3 and 3.10 struct net_device_ops function pointers
+ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid changed.
+Address this by putting ifdef around the code.
+
+
+commit 8e586137e6b63af1e881b328466ab5ffbe562510
+Author: Jiri Pirko <jpirko@redhat.com>
+Date:   Thu Dec 8 19:52:37 2011 -0500
+
+    net: make vlan ndo_vlan_rx_[add/kill]_vid return error value
+
+git describe --contains 8e586137e6b63af1e881b328466ab5ffbe562510
+v3.3-rc1~182^2~291
+
+
+commit 80d5c3689b886308247da295a228a54df49a44f6
+Author: Patrick McHardy <kaber@trash.net>
+Date:   Fri Apr 19 02:04:28 2013 +0000
+
+    net: vlan: prepare for 802.1ad VLAN filtering offload
+
+git describe --contains 80d5c3689b886308247da295a228a54df49a44f6
+v3.10-rc1~66^2~97^2~4
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
new file mode 100644
index 0000000..58930f7
--- /dev/null
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -0,0 +1,78 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 09564d0..325f244 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -157,8 +157,16 @@ static void igb_tx_timeout(struct net_device *);
+ static void igb_reset_task(struct work_struct *);
+ static void igb_vlan_mode(struct net_device *netdev,
+ 			  netdev_features_t features);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
+ static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++static int igb_vlan_rx_add_vid(struct net_device *, u16);
++static int igb_vlan_rx_kill_vid(struct net_device *, u16);
++#else
++static void igb_vlan_rx_add_vid(struct net_device *, u16);
++static void igb_vlan_rx_kill_vid(struct net_device *, u16);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ static void igb_restore_vlan(struct igb_adapter *);
+ static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
+ static void igb_ping_all_vfs(struct igb_adapter *);
+@@ -7261,8 +7269,14 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
+ 	igb_rlpml_set(adapter);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_add_vid(struct net_device *netdev,
+ 			       __be16 proto, u16 vid)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
++#else
++static void igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
++#endif
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+ 	struct e1000_hw *hw = &adapter->hw;
+@@ -7276,11 +7290,19 @@ static int igb_vlan_rx_add_vid(struct net_device *netdev,
+ 
+ 	set_bit(vid, adapter->active_vlans);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int igb_vlan_rx_kill_vid(struct net_device *netdev,
+ 				__be16 proto, u16 vid)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
++#else
++static void igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+ 	struct e1000_hw *hw = &adapter->hw;
+@@ -7296,7 +7318,9 @@ static int igb_vlan_rx_kill_vid(struct net_device *netdev,
+ 
+ 	clear_bit(vid, adapter->active_vlans);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
+ static void igb_restore_vlan(struct igb_adapter *adapter)
+@@ -7306,7 +7330,11 @@ static void igb_restore_vlan(struct igb_adapter *adapter)
+ 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
+ 
+ 	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ 		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
++#else
++		igb_vlan_rx_add_vid(adapter->netdev, vid);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ }
+ 
+ int igb_set_spd_dplx(struct igb_adapter *adapter, u32 spd, u8 dplx)
-- 
1.9.0

