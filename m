Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43462 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761468Ab3LIS2A (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 13:28:00 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so3773231wgh.11
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 10:27:59 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: peter.senna@gmail.com, julia.lawall@lip6.fr, Gilles.Muller@lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/3] backports: refresh patches for next-20131206 a second time
Date: Mon,  9 Dec 2013 19:27:45 +0100
Message-Id: <1386613665-11656-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20131209_192804_024505_48EF7551)
In-Reply-To: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

After a few changes were made we need a refresh of patches
against next-20131206, this refreshes the patches and test
compiles against all supported kernels again.

$ time ckmake --allyesconfig
1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.52              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.70              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.20             [  OK  ]
27  3.11.9              [  OK  ]
28  3.12.1              [  OK  ]
29  3.13-rc1            [  OK  ]

real    33m3.982s
user    892m21.988s
sys     128m11.492s

Current run time *without* the last two cocci patches applied:

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	--verbose \
	--clean \
	--refresh \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/next-20131206

real    3m13.530s
user    2m56.104s
sys     0m16.180s

With the last two cocci patch files applied and spatch version 1.0.0-rc17:

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	--verbose \
	--clean \
	--refresh \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/next-20131206

real    23m2.521s
user    19m19.436s
sys     3m3.840s

With the last two cocci patch files applied and spatch version 1.0.0-rc19:

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	--verbose \
	--clean \
	--refresh \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/next-20131206

real    8m6.077s
user    7m46.076s
sys     0m18.124s

Moving forward please make sure to have present at least spatch
1.0.0-rc19 on your system to generate releases. The gains of extending
how we do backports more automatically with Coccinelle for the
short cost observed on 1.0.0-rc19 makes it worth it to continue to
embrace SmPL to backport further collateral evolutions.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_net_ethernet_atheros_atlx_atl1.patch                  | 8 ++++----
 .../drivers_net_ethernet_atheros_atlx_atl1.patch                  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index dc8a73e..f7f943b 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2912,8 +2912,10 @@ static const struct net_device_ops atl1_
+@@ -2909,8 +2909,10 @@ static const struct net_device_ops atl1_
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1_set_mac,
  	.ndo_change_mtu		= atl1_change_mtu,
@@ -11,7 +11,7 @@
  	.ndo_do_ioctl		= atlx_ioctl,
  	.ndo_tx_timeout		= atlx_tx_timeout,
  #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3023,11 +3025,13 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3020,11 +3022,13 @@ static int atl1_probe(struct pci_dev *pd
  	netdev->features |= NETIF_F_SG;
  	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
  
@@ -25,7 +25,7 @@
  
  	/*
  	 * patch for some L1 of old version,
-@@ -3615,6 +3619,14 @@ static int atl1_set_pauseparam(struct ne
+@@ -3607,6 +3611,14 @@ static int atl1_set_pauseparam(struct ne
  	return 0;
  }
  
@@ -40,7 +40,7 @@
  static void atl1_get_strings(struct net_device *netdev, u32 stringset,
  	u8 *data)
  {
-@@ -3687,6 +3699,12 @@ static const struct ethtool_ops atl1_eth
+@@ -3679,6 +3691,12 @@ static const struct ethtool_ops atl1_eth
  	.nway_reset		= atl1_nway_reset,
  	.get_ethtool_stats	= atl1_get_ethtool_stats,
  	.get_sset_count		= atl1_get_sset_count,
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
index c09ad69..2584d87 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3055,7 +3055,9 @@ static int atl1_probe(struct pci_dev *pd
+@@ -3052,7 +3052,9 @@ static int atl1_probe(struct pci_dev *pd
  	/* copy the MAC address out of the EEPROM */
  	if (atl1_read_mac_addr(&adapter->hw)) {
  		/* mark random mac */
-- 
1.8.4.3

