Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46714 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfS (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:18 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/17] backports: remove usage of addr_assign_type in 6lowpan.c
Date: Wed,  8 Jan 2014 01:34:26 +0100
Message-Id: <1389141274-2002-10-git-send-email-hauke@hauke-m.de> (sfid-20140108_013520_220077_55E86614)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The bluetooth 6lowpan code now accesses the addr_assign_type member of
struct netdev, which is not available in older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
kernel versions.
---
 .../61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch

diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
new file mode 100644
index 0000000..ad2618f
--- /dev/null
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
@@ -0,0 +1,12 @@
+--- a/net/bluetooth/6lowpan.c
++++ b/net/bluetooth/6lowpan.c
+@@ -632,7 +632,9 @@ static void set_addr(u8 *eui, u8 *addr,
+ static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
+ 		         u8 addr_type)
+ {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
+ 	netdev->addr_assign_type = NET_ADDR_PERM;
++#endif
+ 	set_addr(netdev->dev_addr, addr->b, addr_type);
+ 	netdev->dev_addr[0] ^= 2;
+ }
-- 
1.7.10.4

