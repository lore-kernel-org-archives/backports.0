Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38738 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbbBYOWC (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:02 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 02/10] backports: replace struct ethtool_ops get/set_eee changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:46 +0100
Message-Id: <1424874054-22956-3-git-send-email-sassmann@kpanic.de> (sfid-20150225_152215_469192_7C526F8B)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0036-ethtool_eee/ethtool_eee.cocci     | 37 ++++++++++++++++++++++
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch | 29 -----------------
 2 files changed, 37 insertions(+), 29 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/ethtool_eee.cocci
 delete mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch

diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/ethtool_eee.cocci b/patches/collateral-evolutions/network/0036-ethtool_eee/ethtool_eee.cocci
new file mode 100644
index 0000000..7c2d2fe
--- /dev/null
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/ethtool_eee.cocci
@@ -0,0 +1,37 @@
+@r1@
+identifier s, func;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+.get_eee = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+};
+
+@r2@
+identifier s, func;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+.set_eee = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+};
+
+// ----------------------------------------------------------------------
+
+@@
+identifier r1.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+
+@@
+identifier r2.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
deleted file mode 100644
index 7e132ef..0000000
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2593,6 +2593,7 @@ static int igb_set_rxnfc(struct net_devi
- 	return ret;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2744,6 +2745,7 @@ static int igb_set_eee(struct net_device
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
- 
- static int igb_get_module_info(struct net_device *netdev,
- 			       struct ethtool_modinfo *modinfo)
-@@ -3049,8 +3051,10 @@ static const struct ethtool_ops igb_etht
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.get_rxnfc		= igb_get_rxnfc,
- 	.set_rxnfc		= igb_set_rxnfc,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	.get_eee		= igb_get_eee,
- 	.set_eee		= igb_set_eee,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
-- 
2.1.0

