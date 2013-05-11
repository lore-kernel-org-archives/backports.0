Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58752 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3EKA2H (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:28:07 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so8882613iee.23
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:28:07 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 12/12] backports: refresh patches for next-20130419
Date: Fri, 10 May 2013 17:27:03 -0700
Message-Id: <1368232023-23817-13-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022936_389191_D9A0DE88)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m44.234s
user    813m54.992s
sys     126m44.115s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/network/0001-netdev_ops/atlx.patch   |    2 +-
 .../network/16-bluetooth/net_bluetooth_hci_sysfs.patch         |    2 +-
 .../network/16-bluetooth/net_bluetooth_hidp_sock.patch         |    2 +-
 .../network/16-bluetooth/net_bluetooth_sco.patch               |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch               |    8 ++++----
 .../46-use_other_workqueue/net_bluetooth_hci_core.patch        |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch               |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
index de6ad23..8cab3be 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3009,7 +3009,7 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3004,7 +3004,7 @@ static int atl1_probe(struct pci_dev *pd
  	adapter->mii.phy_id_mask = 0x1f;
  	adapter->mii.reg_num_mask = 0x1f;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
index ac74a0e..4def823 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
@@ -24,7 +24,7 @@
  		put_device(dev);
  	}
  
-@@ -379,7 +387,11 @@ static struct attribute_group bt_host_gr
+@@ -378,7 +386,11 @@ static struct attribute_group bt_host_gr
  	.attrs = bt_host_attrs,
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
index b7bb653..3bd4644 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/sock.c
 +++ b/net/bluetooth/hidp/sock.c
-@@ -235,8 +235,12 @@ static struct proto hidp_proto = {
+@@ -226,8 +226,12 @@ static struct proto hidp_proto = {
  	.obj_size	= sizeof(struct bt_sock)
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index 6b6d9a5..bc63111 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -675,7 +679,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -711,7 +715,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index e44aee8..2d36137 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2917,8 +2917,10 @@ static const struct net_device_ops atl1_
+@@ -2912,8 +2912,10 @@ static const struct net_device_ops atl1_
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1_set_mac,
  	.ndo_change_mtu		= atl1_change_mtu,
@@ -11,7 +11,7 @@
  	.ndo_do_ioctl		= atlx_ioctl,
  	.ndo_tx_timeout		= atlx_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3028,11 +3030,13 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3023,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
  	netdev->features |= NETIF_F_SG;
  	netdev->features |= (NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX);
  
@@ -25,7 +25,7 @@
  
  	/*
  	 * patch for some L1 of old version,
-@@ -3645,6 +3649,14 @@ static int atl1_set_pauseparam(struct ne
+@@ -3640,6 +3644,14 @@ static int atl1_set_pauseparam(struct ne
  	return 0;
  }
  
@@ -40,7 +40,7 @@
  static void atl1_get_strings(struct net_device *netdev, u32 stringset,
  	u8 *data)
  {
-@@ -3717,4 +3729,10 @@ static const struct ethtool_ops atl1_eth
+@@ -3712,4 +3724,10 @@ static const struct ethtool_ops atl1_eth
  	.nway_reset		= atl1_nway_reset,
  	.get_ethtool_stats	= atl1_get_ethtool_stats,
  	.get_sset_count		= atl1_get_sset_count,
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index 33f0fde..9d12fdb 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2181,16 +2181,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2191,16 +2191,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
index 593de7b..c09ad69 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3060,7 +3060,9 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3055,7 +3055,9 @@ static int atl1_probe(struct pci_dev *pd
  	/* copy the MAC address out of the EEPROM */
  	if (atl1_read_mac_addr(&adapter->hw)) {
  		/* mark random mac */
-- 
1.7.10.4

