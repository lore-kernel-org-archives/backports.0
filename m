Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbbBYOWE (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:04 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 07/10] backports: replace struct net_device_ops set_vf_spoofchk changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:51 +0100
Message-Id: <1424874054-22956-8-git-send-email-sassmann@kpanic.de> (sfid-20150225_152217_890101_CEDFA206)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../igb_ndo_set_vf_spoofchk.patch                  | 49 ----------------------
 .../0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci | 41 ++++++++++++++++++
 2 files changed, 41 insertions(+), 49 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
 create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci

diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
deleted file mode 100644
index 879312d..0000000
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ /dev/null
@@ -1,49 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net
- static int igb_ndo_set_vf_vlan(struct net_device *netdev,
- 			       int vf, u16 vlan, u8 qos);
- static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
- 				   bool setting);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
- 				 struct ifla_vf_info *ivi);
- static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2100,7 +2102,9 @@ static const struct net_device_ops igb_n
- 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
- 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
- 	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 	.ndo_get_vf_config	= igb_ndo_get_vf_config,
- #ifdef CONFIG_NET_POLL_CONTROLLER
- 	.ndo_poll_controller	= igb_netpoll,
-@@ -7918,6 +7922,7 @@ static int igb_ndo_set_vf_bw(struct net_
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
- 				   bool setting)
- {
-@@ -7944,6 +7949,7 @@ static int igb_ndo_set_vf_spoofchk(struc
- 	adapter->vf_data[vf].spoofchk_enabled = setting;
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 
- static int igb_ndo_get_vf_config(struct net_device *netdev,
- 				 int vf, struct ifla_vf_info *ivi)
-@@ -7957,7 +7963,9 @@ static int igb_ndo_get_vf_config(struct
- 	ivi->min_tx_rate = 0;
- 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
- 	ivi->qos = adapter->vf_data[vf].pf_qos;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	ivi->spoofchk = adapter->vf_data[vf].spoofchk_enabled;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 	return 0;
- }
- 
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
new file mode 100644
index 0000000..7be32c0
--- /dev/null
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
@@ -0,0 +1,41 @@
+@r1@
+identifier s, func;
+@@
+
+struct net_device_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+.ndo_set_vf_spoofchk = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
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
+identifier r1.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+
+@@
+identifier r2.func2, ivi;
+expression assign;
+@@
+
+func2(...  ,struct ifla_vf_info *ivi)
+{
+ <...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ ivi->spoofchk = assign;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ ...>
+}
-- 
2.1.0

