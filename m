Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33476 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbaEPLWc (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:32 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 04/13] backports: handle new ndo_set_vf_spoofchk pointer in struct net_device_ops
Date: Fri, 16 May 2014 13:21:15 +0200
Message-Id: <1400239284-2916-5-git-send-email-sassmann@kpanic.de> (sfid-20140516_132236_271474_803C1C8F)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.2 struct net_device_ops got a new function pointer
ndo_set_vf_spoofchk. Address this by putting ifdef around the code.

commit 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
Author: Greg Rose <gregory.v.rose@intel.com>
Date:   Sat Oct 8 03:05:24 2011 +0000

    if_link: Add additional parameter to IFLA_VF_INFO for spoof checking

git describe --contains 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
v3.2-rc1~129^2~87

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0034-ndo_set_vf_spoofchk/INFO          | 12 +++++
 .../igb_ndo_set_vf_spoofchk.patch                  | 51 ++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/INFO
 create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch

diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/INFO b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/INFO
new file mode 100644
index 0000000..31c4a7e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/INFO
@@ -0,0 +1,12 @@
+In kernel 3.2 struct net_device_ops got a new function pointer
+ndo_set_vf_spoofchk. Address this by putting ifdef around the code.
+
+
+commit 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
+Author: Greg Rose <gregory.v.rose@intel.com>
+Date:   Sat Oct 8 03:05:24 2011 +0000
+
+    if_link: Add additional parameter to IFLA_VF_INFO for spoof checking
+
+git describe --contains 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
+v3.2-rc1~129^2~87
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
new file mode 100644
index 0000000..5864a90
--- /dev/null
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -0,0 +1,51 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 325f244..ccd8f36 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
+ static int igb_ndo_set_vf_vlan(struct net_device *netdev,
+ 			       int vf, u16 vlan, u8 qos);
+ static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
+ 				   bool setting);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
+ 				 struct ifla_vf_info *ivi);
+ static void igb_check_vf_rate_limit(struct igb_adapter *);
+@@ -2097,7 +2099,9 @@ static const struct net_device_ops igb_netdev_ops = {
+ 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
+ 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
+ 	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 	.ndo_get_vf_config	= igb_ndo_get_vf_config,
+ #ifdef CONFIG_NET_POLL_CONTROLLER
+ 	.ndo_poll_controller	= igb_netpoll,
+@@ -7937,6 +7941,7 @@ static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate)
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
+ 				   bool setting)
+ {
+@@ -7963,6 +7968,7 @@ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
+ 	adapter->vf_data[vf].spoofchk_enabled = setting;
+ 	return E1000_SUCCESS;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 
+ static int igb_ndo_get_vf_config(struct net_device *netdev,
+ 				 int vf, struct ifla_vf_info *ivi)
+@@ -7975,7 +7981,9 @@ static int igb_ndo_get_vf_config(struct net_device *netdev,
+ 	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
+ 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
+ 	ivi->qos = adapter->vf_data[vf].pf_qos;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	ivi->spoofchk = adapter->vf_data[vf].spoofchk_enabled;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 	return 0;
+ }
+ 
-- 
1.9.0

