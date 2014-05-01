Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33188 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1i (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:38 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so4361760pab.23
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:27:38 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 8/8] backports: fix igb patch for next-20140501
Date: Thu,  1 May 2014 16:26:51 -0700
Message-Id: <1398986811-25649-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012740_363651_F833E194)
In-Reply-To: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Manual fixes were needed for:

patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch

We currently hit a compile error as of next-20140501 because of the
introduction of smp_mb__after_atomic(). This is not yet addressed.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 .../0001-ethernet-igb/0001-igb_net_device_ops.patch        | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
index 97ad8aa..e464283 100644
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
@@ -1,11 +1,9 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 14ad4c7..f2a5abf 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -160,8 +160,13 @@ static int igb_ioctl(struct net_device *
- static void igb_tx_timeout(struct net_device *);
+@@ -157,8 +157,13 @@ static void igb_tx_timeout(struct net_de
  static void igb_reset_task(struct work_struct *);
- static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features);
+ static void igb_vlan_mode(struct net_device *netdev,
+ 			  netdev_features_t features);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
  static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
@@ -16,7 +14,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7249,8 +7254,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7257,8 +7262,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +27,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7267,8 +7276,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7275,8 +7284,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +40,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7294,7 +7307,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7302,7 +7315,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
-- 
1.9.1

